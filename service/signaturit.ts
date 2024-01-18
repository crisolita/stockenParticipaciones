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
import fs from "fs";
import mustache from "mustache";
import pdf from "html-pdf";

// replace it with your API key
const API_KEY = process.env.SIGNATURITKEY;
const client = new SignaturitClient(API_KEY);
export const createSignature = async () => {
  try {
    let plantilla = fs.readFileSync("CrearCP.html", "utf-8");
    const data = { Document_date: new Date().toLocaleString() };
    plantilla = mustache.render(plantilla, data);

    console.log("llegue aqui");
    // Ajusta las opciones según tus necesidades
    const options = { format: "Letter" };

    pdf
      .create(plantilla)
      .toFile("crearCP.pdf", (err: any, res: { filename: any }) => {
        if (err) return console.log(err);
        console.log("PDF creado exitosamente en", res.filename);
      });
    const document = await client.createSignature("crearCP.pdf", {
      name: `user.first_name`,
      email: `crisolvalentina@gmail.com`,
      role: "Signer",
    });
    console.log(document);
    return document;
  } catch (e) {
    console.log(e);
    return false;
  }
};
