import { abis } from '@my-app/contracts';
import { routerAddress } from '../utils';


export const getRouterInfo = async (routerAddress, web3) => {
  const router = new web3.eth.Contract(abis.router02, routerAddress);

  return {
    factory: await router.methods.factory().call(),
  }
}