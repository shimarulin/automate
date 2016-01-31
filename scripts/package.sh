#!/bin/bash
#

if ! dpkg --get-selections | grep -q "^$1[[:space:]]*install$" >/dev/null; then
    echo "Install package $1:";
    apt-get -y install $1;
else
    echo "$1 already installed.  Skipping";
fi
