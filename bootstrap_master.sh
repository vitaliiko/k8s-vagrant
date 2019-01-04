#!/bin/bash

echo "*** Initialize Kubernetes Cluster ***"
IPADDR=$(ip a show enp0s8 | grep inet | grep -v inet6 | awk '{print $2}' | cut -f1 -d/)
kubeadm init --apiserver-advertise-address=$IPADDR --pod-network-cidr=10.244.0.0/16

echo "*** Copy kube admin config to Vagrant user .kube directory ***"
mkdir /home/vagrant/.kube
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

echo "*** Deploy pods network ***"
su - vagrant -c 'kubectl apply -f /vagrant/kube-flannel.yml'
#su - vagrant -c "kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"
#su - vagrant -c "kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')""

echo "*** Setting up Kubernetes Dashboard ***"
su - vagrant -c 'kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml'

echo "*** Generate and save cluster join command to ~/joincluster.sh ***"
kubeadm token create --print-join-command > /root/joincluster.sh
