import { PrismaClient } from "@prisma/client";
import { Request, Response, response } from "express";
import axios from "axios";
import mangopayInstance from "mangopay2-nodejs-sdk";
import { crearVentaNotaConvertible } from "../service/notasConvertibles";
import {
  cancel,
  createDocNotaConvertible,
  isCompleted,
} from "../service/signaturit";
import { getDoc, getImage, uploadDoc, uploadImage } from "../service/aws";
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
      tipodeinteres,
      capitulacion,
      CAP_no_ronda,
      floor,
      fecha_devolucion,
      negociar,
      media,
      clausulas,
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
    let nota = await crearVentaNotaConvertible(
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
        tipodeinteres,
        floor,
        fecha_devolucion: fecha_devolucion
          ? new Date(fecha_devolucion)
          : undefined,
        negociar,
        creador_id: user.data.id,
        cantidad_restante: cantidad_a_vender,
        clausulas,
      },
      prisma
    );
    let medias = [];
    if (media && nota) {
      for (let med of media) {
        let path = `media_notaconvertible_${med.type}_${nota.id}_${
          nota.countMedia ? nota.countMedia + 1 : 1
        }`;
        nota = await prisma.venta_de_notas_convertibles.update({
          where: { id: nota.id },
          data: { countMedia: nota.countMedia ? nota.countMedia + 1 : 1 },
        });
        let saveMedia = await prisma.mediaNC.create({
          data: {
            venta_nota_convertible_id: nota.id,
            path,
            type: med.type,
          },
        });
        medias.push(saveMedia);
        let data;
        if (med.type == "IMAGE") {
          data = Buffer.from(
            med.base64.replace(/^data:image\/(png|jpg|jpeg);base64,/, ""),
            "base64"
          );
          await uploadImage(data, path);
        } else {
          data = Buffer.from(
            med.base64.replace(/^data:application\/(pdf);base64,/, ""),
            "base64"
          );
          await uploadDoc(data, path);
        }
      }
    }
    res.json(nota);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
