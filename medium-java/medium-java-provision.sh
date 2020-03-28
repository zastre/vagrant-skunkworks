#!/usr/bin/env bash

# Has the instance already been provisioned? If so, exit.

if [ -f "/var/vagrant_provision" ]; then
    exit 0
fi

set -x -e


apt-get update > /dev/null 2>&1

apt-get install -y default-jdk

apt-get install -y vim > /dev/null 2>&1

touch /var/vagrant_provision

# Might be necessary, might be not.
# reboot
