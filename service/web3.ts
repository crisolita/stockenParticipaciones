import { ethers } from "ethers";
import { CONTRACT_ABI, CONTRACT_ADDRESS } from "../utils/const";
export const provider = new ethers.providers.JsonRpcProvider(
  process.env.PROVIDER as string
);
// const wallet = new ethers.Wallet(process.env.PRIVATEKEY as string, provider);
const contract = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI, provider);
export const wallet = new ethers.Wallet(process.env.ADMINPRIVATEKEY as string, provider);

export default contract;
  
export async function manageKeys(password: any) {
  try {
    console.log(password);
  } catch (e) {
    console.log(e);
  }
}
