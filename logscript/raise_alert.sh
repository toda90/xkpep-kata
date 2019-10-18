#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd ${SCRIPTPATH}

date=$(date +%Y.%m.%d)
errcount=$(curl -s -H 'Content-Type: application/json' -XPOST "localhost:9200/logstash-${date}/_search?pretty" -d '
{
  "query": { "match_all": {} }
}'  | grep code | grep 4.. | wc -l)
sum=$(cat controlfile.txt | cut -d";" -f2 | paste -sd+ | bc)
lastnotcount=$(cat notificationfile.txt)
oldcount=$(cat controlfile.txt | grep ${date} | cut -d";" -f2)

if [ "${sum}" -ge $((${lastnotcount} + 10)) ]
  then
    echo "sending alert!"
    sed -i "s/${lastnotcount}/${sum}/g" notificationfile.txt
fi

if [ "${oldcount}" == "${errcount}" ]
  then
    exit
  else
    if [ "${oldcount}" == "" ]
      then
        echo "${date};${errcount}" >> controlfile.txt
        exit
      else 
        sed -i "s/${date};${oldcount}/${date};${errcount}/g" controlfile.txt
    fi
fi
