#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "*** Install docker container engine ***"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update && apt-get install -y docker-ce
systemctl enable docker && systemctl start docker

echo "*** Install kubernetes tools ***"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update && apt-get install -y kubelet kubeadm kubectl kubernetes-cni

echo "*** Set root password ***"
echo -e "kubeadmin\nkubeadmin" | passwd 2>/dev/null

echo "*** Enable ssh password authentication ***"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl reload sshd

echo "*** Set kubelet node IP to private network IP"
IPADDR=$(ip a show enp0s8 | grep inet | grep -v inet6 | awk '{print $2}' | cut -f1 -d/)
sed -i "/KUBELET_EXTRA_ARGS=/c\KUBELET_EXTRA_ARGS=--node-ip=$IPADDR" /etc/default/kubelet
systemctl daemon-reload
systemctl restart kubelet

echo "*** Install ZSH ***"
apt-get install -y zsh git
su - vagrant -c 'wget -q https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh && chmod +x install.sh'
su - vagrant -c 'echo vagrant | ./install.sh && rm -f install.sh'
su - vagrant -c 'echo '"'"'PROMPT="$fg_bold[blue]%}%m ${PROMPT}"'"'"' >> ~/.zshrc'