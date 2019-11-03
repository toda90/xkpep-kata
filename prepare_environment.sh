#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd ${SCRIPTPATH}

. ./setup.cfg

setenforce 0
/usr/bin/yum update
perl -pi -e 's/SELINUX\=enforcing/SELINUX\=disabled/g' /etc/selinux/config
systemctl stop firewalld
systemctl disable firewalld
/usr/bin/yum -y install binutils qt gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms bash-completion
/usr/bin/wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo -O /etc/yum.repos.d/virtualbox.repo
/usr/bin/yum -y install VirtualBox-5.0
/usr/lib/virtualbox/vboxdrv.sh setup
/usr/bin/yum -y install git
/usr/bin/yum -y install java-1.8.0-openjdk-devel
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
FILE=$'[elasticsearch-6.x]\nname=Elasticsearch repository for 6.x packages\nbaseurl=https://artifacts.elastic.co/packages/6.x/yum\ngpgcheck=1\ngpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch\nenabled=1\nautorefresh=1\ntype=rpm-md'
echo "$FILE" > /etc/yum.repos.d/elasticsearch.repo
/usr/bin/yum -y install elasticsearch
systemctl enable elasticsearch.service
systemctl start elasticsearch.service
usermod -a -G vboxusers root
/usr/bin/curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
cp -p minikube /usr/local/bin && rm -f minikube
FILE=$'[kubernetes]\nname=Kubernetes\nbaseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg'
echo "$FILE" > /etc/yum.repos.d/kubernetes.repo
/usr/bin/yum -y install kubectl
git clone https://github.com/toda90/xpep-kata.git
chmod 775 xpep-kata
