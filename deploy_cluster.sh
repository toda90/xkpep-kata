#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd ${SCRIPTPATH}

. ./setup.cfg

cd ./yaml
kubectl apply -f ./mysql_pv.yml
kubectl apply -f ./mysql_pvc.yml
kubectl apply -f ./mysql_app.yml
kubectl apply -f ./mysql_svc.yml
kubectl apply -f ./joomla_app.yml
kubectl apply -f ./joomla_svc.yml
kubectl apply -f ./ingress.yml
