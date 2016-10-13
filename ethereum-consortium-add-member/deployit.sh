#!/usr/bin/env bash

GROUP=$1;
LOCATION="australiasoutheast";

azure group create $GROUP --location $LOCATION -t blockchain=yes;
azure group deployment create -v -g $GROUP -n arm1 -f ./azuredeploy.json -e ./deploy-test.json 

