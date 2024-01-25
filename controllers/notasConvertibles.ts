import { PrismaClient } from "@prisma/client";
import { Request, Response, response } from "express";
import axios from "axios";
import mangopayInstance from "mangopay2-nodejs-sdk";
import { crearVentaNotaConvertible } from "../service/notasConvertibles";
import { createDocNotaConvertible, isCompleted } from "../service/signaturit";
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
        creador_id: user.data.id,
        cantidad_restante: cantidad_a_vender,
      },
      prisma
    );
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

    const { venta_id, cantidad, jwtUser, companyIdBuyer } = req.body;
    let venta = await prisma.venta_de_notas_convertibles.findUnique({
      where: { id: venta_id },
    });
    if (!venta)
      return res.status(400).json({ error: "No existe cuenta participe" });

    if (cantidad > venta.cantidad_restante)
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
        !companyBuyer.governing_bodies_legal_representative_full_name ||
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
      where: { id: venta.companyID },
    });
    if (funds.data.funds < cantidad * venta.ticket_minimo)
      return res.status(400).json({ error: "Fondo insuficiente" });
    // /bloquear saldo
    const bloqueoSaldo = await axios.post(
      "https://pro.stockencapital.com/api/v1/moneyblocks/create_money_block/",
      {
        blocked_amount: cantidad * venta.ticket_minimo,
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
    const order = await prisma.orderNotaConvertible.create({
      data: {
        precio_total: cantidad * venta.ticket_minimo,
        cantidad: cantidad,
        venta_nc_id: venta.id,
        sellerId: venta.creador_id,
        buyerId: user.data.id,
        status: "SALDO_BLOQUEADO",
        bloqueo_id: bloqueoSaldo.data.id,
        create_date: new Date(),
        companyIdBuyer: companyIdBuyer,
      },
    });
    venta = await prisma.venta_de_notas_convertibles.update({
      where: { id: venta.id },
      data: {
        cantidad_restante: venta.cantidad_restante - cantidad,
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
    let order = await prisma.orderNotaConvertible.findUnique({
      where: { id: orderId, status: "SALDO_BLOQUEADO" },
    });
    if (!order || order.sellerId != user.data.id || !order.buyerId)
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
      data: { cantidad_restante: cuenta?.cantidad_restante + order.cantidad },
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
      !order.venta_nc_id
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
      // const document = await createDocNotaConvertible(
      //   order,
      //   cuenta,
      //   buyer,
      //   user.data,
      //   company,
      //   prisma
      // );
      // console.log("doc", document);
      // if (!document || !document.id)
      //   return res.status(500).json({ error: "Error al crear documento" });
      // order = await prisma.orderNotaConvertible.update({
      //   where: { id: order.id },
      //   data: {
      //     signature_id: document.id,
      //     document_id_first: document.documents[0].id,
      //     document_id_second: document.documents[1].id,
      //     status: "PENDIENTE_FIRMA",
      //   },
      // });
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
        valor: order.precio_total,
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
    res.json({ order, nota });
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
