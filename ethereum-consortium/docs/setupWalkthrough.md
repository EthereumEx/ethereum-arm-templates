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
    * [Download Geth] or use your favorite installer
    * Create a folder  
        *c:\geth* will be used for this example
    * Copy the genesis file from Step 2 to c:\geth\genesis.json
    * Initialize geth

            geth --datadir c:\geth\data init c:\geth\genesis.json
    * Obatain boot nodes
      
      Navigate to the resource group where you deployed the template. 
      There should be a resource called *XXXX-dashboard-ip*. Open this 
      resource and copy the IP.  

      Navigate to http://{copied ip}:3001/enodes. Save the returned value
      {bootnodes}.
    * Start geth  
    For this step you'll need the {network id} used in Step 3

            geth --datadir c:\geth\data --networkid {nework id} --bootnodes {bootnodes}

    * Done   
    At this point geth should be running and will eventually sychronize blocks
    from the network. It may take a few minutes for it to connect.



5. **Connecting Etherem Wallet**   
This step will configure the [Ethereum Wallet] to use the account created
in Step 1 and will talk to the network through the local geth instance from
Step 4.

    * Install the pre-funded account in the keystore  
     
      Copy the keystore file saved during Step 1 into *c:\geth\data\keystore\*  
        
      The keystore file from Step 1 is ecrypted using the password that was specified
      on the site at the time of creation. Copying the file into the keystore folder
      will allow the Wallet to access it.
    * Download and install the [Ethereum Wallet]
    * Launch the Wallet  

      The wallet by default should pick up the local geth node through the ipc
      port/file. You should see your account show up and if the network has 
      finished syncing you should see your account in the list and see the 
      pre-funded ether that was allocated in the genesis node.

## Enjoy ! ##  


[Download Geth]:https://geth.ethereum.org/downloads/
[Ethereum Wallet]:https://github.com/ethereum/mist/releases