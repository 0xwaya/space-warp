
require("@nomicfoundation/hardhat-toolbox")
require("@nomicfoundation/hardhat-chai-matchers")
require("@nomiclabs/hardhat-ethers")
require("hardhat-deploy")
require("hardhat-deploy-ethers")
require("./tasks")
require("dotenv").config()

const PRIVATE_KEY = process.env.PRIVATE_KEY

require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });


module.exports = {
    solidity: "0.8.17",
    defaultNetwork: "hyperspace",

    networks: {
        hyperspace: {
            chainId: 3141,
            url: "https://nd-998-437-463.p2pify.com/317c7900a7c3f26a7453d7847b3bf318/rpc/v0",
            accounts: [process.env.PRIVATE_KEY],
        },
    },
    paths: {
        sources: "./contracts",
        tests: "./test",
        cache: "./cache",
        artifacts: "./artifacts",
    },
}