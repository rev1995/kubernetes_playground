# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

NUM_MASTER_NODE = 1
NUM_WORKER_NODE = 2

Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: <<-SHELL
        apt-get update -y
        echo "10.0.0.10  master-1" >> /etc/hosts
        echo "10.0.0.11  worker-1" >> /etc/hosts
        echo "10.0.0.12  worker-2" >> /etc/hosts
  SHELL
  
  config.vm.box = "ubuntu/bionic64"
  config.vm.box_check_update = false
  # Provision Master Nodes
  (1..NUM_MASTER_NODE).each do |i|
      config.vm.define "kmaster-#{i}" do |node|
        # Name shown in the GUI
        node.vm.network "private_network", ip: "10.0.0.10"
        node.vm.hostname = "master-#{i}"
        node.vm.provider "virtualbox" do |vb|
            vb.name = "kubernetes-master-#{i}"
            vb.memory = 2048
            vb.cpus = 2
        end
        # Update hostfile
        # node.vm.provision "setup-hosts", :type => "shell", :path => "host.sh" do |s|
        #   s.args = ["enp0s8"]
        # end
        # Install docker community edition
        node.vm.provision "bootstrap-> docker & Kubeadm in Master", type: "shell", :path => "bootstrap.sh"
        node.vm.provision "scripts to run in master", type: "shell", :path => "master.sh"
      end
  end

  # Provision Worker Nodes
  (1..NUM_WORKER_NODE).each do |i|
      config.vm.define "kworker-#{i}" do |node|
        # Name shown in the GUI
        node.vm.network "private_network", ip: "10.0.0.1#{i}"
        node.vm.hostname = "worker-#{i}"
        node.vm.provider "virtualbox" do |vb|
            vb.name = "kubernetes-worker-#{i}"
            vb.memory = 2048
            vb.cpus = 1
        end
        # Update hostfile
        # node.vm.provision "setup-hosts", :type => "shell", :path => "host.sh" do |s|
        #   s.args = ["enp0s8"]
        # end
        # Install docker community edition
        node.vm.provision "bootstrap-> docker & Kubeadm on Worker", type: "shell", :path => "bootstrap.sh"
        node.vm.provision "scripts to run in worker", type: "shell", :path => "worker.sh"
      end
   end
end
