import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const areaModule = buildModule("AreaCalculatorModule", (m) => {

  const area = m.contract("AreaCalculator");

  return { area };
});

export default areaModule;
