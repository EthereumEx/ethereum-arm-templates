# Ethereum Consortium Member


[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FEthereumEx%2Fethereum-arm-templates%2Fmaster%2Fethereum-consortium-blockchain-member%2Ftemplate.consortiumMember.json)  
[![Visualize](http://armviz.io/visualizebutton.png)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FEthereumEx%2Fethereum-arm-templates%2Fmaster%2Fethereum-consortium-blockchain-member%2Ftemplate.consortiumMember.json)

## Overview
The goal of this template, which was inspired by the [Ethereum Consortium Network template](https://github.com/Azure/azure-quickstart-templates/tree/master/ethereum-consortium-blockchain-network), is to make it easy to spin up a Blockchain network will work on it's own or that could easily be connected to an existing network.

## Features

### Virtual Machine Scale Sets
Miners and transaction nodes are part of a VM scale set which makes it very easy to scale up or scale down the nodes in the network.

### Ethereum Network Stats - Dashboard
The [Ethereum Network Stats](https://github.com/EthereumEx/eth-netstats) dashboard is automatically deployed as is the [agent](https://github.com/EthereumEx/eth-net-intelligence-api)

### Docker Containers
All of the nodes in the network are assembled by using docker containers from [EthereumeEx images](https://github.com/EthereumEx/hackfest-images). This should make it easy in the future to roll out updates to the network as the data is stored on the host machines. 