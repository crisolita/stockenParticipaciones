import { PrismaClient, participacion } from "@prisma/client";
import { Request, Response, response } from "express";
import axios from "axios";
import mangopayInstance from "mangopay2-nodejs-sdk";
import {
  cancel,
  createDocReVenta,
  createSignature,
  isCompleted,
} from "../service/signaturit";
//@ts-ignore
import SignaturitClient from "signaturit-sdk";
import { getDoc, getImage, uploadDoc, uploadImage } from "../service/aws";
import sanitizeHtml from "sanitize-html";

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
    let {
      jwtCreador,
      companyID,
      nombre_del_proyecto,
      descripcion,
      cantidad_a_vender,
      cesion,
      ticket_minimo,
      duracion,
      fecha_lanzamiento,
      media,
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

    //sanitizar HTML

    const cleanHtml = sanitizeHtml(Clausulas, {
      allowedTags: ["p", "a"], // Etiquetas permitidas
      allowedAttributes: {
        a: ["href"], // Atributos permitidos por etiqueta
      },
      disallowedTagsMode: "discard",
    });

    console.log(cleanHtml);

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
    let cuenta = await prisma.cuentas_participes.create({
      data: {
        creator_id: user.data.id,
        nombre_del_proyecto,
        descripcion,
        cantidad_a_vender,
        cantidad_restante: cantidad_a_vender,
        cesion,
        duracion: new Date(duracion),
        ticket_minimo,
        clausulas: Clausulas,
        companyIDSeller: company.id,
        fecha_lanzamiento: new Date(fecha_lanzamiento),
      },
    });
    let medias = [];
    if (media) {
      for (let med of media) {
        let path = `media_${cuenta.nombre_del_proyecto.replace(/\s/g, "_")}_${
          med.type
        }_${cuenta.id}_${cuenta.countMedia ? cuenta.countMedia + 1 : 1}`;
        cuenta = await prisma.cuentas_participes.update({
          where: { id: cuenta.id },
          data: { countMedia: cuenta.countMedia ? cuenta.countMedia + 1 : 1 },
        });
        let saveMedia = await prisma.mediaCP.create({
          data: {
            cuenta_participe_id: cuenta.id,
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

    res.json({ cuenta, medias });
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
export const comprarParticipacion = async (req: Request, res: Response) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;

    let { participe_id, aportacion, jwtUser, companyIdBuyer } = req.body;
    let cuenta_participe = await prisma.cuentas_participes.findUnique({
      where: { id: participe_id },
    });
    if (!cuenta_participe)
      return res.status(400).json({ error: "No existe cuenta participe" });
    if (cuenta_participe.cantidad_restante <= cuenta_participe.ticket_minimo) {
      aportacion = cuenta_participe.cantidad_restante;
    } else if (aportacion > cuenta_participe.cantidad_restante)
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
      console.log(user.data);
      console.log(
        !user.data.first_name ||
          !user.data.last_name ||
          !user.data.id_document_number ||
          !user.data.fiscal_residence
      );
      if (
        !user.data.first_name ||
        !user.data.last_name ||
        !user.data.id_document_number ||
        !user.data.fiscal_residence
      )
        return res
          .status(400)
          .json({ error: "Faltan datos de usuario para poder comprar" });
    }
    const company = await prisma.companies_company.findUnique({
      where: { id: cuenta_participe.companyIDSeller },
    });
    const seller = await prisma.users_user.findUnique({
      where: { id: cuenta_participe.creator_id },
    });
    if (!seller || !company)
      return res
        .status(404)
        .json({ error: "Creador o compania no encontrado" });
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

    let order = await prisma.orders.create({
      data: {
        aportacion: aportacion,
        cuenta_participe_id: cuenta_participe.id,
        sellerID: cuenta_participe.creator_id,
        buyerID: user.data.id,
        status: "SALDO_BLOQUEADO",
        bloqueo_id: bloqueoSaldo.data.id,
        companyIdBuyer: companyIdBuyer ? companyIdBuyer : null,
        create_date: new Date(),
        companyIdSeller: cuenta_participe.companyIDSeller,
      },
    });

    try {
      console.log("Hola");
      const document = await createSignature(
        order,
        cuenta_participe,
        user.data,
        seller,
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

    cuenta_participe = await prisma.cuentas_participes.update({
      where: { id: cuenta_participe.id },
      data: {
        cantidad_restante: cuenta_participe.cantidad_restante - aportacion,
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

    const { jwtUser, companyId } = req.body;
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
    } catch (e) {
      console.log(e);
      return res.status(500).json({ error: "Error al validar usuario" });
    }

    //create bloqueo mangopay user
    let saldoBloqueado = [];
    let finalizadas = [];
    let porFirmarVendedor = [];
    let ventasActivas = [];

    saldoBloqueado.push(
      await prisma.orders.findMany({
        where: {
          sellerID: user.data.id,
          status: "SALDO_BLOQUEADO",
          companyIdSeller: companyId,
        },
      })
    );
    finalizadas.push(
      await prisma.orders.findMany({
        where: {
          sellerID: user.data.id,
          status: "COMPRA_TERMINADA",
          companyIdSeller: companyId,
        },
      })
    );
    porFirmarVendedor.push(
      await prisma.orders.findMany({
        where: {
          sellerID: user.data.id,
          status: "PENDIENTE_FIRMA",
          companyIdSeller: companyId,
        },
      })
    );
    ventasActivas.push(
      await prisma.orders.findMany({
        where: {
          sellerID: user.data.id,
          status: "VENTA_ACTIVA",
          companyIdSeller: companyId,
        },
      })
    );

    return res.json({
      saldoBloqueado,
      finalizadas,
      porFirmarVendedor,
      ventasActivas,
    });
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
    let cuentas = await prisma.cuentas_participes.findMany();
    let reventas = await prisma.orders.findMany({
      where: { status: "VENTA_ACTIVA" },
    });
    let cuentas_participes: any[] = [];
    reventas = reventas.filter((x) => {
      return x.participacion_id;
    });
    for (let cuenta of cuentas) {
      let revende;
      for (let reventa of reventas) {
        if (reventa.cuenta_participe_id == cuenta.id) revende = reventa;
      }
      let medias = await prisma.mediaCP.findMany({
        where: { cuenta_participe_id: cuenta.id },
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
      cuentas_participes.push({
        id: cuenta.id,
        creator_id: cuenta.creator_id,
        nombre_del_proyecto: cuenta.nombre_del_proyecto,
        descripcion: cuenta.descripcion,
        cantidad_a_vender: cuenta.cantidad_a_vender,
        cantidad_restante: cuenta.cantidad_restante,
        cesion: cuenta.cesion,
        ticket_minimo: cuenta.ticket_minimo,
        duracion: cuenta.duracion,
        fecha_lanzamiento: cuenta.fecha_lanzamiento,
        companyIDSeller: cuenta.companyIDSeller,
        clausulas: cuenta.clausulas,
        reventas: revende,
        docs,
        img,
      });
    }

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
    let participaciones = await prisma.participacion.findMany({
      where: { owner_id: user.data.id },
    });
    let rechazadas = await prisma.orders.findMany({
      where: { buyerID: user.data.id, status: "RECHAZADA" },
    });
    return res.json({
      saldoBloqueado,
      finalizadas,
      porFirmarComprador,
      participaciones,
      rechazadas,
    });
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
      where: { id: orderId, status: "PENDIENTE_FIRMA" },
    });
    if (
      !order ||
      order.sellerID != user.data.id ||
      !order.buyerID ||
      !order.signatureId ||
      !order.documentId_first ||
      !order.documentId_second
    )
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
    const docCompleted = await isCompleted(order.signatureId);
    console.log(docCompleted);
    if (docCompleted?.length < 2)
      return res.status(400).json({ error: "Aun no han firmado ambas partes" });
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
    let participacion;
    try {
      // @ts-ignore
      const transferResponse = await createTransfer(myTransfer);
      if (!transferResponse || transferResponse.Status != "SUCCEEDED")
        return res.status(400).json({ error: "Transferencia ha fallado" });
      participacion = await prisma.participacion.create({
        data: {
          cuenta_participe_id: cuenta.id,
          aportacion: order.aportacion,
          document_id_first: order.documentId_first,
          document_id_second: order.documentId_second,
          signature_id: order.signatureId,
          owner_id: buyer.id,
          status: "ACTIVO",
          cesion_is_allowed: cuenta.cesion,
          buy_date: new Date(),
        },
      });
      order = await prisma.orders.update({
        where: { id: order.id },
        data: {
          status: "COMPRA_TERMINADA",
          complete_at: new Date(),
          participacion_id: participacion.id,
        },
      });
    } catch (e) {
      console.log(e);
      return res.status(500).json(e);
    }

    res.json({ order, participacion });
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
    let participacion: participacion | null;
    if (docCompleted?.length < 2)
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
          aportacion: participacion?.aportacion,
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
          aportacion: order.aportacion,
          status: "ACTIVO",
          cesion_is_allowed: cuenta.cesion,
        },
      });
    } else {
      participacion = await prisma.participacion.create({
        data: {
          cuenta_participe_id: cuenta.id,
          aportacion: order.aportacion,
          document_id_first: order.documentId_first,
          document_id_second: order.documentId_second,
          signature_id: order.signatureId,
          owner_id: buyer.id,
          status: "ACTIVO",
          cesion_is_allowed: cuenta.cesion,
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
      where: { id: orderId, status: "PENDIENTE_FIRMA", sellerID: user.data.id },
    });
    if (
      !order ||
      order.sellerID != user.data.id ||
      !order.buyerID ||
      !order.signatureId
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
    const cancelSignature = await cancel(order.signatureId);
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
      data: { cantidad_restante: cuenta?.cantidad_restante + order.aportacion },
    });
    res.json(order);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
export const asignarCtaParticipe = async (req: Request, res: Response) => {
  // @ts-ignore
  const prisma = req.prisma as PrismaClient;
  const { jwtUser, cuenta_participe_id, aportacion, user_id, user_cod } =
    req.body;
  let user;
  try {
    user = await axios.get("https://pro.stockencapital.com/api/v1/users/me/", {
      headers: {
        Authorization: `${jwtUser}`,
      },
    });
    if (!user || user.data.status != "validated" || !user.data.is_superuser)
      return res.status(400).json({ error: "Usuario no valido o no es admin" });
  } catch (e) {
    console.log(e);
    return res.status(500).json({ error: "Error al validar usuario" });
  }
  const cuenta = await prisma.cuentas_participes.findUnique({
    where: { id: cuenta_participe_id },
  });
  if (!cuenta)
    return res
      .status(404)
      .json({ error: "No se ha encontrado cuenta participe" });
  let companyBuyer;
  if (user_cod.substring(0, 2) == "pj") {
    companyBuyer = await prisma.companies_company.findFirst({
      where: { cod: user_cod },
    });
    if (!companyBuyer)
      return res.status(400).json({
        error: "Empresa vendedor no valida",
      });
  }

  const companySeller = await prisma.companies_company.findUnique({
    where: { id: cuenta.companyIDSeller },
  });
  if (!companySeller || companySeller.legal_representative_id != user.data.id)
    return res
      .status(400)
      .json({ error: "Empresa vendedor no valida o no pertenece al usuario" });

  let order = await prisma.orders.create({
    data: {
      aportacion,
      cuenta_participe_id: cuenta.id,
      buyerID: user_id,
      sellerID: user.data.id,
      companyIdSeller: cuenta.companyIDSeller,
      status: "PENDIENTE_FIRMA",
      companyIdBuyer: companyBuyer ? companyBuyer.id : null,
      create_date: new Date(),
    },
  });
  const buyer = await prisma.users_user.findUnique({ where: { id: user_id } });
  if (!buyer) return res.status(400).json({ error: "Usuario no encontrado" });
  const document = await createSignature(
    order,
    cuenta,
    buyer,
    user.data,
    companySeller,
    prisma
  );
  if (!document || !document.id)
    return res.status(500).json({ error: "Error al crear documento" });
  order = await prisma.orders.update({
    where: { id: order.id },
    data: {
      documentId_first: document.documents[0].id,
      documentId_second: document.documents[1].id,
      signatureId: document.id,
    },
  });
  return res.json({ order, document });
};

/// marketplace entre usuario
export const crearVentaDeParticipacion = async (
  req: Request,
  res: Response
) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;

    const { participacion_id, jwtUser, precio, companyIDSeller } = req.body;

    let participacion = await prisma.participacion.findUnique({
      where: { id: participacion_id },
    });
    /// VALIDACION DEL CESION
    if (!participacion || participacion.status !== "ACTIVO")
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
    const cuenta_participe = await prisma.cuentas_participes.findUnique({
      where: { id: participacion.cuenta_participe_id },
    });
    if (!cuenta_participe?.cesion)
      return res
        .status(400)
        .json({ error: "Participacion no puede ser vendida" });
    let mangopayWallet, mangopayId;
    if (companyIDSeller) {
      const company = await prisma.companies_company.findUnique({
        where: { id: companyIDSeller },
      });
      if (!company || !company.cod)
        return res.status(400).json({ error: "Compañia no encontrada" });
      mangopayWallet = await prisma.mangopay_mangopaywallet.findFirst({
        where: { cod: company.cod },
      });
      mangopayId = await prisma.mangopay_mangopayuser.findFirst({
        where: { cod: company.cod },
      });
    } else {
      mangopayWallet = await prisma.mangopay_mangopaywallet.findFirst({
        where: { cod: user.data.cod },
      });
      mangopayId = await prisma.mangopay_mangopayuser.findFirst({
        where: { cod: user.data.cod },
      });
    }

    if (!mangopayWallet || !mangopayId)
      return res
        .status(404)
        .json({ error: "No hay datos de mangopay suficientes" });

    const order = await prisma.orders.create({
      data: {
        aportacion: precio,
        cuenta_participe_id: participacion.cuenta_participe_id,
        sellerID: participacion.owner_id,
        status: "VENTA_ACTIVA",
        companyIdSeller: companyIDSeller ? companyIDSeller : null,
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

    const { orderId, jwtUser, companyIdBuyer } = req.body;
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
    if (!user || user.data.status != "validated" || !user.data.cod)
      return res.status(400).json({ error: "Usuario no valido" });
    console.log(user.data.cod);
    const seller = await prisma.users_user.findUnique({
      where: { id: order.sellerID },
    });
    if (!seller || !seller.cod)
      return res.status(404).json({ error: "Vendedor no valido" });
    let funds, mangopayWalletBuyer, mangopayIdBuyer;
    if (companyIdBuyer) {
      const company = await prisma.companies_company.findUnique({
        where: { id: companyIdBuyer },
      });
      if (
        !company ||
        company.legal_representative_id !== user.data.id ||
        company.status != "validated" ||
        !company.cod
      )
        return res.status(400).json({ error: "Compañia no valida" });
      funds = await axios.get(
        `https://pro.stockencapital.com/api/v1/users/${companyIdBuyer.cod}/funds`,
        {
          headers: {
            Authorization: `${jwtUser}`,
          },
        }
      );
      mangopayWalletBuyer = (
        await prisma.mangopay_mangopaywallet.findFirst({
          where: { cod: company.cod },
        })
      )?.wallet_id;
      mangopayIdBuyer = (
        await prisma.mangopay_mangopayuser.findFirst({
          where: { cod: company.cod },
        })
      )?.id;
    } else {
      funds = await axios.get(
        `https://pro.stockencapital.com/api/v1/users/${user.data.cod}/funds`,
        {
          headers: {
            Authorization: `${jwtUser}`,
          },
        }
      );
      mangopayWalletBuyer = (
        await prisma.mangopay_mangopaywallet.findFirst({
          where: { cod: user.data.cod },
        })
      )?.wallet_id;
      mangopayIdBuyer = (
        await prisma.mangopay_mangopayuser.findFirst({
          where: { cod: user.data.cod },
        })
      )?.mangopay_id;
    }
    const cuenta = await prisma.cuentas_participes.findUnique({
      where: { id: order.cuenta_participe_id },
    });
    if (!mangopayWalletBuyer || !mangopayIdBuyer)
      return res
        .status(404)
        .json({ error: "No hay datos de mangopay suficientes" });
    console.log(mangopayIdBuyer, mangopayWalletBuyer, "info mangopaay");
    const fiscalresidence = await prisma.users_fiscalresidence.findFirst({
      where: { user_id: user.data.id },
    });
    if (!order.participacion_id)
      return res.status(404).json({ error: "Participacion id no encontrada" });
    const participacion = await prisma.participacion.findUnique({
      where: { id: order.participacion_id },
    });
    if (!participacion)
      return res.status(404).json({ error: "Participacion no encontrada" });
    if (!cuenta) return res.status(404).json({ error: "Cuenta no encontrada" });
    console.log(user.data);
    if (
      !user.data.first_name ||
      !user.data.last_name ||
      !user.data.id_document_number ||
      !fiscalresidence
    )
      return res
        .status(400)
        .json({ error: "Faltan datos de usuario para poder comprar" });

    if (funds.data.funds < order.aportacion)
      return res.status(400).json({ error: "Fondo insuficiente" });
    /// transferencia de mangopay de buyer a seller
    let mangopayIdSeller, mangopayWalletSeller;
    if (order.companyIdSeller) {
      const companySeller = await prisma.companies_company.findUnique({
        where: { id: order.companyIdSeller },
      });
      if (!companySeller || !companySeller.cod)
        return res.status(400).json({ error: "Compañia no encontrada" });
      mangopayIdSeller = (
        await prisma.mangopay_mangopayuser.findFirst({
          where: { cod: companySeller.cod },
        })
      )?.mangopay_id;
      mangopayWalletSeller = (
        await prisma.mangopay_mangopaywallet.findFirst({
          where: { cod: companySeller.cod },
        })
      )?.wallet_id;
    } else {
      mangopayIdSeller = (
        await prisma.mangopay_mangopayuser.findFirst({
          where: { cod: seller.cod },
        })
      )?.mangopay_id;
      mangopayWalletSeller = (
        await prisma.mangopay_mangopaywallet.findFirst({
          where: { cod: seller.cod },
        })
      )?.wallet_id;
    }

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
      const document = await createDocReVenta(
        seller,
        user.data,
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
          buyerID: user.data.id,
        },
      });
    } catch (e) {
      console.log(e);
      return res.status(400).json(e);
    }
    return res.json(order);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};

export const prueba_del_doc = async (req: Request, res: Response) => {
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
      res.json(document);
    } catch (e) {
      console.log(e);
      return res.status(400).json(e);
    }
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};

//// nuevo borrar cta participe
export const borrarCtaParticipe = async (req: Request, res: Response) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;
    const { jwtCreador, cuenta_participe_id } = req.body;
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
    const orderpaid = await prisma.orders.findFirst({
      where: { status: "PENDIENTE_FIRMA" },
    });
    if (!orderpaid)
      return res
        .status(400)
        .json({ error: "Hay una orden pagada en esta cuenta participe" });
    await prisma.orders.deleteMany({
      where: { cuenta_participe_id: cuenta_participe_id },
    });
    const cuenta = await prisma.cuentas_participes.delete({
      where: {
        id: cuenta_participe_id,
      },
    });

    res.json(cuenta);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
//// nuevo borrar cta participe
export const editarCtaParticipe = async (req: Request, res: Response) => {
  try {
    // @ts-ignore
    const prisma = req.prisma as PrismaClient;
    const { jwtCreador, cuenta_participe_id, cesion } = req.body;
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
    let cuenta = await prisma.cuentas_participes.findFirst({
      where: {
        id: cuenta_participe_id,
      },
    });
    if (!cuenta?.creator_id != user.data.id)
      return res
        .status(400)
        .json({ error: "Usuario no es creador de la cuenta" });
    cuenta = await prisma.cuentas_participes.update({
      where: {
        id: cuenta_participe_id,
      },
      data: {
        cesion,
      },
    });

    res.json(cuenta);
  } catch (e) {
    console.log(e);
    res.status(500).json(e);
  }
};