export const comprarNotaConvertible = async (req: Request, res: Response) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;

    let { venta_id, aportacion, jwtUser, companyIdBuyer } = req.body;
    let venta = await prisma.venta_de_notas_convertibles.findUnique({
      where: { id: venta_id },
    });
    if (!venta)
      return res.status(400).json({ error: "No existe cuenta participe" });

    if (venta.cantidad_restante <= venta.ticket_minimo) {
      aportacion = venta.cantidad_restante;
    } else if (aportacion > venta.cantidad_restante)
      return res
        .status(400)
        .json({ error: "No hay suficientes participaciones" });
    //create bloqueo mangopay user
    let user;
    try {
      user = await axios.get(
        "https://pro.stockencapital.com/api/v1/users/me/",
        {
          headers: {
            Authorization: `${jwtUser}`,
          },
        }
      );
      if (!user || user.data.status != "validated")
        return res.status(400).json({ error: "Usuario no valido" });
      console.log(user.data.cod);
    } catch (e) {
      return res.status(401).json({ error: "Error autenticando usuario" });
    }
    const funds = await axios.get(
      `https://pro.stockencapital.com/api/v1/users/${user.data.cod}/funds`,
      {
        headers: {
          Authorization: `${jwtUser}`,
        },
      }
    );
    console.log(funds.data);
    const mangopayWallet = await prisma.mangopay_mangopaywallet.findFirst({
      where: { cod: user.data.cod },
    });
    const mangopayId = await prisma.mangopay_mangopayuser.findFirst({
      where: { cod: user.data.cod },
    });
    if (!mangopayWallet || !mangopayId)
      return res
        .status(404)
        .json({ error: "No hay datos de mangopay suficientes" });
    let fiscalresidenceBuyer;
    fiscalresidenceBuyer = await prisma.users_fiscalresidence.findFirst({
      where: { user_id: user.data.id },
    });
    if (!fiscalresidenceBuyer)
      return res
        .status(404)
        .json({ error: "Comprador no tiene fiscal residence" });

    if (companyIdBuyer) {
      const companyBuyer = await prisma.companies_company.findUnique({
        where: { id: companyIdBuyer },
      });
      if (
        !companyBuyer ||
        !companyBuyer.social_denomination ||
        !companyBuyer.country ||
        !companyBuyer.governing_bodies_legal_representative_full_name ||
        !companyBuyer.governing_bodies_legal_representative_position ||
        companyBuyer.legal_representative_id != user.data.id
      )
        return res.status(400).json({
          error: "Empresa no es del usuario o con datos de empresa faltante",
        });
    } else {
      if (
        !user.data.first_name ||
        !user.data.last_name ||
        !user.data.id_document_number ||
        !fiscalresidenceBuyer
      )
        return res
          .status(400)
          .json({ error: "Faltan datos de usuario para poder comprar" });
    }
    const company = await prisma.companies_company.findUnique({
      where: { id: venta.companyID },
    });
    const seller = await prisma.users_user.findUnique({
      where: { id: venta.creador_id },
    });
    if (!seller)
      return res.status(404).json({ error: "Vendedor no encontrado" });
    if (!company)
      return res.status(400).json({ error: "Compania no encontrada" });
    if (funds.data.funds < aportacion)
      return res.status(400).json({ error: "Fondo insuficiente" });
    // /bloquear saldo
    const bloqueoSaldo = await axios.post(
      "https://pro.stockencapital.com/api/v1/moneyblocks/create_money_block/",
      {
        blocked_amount: aportacion,
        user_cod: user.data.cod,
        company_cod: company?.cod,
        status: "PROCESSING",
      },
      {
        headers: {
          Authorization: `${jwtUser}`,
        },
      }
    );
    let order = await prisma.orderNotaConvertible.create({
      data: {
        aportacion,
        venta_nc_id: venta.id,
        sellerId: venta.creador_id,
        buyerId: user.data.id,
        status: "SALDO_BLOQUEADO",
        bloqueo_id: bloqueoSaldo.data.id,
        create_date: new Date(),
        companyIdBuyer: companyIdBuyer,
      },
    });
    //documento aqui

    try {
      console.log("Hola");
      const document = await createDocNotaConvertible(
        seller,
        user.data,
        fiscalresidenceBuyer,
        order,
        company,
        venta,
        prisma
      );
      console.log("doc", document);
      if (!document || !document.id)
        return res.status(500).json({ error: "Error al crear documento" });
      order = await prisma.orderNotaConvertible.update({
        where: { id: order.id },
        data: {
          signature_id: document.id,
          document_id_first: document.documents[0].id,
          document_id_second: document.documents[1].id,
          status: "PENDIENTE_FIRMA",
        },
      });
    } catch (e) {
      console.log(e);
      return res.status(400).json(e);
    }

    venta = await prisma.venta_de_notas_convertibles.update({
      where: { id: venta.id },
      data: {
        cantidad_restante: venta.cantidad_restante - aportacion,
      },
    });

    return res.json({ venta, order });
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
export const rechazarCompraNotaConvertible = async (
  req: Request,
  res: Response
) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;
    const { jwtCreador, orderId } = req.body;
    const user = await axios.get(
      "https://pro.stockencapital.com/api/v1/users/me/",
      {
        headers: {
          Authorization: `${jwtCreador}`,
        },
      }
    );
    if (!user || user.data.status != "validated")
      return res.status(400).json({ error: "Usuario no valido" });

    let order = await prisma.orderNotaConvertible.findUnique({
      where: { id: orderId, status: "PENDIENTE_FIRMA", sellerId: user.data.id },
    });
    if (
      !order ||
      order.sellerId != user.data.id ||
      !order.buyerId ||
      !order.signature_id
    )
      return res.status(400).json({ error: "Orden no encontrada" });

    /// DESBLOQUEAR SALDO MANGOPAY
    const desbloqueoSaldo = await axios.patch(
      "https://pro.stockencapital.com/api/v1/moneyblocks/update_money_block_status/",
      {
        id: order.bloqueo_id,
        status: "DEACTIVATED",
      },
      {
        headers: {
          Authorization: `${jwtCreador}`,
        },
      }
    );
    const cancelSignNC = await cancel(order.signature_id);
    order = await prisma.orderNotaConvertible.update({
      where: { id: order.id },
      data: { complete_at: new Date(), status: "RECHAZADA" },
    });
    /// ACTUALIZAR CANTIDAD RESTANTE DE CUENTA PARTICIPE
    if (!order.venta_nc_id)
      return res.status(404).json({ error: "Order no es de una venta de nc" });
    const cuenta = await prisma.venta_de_notas_convertibles.findUnique({
      where: { id: order.venta_nc_id },
    });
    if (!cuenta || !cuenta.cantidad_restante)
      return res.status(400).json({ error: "Cuenta no encontrada" });
    await prisma.venta_de_notas_convertibles.update({
      where: { id: order.venta_nc_id },
      data: { cantidad_restante: cuenta?.cantidad_restante + order.aportacion },
    });
    res.json(order);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
