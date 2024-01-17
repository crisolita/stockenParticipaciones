//@ts-ignore
import SignaturitClient from "signaturit-sdk";
import {
  PrismaClient,
  companies_company,
  cuentas_participes,
  orders,
  participacion,
  users_user,
} from "@prisma/client";
// replace it with your API key
const API_KEY = process.env.SIGNATURITKEY;
const client = new SignaturitClient(API_KEY);
export const createSignature = async () => {
  try {
    const res = await client.getSignatures(API_KEY);
    console.log(res);
  } catch (e) {
    console.log(e);
  }
};
