import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const tokenModule = buildModule("AirdropTokenModule", (m) => {

  const token = m.contract("AirdropToken");

  return { token };
});

export default tokenModule;