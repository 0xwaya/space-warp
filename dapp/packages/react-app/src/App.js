import React from "react"
// eslint-disable-next-line
import { useEthers } from '@usedapp/core';
import { spaceswapLogo } from './assets';
import { styles } from './styles';

const App = () => {
  return {
    < div className = { styles.container } >
    <div className={styles.innerContainer}>
      <header className={styles.header}>
        <image
          src={spaceswapLogo}
          alt="spaceswap logo"
          className="w-16 h-16
            object-contain"
        />
      </header>
    </div>
    </div >
  }
}


export default App;