export const aceptarCompraNotaConvertible = async (
  req: Request,
  res: Response
) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;
    const { jwtCreador, orderId } = req.body;
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
    } catch (e) {
      console.log(e);
      return res.status(400).json(e);
    }
    console.log(user.data.status);
    if (!user || user.data.status != "validated")
      return res.status(400).json({ error: "Usuario no valido" });
    let order = await prisma.orderNotaConvertible.findUnique({
      where: { id: orderId, status: "SALDO_BLOQUEADO" },
    });
    if (
      !order ||
      order.sellerId != user.data.id ||
      !order.buyerId ||
      !order.venta_nc_id ||
      !order.signature_id
    )
      return res.status(400).json({ error: "Orden no encontrada" });
    const venta = await prisma.venta_de_notas_convertibles.findUnique({
      where: { id: order.venta_nc_id },
    });
    if (!venta) return res.status(400).json({ error: "No hay cuenta" });
    const company = await prisma.companies_company.findUnique({
      where: { id: venta?.companyID },
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

    const buyer = await prisma.users_user.findUnique({
      where: { id: order.buyerId },
    });

    if (!buyer) return res.status(400).json({ error: "Comprador no valido" });

    let desbloqueoSaldo;
    // / DESBLOQUEAR SALDO MANGOPAY Y ENVIARSELO A VENDEDOR

    try {
      desbloqueoSaldo = await axios.patch(
        "https://pro.stockencapital.com/api/v1/moneyblocks/update_money_block_status/",
        {
          id: order.bloqueo_id,
          status: "EXECUTED",
        },
        {
          headers: {
            Authorization: `${jwtCreador}`,
          },
        }
      );
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Error desbloqueando el saldo" });
    }
    const docCompleted = await isCompleted(order.signature_id);
    if (docCompleted.length < 2)
      return res.status(400).json({ error: "Aun no han firmado ambas partes" });
    /// transferencia de mangopay de buyer a seller
    let mangopayIdBuyer,
      mangopayIdSeller,
      mangopayWalletBuyer,
      mangopayWalletSeller;
    mangopayIdSeller = (
      await prisma.mangopay_mangopayuser.findFirst({
        where: { cod: company.cod },
      })
    )?.mangopay_id;
    mangopayWalletSeller = (
      await prisma.mangopay_mangopaywallet.findFirst({
        where: { cod: company.cod },
      })
    )?.wallet_id;
    if (order.companyIdBuyer) {
      const companyBuyer = await prisma.companies_company.findUnique({
        where: { id: order.companyIdBuyer },
      });
      if (!companyBuyer || !companyBuyer.cod)
        return res
          .status(400)
          .json({ error: "Compañia de comprados no valida" });
      mangopayIdBuyer = (
        await prisma.mangopay_mangopayuser.findFirst({
          where: { cod: companyBuyer.cod },
        })
      )?.mangopay_id;
      mangopayWalletBuyer = (
        await prisma.mangopay_mangopaywallet.findFirst({
          where: { cod: companyBuyer.cod },
        })
      )?.wallet_id;
    } else {
      if (!buyer.cod)
        return res.status(400).json({ error: "Cod no asignado al usuario" });
      mangopayIdBuyer = (
        await prisma.mangopay_mangopayuser.findFirst({
          where: { cod: buyer.cod },
        })
      )?.mangopay_id;
      mangopayWalletBuyer = (
        await prisma.mangopay_mangopaywallet.findFirst({
          where: { cod: buyer.cod },
        })
      )?.wallet_id;
    }
    console.log(
      mangopayIdBuyer,
      "ID  buyer",
      mangopayIdSeller,
      "ID seller",
      mangopayWalletBuyer,
      "wallet buyer",
      mangopayWalletSeller,
      "wallet seller"
    );
    let myTransfer = {
      AuthorId: mangopayIdBuyer,
      Tag: "Created using Mangopay NodeJS SDK",
      CreditedUserId: mangopayIdSeller,
      DebitedFunds: {
        Currency: "EUR",
        Amount: order.aportacion * 100,
      },
      Fees: {
        Currency: "EUR",
        Amount: 0,
      },
      DebitedWalletId: mangopayWalletBuyer,
      CreditedWalletId: mangopayWalletSeller,
    };

    const createTransfer = async (
      myTransfer: mangopayInstance.transfer.CreateTransfer
    ) => {
      try {
        const response = await mangopay.Transfers.create(myTransfer);
        console.log(response);
        return response;
      } catch (err) {
        console.log(err);
        return false;
      }
    };
    let nota;
    try {
      // @ts-ignore
      const transferResponse = await createTransfer(myTransfer);
      if (!transferResponse || transferResponse.Status != "SUCCEEDED")
        return res.status(400).json({ error: "Transferencia ha fallado" });
      nota = await prisma.nota_convertible.create({
        data: {
          valor: order.aportacion,
          venta_nc_id: venta.id,
          document_id_first: order.document_id_first,
          document_id_second: order.document_id_second,
          signature_id: order.signature_id,
          buy_date: new Date(),
          interes_fijo: venta.interes_fijo,
          interes_variable: venta.interes_variable,
          vence_date: venta.vence_date,
          tasa_descuento: venta.tasa_descuento,
          capitulacion: venta.capitulacion,
          CAP_no_ronda: venta.CAP_no_ronda,
          floor: venta.floor,
          fecha_devolucion: venta.fecha_devolucion,
          negociar: venta.negociar,
          owner_id: buyer.id,
        },
      });
      order = await prisma.orderNotaConvertible.update({
        where: { id: order.id },
        data: {
          complete_at: new Date(),
          nota_convertible_id: nota.id,
          status: "COMPRA_TERMINADA",
        },
      });
    } catch (e) {
      console.log(e);
      return res.status(500).json(e);
    }

    res.json(order);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};

export const signCompraDoc = async (req: Request, res: Response) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;
    const { jwtCreador, orderId } = req.body;
    const user = await axios.get(
      "https://pro.stockencapital.com/api/v1/users/me/",
      {
        headers: {
          Authorization: `${jwtCreador}`,
        },
      }
    );
    if (!user || user.data.status != "validated")
      return res.status(400).json({ error: "Usuario no valido" });

    let order = await prisma.orderNotaConvertible.findUnique({
      where: { id: orderId, status: "PENDIENTE_FIRMA" },
    });
    if (
      !order ||
      !order.buyerId ||
      !order.signature_id ||
      !order.document_id_first ||
      !order.document_id_second ||
      !order.venta_nc_id
    )
      return res.status(400).json({ error: "Orden no encontrada" });
    const venta = await prisma.venta_de_notas_convertibles.findUnique({
      where: { id: order.venta_nc_id },
    });
    if (!venta)
      return res
        .status(404)
        .json({ error: "No existe cuenta participe asociada" });
    const buyer = await prisma.users_user.findUnique({
      where: { id: order.buyerId },
    });
    if (!buyer) return res.status(400).json({ error: "Comprador no valido" });

    const docCompleted = await isCompleted(order.signature_id);
    let nota;
    if (docCompleted.length < 2)
      return res.status(400).json({ error: "Aun no han firmado ambas partes" });

    nota = await prisma.nota_convertible.create({
      data: {
        valor: order.aportacion,
        venta_nc_id: venta.id,
        document_id_first: order.document_id_first,
        document_id_second: order.document_id_second,
        signature_id: order.signature_id,
        buy_date: new Date(),
        interes_fijo: venta.interes_fijo,
        interes_variable: venta.interes_variable,
        vence_date: venta.vence_date,
        tasa_descuento: venta.tasa_descuento,
        capitulacion: venta.capitulacion,
        CAP_no_ronda: venta.CAP_no_ronda,
        floor: venta.floor,
        fecha_devolucion: venta.fecha_devolucion,
        negociar: venta.negociar,
        owner_id: buyer.id,
      },
    });
    order = await prisma.orderNotaConvertible.update({
      where: { id: order.id },
      data: {
        complete_at: new Date(),
        nota_convertible_id: nota.id,
        status: "SALDO_BLOQUEADO",
      },
    });
    res.json({ order, nota });
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};

