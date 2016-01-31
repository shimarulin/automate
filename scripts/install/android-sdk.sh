#!/bin/bash
#
#
# Based on https://gist.github.com/tahl/1026610
DEST=/opt

i=$(cat /proc/$PPID/cmdline)
if [[ $UID != 0 ]]; then
    echo "Please type sudo $0 $*to use this."
    exit 1
fi

if [[ `getconf LONG_BIT` = "64" ]]; then
    echo "64-bit operating system detected. "
else
	echo "32-bit operating system currently not supported."
    exit 1
fi

apt-get update

#Download and install the Android SDK
if [ ! -d "$DEST/android-sdk" ]; then
	for a in $( wget -qO- http://developer.android.com/sdk/index.html | egrep -o "http://dl.google.com[^\"']*linux.tgz" ); do 
		wget $a && tar --wildcards --no-anchored -xvzf android-sdk_*-linux.tgz; 
		mv android-sdk-linux $DEST/android-sdk; 
		chmod 777 -R $DEST/android-sdk; 
		rm android-sdk_*-linux.tgz;
	done
else
     echo "Android SDK already installed to $DEST/android-sdk.  Skipping."
fi

#Download and install the Android NDK
if [ ! -d "$DEST/android-ndk" ]; then 
	for b in $(  wget -qO- http://developer.android.com/sdk/ndk/index.html | egrep -o "http://dl.google.com[^\"']*linux-x86.tar.bz2"); do 
        wget $b && tar --wildcards --no-anchored -xjvf android-ndk-*-linux-x86.tar.bz2; 
        mv android-ndk-*/ $DEST/android-ndk; 
        chmod 777 -R $DEST/android-ndk; 
        rm android-ndk-*-linux-x86.tar.bz2;
	done
else
    echo "Android NDK already installed to $DEST/android-ndk.  Skipping."
fi
