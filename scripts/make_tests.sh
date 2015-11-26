#!/bin/sh

TARGET="github.com/l0rd/docker-unit/build"

export GOPATH="$PROJ_DIR/Godeps/_workspace:$GOPATH"

CMD="go test $TARGET"

echo "$CMD" && $CMD