export const asignarNota = async (req: Request, res: Response) => {
  // @ts-ignore
  const prisma = req.prisma as PrismaClient;
  const { jwtCreador, venta_nc_id, aportacion, user_id, user_cod } = req.body;
  let user;
  try {
    user = await axios.get("https://pro.stockencapital.com/api/v1/users/me/", {
      headers: {
        Authorization: `${jwtCreador}`,
      },
    });
    if (!user || user.data.status != "validated")
      return res.status(400).json({ error: "Usuario no valido" });
  } catch (e) {
    console.log(e);
    return res.status(500).json({ error: "Error al validar usuario" });
  }
  const venta = await prisma.venta_de_notas_convertibles.findUnique({
    where: { id: venta_nc_id },
  });
  if (!venta)
    return res
      .status(404)
      .json({ error: "No se ha encontrado cuenta participe" });
  let companyBuyer;
  if (user_cod.substring(0, 2) == "pj") {
    companyBuyer = await prisma.companies_company.findFirst({
      where: { id: user_cod },
    });
    if (!companyBuyer || companyBuyer.legal_representative_id != user_id)
      return res.status(400).json({
        error: "Empresa vendedor no valida o no pertenece al usuario",
      });
  }
  const companySeller = await prisma.companies_company.findUnique({
    where: { id: venta.companyID },
  });
  if (!companySeller || companySeller.legal_representative_id != user.data.id)
    return res
      .status(400)
      .json({ error: "Empresa vendedor no valida o no pertenece al usuario" });
  const buyer = await prisma.users_user.findUnique({ where: { id: user_id } });
  if (!buyer) return res.status(400).json({ error: "Usuario no encontrado" });
  const fiscalresidenceBuyer = await prisma.users_fiscalresidence.findFirst({
    where: { user_id: buyer.id },
  });
  if (!fiscalresidenceBuyer)
    return res
      .status(400)
      .json({ error: "Usuario debe tener residencia fiscal" });
  let order = await prisma.orderNotaConvertible.create({
    data: {
      aportacion,
      venta_nc_id: venta.id,
      buyerId: user_id,
      sellerId: user.data.id,
      status: "PENDIENTE_FIRMA",
      companyIdBuyer: companyBuyer ? companyBuyer.id : null,
      create_date: new Date(),
    },
  });

  const document = await createDocNotaConvertible(
    user.data,
    buyer,
    fiscalresidenceBuyer,
    order,
    companySeller,
    venta,
    prisma
  );
  if (!document || !document.id)
    return res.status(500).json({ error: "Error al crear documento" });
  order = await prisma.orderNotaConvertible.update({
    where: { id: order.id },
    data: {
      document_id_first: document.documents[0].id,
      document_id_second: document.documents[1].id,
      signature_id: document.id,
    },
  });
  return res.json({ order, document });
};

