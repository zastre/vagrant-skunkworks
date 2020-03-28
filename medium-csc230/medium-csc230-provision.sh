#!/usr/bin/env bash

# Has the instance already been provisioned? If so, exit.

if [ -f "/var/vagrant_provision" ]; then
    exit 0
fi

set -x -e

apt-get update > /dev/null 2>&1
apt-get install -y default-jdk
apt-get install -y vim > /dev/null 2>&1
apt-get install -y xorg > /dev/null 2>&1
apt-get install -y xauth > /dev/null 2>&1

# Fetch the MARS simulator for MIPS
cd /home/vagrant/code
wget https://courses.missouristate.edu/KenVollmar/mars/MARS_4_5_Aug2014/Mars4_5.jar

touch /var/vagrant_provision

# Might be necessary, might be not.
# reboot
