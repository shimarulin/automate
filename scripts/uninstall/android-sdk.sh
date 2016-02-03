#!/bin/bash
# Based on https://gist.github.com/tahl/1026610
DEST=/opt
rc=/etc/profile.d/android-sdk-linux.sh;

i=$(cat /proc/$PPID/cmdline)
if [[ $UID != 0 ]]; then
    echo "Please type sudo $0 $*to use this."
    exit 1
fi

rm -rf $DEST/android-sdk-linux
rm $rc
echo "Android SDK uninstalled"
