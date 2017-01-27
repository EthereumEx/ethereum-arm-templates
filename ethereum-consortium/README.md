# Ethereum Consortium


[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FEthereumEx%2Fethereum-arm-templates%2Fmaster%2Fethereum-consortium%2Ftemplate.consortium.json)
[![Visualize](http://armviz.io/visualizebutton.png)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FEthereumEx%2Fethereum-arm-templates%2Fmaster%2Fethereum-consortium%2Ftemplate.consortium.json)

![Deployment Test Result](https://dpeted.visualstudio.com/_apis/public/build/definitions/f172cbc4-c5dd-4e53-a795-ed5dc807800c/154/badge) - Deployment Validation Result

## Overview
The goal of this template, which was inspired by the [Ethereum Consortium Network template](https://github.com/Azure/azure-quickstart-templates/tree/master/ethereum-consortium-blockchain-network), is to make it easy to spin up a Blockchain network will work on it's own or that could easily be connected to an existing network.

## Features

### Virtual Machine Scale Sets
Miners and transaction nodes are part of a VM scale set which makes it very easy to scale up or scale down the nodes in the network.

### Ethereum Network Stats - Dashboard
The [Ethereum Network Stats](https://github.com/EthereumEx/eth-netstats) dashboard is automatically deployed as is the [agent](https://github.com/EthereumEx/eth-net-intelligence-api)

### Docker Containers
All of the nodes in the network are assembled by using docker containers from [EthereumeEx images](https://github.com/EthereumEx/hackfest-images). This should make it easy in the future to roll out updates to the network as the data is stored on the host machines.

## Getting Started
* [Network setup walk through](docs/setupWalkthrough.md)
* [Adding a new member to a network](docs/newMemberWalkthrough.md)
* [Deploy using custom docker images](docs/customDockerDeployment.md)

## Example Parameters File
    {
        "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "consortiumName": {
            "value": "Test"
            },
            "members": {
            "value": [
                {
                    "name":"M1",
                    "minerCount" : 2,
                    "txNodeCount" : 3,
                    "minerAddress" : "0x0000000000000000000000000000000000000000",
                    "location" : "westus"
                },
                {
                    "name":"M2",
                    "minerCount" : 2,
                    "txNodeCount" : 3,
                    "minerAddress" : "0x0000000000000000000000000000000000000000",
                    "location" : "eastus"
                }
            ]
            },
            "sshPublicKey": {
                "value": ""
            },
            "genesisJson": {
                "value": ""
            },
            "gethNetworkId": {
                "value": "20161125"
            },
            "dashboardSecret": {
                "value": "abc12345"
            },
        }
    } 