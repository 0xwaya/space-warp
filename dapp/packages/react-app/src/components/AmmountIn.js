import React, { useState, useEffect, useRef } from 'react'

import { chevronDown } from '../assets';
import styles from '../styles';
import { useOnClickOutside } from '../utils';

const AmmountIn = () => {
    const [showList, setShowList] = useState(false);

    return (
        <div className={styles.amountContainer}>
            <input
                placeholder='0.0'
                type='number'
                value=''
                disabled={false}
                onChange={() => { }}
                className={styles.amountInput}
            />

            <div className='relative' onClick={() => setShowList((prevState) => !prevState)}>
                <button className={styles.currencyButtom}>
                    {'ETH'}
                    <img
                        src=(chevronDown)
                    alt='chevron down'
                    className={'w-4 h-4 object-contain ml-2 ${false ? 'rotate-180' : 'rotate-0'}'}

                    }

                </button>

            </div>

            )
}

            export default AmmountIn;