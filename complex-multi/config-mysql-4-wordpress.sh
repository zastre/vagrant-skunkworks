#!/bin/bash

# To get this to work, depending upon an idea found at
# https://bit.ly/3bEJe2N

# Depending upon $MYSQL_ROOT_PASSWORD and $WEB_BIND_ADDRESS having been
# exported into environment at some earlier time.
#
# Put different, the assumption is that _this_ script has been
# called by some other script performing the exports.

sudo mysql --defaults-extra-file=./code/db-login.rc <<MYSQL_INPUT
CREATE DATABASE wordpress;
CREATE USER 'wordpressUser'@'${WEB_BIND_ADDRESS}' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressUser'@'${WEB_BIND_ADDRESS}';
FLUSH PRIVILEGES;
MYSQL_INPUT
