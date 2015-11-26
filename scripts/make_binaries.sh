#!/bin/sh

FAILURES=""
TARGET="github.com/l0rd/docker-unit/cmd/docker-unit"

mkdir -p "$1"

for PLATFORM in $PLATFORMS; do
	OUTPUTDIR="$1/$PLATFORM"
	mkdir -p "$OUTPUTDIR"

	export GOPATH="$PROJ_DIR/Godeps/_workspace:$GOPATH"
	export GOOS="${PLATFORM%/*}"
	export GOARCH="${PLATFORM#*/}"

	CMD="go build -o $OUTPUTDIR/docker-unit $TARGET"

	echo "$CMD" && $CMD || FAILURES="$FAILURES $PLATFORM"
done

if [ -n "$FAILURES" ]; then
	echo "*** build FAILED on $FAILURES ***"
	exit 1
fi
