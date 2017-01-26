#!/bin/bash

LOG=/root/install.log
SCRIPTS=/root/scripts
ROOT_URL=$1
JSON_PAYLOAD=$2
CURLARGS="-S -s --connect-timeout 5 --retry 15"

download() {
  echo >> $LOG 2>&1
  date >> $LOG 2>&1
  echo "Downloading from $1" >> $LOG 2>&1
  curl $CURLARGS -o $2 $1 >> $LOG 2>&1

  if [ ! -f $2 ]; then
    echo "Failed to download $2" >> $LOG 2>&1
    exit 2
  fi
}

date > $LOG
echo $0 $@ >> $LOG
mkdir -p $SCRIPTS
SCRIPT_COMPLETE=$SCRIPTS/.complete.0

if [ ! -f $SCRIPT_COMPLETE ]; then
  export DEBIAN_FRONTEND=noninteractive
  apt-mark hold walinuxagent >> $LOG 2>&1
  URL=https://gist.githubusercontent.com/ericmaino/32d7155dedcf3d020f3a35bcea494ff7/raw/6824ea7d00f4c939c0f0ecba3351060a2820d2ea/install-docker-ubuntu1604.sh
  download $URL $SCRIPTS/installDocker.sh
  sh $SCRIPTS/installDocker.sh >> $LOG 2>&1
  echo > $SCRIPT_COMPLETE
fi

apt-get install -y nodejs-legacy npm >> $LOG 2>&1
echo $JSON_PAYLOAD | base64 -d > $SCRIPTS/data.json
download $ROOT_URL/initScripts/initNode.js $SCRIPTS/initNode.js 
download $ROOT_URL/initScripts/package.json $SCRIPTS/package.json 

for ARG in "$@"
do
  if [ -z "$SKIP" ]; then
    SKIP=1
  else
     NEWARGS="$NEWARGS $ARG"
  fi
done

ACTIVE_DIR=$(pwd)
cd $SCRIPTS
npm install >> $LOG 2>&1
node initNode.js >> $LOG 2>&1
cd $ACTIVE_DIR
