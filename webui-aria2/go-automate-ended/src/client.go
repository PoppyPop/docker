package main

import (
	"log"
	"time"

	"github.com/gorilla/websocket"
)

var (
	newline = []byte{'\n'}
	space   = []byte{' '}
)

// Client is a middleman between the websocket connection and the hub.
type Client struct {
	// The websocket connection.
	conn *websocket.Conn

	// Buffered channel of outbound messages.
	send chan []byte

	// Buffered channel of error.
	err chan error

	// indicate if client is dead
	killed bool
}

// SignalError ...
func (c *Client) SignalError(msg string, err error) {
	log.Println(msg, err)
	c.err <- err
	c.killed = true
}

// readPump pumps messages from the websocket connection to the hub.
//
// The application runs readPump in a per-connection goroutine. The application
// ensures that there is at most one reader on a connection by executing all
// reads from this goroutine.
func (c *Client) readPump() {

	for {
		if c.killed {
			return
		}

		_, r, err := c.conn.NextReader()

		if err != nil {
			c.SignalError("read:", err)
			return
		}

		err2 := DecodeClientRequest(r, c)

		if err2 != nil {
			//c.SignalError("Decode error:", err2)
			log.Println("Decode error:", err2)
		}
	}
}

// Close ..
func (c *Client) Close() error {
	err := c.conn.WriteMessage(websocket.CloseMessage, websocket.FormatCloseMessage(websocket.CloseNormalClosure, ""))
	if err != nil {
		return err
	}
	c.killed = true
	return nil
}

// writePump pumps messages from the hub to the websocket connection.
//
// A goroutine running writePump is started for each connection. The
// application ensures that there is at most one writer to a connection by
// executing all writes from this goroutine.
func (c *Client) writePump() {

	ticker := time.NewTicker(pingPeriod)
	defer func() {
		ticker.Stop()
	}()
	for {
		if c.killed {
			return
		}

		select {
		case <-ticker.C:
			if err := c.conn.WriteMessage(websocket.PingMessage, []byte{}); err != nil {
				c.SignalError("", err)
				return
			}

		case message, ok := <-c.send:

			if !ok {
				c.SignalError("send chan closed", nil)
				return
			}

			w, err := c.conn.NextWriter(websocket.TextMessage)
			if err != nil {
				return
			}
			w.Write(message)

			// Add queued chat messages to the current websocket message.
			n := len(c.send)
			for i := 0; i < n; i++ {
				w.Write(newline)
				w.Write(<-c.send)
			}

			if err := w.Close(); err != nil {
				return
			}
		}
	}
}
