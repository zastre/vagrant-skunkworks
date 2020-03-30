# Complex configuration (two server instances)

* Idea: Provision an instance of WordPress where there is a `web` server
instance and a separate `db` server instance.

* Also provision both `web` and `db` without requiring
intervention or interaction.

* Assumption: The `db` instance is provisioned **first**, and only
**after this succeeds** is the `web` instance provisioned. That is,
Wordpress is installed on the `web` server and will require a running
`db` server before any Wordpress-site setup is possible.

* `ssh` protocol ports are forwarded for both servers.
Doing this ensures we do not have quasi-random ports being assigned
for `22` during booting necessary for `vagrant up` (i.e., the way
`vagrant` resolves collisions with port `22). By predictably
forwarding port `22`, we can write scripts relying the forwarded port
number no longer changing from `up` to `up`.

    * To `10122` for `web`
    * To `10222` for `deb`

* When `db` comes up for the first time, followed by `web`, the latter
  can be used to configure a new Wordpress site (i.e., combination of
  files on `web` and data on `db`). The address
  `http://192.168.56.101` will take you to the starting point of
  Wordpress-site setup.


## Configuring `db`

* `Vagrantfile`: `db` is given an address on the local network (i.e.,
an `192.168.*.*` address). **Gotcha:** Configuration may not work if your
network already `192.168.56.102`.

* Provision script:
    * `vagrant up db`
    * Assumption: provision script runs as root (so no need for
      `sudo` before commands).
    * Install `expect` to help respond to prompts without interaction
    * Install `mysql`
    * Run `mysql_secure_installation` but use `expect` to provide
      needed prompts.
    * Modify `bind-address` in `/etc/mysql/mysql.conf.d/mysqld.cnf` to
      refer to the local-network address we have given to this `db`
      instance; restart the daemon.
    * Run `config-mysql-4-wordpress.sh` to add user, database,
      privileges, etc. needed once `web` connects to this database.
      (This script depends upon `db-local.rc` for MySQL root-user login
      access + password.)
    * In the previous step, user `wordpressUser` is permitted to
      connect to `db` via the `mysql` client if this is done
      from the `web` instance, *i.e.*,

    ```mysql -u wordpressUser -p -h192.168.56.102```

    * Shell access of the  `db` instance is via `vagrant ssh db`.

## Configuring `web`

* `Vagrantfile`: `web` is given an address on the local network (i.e.,
`192.168.*.*` address). **Gotcha:** Configuration may not work if your
network already uses `192.168.56.101`.

* Provision script:
    * `vagrant up web`
    * Assumption: provision script runs as root (so no need for
      `sudo` before commands).
    * Must first add `ppa:ondrej/php` as a repository in order to get
      the various `php`-related libraries need for `PHP 7.2`.
    * Fetch and install some needed packages & libraries.
    * Download and configure Wordpress; important here is to
      ensure it uses the MySQL instance at `192.168.56.102`.
 

## Some resources

* [General stuff on multiple servers] https://www.vagrantup.com/docs/multi-machine/

* [Specific details on two servers, `web` and `db`]
https://www.thisprogrammingthing.com/2015/multiple-vagrant-vms-in-one-vagrantfile/

* [Configuration where Wordpress and the needed MySQL instance are on
different servers.]
https://www.interserver.net/tips/kb/configure-wordpress-external-database/

* [Wordpress installation via script] https://gist.github.com/bgallagh3r/2853221

* [`expect` incantation to help with MySQL installation]
https://gist.github.com/Mins/4602864

* [Some bits and pieces helpful when eliminating need for interactive
session with `mysql` client.]
https://www.oreilly.com/library/view/mysql-cookbook-2nd/059652708X/ch01s30.html
