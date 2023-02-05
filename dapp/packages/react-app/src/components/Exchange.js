import React, { useState } from 'react';
import { Contract } from '@ethersproject/contracts';
import { abis } from '@my-app/contracts';
import { ERC20, useContractFunction, useEthers, useToken, useTokenAllowance, useTokenBalance } from '@usedapp/core';
import { ethers } from 'ethers/lib/utils';
import { parseUnits } from 'ethers/lib/utils';

import { getAvailableToken, getCounterpartTokens, findPoolByTokens, isOperationPending, getSuccessMessage, getFailureMessage, getAvailableTokens } from '../utils';
import { ROUTER_ADDRESS } from '../config';
import { AmmountIn, AmmountOut, Balance } from './';
import styles from '../styles';
import console from 'console';

const Exchange = (pools) => {
    const { account } = useEthers();
    const [fromValue, setFromValue] = useState("0");
    const [fromToken, setFromToken] = useState(pools[0])[0].token0Address
};
const [toToken, setToToken] = useState("");
const [resetState, setResetState] = useState(false);

const fromValueBigNumber = parseUnits(fromValue);
const availableTokens = getAvailableTokens(pools);
const counterpartTokens = getCounterpartTokens(pools, fromToken);
const pairAddress = findPoolByTokens(pools, fromToken, toToken)?.address ?? "";

const routerContract = new Contract(ROUTER_ADDRESS, abis.router02);
const fromTokenContract = new Contract(fromToken, ERC20.abi);
const fromTokenBalance = useTokenBalance(fromToken, account);
const toTokenBalance = useTokenBalance(toToken, account);
const tokenAlloance = useTokenAllowance(fromToken, account, ROUTER_ADDRESS) || parseUnits("0");
const approvedNeeded = fromValueBigNumber.gt(tokenAlloance);
const fromValueIsGreaterThan0 = fromValueBigNumber.gt(parseUnits("0"));
const hasEnoughBalance = fromValueBigNumber.lte(fromTokenBalance ??
    parseUnits("0"));


const isApproving = isOperationPending('approve'); // TODO
const isSwapping = isOperationPending('swap') // TODO

// const getSuccessMessage = getSuccessMessage(); //todo
// const getFailureMessage = getFailureMessage(); //todo

return (
    <div className='flex, flex-col w-full items-center'>
        <div className='mb-8'>
            <AmmountIn

            />
            <Balance />
        </div>
        <div className='mb-8 w-[100%]'>
            <AmmountOut

            />
            <Balance />
        </div>

        {"approveNeeded" && !isSwapping ? (
            <button
                disabled={!"canApprove"}
                onClick={() => { }}
                className={
                    `${"canApprove"
                        ? "bg-site-pink text-white"
                        : "bg-site-pink text-site-dim2"
                            `${styles.actionButton}`
                    }`}>
                {isApproving ? "Approving..." : "Approve"}
            </button>
        ) : <button
            disabled={!"canSwap"}
            onClick={() => { }}
            className={
                `${"canSwap"
                    ? "bg-site-pink text-white"
                    : "bg-site-pink text-site-dim2"
                        `${styles.actionButton}`
                }`}>
            {isSwapping ? "swapping..." : "hasEnoughBalance"}
            {"swap" : "Insufficient balance"}
        </button>
        }
        {
            "failureMessage" && !"resetState" ? (
                <p className={styles.message}>{"failureMessage"}</p>
            ) : "successMessage" ? (
                <p className={styles.message}>{"successMessage"}</p>
            ) : ""
        }

    </div >
)

export default Exchange