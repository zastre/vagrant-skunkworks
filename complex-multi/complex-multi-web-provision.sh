#!/usr/bin/env bash

# Has the instance already been provisioned? If so, exit.

if [ -f "/var/vagrant_provision" ]; then
    exit 0
fi

set -x -e

source ./code/include.sh

apt-get update > /dev/null 2>&1
add-apt-repository ppa:ondrej/php -y

apt-get install apache2 -y
apt-get install php7.2 php7.2-curl -y
apt-get install php7.2-mysql php7.2-mbstring -y
apt-get install php7.2-dom php7.2-gd -y
apt-get install libapache2-mod-php7.2
apt-get install mysql-client -y

service apache2 restart


#
# Wave the "I'm here!"  flag. That is, heading to 192.168.56.101 in 
# the web-browser should pull up the PHP config info page.
#

rm /var/www/html/index.html
cp ./code/index.php /var/www/html/index.php


#
# Download and configure Wordpress so that someone can
# go to the web address and begin a new site.
#
# Based on a script shown at:
# https://gist.github.com/bgallagh3r/2853221

DB_NAME="wordpress"
DB_USER="wordpressUser"
DB_PASSWORD=$MYSQL_ROOT_PASSWORD
DB_HOST=$DB_BIND_ADDRESS

curl -O https://wordpress.org/latest.tar.gz
tar -zxf latest.tar.gz
cd wordpress

cp wp-config-sample.php wp-config.php

sed -i "s/database_name_here/$DB_NAME/g" wp-config.php
sed -i "s/username_here/$DB_USER/g" wp-config.php
sed -i "s/password_here/$DB_PASSWORD/g" wp-config.php
sed -i "s/localhost/$DB_HOST/g" wp-config.php

# set WP salts
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php

mkdir wp-content/uploads
chmod 775 wp-content/uploads
mv * /var/www/html

cd ..
\rm -rf wordpress
\rm latest.tar.gz

chown -R www-data:www-data /var/www/html


#
# Existence of file below is used during `vagrant up` to determine
# if provisioning is required. If absent: provision; if present,
# do not re-provision.
#

touch /var/vagrant_provision

# Might be necessary, might be not.
# reboot
