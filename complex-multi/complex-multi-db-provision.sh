#!/usr/bin/env bash

# Has the instance already been provisioned? If so, exit.

if [ -f "/var/vagrant_provision" ]; then
    exit 0
fi

set -x -e

source ./code/include.sh

apt-get update > /dev/null 2>&1
apt-get install -y expect
apt-get install mysql-server mysql-client -y


# Some incantations to ensure we can run `mysql_secure_installation`
# while providing answers to the needed prompts. 
#
# Found said incantation at: https://gist.github.com/Mins/4602864 
# Requires a wee bit of finnessing.
#

#
# Here beginneth the incantation.
#

SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Validate password plugin:\"
send \"n\r\"

expect \"New password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"

expect \"Re-enter new password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
")


echo "$SECURE_MYSQL"

#
# Here endeth the incantation
#

#
# Update the binding address, restart the service.
#
sed -i "s/bind-address.*/bind-address = ${DB_BIND_ADDRESS}/g" \
    /etc/mysql/mysql.conf.d/mysqld.cnf
service mysql restart

#
# Configure needed database, user, etc. for Wordpress (at it
# will be used by the `web` server instance).
#

./code/config-mysql-4-wordpress.sh


#
# Existence of file is used during `vagrant up` to determine
# if provisioning is required. If absent: provision; if present,
# do not re-provision.
#

touch /var/vagrant_provision

# Might be necessary, might be not.
# reboot
