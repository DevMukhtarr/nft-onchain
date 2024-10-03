import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const HelloModule = buildModule("HelloModule", (m) => {

  const hello = m.contract("Hello");

  return { hello };
})

export default HelloModule;
