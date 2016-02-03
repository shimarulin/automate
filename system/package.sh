#!/bin/bash
#

if ! dpkg --get-selections | grep -q "^$1[[:space:]]*install$" >/dev/null; then
    echo "$1 was not found, installing...";
    apt-get -y install $1;
else
    echo "$1 already installed.  Skipping";
fi

# Alternate
#if [[ $(dpkg-query -f'${Status}' --show $package 2>/dev/null) = *\ installed ]]; then
#    echo "$package already installed.  Skipping."
#else
#    echo "$package was not found, installing..."
#    apt-get -y install $package
#fi