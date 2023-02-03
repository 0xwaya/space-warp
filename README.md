# ETHGlobal 
# Space 🛸 Warp hackathon

## Creating a Dapp Dex powered by (Uniswap v2.0) 
## run on FVM hyperspace testnet, deploy token,
## create FIL+SPACE pair in LP


###  (experimental code only )

### Dev:  @0xwaya


Project goal to to deploy a Dex dapp on FVM powered by uniswap. 

Create & run local FVM hyperspace testnet node on ChainStack.

```
    HTTPS endpoint: https://nd-998-437-463.p2pify.com/rpc/v0

    WSS Endpoint: wss://ws-nd-998-437-463.p2pify.com/rpc/v0

 ```

Create  & deploy SpaceCoin ERC20 token on the Chainstack Filecoin hyperspace orion node

```
    Hash: 0x54510eb3bb6020dd3d22eb2ddaec6c6c15f4ea8861fd77085a87adf78356f82b

    Space Coin (SPACE) Contract: 0x97Be9d60712b464B26e34b90A4b9324DF435C63c

    "tx_hash": bafy2bzaceccwo7edpu2ws23rn35lfjhyv2uxvb4hkftshospktcbandiyco3k

```

        
Create & deploy FilecoinMock ERC20 token on FVM hyperspace

```
    Hash: 0xcb4518e3864eca3b5a4f527439562c733645babd4f7cb75a34281be5e80d8eb5

    FileToken (FILE) Contract: 0x199656acC1A537Cc55c12fa35750b8d390eDABd2

     "tx_hash": bafy2bzacebykggxo7xf7tzm4g7muzlp2drqchlh3cehkrt6odduhm3sbi7gkk


```

Clone Uniswap v2.0 and connect to nodes using CRANQ diagrams
        // deploy in testnet

Design simple prototype app using ReactJs.
        // write the initial scripst to connect front end / wallet 

Create liquidity pool pair = FIL/SPACE
        // test and deploy

Create 2 min presentation for hackathon is everthing runs smoothly 

    



In terminal, create directory to store code in. once inside directory use this command:



```
git clone https://github.com/0xwaya/space.warp.git
cd space.warp
yarn install
```

or using GitHub CLI

```
gh repo clone 0xwaya/space-warp
cd space-warp
yarn install
```


This will clone the hardhat kit onto your computer, switch directories into the newly installed kit, and install the dependencies the kit needs to work.

if you have problems installing dependencies try :

```
npm i @zondax/filecoin-solidity
npm i @openzeppelin/contracts
```

Install solidity-sborutils manually

```
$ git clone https://github.com/smartcontractkit/solidity-cborutils.git
$ cd solidity-cborutils
$ yarn install

```


## Add your Private Key as an Environment Variable 

## use (.env) fie and add to .gitgnore "DO NOT PUSH YOUR PRIVATE KEYS TO GITHUB" 

Add your private key as an environment variable by running this command:

 ```
export PRIVATE_KEY='3094U2934U.....f'
```

## Get the Deployer Address

Run this command:
```
yarn hardhat get-address
```

The will show you the ethereum-style address associated with that private key and the filecoin-style f4 address (also known as t4 address on testnets)


## Fund the Deployer Address

Go to the [Hyperspace testnet faucet](https://hyperspace.yoga/#faucet), and paste in the Ethereum address from the previous step. This will send some hyperspace testnet FIL to the account.


## Deploy the Contracts

Currently there are 3 main types of contracts:

* Basic Solidity Examples: Simple contracts to show off basic solidity

* Filecoin API Examples: Contracts that demo how to use the Filecoin APIs in Solidity to access storage deals and other Filecoin specific functions.

* Hackathon contracts for Space Warp.


Type in the following command in the terminal to deploy all contracts:

 ```
yarn hardhat deploy
```

This will compile all the contracts in the contracts folder and deploy them to the Hyperspace test network automatically!

Keep note of the deployed contract addresses for the next step.

## Interact with the Contracts

You can interact with contracts via hardhat tasks, found in the 'tasks' folder. For example, to interact with the SimpleCoin contract:

Type in the following command in the terminal:

 ```
yarn hardhat get-balance --contract 'THE DEPLOYED CONTRACT ADDRESS HERE' --account 'YOUR ETHEREUM ADDRESS HERE'
```

The console should read that your account has 12000 SimpleCoin!

## Filecoin APIs

The primary advantage of the FEVM over other EVM based chains is the ability to access and program around Filecoin storage deals. This can be done in the FEVM via the [Filecoin.sol library maintained by Zondax](https://github.com/Zondax/filecoin-solidity). **Note this library is currently in BETA**. It is unaudited, and the APIs will likely be changing with time. This repo will be updated as soon as possible when a breaking change occurs.

The library is included in this kit as an NPM package and will automatically be downloaded when you perform the `yarn` command (don't confuse these with the included mocks)!

Currently you will find a getter contract that calls the getter methods on the MarketAPI to get storage deal data and store that data. To do this you will need *dealIDs* which you can [find here on FilFox](https://hyperspace.filfox.info/en/deal).

As an example to store most of the data available for a deal run the store-all command with a specified dealID. Below is an example of using this command below with the a deal on Hyperspace testnet with a dealID of 707.

```
yarn hardhat store-all --contract "DEPLOYED FILECOIN_MARKET_CONSUMER CONTRACT ADDRESS HERE" --dealid "707"
```
