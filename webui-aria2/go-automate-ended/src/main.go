// Copyright 2015 The Gorilla WebSocket Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package main

import (
	"bytes"
	"encoding/json"
	"errors"
	"flag"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"math/rand"
	"net/url"
	"os"
	"os/signal"
	"path/filepath"
	"strings"
	"time"

	//lq "github.com/ahmetb/go-linq"
	"github.com/gorilla/websocket"
	"github.com/mholt/archiver"
)

// Event Struct of the returning message as definied in aria2 rpc
type Event struct {
	Gid string `json:"gid"`
}

// serverRequest ...
type serverRequest struct {
	// A String containing the name of the method to be invoked.
	Method string `json:"method"`
	// An Array of objects to pass as arguments to the method.
	Params *json.RawMessage `json:"params"`
	// The request id. This can be of any type. It is used to match the
	// response with the request that it is replying to.
	ID uint64 `json:"id"`
}

// StatusResponse ...
type StatusResponse struct {
	Gid    string         `json:"gid"`
	Status string         `json:"status"`
	Dir    string         `json:"dir"`
	Files  []FileResponse `json:"files"`
}

// FileResponse ...
type FileResponse struct {
	Path string `json:"path"`
}

// DecodeClientRequest decodes the response body of a client request into
// the interface reply.
func DecodeClientRequest(reader io.Reader, c *Client) error {

	var buf bytes.Buffer
	r := io.TeeReader(reader, &buf)

	// We check if this is an event or a response
	var sr serverRequest
	if err := json.NewDecoder(r).Decode(&sr); err != nil {
		return err
	}

	if sr.Method == "aria2.onDownloadComplete" {
		// Event (serverRequest)
		DecodeEvent(sr, c)
	} else if sr.Method == "" {

		if rpcIds[sr.ID] {

			// We got our response
			delete(rpcIds, sr.ID)
			// response
			var reply StatusResponse
			err := DecodeClientResponse(&buf, &reply)
			if err != nil {
				return err
			}

			go HandleGID(reply, c)
		}

	}

	return nil
}

// HandleGID ...
func HandleGID(reply StatusResponse, c *Client) {

	log.Printf("[%s] Handling GID", reply.Gid)

	videoExt := map[string]bool{"mkv": true, "avi": true, "mp4": true}
	audioExt := map[string]bool{"mp3": true, "ogg": true, "flac": true}
	archiveExt := map[string]bool{"rar": true, "zip": true}

	for _, element := range reply.Files {
		fileName := filepath.Base(element.Path)
		ext := strings.TrimPrefix(filepath.Ext(fileName), ".")

		if ext == "nfo" {
			errRemove := os.Remove(element.Path)
			if errRemove != nil {
				log.Printf("[%s] %s", reply.Gid, errRemove)
				return
			}

			continue
		}

		if videoExt[ext] || audioExt[ext] {

			log.Printf("[%s] Moving: %s", reply.Gid, element.Path)

			errRename := MoveFile(element.Path, "/ended/"+fileName)

			if errRename != nil {
				log.Printf("[%s] %s", reply.Gid, errRename)
				return
			}

			errTr := TransfertFile(reply.Gid, "/ended/"+fileName)
			if errTr != nil {
				log.Printf("[%s] %s", reply.Gid, errTr)
			}

			RemoveDl(reply.Gid, c)

			continue
		}

		if archiveExt[ext] {

			errMkDirAll := os.MkdirAll("/extract/"+fileName, 0777)
			if errMkDirAll != nil {
				log.Printf("[%s] %s", reply.Gid, errMkDirAll)
				return
			}

			var errExtract error

			if ext == "rar" {
				errExtract = archiver.Rar.Open(element.Path, "/extract/"+fileName)
			} else if ext == "zip" {
				errExtract = archiver.Zip.Open(element.Path, "/extract/"+fileName)
			}

			if errExtract != nil {
				log.Printf("[%s] Error extracting file %s: %s", reply.Gid, element.Path, errExtract)
				return
			}

			errRename := MoveDir("/extract/"+fileName, "/ended/"+fileName)
			if errRename != nil {
				log.Printf("[%s] %s", reply.Gid, errRename)
				return
			}

			errRemove := os.RemoveAll(element.Path)
			if errRemove != nil {
				log.Printf("[%s] %s", reply.Gid, errRemove)
				return
			}

			continue
		}
	}

	files, _ := ioutil.ReadDir(reply.Dir)
	if len(files) == 0 {
		os.RemoveAll(reply.Dir)
	}

	log.Printf("[%s] Terminated", reply.Gid)

	return
}

