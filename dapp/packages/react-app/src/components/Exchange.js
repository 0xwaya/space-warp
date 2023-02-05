import React, { useEffect, useLayoutEffect, useState } from 'react';
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

const { state: swapApproveState, send: swapApproveSend } =
    useContractFunction(fromTokenContract, "approve", {
        transactionName: "onApproveRequested",
        getLimitBufferPercentage: 10,
    });

const { state: swapExecuteState, send: swapExecuteSend } =
    useContractFunction(routerContract, "swapExactTokensForTokens", {
        transactionName: "swarpExactTokensForTokens",
        getLimitBufferPercentage: 10,
    });


const isApproving = isOperationPending(swapApproveState);
const isSwapping = isOperationPending(swapExecuteState);
const canApprove = !isApproving && approvedNeeded;
const canSwap = !approvedNeeded && !isSwapping &&
    fromValueIsGreaterThan0 && hasEnoughBalance;

const successMessage = getSuccessMessage(swapApproveState,
    swapApproveState);
const failureMessage = getFailureMessage(swapApproveState,
    swapExecuteState);

const onApproveRequested = () => {
    swapApproveSend(ROUTER_ADDRESS, ethers.constants.MaxUint256);
}
const onSwapRequested = () => {
    swapExecuteSend(
        fromValueBigNumber,
        0,
        [fromToken, toToken],
        account,
        math.floor(Date.now() / 1000) + 60 * 2
    ).then(() => {
        setFromValue("0");
    })
}

const onFromValueChange = (value) => {
    const trimmedValue = value.trim();

    try {
        if (trimmedValue) {
            parseUnits(value);

            setFromValue(value);
        }
    }

    const onFromTokenChange = (value) => {
        setFromToken(value);
    }

    const onToTokenChange = (value) => {
        setToToken(value);
    }

    useEffect(() => {
        if (failureMessage || successMessage) {
            setTimeout(() => {
                setResetState(true);
                setFromValue("0");
                setToToken("");
            }, 5000)
        }
    }, [failureMessage, successMessage]);

}
return (
    <div className='flex, flex-col w-full items-center'>
        <div className='mb-8'>
            <AmmountIn
                value={fromValue}
                onChange={fromValueChange}
                currencyValue={fromToken}
                onSelect={onFromTokenChange}
                currencies={availableTokens}
                inSwapping={isSwapping && hasEnoughBalance} />

            <Balance tokenBalance={fromTokenBalance} />
        </div>
        <div className='mb-8 w-[100%]'>
            <AmmountOut
                fromToken={fromToken}
                toToken={toToken}
                ammountIn={fromValueBigNumber}
                pairContract={pairAddress}
                currencyValue={toToken}
                onSelect={onToTokenChange}
                currencies={counterpartTokens}
            />
            <Balance tokenBalance={toTokenBalance} />
        </div>

        {approvedNeeded && !isSwapping ? (
            <button
                disabled={!canApprove}
                onClick={onApproveRequested}
                className={
                    `${canApprove
                        ? "bg-site-pink text-white"
                        : "bg-site-pink text-site-dim2"
                            `${styles.actionButton}`
                    }`}>
                {isApproving ? "Approving..." : "Approve"}
            </button>
        ) : <button
            disabled={!canSwap}
            onClick={onSwapRequested}
            className={
                `${canSwap
                    ? "bg-site-pink text-white"
                    : "bg-site-pink text-site-dim2"
                        `${styles.actionButton}`
                }`}>
            {isSwapping ? "swapping..." : hasEnoughBalance}
            {"swap" : "Insufficient balance"}
        </button>
        }
        {
            { failureMessage && !resetState ? (
                <p className={styles.message}>{failureMessage}</p>
            ) : successMessage ? (
                <p className={styles.message}>{successMessage}</p>
            ) : ""}
            }
    </div>
)

export default Exchange