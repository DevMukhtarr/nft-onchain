import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const ProductModule = buildModule("ProductContractModule", (m) => {

  const product = m.contract("ProductContract");

  return { product };
});

export default ProductModule;