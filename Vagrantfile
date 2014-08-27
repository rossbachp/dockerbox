# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "trusty64"
  # 359Mb
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.define :dockerbox do |c|
    c.vm.network "private_network", ip: "192.168.50.4"
    c.vm.host_name = "dockerbox.example.com"
    c.vm.provider 'virtualbox' do |vb|
         vb.gui = false
    vb.customize [ 'modifyvm', :id, '--nicpromisc2', 'allow-all']
         vb.customize [ 'modifyvm', :id, '--memory', '1024']
         vb.customize [ 'modifyvm', :id, '--cpus', '2']
         vb.name = 'dockerbox'
    end

    c.vm.synced_folder "docker.d", "/srv/docker"

    c.vm.provision "shell", path: 'provision.d/01_packages.shprov'
    c.vm.provision "shell", path: 'provision.d/10_docker.shprov'
    c.vm.provision "shell", path: 'provision.d/15_docker_prepare_image.shprov'
    c.vm.provision "shell", path: 'provision.d/16_docker_tools.shprov'

  end
end
