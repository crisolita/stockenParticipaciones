import { PrismaClient } from "@prisma/client";
import { Request, Response, response } from "express";
import axios from "axios";
import mangopayInstance from "mangopay2-nodejs-sdk";
import {
  createDocReVenta,
  createSignature,
  isCompleted,
} from "../service/signaturit";
//@ts-ignore
import SignaturitClient from "signaturit-sdk";
const API_KEY = process.env.SIGNATURITKEY;
const ENV = process.env.ENV;

const client = new SignaturitClient(API_KEY);
const mangopay = new mangopayInstance({
  clientId: process.env.CLIENT_ID_MANGOPAY as string,
  clientApiKey: process.env.API_KEY_MANGOPAY as string,
  baseUrl: "https://api.mangopay.com",
});
export const crearCuentaParticipe = async (req: Request, res: Response) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;
    const {
      jwtCreador,
      companyID,
      nombre_del_proyecto,
      descripcion,
      cantidad_a_vender,
      precio_unitario,
      cesion,
      duracion,
      remuneracion,
      plazos_remuneracion,
      resultado,
      determinacion,
      juridicion,
      fecha_lanzamiento,
      liquidacion,
      Clausulas,
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
    if (
      !company.social_denomination ||
      !company.country ||
      !company.city ||
      !company.street_address ||
      !company.cif ||
      !company.registration_data_notary_city ||
      !company.registration_data_notary_full_name ||
      !company.registration_data_date ||
      !company.registration_data_number ||
      !company.registration_data_inscription_date ||
      !company.registration_data_state ||
      !company.registration_data_volume_number ||
      !company.registration_data_page_number ||
      !company.registration_data_sheet_number ||
      !company.registration_data_inscription_number ||
      !company.governing_bodies_legal_representative_position ||
      !company.governing_bodies_legal_representative_full_name ||
      !company.governing_bodies_legal_representative_powers_date ||
      !company.governing_bodies_notary_city ||
      !company.governing_bodies_notary_full_name ||
      !company.governing_bodies_notary_number ||
      !company.description
    )
      return res.status(400).json({ error: "Informacion de empresa faltante" });
    /// validar que la empresa tenga mangopay ID
    const cuenta = await prisma.cuentas_participes.create({
      data: {
        creator_id: user.data.id,
        nombre_del_proyecto,
        descripcion,
        cantidad_a_vender,
        precio_unitario,
        cantidad_restante: cantidad_a_vender,
        cesion,
        duracion: new Date(duracion),
        remuneracion,
        plazos_remuneracion,
        resultado,
        determinacion,
        juridicion,
        liquidacion,
        clausulas: Clausulas,
        companyIDSeller: company.id,
        fecha_lanzamiento: new Date(fecha_lanzamiento),
      },
    });

    res.json(cuenta);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
export const comprarParticipacion = async (req: Request, res: Response) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;

    const { participe_id, cantidad, jwtUser, companyIdBuyer } = req.body;
    let cuenta_participe = await prisma.cuentas_participes.findUnique({
      where: { id: participe_id },
    });
    if (!cuenta_participe)
      return res.status(400).json({ error: "No existe cuenta participe" });

    if (cantidad > cuenta_participe.cantidad_restante)
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
    if (companyIdBuyer) {
      const companyBuyer = await prisma.companies_company.findUnique({
        where: { id: companyIdBuyer },
      });
      if (
        !companyBuyer ||
        !companyBuyer.social_denomination ||
        !companyBuyer.country ||
        !companyBuyer.registration_data_notary_full_name ||
        !companyBuyer.registration_data_volume_number ||
        !companyBuyer.registration_data_page_number ||
        !companyBuyer.registration_data_inscription_date ||
        !companyBuyer.registration_data_state ||
        !companyBuyer.governing_bodies_legal_representative_powers_date ||
        !companyBuyer.governing_bodies_legal_representative_full_name ||
        !companyBuyer.governing_bodies_notary_city ||
        !companyBuyer.governing_bodies_notary_number ||
        !companyBuyer.governing_bodies_notary_full_name ||
        !companyBuyer.governing_bodies_legal_representative_position ||
        companyBuyer.legal_representative_id != user.data.id
      )
        return res.status(400).json({
          error: "Empresa no es del usuario o con datos de empresa faltante",
        });
    } else {
      const fiscalresidence = await prisma.users_fiscalresidence.findFirst({
        where: { user_id: user.data.id },
      });

      if (
        !user.data.first_name ||
        !user.data.last_name ||
        // !user.data.marital_status ||
        // !user.data.profession ||
        !user.data.id_document_number ||
        !fiscalresidence
      )
        return res
          .status(400)
          .json({ error: "Faltan datos de usuario para poder comprar" });
    }
    const company = await prisma.companies_company.findUnique({
      where: { id: cuenta_participe.companyIDSeller },
    });
    if (funds.data.funds < cantidad * cuenta_participe.precio_unitario)
      return res.status(400).json({ error: "Fondo insuficiente" });
    // /bloquear saldo
    const bloqueoSaldo = await axios.post(
      "https://pro.stockencapital.com/api/v1/moneyblocks/create_money_block/",
      {
        blocked_amount: cantidad * cuenta_participe.precio_unitario,
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
    const order = await prisma.orders.create({
      data: {
        precio_total: cantidad * cuenta_participe.precio_unitario,
        cantidad: cantidad,
        cuenta_participe_id: cuenta_participe.id,
        sellerID: cuenta_participe.creator_id,
        buyerID: user.data.id,
        status: "SALDO_BLOQUEADO",
        bloqueo_id: bloqueoSaldo.data.id,
        create_date: new Date(),
      },
    });
    cuenta_participe = await prisma.cuentas_participes.update({
      where: { id: cuenta_participe.id },
      data: {
        cantidad_restante: cuenta_participe.cantidad_restante - cantidad,
      },
    });

    return res.json({ cuenta_participe, order });
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
export const verOrdenesBySell = async (req: Request, res: Response) => {
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

    //create bloqueo mangopay user
    let saldoBloqueado = [];
    let finalizadas = [];
    let porFirmarVendedor = [];
    saldoBloqueado.push(
      await prisma.orders.findMany({
        where: { sellerID: user.data.id, status: "SALDO_BLOQUEADO" },
      })
    );
    finalizadas.push(
      await prisma.orders.findMany({
        where: { sellerID: user.data.id, status: "COMPRA_TERMINADA" },
      })
    );
    porFirmarVendedor.push(
      await prisma.orders.findMany({
        where: {
          sellerID: user.data.id,
          status: "PENDIENTE_FIRMA",
        },
      })
    );

    return res.json({ saldoBloqueado, finalizadas, porFirmarVendedor });
  } catch (e) {
    res.status(500).json(e);
  }
};

export const verCuentasParticipes = async (req: Request, res: Response) => {
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
    let cuentas_participes = await prisma.cuentas_participes.findMany();

    return res.json(cuentas_participes);
  } catch (e) {
    res.status(500).json(e);
  }
};
export const verOrdenesByBuyer = async (req: Request, res: Response) => {
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

    /// ORDENES RECHAZADAS
    const saldoBloqueado = await prisma.orders.findMany({
      where: { buyerID: user.data.id, status: "SALDO_BLOQUEADO" },
    });
    const finalizadas = await prisma.orders.findMany({
      where: { buyerID: user.data.id, status: "COMPRA_TERMINADA" },
    });
    const porFirmarComprador = await prisma.orders.findMany({
      where: { buyerID: user.data.id, status: "PENDIENTE_FIRMA" },
    });

    return res.json({ saldoBloqueado, finalizadas, porFirmarComprador });
  } catch (e) {
    res.status(500).json(e);
  }
};
export const aceptarComprasCuentaParticipe = async (
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
    let order = await prisma.orders.findUnique({
      where: { id: orderId, status: "SALDO_BLOQUEADO" },
    });
    if (!order || order.sellerID != user.data.id || !order.buyerID)
      return res.status(400).json({ error: "Orden no encontrada" });
    const cuenta = await prisma.cuentas_participes.findUnique({
      where: { id: order.cuenta_participe_id },
    });
    if (!cuenta) return res.status(400).json({ error: "No hay cuenta" });
    const company = await prisma.companies_company.findUnique({
      where: { id: cuenta?.companyIDSeller },
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
      where: { id: order.buyerID },
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
    // console.log("QEEEE LOCOO");
    // /// transferencia de mangopay de buyer a seller
    // let mangopayIdBuyer,
    //   mangopayIdSeller,
    //   mangopayWalletBuyer,
    //   mangopayWalletSeller;
    // mangopayIdSeller = (
    //   await prisma.mangopay_mangopayuser.findFirst({
    //     where: { cod: company.cod },
    //   })
    // )?.mangopay_id;
    // mangopayWalletSeller = (
    //   await prisma.mangopay_mangopaywallet.findFirst({
    //     where: { cod: company.cod },
    //   })
    // )?.wallet_id;
    // if (order.companyIdBuyer) {
    //   const companyBuyer = await prisma.companies_company.findUnique({
    //     where: { id: order.companyIdBuyer },
    //   });
    //   if (!companyBuyer || !companyBuyer.cod)
    //     return res
    //       .status(400)
    //       .json({ error: "Compañia de comprados no valida" });
    //   mangopayIdBuyer = (
    //     await prisma.mangopay_mangopayuser.findFirst({
    //       where: { cod: companyBuyer.cod },
    //     })
    //   )?.mangopay_id;
    //   mangopayWalletBuyer = (
    //     await prisma.mangopay_mangopaywallet.findFirst({
    //       where: { cod: companyBuyer.cod },
    //     })
    //   )?.wallet_id;
    // } else {
    //   if (!buyer.cod)
    //     return res.status(400).json({ error: "Cod no asignado al usuario" });
    //   mangopayIdBuyer = (
    //     await prisma.mangopay_mangopayuser.findFirst({
    //       where: { cod: buyer.cod },
    //     })
    //   )?.mangopay_id;
    //   mangopayWalletBuyer = (
    //     await prisma.mangopay_mangopaywallet.findFirst({
    //       where: { cod: buyer.cod },
    //     })
    //   )?.wallet_id;
    // }
    // console.log(
    //   mangopayIdBuyer,
    //   "ID  buyer",
    //   mangopayIdSeller,
    //   "ID seller",
    //   mangopayWalletBuyer,
    //   "wallet buyer",
    //   mangopayWalletSeller,
    //   "wallet seller"
    // );
    // let myTransfer = {
    //   AuthorId: mangopayIdBuyer,
    //   Tag: "Created using Mangopay NodeJS SDK",
    //   CreditedUserId: mangopayIdSeller,
    //   DebitedFunds: {
    //     Currency: "EUR",
    //     Amount: order.precio_total * 100,
    //   },
    //   Fees: {
    //     Currency: "EUR",
    //     Amount: 0,
    //   },
    //   DebitedWalletId: mangopayWalletBuyer,
    //   CreditedWalletId: mangopayWalletSeller,
    // };

    // const createTransfer = async (
    //   myTransfer: mangopayInstance.transfer.CreateTransfer
    // ) => {
    //   try {
    //     const response = await mangopay.Transfers.create(myTransfer);
    //     console.log(response);
    //     return response;
    //   } catch (err) {
    //     console.log(err);
    //     return false;
    //   }
    // };
    // try {
    //   // @ts-ignore
    //   const transferResponse = await createTransfer(myTransfer);
    //   if (!transferResponse || transferResponse.Status != "SUCCEEDED")
    //     return res.status(400).json({ error: "Transferencia ha fallado" });
    /// crear yun modelo para este registro aparte
    // const transaction = await prisma.mangopay_basemangopaytransaction.create({
    //   data: {
    //     created: new Date(transferResponse.CreationDate),
    //     modified: new Date(transferResponse.ExecutionDate),
    //     transaction_id: transferResponse.Id,
    //     status: transferResponse.Status,
    //     amount: transferResponse.DebitedFunds.Amount,
    //     currency: transferResponse.DebitedFunds.Currency,
    //     fees: transferResponse.Fees.Amount,
    //     cod: transferResponse.ResultCode,
    //   },
    // });
    // await prisma.mangopay_mangopaytransfer_cuenta_participe.create({
    //   data: {
    //     from_user_id: buyer.id,
    //     to_user_id: user.data.id,
    //     basemangopaytransaction_ptr_id: transaction.id,
    //     from_cod: buyer.cod,
    //     to_cod: company.cod,
    //     total_amount: transaction.amount,
    //     cuenta_participe_id: cuenta.id,
    //   },
    // });
    // } catch (e) {
    //   console.log(e);
    //   return res.status(500).json(e);
    // }
    try {
      console.log("Hola");
      const document = await createSignature(
        order,
        cuenta,
        buyer,
        user.data,
        company,
        prisma
      );
      console.log("doc", document);
      if (!document || !document.id)
        return res.status(500).json({ error: "Error al crear documento" });
      order = await prisma.orders.update({
        where: { id: order.id },
        data: {
          signatureId: document.id,
          documentId_first: document.documents[0].id,
          documentId_second: document.documents[1].id,
          status: "PENDIENTE_FIRMA",
        },
      });
    } catch (e) {
      console.log(e);
      return res.status(400).json(e);
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

    let order = await prisma.orders.findUnique({
      where: { id: orderId, status: "PENDIENTE_FIRMA" },
    });
    if (
      !order ||
      !order.buyerID ||
      !order.signatureId ||
      !order.documentId_first ||
      !order.documentId_second
    )
      return res.status(400).json({ error: "Orden no encontrada" });
    const cuenta = await prisma.cuentas_participes.findUnique({
      where: { id: order.cuenta_participe_id },
    });
    if (!cuenta)
      return res
        .status(404)
        .json({ error: "No existe cuenta participe asociada" });
    const buyer = await prisma.users_user.findUnique({
      where: { id: order.buyerID },
    });
    if (!buyer) return res.status(400).json({ error: "Comprador no valido" });

    const docCompleted = await isCompleted(order.signatureId);
    let participacion;
    if (docCompleted.length < 2)
      return res.status(400).json({ error: "Aun no han firmado ambas partes" });
    if (order.participacion_id) {
      //participacion anterior
      participacion = await prisma.participacion.findUnique({
        where: { id: order.participacion_id },
      });
      //guardar el record
      if (!participacion)
        return res.status(404).json({ error: "Participacion no encontrada" });
      const record = await prisma.record_participaciones.create({
        data: {
          participacion_id: participacion.id,
          cantidad: participacion?.cantidad,
          monto_pagado: participacion?.monto_pagado,
          old_document_id_first: participacion?.document_id_first,
          old_document_second: participacion.document_id_second,
          old_signature_id: participacion.signature_id,
          old_owner_id: participacion.owner_id,
          change_date: new Date(),
        },
      });
      participacion = await prisma.participacion.update({
        where: { id: participacion.id },
        data: {
          buy_date: new Date(),
          owner_id: order.buyerID,
          document_id_first: order.documentId_first,
          document_id_second: order.documentId_second,
          signature_id: order.signatureId,
          monto_pagado: order.precio_total,
        },
      });
    } else {
      participacion = await prisma.participacion.create({
        data: {
          cuenta_participe_id: cuenta.id,
          cantidad: order.cantidad,
          monto_pagado: order.precio_total,
          document_id_first: order.documentId_first,
          document_id_second: order.documentId_second,
          signature_id: order.signatureId,
          owner_id: buyer.id,
          buy_date: new Date(),
        },
      });
    }

    order = await prisma.orders.update({
      where: { id: order.id },
      data: {
        complete_at: new Date(),
        participacion_id: participacion.id,
        status: "COMPRA_TERMINADA",
      },
    });
    res.json({ order, participacion });
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};

export const rechazarComprasCuentaParticipe = async (
  req: Request,
  res: Response
) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;
    const { jwtCreador, companyID, orderId } = req.body;
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
    const company = await prisma.companies_company.findUnique({
      where: { id: companyID },
    });
    if (
      !company ||
      company.legal_representative_id != user.data.id ||
      company.status != "validated"
    )
      return res.status(400).json({
        error: "Compañia no existe, no pertenece al usuario o no esta validada",
      });
    let order = await prisma.orders.findUnique({
      where: { id: orderId, status: "SALDO_BLOQUEADO" },
    });
    if (!order || order.sellerID != user.data.id || !order.buyerID)
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
    order = await prisma.orders.update({
      where: { id: order.id },
      data: { complete_at: new Date(), status: "RECHAZADA" },
    });
    /// ACTUALIZAR CANTIDAD RESTANTE DE CUENTA PARTICIPE
    const cuenta = await prisma.cuentas_participes.findUnique({
      where: { id: order.cuenta_participe_id },
    });
    if (!cuenta || !cuenta.cantidad_restante)
      return res.status(400).json({ error: "Cuenta no encontrada" });
    await prisma.cuentas_participes.update({
      where: { id: order.cuenta_participe_id },
      data: { cantidad_restante: cuenta?.cantidad_restante + order.cantidad },
    });
    res.json(order);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};

/// marketplace entre usuario
export const crearVentaDeParticipacion = async (
  req: Request,
  res: Response
) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;

    const { participacion_id, jwtUser, precio } = req.body;

    let participacion = await prisma.participacion.findUnique({
      where: { id: participacion_id },
    });
    /// VALIDACION DEL CESION
    if (!participacion)
      return res.status(400).json({ error: "No existe cuenta participe" });
    //create bloqueo mangopay user
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
    console.log(user.data.cod);
    if (participacion.owner_id != user.data.id)
      return res
        .status(400)
        .json({ error: "Participacion no pertenece al usuario" });

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

    const order = await prisma.orders.create({
      data: {
        precio_total: precio,
        cantidad: participacion.cantidad,
        cuenta_participe_id: participacion.cuenta_participe_id,
        sellerID: participacion.owner_id,
        status: "VENTA_ACTIVA",
        participacion_id: participacion.id,
        create_date: new Date(),
      },
    });
    return res.json(order);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
export const comprarParticipacionPorOrden = async (
  req: Request,
  res: Response
) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;

    const { orderId, jwtUser } = req.body;
    let order = await prisma.orders.findUnique({
      where: { id: orderId },
    });
    if (!order || order.status != "VENTA_ACTIVA")
      return res
        .status(400)
        .json({ error: "No existe order o no esta activa" });

    //create bloqueo mangopay user
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
    console.log(user.data.cod);
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

    const fiscalresidence = await prisma.users_fiscalresidence.findFirst({
      where: { user_id: user.data.id },
    });
    if (
      !user.data.first_name ||
      !user.data.last_name ||
      !user.data.marital_status ||
      !user.data.profession ||
      !user.data.id_document_number ||
      !fiscalresidence
    )
      return res
        .status(400)
        .json({ error: "Faltan datos de usuario para poder comprar" });

    if (funds.data.funds < order.precio_total)
      return res.status(400).json({ error: "Fondo insuficiente" });
    // /bloquear saldo
    /// bloqueo de mangopay

    try {
      const seller = await prisma.users_user.findUnique({
        where: { id: order.sellerID },
      });
      const bloqueoSaldo = await axios.post(
        "https://pro.stockencapital.com/api/v1/moneyblocks/create_money_block/",
        {
          blocked_amount: order.precio_total,
          user_cod: user.data.cod,
          company_cod: seller?.cod,
          status: "PROCESSING",
        },
        {
          headers: {
            Authorization: `${jwtUser}`,
          },
        }
      );
    } catch (e) {
      console.log(e);
      res.status(400).json({ error: "Error al bloquear saldo" });
    }

    order = await prisma.orders.update({
      where: { id: order.id },
      data: {
        buyerID: user.data.id,
        status: "SALDO_BLOQUEADO",
      },
    });

    return res.json(order);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};

export const rechazarCompraParticipacion = async (
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

    let order = await prisma.orders.findUnique({
      where: { id: orderId, status: "SALDO_BLOQUEADO" },
    });
    if (!order || order.sellerID != user.data.id || !order.buyerID)
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
    order = await prisma.orders.update({
      where: { id: order.id },
      data: { complete_at: new Date(), status: "RECHAZADA" },
    });
    const newOrder = await prisma.orders.create({
      data: {
        precio_total: order.precio_total,
        cantidad: order.cantidad,
        cuenta_participe_id: order.cuenta_participe_id,
        sellerID: order.sellerID,
        status: "VENTA_ACTIVA",
        participacion_id: order.participacion_id,
        create_date: order.create_date,
      },
    });
    res.json({ order, newOrder });
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};

export const aceptarCompraParticipacion = async (
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
    if (!user || user.data.status != "validated")
      return res.status(400).json({ error: "Usuario no valido" });
    let order = await prisma.orders.findUnique({
      where: { id: orderId, status: "SALDO_BLOQUEADO" },
    });
    if (!order || order.sellerID != user.data.id || !order.buyerID)
      return res.status(400).json({ error: "Orden no encontrada" });
    const cuenta = await prisma.cuentas_participes.findUnique({
      where: { id: order.cuenta_participe_id },
    });

    const buyer = await prisma.users_user.findUnique({
      where: { id: order.buyerID },
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
      return res.status(500).json(e);
    }
    /// transferencia de mangopay de buyer a seller
    let mangopayIdBuyer,
      mangopayIdSeller,
      mangopayWalletBuyer,
      mangopayWalletSeller;
    mangopayIdSeller = (
      await prisma.mangopay_mangopayuser.findFirst({
        where: { cod: user.data.cod },
      })
    )?.mangopay_id;
    mangopayWalletSeller = (
      await prisma.mangopay_mangopaywallet.findFirst({
        where: { cod: user.data.cod },
      })
    )?.wallet_id;

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
        Amount: order.precio_total,
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
    try {
      //@ts-ignore
      const transferResponse = await createTransfer(myTransfer);
      if (!transferResponse || transferResponse.Status != "SUCCEEDED")
        return res.status(400).json({ error: "Transferencia ha fallado" });
    } catch (e) {
      console.log(e);
      return res.status(500).json(e);
    }
    try {
      if (!order.participacion_id)
        return res
          .status(404)
          .json({ error: "Participacion id no encontrada" });
      const participacion = await prisma.participacion.findUnique({
        where: { id: order.participacion_id },
      });
      if (!participacion)
        return res.status(404).json({ error: "Participacion no encontrada" });
      if (!cuenta)
        return res.status(404).json({ error: "Cuenta no encontrada" });
      const document = await createDocReVenta(
        user.data,
        buyer,
        participacion,
        cuenta,
        prisma
      );
      console.log("doc", document);
      if (!document || !document.id)
        return res.status(500).json({ error: "Error al crear documento" });
      // guardar particpacion en historial y asignar a nuevo comprador
      order = await prisma.orders.update({
        where: { id: order.id },
        data: {
          status: "PENDIENTE_FIRMA",
          documentId_first: document.documents[0].id,
          documentId_second: document.documents[1].id,
          signatureId: document.id,
        },
      });
    } catch (e) {
      console.log(e);
      return res.status(400).json(e);
    }
    res.json(order);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
