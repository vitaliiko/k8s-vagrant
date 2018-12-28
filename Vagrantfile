
# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  config.vm.provision "shell", path: "bootstrap.sh"

  # Kubernetes Master Server
  config.vm.define "k8s-master" do |kmaster|
    kmaster.vm.box = "ubuntu/xenial64"
    kmaster.vm.hostname = "k8s-master"
    kmaster.vm.network "private_network", ip: "172.42.42.100"
    kmaster.vm.provider "virtualbox" do |v|
      v.name = "k8s-master"
      v.memory = 2048
      v.cpus = 2
    end
    kmaster.vm.provision "shell", path: "bootstrap_master.sh"
  end

  NodeCount = 2

  # Kubernetes Worker Nodes
  (1..NodeCount).each do |i|
    config.vm.define "k8s-worker-#{i}" do |workernode|
      workernode.vm.box = "ubuntu/xenial64"
      workernode.vm.hostname = "k8s-worker-#{i}"
      workernode.vm.network "private_network", ip: "172.42.42.10#{i}"
      workernode.vm.provider "virtualbox" do |v|
        v.name = "k8s-worker-#{i}"
        v.memory = 2048
        v.cpus = 2
      end
      workernode.vm.provision "shell", path: "bootstrap_worker.sh"
    end
  end
end