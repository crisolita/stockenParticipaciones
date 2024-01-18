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
import puppeteer from "puppeteer";

// replace it with your API key
const API_KEY = process.env.SIGNATURITKEY;
const client = new SignaturitClient(API_KEY);
export const createSignature = async () => {
  try {
    let plantilla = fs.readFileSync(
      "emails/emails-user/Gestion User - Login con codigo de acceso.html",
      "utf-8"
    );
    const data = { "Document.date": new Date().toLocaleString() };
    plantilla = mustache.render(plantilla, data);
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.setContent(plantilla);

    // Ajusta las opciones según tus necesidades
    await page.pdf({ path: "crearCP.pdf", format: "A4" });

    await browser.close();
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
