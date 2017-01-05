#!/bin/bash

LOG=/root/install.log
SCRIPTS=/root/scripts
CURLARGS="-S -s --connect-timeout 5 --retry 15"

date > $LOG
echo $0 $@ >> $LOG
mkdir -p $SCRIPTS
SCRIPT_COMPLETE=$SCRIPTS/.complete.0

if [ ! -f $SCRIPT_COMPLETE ]; then
  export DEBIAN_FRONTEND=noninteractive
  apt-mark hold walinuxagent >> $LOG 2>&1
  URL=https://gist.githubusercontent.com/ericmaino/32d7155dedcf3d020f3a35bcea494ff7/raw/6824ea7d00f4c939c0f0ecba3351060a2820d2ea/install-docker-ubuntu1604.sh
  echo "Downloading from $URL" >> $LOG 2>&1
  curl $CURLARGS -o $SCRIPTS/installDocker.sh $URL >> $LOG 2>&1
  sh $SCRIPTS/installDocker.sh >> $LOG 2>&1
  echo > $SCRIPT_COMPLETE
fi

echo >> $LOG 2>&1
date >> $LOG 2>&1
echo "Downloading from $1" >> $LOG 2>&1
SCRIPT=$SCRIPTS/setupMachine.sh
curl $CURLARGS -o $SCRIPT $1/initNode.sh >> $LOG 2>&1

if [ ! -f $SCRIPT ]; then
  echo "Failed to download $SCRIPT" >> $LOG 2>&1
  exit 2
fi

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
sh $SCRIPT $NEWARGS >> $LOG 2>&1