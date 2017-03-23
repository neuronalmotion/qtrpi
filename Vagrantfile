# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  #config.vm.box = "ubuntu/xenial64"
  config.vm.box = "bento/ubuntu-16.04"
 
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 8
  end

  config.vm.provision :ansible do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "ansible/vagrant.yml"
  end

end
