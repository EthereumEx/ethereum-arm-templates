# Ethereum Consortium - Adding a new member

1. **Ensure a consoritum already exists**
    * In order to complete the steps listed below you will need the following items from
    the original consortium deployment
        * IP Address of the dashboard
        * A link to the genesis.json or a copy of the file
        * The network Id
        * The dashboard secret

2. **Create an account**  
    * Navigate to [My Ether Wallet](http://myetherwallet.com)
    * Type in a password that will be used to secure the file generated
    * Download the Keystore file. We'll use this later.
    * Copy the address ex. 0x0000000000000000000000000000000000000000

3. **Deploy the template**  
    [Ethereum Consortium Template](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FEthereumEx%2Fethereum-arm-templates%2Fmaster%2Fethereum-consortium%2Ftemplate.consortiumMember.json)
    
    **tx Genesis JSON**  
    The path to the URL to access the genesis file from the consortium.

    **miner Genesis JSON**  
    The path to the URL to access the genesis file from the consortium.

    **Geth Network Id**  
    This value should come from the original consortium. Step 1.

    **Dashboard Secret**  
    This value should come from the original consortium. Step 1.

    **Dashboard Ip**  
    This value should come from the original consortium. Step 1.

    **Registrar Ip**  
    This is the same value as the Dashboard Ip.
    
    **Miner Address**
    This is the account address you generated above at Step 2.

5. **Completed Deployment**
    * Once the deployment completes you will find a Dashboard IP address in the output of
    of the template. You may also find it as a resource calle {consorsortium name}-dashboard-ip.
        * Port 3000 - Eth Stats Dashboard, this is useful to see the nodes, their blocks, etc.
        * Port 3001 - Boot node registrar