// DecodeEvent decode les réponse de type Event
func DecodeEvent(req serverRequest, c *Client) error {
	var res [1]Event
	json.Unmarshal(*req.Params, &res)

	log.Printf("[%s] Method: %s", res[0].Gid, req.Method)

	GetDetails(res[0].Gid, c)

	return nil
}

// EncodeClientRequest ...
func EncodeClientRequest(method string, handleResponse bool, args []string) ([]byte, error) {
	c := &clientRequest{
		Method: method,
		Params: args,
		ID:     uint64(rand.Int63()),
	}
	rpcIds[c.ID] = handleResponse

	return json.Marshal(c)
}

// DecodeClientResponse ...
func DecodeClientResponse(r io.Reader, reply interface{}) error {
	var c clientResponse
	if err := json.NewDecoder(r).Decode(&c); err != nil {
		return err
	}
	if c.Error != nil {
		return fmt.Errorf("%v", c.Error)
	}
	if c.Result == nil {
		return errors.New("result is null")
	}
	return json.Unmarshal(*c.Result, reply)
}

type clientResponse struct {
	Result *json.RawMessage `json:"result"`
	Error  interface{}      `json:"error"`
	ID     uint64           `json:"id"`
}

type clientRequest struct {
	// A String containing the name of the method to be invoked.
	Method string `json:"method"`
	// Object to pass as request parameter to the method.
	Params []string `json:"params"`
	// The request id. This can be of any type. It is used to match the
	// response with the request that it is replying to.
	ID uint64 `json:"id"`
}

// GetDetails get details of one download
func GetDetails(gid string, c *Client) {
	log.Printf("[%s] Get status from aria", gid)

	args := []string{"token:" + *token, gid}

	message, errj := EncodeClientRequest("aria2.tellStatus", true, args)
	if errj != nil {
		log.Println("json:", errj)
		return
	}

	c.send <- message
}

// RemoveDl removeDl
func RemoveDl(gid string, c *Client) {
	log.Printf("[%s] Removig from aria", gid)

	args := []string{"token:" + *token, gid}

	message, errj := EncodeClientRequest("aria2.removeDownloadResult", false, args)
	if errj != nil {
		log.Println("json:", errj)
		return
	}

	c.send <- message
}

// TransfertFile ...
func TransfertFile(gid string, file string) (err error) {
	log.Printf("[%s] Transfert file: %s", gid, file)

	errMount := MoveFile(file, "/nfs")

	if errMount != nil {
		return errMount
	}

	return
}

const (
	// Time allowed to read the next pong message from the peer.
	pongWait = 60 * time.Second

	// Send pings to peer with this period. Must be less than pongWait.
	pingPeriod = (pongWait * 9) / 10
)

var addr = flag.String("addr", "192.168.0.235:6800", "http service address")
var token = flag.String("token", "reMgE94K5cSiE926", "auth token")

var rpcIds = make(map[uint64]bool)

func main() {
	flag.Parse()
	log.SetFlags(0)

	interrupt := make(chan os.Signal, 1)
	signal.Notify(interrupt, os.Interrupt)

	u := url.URL{Scheme: "ws", Host: *addr, Path: "/jsonrpc"}
	nbtry := 1

	for {
		log.Printf("connecting to %s", u.String())
		c, _, err := websocket.DefaultDialer.Dial(u.String(), nil)
		if err != nil {
			log.Println("dial:", err)

			if nbtry == 5 {
				log.Fatal("Fatal: no endpoint")
			}

			wait := time.Duration(7 * nbtry)
			log.Printf("Wait for %dsec.", wait)

			ticker := time.NewTicker(time.Second * wait)
			clearLoop := false
			for !clearLoop {
				select {
				case <-interrupt:
					log.Fatal("interrupt")
				case <-ticker.C:
					clearLoop = true
				}
			}
			if clearLoop {
				nbtry++
				ticker.Stop()
				continue
			}
		}
		defer c.Close()

		// reset nbtry
		nbtry = 1

		c.SetReadDeadline(time.Now().Add(pongWait))
		c.SetPongHandler(func(appData string) error {
			c.SetReadDeadline(time.Now().Add(pongWait))
			return nil
		})

		client := &Client{conn: c, send: make(chan []byte, 256), err: make(chan error, 256)}

		go client.readPump()
		go client.writePump()

		interrupted := false
		for !interrupted {
			select {
			case errClient, ok := <-client.err:
				interrupted = true
				if !ok {
					println("Err chan closed")
				}

				log.Println("Error: ", errClient)

			case <-interrupt:
				interrupted = true
				if !client.killed {
					client.Close()
				}

				log.Fatal("interrupted")
			}
		}
	}
}