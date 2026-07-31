#!/usr/bin/env bash
set -ex

VERSION="1.0.0"

ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/amd64/g')

mkdir $STARTUPDIR/upload_server
if [ "$ARCH" = "arm64" ]; then
    echo "Upload server for arm64 is not currently available. Skipping."
    touch $STARTUPDIR/upload_server/flowcase_upload_server
else
    wget --quiet https://github.com/flowcase/flowcase_upload_server/releases/download/v$VERSION/flowcase_upload_server_$ARCH.tar.gz -O /tmp/flowcase_upload_server.tar.gz
    tar -xvf /tmp/flowcase_upload_server.tar.gz -C $STARTUPDIR/upload_server
    rm /tmp/flowcase_upload_server.tar.gz
fi
