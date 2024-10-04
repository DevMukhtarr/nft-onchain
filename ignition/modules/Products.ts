import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const tokenModule = buildModule("Web3CXIModule", (m) => {

  const token = m.contract("Web3CXI");

  return { token };
});

export default tokenModule;