import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const SimpleLotteryModule = buildModule("SimpleLotteryModule", (m) => {

  const lottery = m.contract("SimpleLottery", [2]);

  return { lottery };
});

export default SimpleLotteryModule;