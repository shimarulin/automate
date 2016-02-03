#!/bin/bash
# v0.0.1

export AUTOMATE_HOME=/usr/local/lib/automate;
export AUTOMATE_SCRIPTS=/usr/local/lib/automate/scripts;
export AUTOMATE_SYS=/usr/local/lib/automate/system;

AUTOMATE=/usr/local/lib/automate;
SCRIPTS=/usr/local/lib/automate/scripts;

function install () {
    if [ -e "$SCRIPTS/install/$1.sh" ]; then
        sudo bash $SCRIPTS/install/$1.sh;
    else
        echo "$1 install script not available.  Skipping"
        exit 1
    fi
}

function uninstall () {
    if [ -e "$SCRIPTS/uninstall/$1.sh" ]; then
        sudo bash $SCRIPTS/uninstall/$1.sh;
    else
        echo "$1 uninstall script not available.  Skipping"
        exit 1
    fi
}

function list () {
    echo "Available command list:";
    printf "\n%s\n" "install";
    printf "\t%s\n" `ls $SCRIPTS/install | sed -e 's/\..*$//'`;
}

case "$1" in
install)
    install $2;
    ;;
uninstall)
    echo "uninstall";
    ;;
list)
    list;
    ;;
self-update)
    sudo bash $AUTOMATE/update;
    ;;
self-uninstall)
    sudo bash $AUTOMATE/uninstall;
    ;;
*)
    echo $"Usage: $0 {install|uninstall}"
    exit 1
esac

