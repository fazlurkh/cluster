#!/bin/bash
sudo apt-get remove docker docker-engine docker.io containerd runc
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

modprobe br_netfilter
modprobe overlay

cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system

apt-get -y update && apt-get install -y containerd.io
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml


sed -e 's/SystemdCgroup = false/SystemdCgroup = true/g' -i /etc/containerd/config.toml
systemctl daemon-reload
systemctl restart containerd
systemctl restart kubelet
