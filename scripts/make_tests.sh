#!/bin/sh

TARGET="github.com/l0rd/docker-unit/build"

CMD="go test $TARGET"

echo "$CMD" && $CMD
