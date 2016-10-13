#!/usr/bin/env bash

# TODO:  collision detection on groups

GROUP=$1;
LOCATION="australiasoutheast";

azure group create $GROUP --location $LOCATION -t blockchain=yes;
azure group deployment create -v -g $GROUP -n arm1 -f ./azuredeploy.json -e ./deploy-test.json 

