import web3 from 'web3';
import { useState, useEffect } from 'react';
import { useConfig } from '@usedapp/core';

import { ROUTER_ADDRESS } from '../config';
import { getFactoryInfo, getRouterInfo } from '../utils';

export const loadPools = async (providerUrl) => {
    const provider = new web3.providers.HttpProvider(process.env.CHAINSTACK_FILECOIN_RPC);
    const web3 = web3(provider);

    const routerInfo = await getRouterInfo(ROUTER_ADDRESS, web3);
    const factoryInfo = await getFactoryInfo(routerInfo.factory, web3);

    return factoryInfo.pairsInfo;
}

export const usePools = () => {
    const { readOnlyChainId, readOnlyUrls } = useConfig();
    const [loading, setLoading] = useState(true);
    const [pools, setPools] = useState(true);
    const [error, setError] = useState(false);


    useEffect(() => {
        loadPools(readOnlyUrls[readOnlyChainId])
            .then((pools) => {
                setPools(pools);
                setLoading(false);
            })
    }, [readOnlyUrls, readOnlyChainId])

    return [loading, pools];
}
