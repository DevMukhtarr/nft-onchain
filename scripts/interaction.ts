import { ethers } from "hardhat";
import { ContractTransactionReceipt } from "ethers";

const svg = `<svg viewBox="0 0 36 36" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--twemoji" preserveAspectRatio="xMidYMid meet" fill="#000000"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"><path fill="#3B88C3" d="M36 32a4 4 0 0 1-4 4H4a4 4 0 0 1-4-4V4a4 4 0 0 1 4-4h28a4 4 0 0 1 4 4v28z"></path><path fill="#FFF" d="M14.747 9.125c.527-1.426 1.736-2.573 3.317-2.573c1.643 0 2.792 1.085 3.318 2.573l6.077 16.867c.186.496.248.931.248 1.147c0 1.209-.992 2.046-2.139 2.046c-1.303 0-1.954-.682-2.264-1.611l-.931-2.915h-8.62l-.93 2.884c-.31.961-.961 1.642-2.232 1.642c-1.24 0-2.294-.93-2.294-2.17c0-.496.155-.868.217-1.023l6.233-16.867zm.34 11.256h5.891l-2.883-8.992h-.062l-2.946 8.992z"></path></g></svg>`
  
  interface TxnReceipt {
    events?: Event[];
  }

interface TxnReceipt extends ContractTransactionReceipt {
events?: Event[];
}

async function main() {
    const NFTONCHAINCONTRACTADDRESS = "0x79a87956d6594b2d4A5dB3e7498F1aDd2951560b"
    const nftContract = await ethers.getContractAt("OnChainNFT", NFTONCHAINCONTRACTADDRESS);

    const txn = await nftContract.mint(svg);
    const txnReceipt: TxnReceipt | null = await txn.wait();

    console.log(txnReceipt)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});