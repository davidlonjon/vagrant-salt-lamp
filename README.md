# Vagrant Salt LAMP

 **FOR MAC (Tested on Lion 10.8.4)  & LINUX  (Roughly tested on ubuntu)**

This allows to create basic LAMP setup on a virtual machine managed by Vagrant and Salt.

## Required Prerequesites:
- Curl
- Vagrant > 1.1 ([http://www.vagrantup.com/](http://www.vagrantup.com/))
- Salty Vagrant Plugin (https://github.com/saltstack/salty-vagrant)
- Vagrant Hostmanager Plugin (https://github.com/smdahlen/vagrant-hostmanager)

Additional Optional Vagrant Plugins:
- Vagrant VbGuest Plugin (https://github.com/dotless-de/vagrant-vbguest)
- Vagrant Shell Commander Plugin (https://github.com/fgimenez/vagrant-shell-commander)
- Vagrant dnsmasq Plugin (https://github.com/mattes/vagrant-dnsmasq)
- Vagrant Box Updater Plugin (https://github.com/spil-ruslan/vagrant-box-updater)

See list of more plugins at: https://github.com/mitchellh/vagrant/wiki/Available-Vagrant-Plugins

## Issues:
- Removal of hosts entries on host machine does not seems to work
