import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const OnChainNFTModule = buildModule("OnChainNFTModule", (m) => {

  const onchainnft = m.contract("OnChainNFT");

  return { onchainnft };
});

export default OnChainNFTModule;
