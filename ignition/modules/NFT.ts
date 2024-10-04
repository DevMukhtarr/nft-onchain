import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const OnChainNFTModule = buildModule("OnChainNFTModule", (m) => {

  const nft = m.contract("OnChainNFT");

  return { nft };
});

export default OnChainNFTModule;