export const verNotasConvertibles = async (req: Request, res: Response) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;

    const { jwtUser } = req.body;
    const user = await axios.get(
      "https://pro.stockencapital.com/api/v1/users/me/",
      {
        headers: {
          Authorization: `${jwtUser}`,
        },
      }
    );
    if (!user || user.data.status != "validated")
      return res.status(400).json({ error: "Usuario no valido" });
    let ventas = await prisma.venta_de_notas_convertibles.findMany();

    let notas_convertibles: any[] = [];

    for (let venta of ventas) {
      let medias = await prisma.mediaNC.findMany({
        where: { venta_nota_convertible_id: venta.id },
      });
      let img = [];
      let docs = [];
      for (let med of medias) {
        if (med.type == "IMAGE") {
          img.push({
            id: med.id,
            type: med.type,
            path: await getImage(med.path),
          });
        } else if (med.type == "DOC") {
          docs.push({
            id: med.id,
            type: med.type,
            path: await getDoc(med.path),
          });
        }
      }
      notas_convertibles.push({
        venta,
        img,
        docs,
      });
    }

    return res.json(notas_convertibles);
  } catch (e) {
    res.status(500).json(e);
  }
};

/// nuevo borrar
export const borrarNotaConvertible = async (req: Request, res: Response) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;
    const { jwtCreador, venta_nc_id } = req.body;
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
    /// validar que la empresa tenga mangopay ID
    const orderpaid = await prisma.orderNotaConvertible.findFirst({
      where: { status: "PENDIENTE_FIRMA" },
    });
    if (!orderpaid)
      return res
        .status(400)
        .json({ error: "Hay una orden pagada en esta nota convertible" });
    await prisma.orderNotaConvertible.deleteMany({
      where: { venta_nc_id },
    });
    const venta = await prisma.venta_de_notas_convertibles.delete({
      where: {
        id: venta_nc_id,
      },
    });

    res.json(venta);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
