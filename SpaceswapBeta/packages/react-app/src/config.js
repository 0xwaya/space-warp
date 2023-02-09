import { HYPERSPACE_ID } from '@my-app/contracts';

export const ROUTER_ADDRESS = "0xB9491aef6f4d742ad7f648EF43baE3dA6b5e6F1D";

export const DAPP_CONFIG = {
  readOnlyUrls: { [HYPERSPACE_ID.chainId]: [process.env.CHAINSTACK_FILECOIN_RPC] },

  supportedChains: [HYPERSPACE_ID.chainId],
  defaultChainId: HYPERSPACE_ID.chainId,
  chainId: HYPERSPACE_ID.chainId,
  chainName: HYPERSPACE_ID.name,
};


