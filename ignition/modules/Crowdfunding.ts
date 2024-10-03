import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const CrowdfundModule = buildModule("CrowdfundModule", (m) => {

  const crowdfunding = m.contract("Crowdfunding");

  return { crowdfunding };
});

export default CrowdfundModule;
