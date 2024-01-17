import { PrismaClient } from "@prisma/client";
import { Request, Response, response } from "express";
import { crearDocumentoDeCompra, getTemplates } from "../service/pandadoc";
import axios from "axios";
import mangopayInstance from "mangopay2-nodejs-sdk";
import { crearVentaNotaConvertible } from "../service/notasConvertibles";
const mangopay = new mangopayInstance({
  clientId: process.env.CLIENT_ID_MANGOPAY as string,
  clientApiKey: process.env.API_KEY_MANGOPAY as string,
  baseUrl: "https://api.mangopay.com",
});
export const crearNotaConvertible = async (req: Request, res: Response) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;
    const {
      jwtCreador,
      companyID,
      cantidad_a_vender,
      ticket_minimo,
      interes_fijo,
      interes_variable,
      vence_date,
      vence_cantidad,
      tasa_descuento,
      capitulacion,
      CAP_no_ronda,
      floor,
      fecha_devolucion,
      negociar,
    } = req.body;
    let user;
    try {
      user = await axios.get(
        "https://pro.stockencapital.com/api/v1/users/me/",
        {
          headers: {
            Authorization: `${jwtCreador}`,
          },
        }
      );
      console.log(user.data);
      if (!user || user.data.status != "validated")
        return res.status(400).json({ error: "Usuario no valido" });
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Error al validar usuario" });
    }
    const company = await prisma.companies_company.findUnique({
      where: { id: companyID },
    });
    if (
      !company ||
      company.legal_representative_id != user.data.id ||
      company.status != "validated" ||
      !company.cod
    )
      return res.status(400).json({
        error: "Compañia no existe, no pertenece al usuario o no esta validada",
      });

    /// lo que falte de empresa pedirselo al usuario, en el documento?
    const mangopayWallet = await prisma.mangopay_mangopaywallet.findFirst({
      where: { cod: company.cod },
    });
    const mangopayId = await prisma.mangopay_mangopayuser.findFirst({
      where: { cod: company.cod },
    });
    console.log(mangopayId?.mangopay_id, mangopayWallet?.wallet_id);
    if (!mangopayWallet?.wallet_id || !mangopayId?.mangopay_id)
      return res
        .status(404)
        .json({ error: "No hay datos de mangopay suficientes" });

    /// validar que la empresa tenga mangopay ID
    const nota = await crearVentaNotaConvertible(
      {
        cantidad_a_vender,
        ticket_minimo,
        companyID,
        interes_fijo,
        interes_variable,
        vence_date: vence_date ? new Date(vence_date) : undefined,
        vence_cantidad,
        tasa_descuento,
        capitulacion,
        CAP_no_ronda,
        floor,
        fecha_devolucion: fecha_devolucion
          ? new Date(fecha_devolucion)
          : undefined,
        negociar,
      },
      prisma
    );
    res.json(nota);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
