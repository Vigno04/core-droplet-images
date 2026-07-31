#!/usr/bin/env bash
set -ex

VERSION="1.0.0"

ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/amd64/g')

mkdir $STARTUPDIR/upload_server
wget --quiet https://github.com/Vigno04/flowcase_upload_server/releases/download/v$VERSION/flowcase_upload_server_$ARCH.tar.gz -O /tmp/flowcase_upload_server.tar.gz
tar -xvf /tmp/flowcase_upload_server.tar.gz -C $STARTUPDIR/upload_server
rm /tmp/flowcase_upload_server.tar.gz
