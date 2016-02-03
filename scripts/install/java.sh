#!/bin/bash
#
if [[ $UID != 0 ]]; then
    echo "Please type sudo $0 $*to use this."
    exit 1
fi

JAVAV=8;

bash ../../system/repository.sh ppa:webupd8team/java
apt-get update;
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
bash ../../system/package.sh oracle-java$JAVAV-installer;

# Setting Java environment variables
apt-get -y install oracle-java$JAVAV-set-default;
update-java-alternatives -s java-$JAVAV-oracle;