/// nuevo
export const verOrdenesByBuyerNC = async (req: Request, res: Response) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;

    const { jwtUser } = req.body;
    const user = await axios.get(
      "https://pro.stockencapital.com/api/v1/users/me/",
      {
        headers: {
          Authorization: `${jwtUser}`,
        },
      }
    );
    if (!user || user.data.status != "validated")
      return res.status(400).json({ error: "Usuario no valido" });
    let orders = await prisma.orderNotaConvertible.findMany({
      where: { buyerId: user.data.id },
    });
    let notas = await prisma.nota_convertible.findMany({
      where: { owner_id: user.data.id },
    });
    return res.json({ orders, notas });
  } catch (e) {
    res.status(500).json(e);
  }
};
export const verOrdenesBySellerNC = async (req: Request, res: Response) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;

    const { jwtUser } = req.body;
    const user = await axios.get(
      "https://pro.stockencapital.com/api/v1/users/me/",
      {
        headers: {
          Authorization: `${jwtUser}`,
        },
      }
    );
    if (!user || user.data.status != "validated")
      return res.status(400).json({ error: "Usuario no valido" });
    let orders = await prisma.orderNotaConvertible.findMany({
      where: { sellerId: user.data.id },
    });
    return res.json(orders);
  } catch (e) {
    res.status(500).json(e);
  }
};
