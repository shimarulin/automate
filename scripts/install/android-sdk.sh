#!/bin/bash
# Based on https://gist.github.com/tahl/1026610
DEST=/opt

i=$(cat /proc/$PPID/cmdline)
if [[ $UID != 0 ]]; then
    echo "Please type sudo $0 $*to use this."
    exit 1
fi

if [[ `getconf LONG_BIT` = "64" ]]; then
    echo "64-bit operating system detected..."
else
	echo "32-bit operating system currently not supported. Exit"
    exit 1
fi

dpkg --add-architecture i386
apt-get update

for package in libncurses5:i386 libstdc++6:i386 zlib1g:i386; do
    bash $AUTOMATE_SYS/system/package.sh $package;
done

#Download and install the Android SDK
if [ ! -d "$DEST/android-sdk-linux" ]; then
	for a in $( wget -qO- http://developer.android.com/sdk/index.html | egrep -o "http://dl.google.com[^\"']*linux.tgz" ); do 
		wget $a && tar --wildcards --no-anchored -xvzf android-sdk_*-linux.tgz; 
		mv android-sdk-linux $DEST/android-sdk-linux;
		chmod 777 -R $DEST/android-sdk-linux;
		rm android-sdk_*-linux.tgz;
	done
else
     echo "Android SDK already installed to $DEST/android-sdk-linux"
fi

#Check if the ADB environment is set up.
rc=/etc/profile.d/android-sdk-linux.sh;
if [ ! -f $rc ]; then
    echo "ADB environment set up...";
    export ANDROID_HOME=$DEST/android-sdk-linux;
    export PATH=$PATH:$DEST/android-sdk-linux/tools:$DEST/android-sdk-linux/platform-tools;
    touch $rc
    echo "export ANDROID_HOME=$DEST/android-sdk-linux" >> $rc
    echo "export PATH=\$PATH:$DEST/android-sdk-linux/tools:$DEST/android-sdk-linux/platform-tools" >> $rc
else
     echo "ADB environment already set up"
fi