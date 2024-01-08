import { PrismaClient } from "@prisma/client";
import { Request, Response, response } from "express";
import { crearDocumentoDeCompra, getTemplates } from "../service/pandadoc";
import axios from "axios";
import mangopayInstance from "mangopay2-nodejs-sdk";
const mangopay = new mangopayInstance({
  clientId: process.env.CLIENT_ID_MANGOPAY as string,
  clientApiKey: process.env.API_KEY_MANGOPAY as string,
  baseUrl: "https://api.mangopay.com",
});
