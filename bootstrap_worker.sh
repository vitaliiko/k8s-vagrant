#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "*** Join node to Kubernetes Cluster ***"
apt-get install -y sshpass >/dev/null 2>&1
sshpass -p "kubeadmin" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no 172.42.42.100:~/joincluster.sh ~/joincluster.sh
bash ~/joincluster.sh
