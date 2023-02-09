# ETHGlobal 
# Space 🛸 Warp hackathon

## Creating a Dapp Dex powered by (Uniswap v2.0) 
## run on FVM hyperspace testnet, deploy token,
## create FIL+SPACE pair in LP


###  (experimental code only )

### Dev:  @0xwaya


Project goal to to deploy a Dex dapp on FVM powered by uniswap. 


* Create & running FVM hyperspace testnet node on ChainStack. (Orion-node)

```
    HTTPS endpoint: https://nd-998-437-463.p2pify.com/rpc/v0

    WSS Endpoint: wss://ws-nd-998-437-463.p2pify.com/rpc/v0

 ```


* Created SpaceCoinV1 and deployed on FVM.

```

	SPACE V1 Contract: “ 0x9b7aF8E07B846519c6f811880B21Df947f55B057 ”

```


        
* Created & deployed FILEcoinMOCK  ERC20 token on FVM.

```

	
        FILE V1  Contract: “ 0x2548323B2AfBABbc89206A81786d6D075b382735 ”             


```


* Created & deployed SpaceswapFactoryV1.sol 

```

        Spaceswap V1 - FACTORY: “ 0x73372C04C14f91862045A8a67D724e894e9ba5ca “

```


* Created & deployed SpaceswapRouterV1.sol 

```

        Spaceswap V1 - ROUTER: “ 0xB9491aef6f4d742ad7f648EF43baE3dA6b5e6F1D “

```

* Created & deployed (FILE + SPACE) LP paircontract.

```

	FILEV1 + SPACE V1 =  LP PAIR = “ 0x93d544bfeE90C7c69f1Fbb6024255283D8135C6C  “

```





FOR EXPERIMENTAL USE ONLY!!!!!!

In the project directory, you can run:

### `yarn start`

Runs the app in development mode.<br>
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will automatically reload if you make changes to the code.<br>
You will see the build errors and lint warnings in the console.

### `yarn test`

Runs the test watcher in an interactive mode.<br>
By default, runs tests related to files changed since the last commit.

[Read more about testing.](https://facebook.github.io/create-react-app/docs/running-tests)

### `yarn build`

Builds the app for production to the `build` folder.<br />
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.<br />
Your app is ready to be deployed!

See the React documentation on [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `yarn react-app:eject`

**Note: this is a one-way operation. Once you `eject`, you can’t go back!**

If you aren’t satisfied with the build tool and configuration choices, you can `eject` the React app at any time. This command will
remove the single build dependency from your React package.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right
into your project so you have full control over them. All of the commands except `eject` will still work, but
they will point to the copied scripts so you can tweak them. At this point you’re on your own.

You don’t have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn’t feel obligated to use this feature. However we understand that this tool wouldn’t be useful if you couldn’t customize it when you are ready for it.

## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

### Code Splitting

This section has moved here: https://facebook.github.io/create-react-app/docs/code-splitting

### Analyzing the Bundle Size

This section has moved here: https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size

### Making a Progressive Web App

This section has moved here: https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app

### Advanced Configuration

This section has moved here: https://facebook.github.io/create-react-app/docs/advanced-configuration

### Deployment

This section has moved here: https://facebook.github.io/create-react-app/docs/deployment

### `yarn build` fails to minify

This section has moved here: https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify
xs