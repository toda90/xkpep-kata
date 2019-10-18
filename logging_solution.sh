#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd ${SCRIPTPATH}

. ./setup.cfg

cd xpep-kata/yaml
kubectl create namespace logging
kubectl create -f fluent_bit_configmap.yml
kubectl create -f fluent_bit_service_account.yml
kubectl create -f fluent_bit_role.yml
kubectl create -f fluent_bit_role_binding.yml
kubectl create -f fluent_bit_daemonset.yml
