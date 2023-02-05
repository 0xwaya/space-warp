import React, { useState } from 'react';
import { Contract } from '@ethersproject/contracts';
import { abis } from '@my-app/contracts';
import { ERC20, useContractFunction, useEthers, useToken, useTokenAllowance, useTokenBalance } from '@usedapp/core';
import { ethers } from 'ethers/lib/utils';
import { parseUnits } from 'ethers/lib/utils';

import { gestAvailableToken, getCounterpartTokens, findPoolByTokens, isOperationPending, getFailureMessage, getSuccessMessage } from '../utils';
import { ROUTER_ADDRESS } from '../config';
import { AmmountIn, AmmountOut, Balance } from './';
import styles from '../styles';

const Exchange = (pools) => {
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
        </div>
    )
}

export default Exchange;