package main

import (
	. "./client"
)

import (
	"io/ioutil"

	"fmt"

	"encoding/json"
	"path/filepath"

	"os"

	"github.com/cloudflare/cfssl/auth"
	"github.com/jessevdk/go-flags"
)

type jsonSignRequest struct {
	Hosts   []string `json:"hosts,omitempty"`
	Request string   `json:"certificate_request"`
	Subject string   `json:"subject,omitempty"`
	Profile string   `json:"profile,omitempty"`
	Label   string   `json:"label,omitempty"`
	Bundle  bool     `json:"bundle,omitempty"`
}

type jsonNewCertRequest struct {
	Request jsonNewKeyRequest `json:"request"`
	Profile string            `json:"profile,omitempty"`
}

type jsonNewKeyRequest struct {
	Hosts  []string          `json:"hosts"`
	Names  map[string]string `json:"names,omitempty"`
	CN     string            `json:"CN"`
	Key    string            `json:"key,omitempty"`
	Bundle bool              `json:"bundle,omitempty"`
}

type jsonSignError struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
}

type mainOpts struct {
	Gen     genOpts  `command:"generate" alias:"gen" description:"Generate the private key / CSR / CRT in automatique mode"`
	Sign    signOpts `command:"sign" description:"Sign an CSR"`
	Profile string   `short:"p" long:"profile" required:"false" description:"signing profile (client / server)" default:"client"`
	Url     string   `short:"u" long:"url" required:"false" description:"the cfssl server" default:"http://127.0.0.1:8888"`
}

type genOpts struct {
	Domains []string `short:"d" long:"domain" required:"false" description:"The domains/ips to sign"`
}

type signOpts struct {
	Key  string `short:"k" long:"key" required:"false" description:"Auth key for request sign"`
	Out  string `short:"o" long:"out" required:"false" description:"output file"`
	Args struct {
		Csr flags.Filename `positional-arg-name:"csr" description:"csr file to sign"`
	} `positional-args:"true" required:"1"`
}

func main() {

	var opts mainOpts

	p := flags.NewParser(&opts, flags.Default)
	_, err := p.Parse()

	if err != nil {
		if flagsErr, ok := err.(*flags.Error); ok && flagsErr.Type == flags.ErrHelp {
			os.Exit(0)
		} else {
			os.Exit(1)
		}
	}

	if p.Active.Name == "generate" {

		var rq jsonNewCertRequest

		fileName := opts.Gen.Domains[0]
		rq.Request.CN = "pki.moot.fr"
		rq.Request.Hosts = opts.Gen.Domains
		rq.Profile = opts.Profile

		s := NewServer(opts.Url)

		jsonrequest, _ := json.Marshal(rq)
		newcert, err := s.NewCert(jsonrequest)

		if newcert != nil && err == nil {
			ioutil.WriteFile(fileName+".crt", []byte(newcert.Certificate), 0644)
			ioutil.WriteFile(fileName+".csr", []byte(newcert.CertificateRequest), 0644)
			ioutil.WriteFile(fileName+".key", []byte(newcert.PrivateKey), 0644)

			fmt.Println("Success")
		} else {
			fmt.Printf("Error generating cert: %s\n", err)
		}

	} else if p.Active.Name == "sign" {

		// Read csr
		csr := string(opts.Sign.Args.Csr)

		if _, err := os.Stat(csr); os.IsNotExist(err) {
			fmt.Printf("File '%s' does not exist, -h for help\n", csr)
			os.Exit(1)
		}

		csrName := filepath.Base(csr)

		buf, _ := ioutil.ReadFile(csr)
		csrString := string(buf)

		// compute out
		if opts.Sign.Out == "" {
			var extension = filepath.Ext(csrName)
			var name = csrName[0 : len(csrName)-len(extension)]

			opts.Sign.Out = name + ".crt"
		}

		authProvider, _ := auth.New(opts.Sign.Key, nil)
		s := NewAuthServer(opts.Url, nil, authProvider)

		var rq jsonSignRequest
		rq.Profile = opts.Profile
		rq.Request = csrString

		jsonrequest, _ := json.Marshal(rq)

		as, err := s.Sign(jsonrequest)

		if as != nil || err == nil {
			ioutil.WriteFile(opts.Sign.Out, as, 0644)
			fmt.Printf("%s Succefully signed with profile %s\n", opts.Sign.Out, opts.Profile)
		} else {
			var errResp jsonSignError
			json.Unmarshal([]byte(err.Error()), &errResp)

			fmt.Printf("Error requesting cert: %s\n", errResp.Message)
		}
	}
}
