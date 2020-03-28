#!/usr/bin/env bash

# Has the instance already been provisioned? If so, exit.

if [ -f "/var/vagrant_provision" ]; then
    exit 0
fi

set -x -e


# Must jump through a few hoops in order to ensure Python 3.6
# is installed (otherwise Python 3.5 is the default)
apt-get -y install software-properties-common python-software-properties 
add-apt-repository ppa:deadsnakes/ppa > /dev/null 2>&1 -y
apt-get update > /dev/null 2>&1
apt-get install -y python3.6 > /dev/null 2>&1
apt-get install -y vim > /dev/null 2>&1

touch /var/vagrant_provision

# Might be necessary, might be not.
# reboot
