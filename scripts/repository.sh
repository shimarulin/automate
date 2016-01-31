#!/bin/bash
#

SOURCE=${1//ppa:/};
if ! grep -q "$SOURCE" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    echo "Add $1 repository:"
    add-apt-repository $1;
else
    echo "$1 already added.  Skipping"
fi
