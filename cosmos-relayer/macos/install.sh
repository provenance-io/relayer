#!/bin/bash

GPATH=$(go env | grep GOPATH | cut -d'=' -f2)
GPATH="${GPATH#?}"
GPATH="${GPATH%?}"
RELAYER=rly
GO_RELAYER_BIN=$GPATH/bin/$RELAYER 
USR_RELAYER_BIN=/usr/local/bin/$RELAYER

# Check for cosmos relayer
if [ ! -f ${GO_RELAYER_BIN} ]; then
    echo "Need to install cosmos relayer"
    exit 1
fi

# Create symlink if it doesn't exist
if [ ! -f ${USR_RELAYER_BIN} ]; then
    echo "Creating relayer symlink for service"
    sudo ln -s ${GO_RELAYER_BIN} ${USR_RELAYER_BIN}
fi

launchctl bootstrap gui/502 com.provenance.relayer.plist