import React from 'react'
import { shortenAddress, useEthers, useLookupAddress } from "@usedapp/core";
import { useEffect, useState } from "react"

import styles from '../styles';
import { render } from 'react-dom';

const WalletButtom = () => {
    const [rendered, setRendered] = useState('');
    const { ens } = useLookupAddress();
    const { account, activateBrowserWallet, deactivate } = useEthers();

    return (

        <button
            onClick={() => {
                if (!account) {
                    activateBrowserWallet();
                } else {
                    deactivate();
                }
            }}
            className={styles.walletButton}
        >
            {rendered === "" && "Connect Wallet"}
            {rendered !== "" && rendered}

        </button>
    )
}

export default WalletButtom