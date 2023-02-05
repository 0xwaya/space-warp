import React, { useState, useEffect, sueRef } from 'react'

import { chevronDown } from '../assets';
import styles from '../styles';
import { useOnClickOutside } from '../utils';

const AmmountIn = () => {
    return (
        <div className={styles.amountContainer}>
            <input
                placeholder='0.0'
                type={'number'}
                value=''
                disabled={false}
                onChange={() => { }}
                className={styles.amountInput}
            />
            <div className='relative' onClick={() => { }} />
            <button className={styles.currencyButtom}>
                {'ETH'}
            </button>

        </div>

    )
}

export default AmmountIn;