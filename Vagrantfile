# -*- mode: ruby -*-
# vi: set ft=ruby :
 
Vagrant.configure(2) do |config|
 
  # use a centos7 base image for guest VM
  config.vm.box = "centos/7"

  # name of box: <last folder name>-dart-<random number>
  config.vm.define :dart_local do |t|
  end
 
  # forwarding ports for dokcer, postgres, elasticmq, nginx/flask (5000)
  config.vm.network "forwarded_port", guest: 2376, host: 2376, protocol: "tcp" # docker
  config.vm.network "forwarded_port", guest: 5432, host: 5432, protocol: "tcp" # postgres
  config.vm.network "forwarded_port", guest: 9324, host: 9324, protocol: "tcp" # elasticmq
  config.vm.network "forwarded_port", guest: 5000, host: 5000, protocol: "tcp" # dart-web

  # Files in the same folder as the Vagrantfile will be synched in guest machine via /vagrant_data
  config.vm.synced_folder ".", "/vagrant_data"
 
  # set memory of VM to 2GB
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "2048"
  end
 
  # :privileged => false means we run as the vagrant user (not running using sudo which creating root permissions on files)
  config.vm.provision "shell", path: "./vagrant_scripts/vm_setup.sh", :privileged => false
end
