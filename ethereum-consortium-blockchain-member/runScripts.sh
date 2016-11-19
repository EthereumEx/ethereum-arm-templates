#!/bin/bash

LOG=/root/install.log
SCRIPTS=/root/scripts

date > $LOG
mkdir -p $SCRIPTS
export DEBIAN_FRONTEND=noninteractive
apt-mark hold walinuxagent
curl -S -s -o $SCRIPTS/installDocker.sh https://gist.githubusercontent.com/ericmaino/32d7155dedcf3d020f3a35bcea494ff7/raw/6824ea7d00f4c939c0f0ecba3351060a2820d2ea/install-docker-ubuntu1604.sh >> $LOG 2>&1
sh $SCRIPTS/installDocker.sh >> $LOG 2>&1

echo >> $LOG 2>&1
date >> $LOG 2>&1
echo "Downloading from $1" >> $LOG 2>&1
curl  -S -s -o $SCRIPTS/setupMachine.sh $1/initNode.sh >> $LOG 2>&1

NEWARGS=
SKIP=

for ARG in "$@"
do
  if [ -z "$SKIP" ]; then
    SKIP=1
  else
     NEWARGS="$NEWARGS $ARG"
  fi
done


echo $NEWARGS >> $LOG 2>&1
sh $SCRIPTS/setupMachine.sh $NEWARGS >> $LOG 2>&1