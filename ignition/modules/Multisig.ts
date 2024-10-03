import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const quorum = 2;
const validSigners = ["0x73E86E1c95c13E1C3054f11A7785337744f7f450","0x2dB76cc2EEc8512084808829495d58f844ff6fC0","0x9e5048bF692b7C25c2267715BBeC90636dB119C9"]

const MultiSigModule = buildModule("MultisigModule", (m) => {
  const multisig = m.contract("Multisig", [quorum, validSigners]);

  return { multisig };
});

export default MultiSigModule;
