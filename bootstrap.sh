#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "*** Install docker container engine ***"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update && apt-get install -y docker-ce
systemctl enable docker && systemctl start docker

echo "*** Install kubelet kubeadm kubectl ***"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update && apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# Set Root password
echo "*** Set root password ***"
echo -e "kubeadmin\nkubeadmin" | passwd 2>/dev/null

# Enable ssh password authentication
echo "*** Enable ssh password authentication ***"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl reload sshd
