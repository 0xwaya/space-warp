const {
    ethers
} = require("hardhat");

require("dotenv").config({
    path: ".env"
});

const util = require("util")
const request = util.promisify(require("request"))
const { networkConfig } = require("../helper-hardhat-config")
const PRIVATE_KEY = process.env.DEPLOYER_PRIVATE_KEY;

async function callRpc(method, params) {
    var options = {
        method: "POST",
        url: [process.env.CHAINSTACK_FILECOIN_RPC],
        // url: "https://api.hyperspace.node.glif.io/rpc/v1",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({
            jsonrpc: "2.0",
            method: method,
            params: params,
            id: 1,
        }),
    }
    const res = await request(options)
    return JSON.parse(res.body).result
}

const provider = new ethers.providers.JsonRpcProvider(process.env.CHAINSTACK_FILECOIN_RPC)

module.exports = async ({ deployments }) => {
    const { deploy } = deployments

    const priorityFee = await callRpc("eth_maxPriorityFeePerGas")

    // Wraps Hardhat's deploy, logging errors to console.
    const deployLogError = async (title, obj) => {
        let ret;
        try {
            ret = await deploy(title, obj);
        } catch (error) {
            console.log(error.toString())
            process.exit(1)
        }
        return ret;
    }

    console.log("Wallet Ethereum Address:", deployer.address)
    const chainId = network.config.chainId
    const tokenToBeMinted = networkConfig[chainId]["tokenToBeMinted"]


    await deployLogError("SpaceCoin", {
        from: deployer.address,
        args: [tokenToBeMinted],
        // maxPriorityFeePerGas to instruct hardhat to use EIP-1559 tx format
        maxPriorityFeePerGas: priorityFee,
        log: true,
    })

    await deployLogError("", {
        from: deployer.address,
        args: [],
        // maxPriorityFeePerGas to instruct hardhat to use EIP-1559 tx format
        maxPriorityFeePerGas: priorityFee,
        log: true,
    })

    await deployLogError("", {
        from: deployer.address,
        args: [],
        // maxPriorityFeePerGas to instruct hardhat to use EIP-1559 tx format
        maxPriorityFeePerGas: priorityFee,
        log: true,
    })
}

