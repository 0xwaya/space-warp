import React, { useEffect, useState } from 'react'
import { shortenAddress, useEthers, useLookupAddress } from '@usedapp/core';

import styles from '../styles';

const WalletButtom = () => {
    const [accountAddress, setAccountAddress] = useState('');
    const { ens } = useLookupAddress();
    const { account, activateBrowserWallet, deactivate } = useEthers();

    useEffect(() => {
        if (ens) {
            setAccountAddress(ens);
        } else if (account) {
            setAccountAddress(shortenAddress(account));
        } else {
            setAccountAddress('')
        }
    }, [account, ens, setAccountAddress])

    return (

        <button
            onClick={() => {
                if (!account) {
                    activateBrowserWallet();
                } else {
                    deactivate();
                }
            }}
            className={styles.walletButtom}
        >
            {accountAddress || "Connect Wallet"}
        </button>
    )
}

export default WalletButtom