#!/bin/bash

echo "*** Initialize Kubernetes Cluster ***"
kubeadm init --apiserver-advertise-address=172.42.42.100 --pod-network-cidr=10.244.0.0/16

echo "*** Copy kube admin config to Vagrant user .kube directory ***"
mkdir /home/vagrant/.kube
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

echo "*** Deploy flannel network ***"
su - vagrant -c "kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"

echo "*** Generate and save cluster join command to ~/joincluster.sh ***"
kubeadm token create --print-join-command > /root/joincluster.sh
