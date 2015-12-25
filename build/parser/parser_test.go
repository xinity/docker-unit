package parser

import (
	"os"
	"testing"

)

// to test that run the following command
//    GOPATH="$project_dir/Godeps/_workspace:$HOME/GitHub/docker-unit" go test -test.v github.com/l0rd/docker-unit/build

func TestNewTester(t *testing.T) {
    
    file, err := os.Open("commands")
	if err != nil {
		t.Fatalf("Can't open 'commands': %s", err)
	}
	defer file.Close()


    _, err = Parse(file)
	if err != nil {
		t.Fatalf("unable to parse input: %s", err)
		return
	}
}