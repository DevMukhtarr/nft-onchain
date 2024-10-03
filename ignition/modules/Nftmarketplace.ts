import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const nftAddress = "0xB4f562a85b7F9cCF9F8bC0fdB708eC8F7a759381";
const NftmarketplaceModule = buildModule("NftmarketplaceModule", (m) => {

  const nftmarketplace = m.contract("Nftmarketplace", [nftAddress]);

  return { nftmarketplace };
});

export default NftmarketplaceModule;
