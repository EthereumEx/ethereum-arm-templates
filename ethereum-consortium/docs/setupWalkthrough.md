# Ethereum Consortium - Network Setup #

1. **Create an account**
    * Navigate to [My Ether Wallet](http://myetherwallet.com)
    * Type in a password that will be used to secure the file generated
    * Download the Keystore file. We'll use this later.
    * Copy the address ex. 0x0000000000000000000000000000000000000000

2. **Generate the a genesis.json file**
    * Replace the 0x0000000000000000000000000000000000000000 in the alloc section of the json below with the address that you copied above.
    * Update the nonce with a valid hex value
    * Save the contents somewhere that will be accessible via a URL

            {
                "coinbase": "0x0",
                "difficulty": "0x20000",
                "extraData": "0x",
                "gasLimit": "0x2625A0",
                "mixhash": "0x0",
                "nonce": "0x0000",
                "parentHash": "0x0",
                "timestamp": "0x00",
                "alloc": {
                    "0x0000000000000000000000000000000000000000":{
                        "balance":"10000000000"
                    }
                }
            }

3. **Deploy the template**  
    [Ethereum Consortium Template](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FEthereumEx%2Fethereum-arm-templates%2Fmaster%2Fethereum-consortium%2Ftemplate.consortium.json)
    
    **Genesis Url**  
    This is the URL from Step 2

    **Geth Network Id**  
    This is a shared secret that all geth nodes need to be started with in order to communicate

    **Dashboard Secret**  
    This is a shared secret between the dashboard and it's clients

    **Members**  
    This value is expected to be an array of members that will be deployed the Network.

    *name* - a name for the members  
    *txNodeCount* - the number of transaction nodes to create for this members  
    *minerCount* - the number of miners to create for this members. This number can be 0.  
    *minerAddress* - the address that will recieve rewards for successful mining. Use the address saved from Step 1.  
    *location* - this the Azure data center location this member will be deployed to.  


        [
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

4. **Connect a local geth node**  
To be written . . .

5. **Connecting Etherem Wallet**   
To be written . . .