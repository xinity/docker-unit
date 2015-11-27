#!/bin/sh

FAILURES=""
TARGET="github.com/l0rd/docker-unit/cmd/docker-unit"

mkdir -p "$1"
ZIPDIR="$1/zip"
mkdir -p $ZIPDIR

for PLATFORM in $PLATFORMS; do
	OUTPUTDIR="$1/$PLATFORM"
	mkdir -p "$OUTPUTDIR"

	export GOPATH="$PROJ_DIR/Godeps/_workspace:$GOPATH"
	export GOOS="${PLATFORM%/*}"
	export GOARCH="${PLATFORM#*/}"

	CMD="go build -o $OUTPUTDIR/docker-unit $TARGET"
        ZIP="zip -q -r $ZIPDIR/docker-unit_$GOOS-$GOARCH.zip $OUTPUTDIR/docker-unit"

	echo "$CMD" && $CMD && echo "$ZIP" && $ZIP || FAILURES="$FAILURES $PLATFORM"
done

if [ -n "$FAILURES" ]; then
	echo "*** build FAILED on $FAILURES ***"
	exit 1
fi
