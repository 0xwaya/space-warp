const { ethers } = require("hardhat")

const networkConfig = {
    3141: {
        name: "hyperspace",
        tokenToBeMinted: 10000,
    },
}

// const developmentChains = ["hardhat", "localhost"]

module.exports = {
    networkConfig,
    // developmentChains, 
}
