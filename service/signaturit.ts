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
      {
        name: `user.first_name`,
        email: `crisolvalentina@gmail.com`,
        role: "Signer",
      },
      {
        templates: "#crear",
        data: {
          emp_nif: "827392",
          emp_country: "ES",
          emp_city: "Caracas",
          emp_name: "Blockimpulse",
          doc_date: new Date().toLocaleDateString(),
        },
        signature_widget: {
          page: 1,
          x: 100,
          y: 200,
        },
      }
    );
    console.log(document);
    return document;
  } catch (e) {
    console.log(e);
    return false;
  }
};
