#!/bin/bash
#
ZIP_FILE="/tmp/gpaste-`date +%s`.zip"
VERSION="3.18.3"
wget -O $ZIP_FILE https://github.com/Keruspe/GPaste/archive/v$VERSION.zip
unzip -d /tmp $ZIP_FILE

pushd /tmp/GPaste-$VERSION

sudo apt-get -y install libtool valac gobject-introspection intltool libappstream-glib-dev gnome-control-center-dev libgirepository1.0-dev libclutter-1.0-dev appstream-util
./autogen.sh && ./configure --sysconfdir=/etc && make && sudo make install && sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

popd

rm $ZIP_FILE;
rm -rf /tmp/GPaste-$VERSION
