#!/bin/bash

echo "Starting Machine Initialization"
if [ "$#" -eq 1 ]; then
        WS_SECRET=$1
        docker pull ethereumex/eth-stats-dashboard
        docker run -td \
                --name dashboard \
                --restart always \
                -p 0.0.0.0:3000:3000 \
                -p 0.0.0.0:3001:3001 \
                -e WS_SECRET=$WS_SECRET \
                ethereumex/eth-stats-dashboard
fi

if [ "$#" -ne 1 ]; then
        GENESIS_URL=$1
        NETWORK_ID=$2
        BOOTNODE_NETWORK=$3
        BOOTNODE_PUBLIC_IP=$4
        WS_SECRET=$5
        
        WS_SERVER="ws://$6:3000"
        BOOTNODE_URL="http://$7:3001"
        ENABLE_MINER=

        if [ "$8" ]; then
                ENABLE_MINER="-e ENABLE_MINER=1 -e MINER_ADDRESS=$8"
        fi

        USER=azureuser
        GETHROOT=/home/$USER/geth
        HOST_IP=$(ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://')
        NODE_NAME=$(hostname)

        mkdir -p $GETHROOT/.data
        curl -S -s -o $GETHROOT/genesis.json $GENESIS_URL
        chown -R $USER $GETHROOT

        docker pull ethereumex/geth-node
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
                $ENABLE_MINER \
                ethereumex/geth-node
fi

