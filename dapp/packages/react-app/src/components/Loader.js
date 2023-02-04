import React from 'react'

import styles from '../styles';
import { fvmfilecoinLogo } from '../assets';

const Loader = () => {
    return (
        <div className={styles.loader}>
            <img
                src={fvmfilecoinLogo}
                alt="fvm logo"
                className={styles.loaderImg} />
            <p className={styles.loaderText}>{title}</p>
        </div>

    )
}

export default Loader