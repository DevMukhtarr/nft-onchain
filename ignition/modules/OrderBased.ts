import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const OrderBasedSwapModule = buildModule("OrderBasedSwapModule", (m) => {

  const orderbased = m.contract("OrderBasedSwap");

  return { orderbased };
});

export default OrderBasedSwapModule;
