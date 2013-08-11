# Vagrant Salt LAMP

This allows to create basic LAMP  development environment in a virtual machine managed by Vagrant and Salt.

## Requirements:
- Curl (to do the installation)
- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](http://www.vagrantup.com/) > 1.1
- [Salty Vagrant Plugin](https://github.com/saltstack/salty-vagrant)
- [Vagrant Hostmanager Plugin](https://github.com/smdahlen/vagrant-hostmanager)

Reading about Virtualbox, Vagrant and Salt is highly recommended.
Basic understnading of [YAML](http://en.wikipedia.org/wiki/YAML) will help to in order to modify the settings files

## Additional Optional Vagrant Plugins:
- [Vagrant VbGuest](https://github.com/dotless-de/vagrant-vbguest) (Highly recommended for the VM to get the latest VirtualBox Guest Additions intalled automatically)
- [Vagrant Shell Commander](https://github.com/fgimenez/vagrant-shell-commander)
- [Vagrant dnsmasq](https://github.com/mattes/vagrant-dnsmasq)
- [Vagrant Box Updater](https://github.com/spil-ruslan/vagrant-box-updater)

See list of more plugins at: [https://github.com/mitchellh/vagrant/wiki/Available-Vagrant-Plugins](https://github.com/mitchellh/vagrant/wiki/Available-Vagrant-Plugins)

## Installation
`curl -L https://github.com/davidlonjon/vagrant-salt-lamp/archive/master.tar.gz | tar zx`

## Usage

Go into the extracted directory
`cd vagrant-salt-lamp-master`

Edit settings.yml & ./shares/srv/pillar/settings.sls to be specific to your project
- `vi settings.yml`
- `vi ./shares/srv/pillar/settings.sls`

Run vagrant
`vagrant up`

SSH into your newly created virtual machine
` vagrant ssh`
in which  you should have a full LAMP stack.

## What'll get

### Installed Software
By default:

A Vagrant/Virtualbox virtual machine installed with Ubuntu Precise64

Inside the VM:
- Default tools:
  - git
  - curl
  - vim
  - tmux
  - screen
  - htop
  - mytop
  - nmon
  - perl and perl libraries which will allow to install manually innotop
- Apache
- MySQL
- php
- phpMyAdmin
## Defaults

## Issues:
- Removal of hosts entries on host machine does not seems to work
- Problem with installing compass at first run of 'vagrant up' command

## Notes

**Only been test on MAC (Tested on Lion OSX 10.8.4)  as host and Ubunut Precise64 (12.04) as guest**.

It is unlikely to work on Windows.

## Todo
  Possible add the following to the setup:
  - Webgind
  - Jenkins
  - Capistrano
  - Fabric
  - Redis
  - Postfix

## Credits
  This project and code have been directly inspired by or copied from:
  - [https://github.com/Virtualmaster/ha-lamp-salt-states/](https://github.com/Virtualmaster/ha-lamp-salt-states/)
  - [https://github.com/tony/salt-states-configs](https://github.com/tony/salt-states-configs)
  - [https://github.com/auser/states/](https://github.com/auser/states/)
  - [https://github.com/MiniCodeMonkey/](https://github.com/MiniCodeMonkey/)
  - [https://github.com/trilan/salt-states/](https://github.com/trilan/salt-states/)
