# medium-lang

* Main purpose of this server is to show:
    1. Multiple versions of `python`, `gcc`, and `g++` on the same
      machine.
    1. Demonstrate a version of the provision script as inlined within
       the `Vagrantfile` itself.

## `python`

* Installed are 2.7 and 3.6
* Default is 3.6
* To select / switch, use `sudo update-alternatives --config python`
* Also installed: `pytest`


## C++/`g++`

* Installed are `g++` versions 5, 7, and 9
* Default is 9
* To select / switch, use `sudo update-alternatives --config g++`


## C++/`gcc`

* Installed are `gcc` versions 5, 7, and 9
* Default is 9
* To select / switch, use `sudo update-alternatives --config gcc`
* Also installed `valgrind`


## Resources

* https://askubuntu.com/questions/26498/how-to-choose-the-default-gcc-and-g-version
