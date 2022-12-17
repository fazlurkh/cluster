#!/bin/bash
sudo kubectl apply -f "https://raw.githubusercontent.com/fazlurkh/pods/main/ts.yaml" >> /dev/null
sudo kubectl taint node `kubectl get nodes --no-headers | tail -2 | awk '{print $1}'` cka=test:NoSchedule --overwrite >> /dev/null
sudo kubectl run ckaexam --image nginx  >> /dev/null
sudo mkdir -p ~/backup
sudo cp -p ~/.kube/config ~/backup/  >> /dev/null
sudo sed -e 's/6443/9663/g' -i ~/.kube/config
sudo cp -p /etc/kubernetes/manifests/kube-apiserver.yaml ~/backup/ >> /dev/null
sudo sed -e 's/RBAC/RBAC,ROHAN/g' -i /etc/kubernetes/manifests/kube-apiserver.yaml
sudo systemctl disable --now kubelet &> /dev/null
sudo echo "Executing steps to upgrade your cluster... Please standby... "
sudo sleep 10
sudo echo "Opps ... Looks like your cluster is broken, Please fix it ... and then upgrade your cluster manually"
