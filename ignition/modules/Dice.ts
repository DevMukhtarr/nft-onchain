import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const DiceModule = buildModule("DiceModule", (m) => {

  const dice = m.contract("Dice");

  return { dice };
});

export default DiceModule;
