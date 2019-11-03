#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd ${SCRIPTPATH}

. ./setup.cfg

minikube start --memory=${ALLOCATED_RAM} --cpus=${ALLOCATED_CPU}
minikube addons enable dashboard
minikube addons enable default-storageclass 
minikube addons enable ingress 
minikube addons enable metrics-server
minikube addons enable storage-provisioner 
