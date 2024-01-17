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
    const document = await client.createSignature(
      "Nota Convertible - Datos & Formulario.pdf",
      { name: `user.first_name`, email: `crisolvalentina@gmail.com` },
      { templates: "#creacion" }
    );
    console.log(document);
    return document;
  } catch (e) {
    console.log(e);
    return false;
  }
};
