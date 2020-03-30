# Demo of vagrant (boxes, provisioning)

## Simple, small box (`simple/`)

* Purpose:
* box: minimal/xenial64
* port forwarding: guest port 8000 is mapped to host port 8080
* X11 forwarding: **none** (*i.e.*, X11 not installed)
* host directory is mapped to `/home/vagrant/code`
* provisioning via the shell script `simple-provision.sh`


## Medium, typical box (`medium-java/`)

* Purpose:
* box: bento/ubuntu-18.04
* port forwarding: **none**
* X11 forwarding: **none** (*i.e.*, X11 not installed)
* host directory is mapped to `/home/vagrant/code`
* provisioning via the shell script `medium-java-provision.sh`


## Medium, X11 (`medium-csc230/`)

* Purpose:
* box: ubuntu/trusty64
* port forwarding: **none**
* X11 forwarding: enabled
* host directory is mapped to `/home/vagrant/code`
* provisioning via the shell script `medium-csc230-provision.sh`
* Installed the MARS MIPS simulator:
    * Link: https://courses.missouristate.edu/KenVollmar/mars/index.htm
    * This depends upon Java


## Some tutorials, how-tos for Vagrant

* http://www.thisprogrammingthing.com/2013/getting-started-with-vagrant/

* https://www.howtoforge.com/setup-a-local-wordpress-development-environment-with-vagrant/

* https://www.interserver.net/tips/kb/configure-wordpress-external-database/

* (for idea on using `expect` during provisioning): https://gist.github.com/Mins/4602864
