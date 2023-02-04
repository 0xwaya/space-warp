import React from "react"
import { useEthers } from '@usedapp/core';

import styles from './styles';
import { spaceswapLogo } from './assets';

const App = () => {
  return (

    <div className={styles.container}>
      <div className={styles.innerContainer}>
        <header className={styles.header}>
          <image
            src={spaceswapLogo}
            alt="spaceswap logo"
            className="w-16 h-16
            object-contain"
          />
          WalletButton
        </header>

        <div className={styles.exchangeContainer}>
          <h1 className={styles.headTitle}>Spaceswap beta-0.1</h1>
          <p>

          </p>
        </div>
      </div>
    </div >
  )
}


export default App;