import React from 'react'
import { useEthers } from '@usedapp/core';

import { usePools } from './hooks';
import styles from './styles/index';
import { spaceswapLogo } from './assets';
import { Exchange, Loader, WalletButtom } from './components';

const App = () => {
  const { Account } = useEthers();
  const [loading, pools] = usePools();

  return (
    <div className={styles.container}>
      <div className={styles.innerContainer}>
        <header className={styles.header}>
          <image
            src={spaceswapLogo}
            alt="spaceswap logo"
            className="w-16 h-16
            object-contain" />
          <WalletButtom />

        </header>

        <div className={styles.exchangeContainer}>
          <h1 className={styles.headTitle}>Spaceswap beta-V.1</h1>
          <p className={styles.subTitle}> Add liquidity to Filecoin FVM</p>

          <div className={styles.exchangeBoxWrapper}>
            <div className={styles.exchangeBox}>
              <div className={styles.exchangeContainer}>
                <div className="orange_gradient" />
                <div className={styles.exchange}>
                  {Account ? (
                    loading ? (
                      <Loader title="Loading pools, please wait!" />
                    ) : <Exchange pools={pools} />
                  ) :
                    <><Loader title="Please connect your wallet" /><div className="blue_gradient" /></>
                  }
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}


export default App