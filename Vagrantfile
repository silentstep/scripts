# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
# Title of the vagrant box to be provisioned
  config.vm.box = "ARTACK/debian-jessie"
# Network settings: forward ports
  config.vm.network "forwarded_port", guest: 80, host: 8080
# Network settings: setup vlan
  config.vm.network "private_network", ip: "192.168.30.20"
# Syncronise folders on host nad guest for easy file transfer
  config.vm.synced_folder "scripting/", "/home/vagrant/scripting", owner:"vagrant", group: "vagrant"
# Provision the VM with custom software
  # apache2
  # php7
  # mysql
  # custom shell scripts
  ## initialize.sh (create cronjob)
  ## db-creation.sh (create database)
  ## fetch-hook.sh (fetch data and write to db)
  config.vm.provision "shell", path: "provision.sh" 

  end
