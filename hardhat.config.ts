import { HardhatUserConfig } from "hardhat/config";
import dotenv from "dotenv";
import "@nomicfoundation/hardhat-toolbox";
dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    hardhat: {},
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${process.env.ALCHEMY_KEY}`,
      accounts: [`${process.env.WALLET_PRIVATE_KEY}`]
    },
    "lisk-sepolia": {
      url: process.env.LISK_RPC_URL!,
      accounts: [process.env.WALLET_PRIVATE_KEY!],
      gasPrice: 1000000000,
    }
  },
  etherscan:{
    apiKey: process.env.ETHERSCAN_KEY
  }
};

export default config;
