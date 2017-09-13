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
func DecodeClientRequest(reader io.Reader, s *websocket.Conn) error {

	var buf bytes.Buffer
	r := io.TeeReader(reader, &buf)

	// We check if this is an event or a response
	var c serverRequest
	if err := json.NewDecoder(r).Decode(&c); err != nil {
		return err
	}

	if c.Method == "aria2.onDownloadComplete" {
		// Event (serverRequest)
		DecodeEvent(c, s)
	} else if c.Method == "" {

		if rpcIds[c.ID] {
			// response
			var reply StatusResponse
			err := DecodeClientResponse(&buf, &reply)
			if err != nil {
				return err
			}

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
						return errRemove
					}

					continue
				}

				if videoExt[ext] || audioExt[ext] {

					log.Printf("[%s] Moving: %s", reply.Gid, element.Path)

					errRename := MoveFile(element.Path, "/ended/"+fileName)

					if errRename != nil {
						return errRename
					}

					TransfertFile(reply.Gid, "/ended/"+fileName)
					/*if errTr != nil {
						return errTr
					}*/

					RemoveDl(reply.Gid, s)

					continue
				}

				if archiveExt[ext] {

					errMkDirAll := os.MkdirAll("/extract/"+fileName, 0777)
					if errMkDirAll != nil {
						return errMkDirAll
					}

					var errExtract error

					if ext == "rar" {
						errExtract = archiver.Rar.Open(element.Path, "/extract/"+fileName)
					} else if ext == "zip" {
						errExtract = archiver.Zip.Open(element.Path, "/extract/"+fileName)
					}

					if errExtract != nil {
						log.Printf("[%s] Error extracting file %s: %s", reply.Gid, element.Path, errExtract)
						return errExtract
					}

					errRename := MoveDir("/extract/"+fileName, "/ended/"+fileName)
					if errRename != nil {
						return errRename
					}

					errRemove := os.RemoveAll(element.Path)
					if errRemove != nil {
						return errRemove
					}

					continue
				}
			}

			files, _ := ioutil.ReadDir(reply.Dir)
			if len(files) == 0 {
				os.RemoveAll(reply.Dir)
			}

			log.Printf("[%s] Terminated", reply.Gid)
		}

		delete(rpcIds, c.ID)
	}

	return nil
}

// DecodeEvent decode les réponse de type Event
func DecodeEvent(req serverRequest, s *websocket.Conn) error {
	var res [1]Event
	json.Unmarshal(*req.Params, &res)

	log.Printf("[%s] Method: %s", res[0].Gid, req.Method)

	GetDetails(res[0].Gid, s)

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
func GetDetails(gid string, s *websocket.Conn) {
	log.Printf("[%s] Get status from aria", gid)

	args := []string{"token:" + *token, gid}

	message, errj := EncodeClientRequest("aria2.tellStatus", true, args)
	if errj != nil {
		log.Println("json:", errj)
		return
	}

	err := s.WriteMessage(websocket.TextMessage, []byte(message))

	if err != nil {
		log.Println("write:", errj)
		return
	}
}

// RemoveDl removeDl
func RemoveDl(gid string, s *websocket.Conn) {
	log.Printf("[%s] Removig from aria", gid)

	args := []string{"token:" + *token, gid}

	message, errj := EncodeClientRequest("aria2.removeDownloadResult", false, args)
	if errj != nil {
		log.Println("json:", errj)
		return
	}

	err := s.WriteMessage(websocket.TextMessage, []byte(message))

	if err != nil {
		log.Println("write:", errj)
		return
	}
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
	log.Printf("connecting to %s", u.String())

	c, _, err := websocket.DefaultDialer.Dial(u.String(), nil)
	if err != nil {
		log.Fatal("dial:", err)
	}
	defer c.Close()

	c.SetReadDeadline(time.Now().Add(pongWait))
	c.SetPongHandler(func(appData string) error {
		c.SetReadDeadline(time.Now().Add(pongWait))
		return nil
	})

	done := make(chan struct{})

	go func() {
		defer c.Close()
		defer close(done)
		for {
			_, r, err := c.NextReader()

			if err != nil {
				log.Println("read:", err)
				return
			}

			err2 := DecodeClientRequest(r, c)

			if err2 != nil {
				log.Println("Decode error:", err2)
				return
			}

		}
	}()

	ticker := time.NewTicker(pingPeriod)
	defer ticker.Stop()

	for {
		select {
		case <-ticker.C:
			if err := c.WriteMessage(websocket.PingMessage, []byte{}); err != nil {
				return
			}

		case <-interrupt:
			log.Println("interrupt")
			// To cleanly close a connection, a client should send a close
			// frame and wait for the server to close the connection.
			err := c.WriteMessage(websocket.CloseMessage, websocket.FormatCloseMessage(websocket.CloseNormalClosure, ""))
			if err != nil {
				log.Println("write close:", err)
				return
			}
			select {
			case <-done:
			case <-time.After(time.Second):
			}
			c.Close()
			return
		}
	}
}
