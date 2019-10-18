#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd ${SCRIPTPATH}

. ./setup.cfg

crontab -l > mycron
echo "* * * * * ${SCRIPTPATH}/logscript/raise_alert.sh" > mycron
crontab mycron
rm mycron
