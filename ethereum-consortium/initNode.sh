#!/bin/bash

echo "Starting Machine Initialization"
if [ "$#" -eq 2 ]; then
        DOCKER_TAG=$1
        WS_SECRET=$2

        docker pull ethereumex/eth-stats-dashboard:$DOCKER_TAG
        docker run -td \
                --name dashboard \
                --restart always \
                -p 0.0.0.0:3000:3000 \
                -p 0.0.0.0:3001:3001 \
                -e WS_SECRET=$WS_SECRET \
                ethereumex/eth-stats-dashboard:$DOCKER_TAG
fi

if [ "$#" -ne 1 ]; then
        DOCKER_TAG=$1
        BOOTNODE_NETWORK=$2
        BOOTNODE_PUBLIC_IP=$3
        DASHBOARD_IP=$4
        REGISTRAR_IP=$5
        MINER_THREADS=$6
        GENESIS_URL=$7
        NETWORK_ID=$8
        WS_SECRET=$9
        MINER_ADDRESS=${10}

        WS_SERVER="ws://$DASHBOARD_IP:3000"
        BOOTNODE_URL="http://$REGISTRAR_IP:3001"
        ENABLE_MINER=

        if [ "$MINER_ADDRESS" ]; then
                ENABLE_MINER="-e ENABLE_MINER=1 -e MINER_ADDRESS=$MINER_ADDRESS"
        fi

        USER=azureuser
        GETHROOT=/home/$USER/geth
        HOST_IP=$(ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://')
        NODE_NAME=$(hostname)

        mkdir -p $GETHROOT/.data
        curl -S -s -o $GETHROOT/genesis.json $GENESIS_URL
        chown -R $USER $GETHROOT

        docker pull ethereumex/geth-node:$DOCKER_TAG
        docker run -td \
                --name geth-node \
                --restart always \
                -p 0.0.0.0:8545:8545 \
                -p 0.0.0.0:8546:8546 \
                -p 0.0.0.0:30303:30303 \
                -p 0.0.0.0:30303:30303/udp \
                -v $GETHROOT/genesis.json:/home/geth/genesis.json \
                -v $GETHROOT/.data:/home/geth/.geth \
                -e NETWORKID=$NETWORK_ID -e WS_SERVER=$WS_SERVER -e WS_SECRET=$WS_SECRET \
                -e NODE_NAME=$NODE_NAME \
                -e INSTANCE_NAME=$NODE_NAME \
                -e BOOTNODE_URL=$BOOTNODE_URL \
                -e BOOTNODE_NETWORK=$BOOTNODE_NETWORK \
                -e BOOTNODE_PUBLIC_IP=$BOOTNODE_PUBLIC_IP \
                -e HOST_IP=$HOST_IP \
                -e MINER_THREADS=$MINER_THREADS \
                $ENABLE_MINER \
                ethereumex/geth-node:$DOCKER_TAG
fi

