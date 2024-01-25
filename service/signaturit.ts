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
import cheerio from "cheerio";
// replace it with your API key
const API_KEY = process.env.SIGNATURITKEY;
const client = new SignaturitClient(API_KEY);

export const textoCliente = (
  fullname: string,
  estado_civil: string | null,
  profesion: string | null,
  direccion: string,
  NIF: string | null
) => {
  return `Y de otra parte, ${fullname}, mayor de edad, ${estado_civil}, ${profesion}, con domicilio ${direccion},  y con Número de Identificación Fiscal ${NIF}, (en adelante, el “Cuentapartícipe”).`;
};
export const textoSociedad = (
  fullname?: string | null,
  nacionalidad?: string | null,
  fullname_notario?: string | null,
  tomo?: string | null,
  folio?: string | null,
  hoja?: string | null,
  inscripcion?: string | null,
  direccion?: string | null,
  NIF?: string | null,
  ciudad_notario?: string | null,
  date_notariado?: String | null,
  n_protocolo?: string | null,
  date_inscripcion?: string | null,
  provincia_registro?: string | null,
  date_apoderamiento?: string | null,
  legal_representative?: string | null,
  ciudad_notario_lr?: string | null,
  n_protocolo_lr?: string | null,
  fullname_notario_lr?: string | null,
  cargo?: string | null
) => {
  return `Y de otra parte, ${fullname}, entidad de nacionalidad ${nacionalidad} en ${direccion} y provista de Número de Identificación Fiscal ${NIF}.
  Constituida mediante escritura pública autorizada por el Notario de ${ciudad_notario}  Don ${fullname_notario}  el ${date_notariado}, bajo el número ${n_protocolo} de su protocolo e inscrita el ${date_inscripcion} en el Registro Mercantil de ${provincia_registro},
  en el tomo ${tomo}, folio ${folio}, hoja ${hoja}, inscripción ${inscripcion} (en adelante, el “Cuentapartícipe”.)

  Se halla representada en este acto por ${legal_representative}, quien actúa en su condición de ${cargo} en virtud de la escritura de apoderamiento otorgada el ${date_apoderamiento}  ante el Notario de ${ciudad_notario_lr} Don ${fullname_notario_lr}, bajo el número ${n_protocolo_lr} de su protocolo.`;
};

export const createSignature = async (
  order: orders,
  cuenta: cuentas_participes,
  buyer: users_user,
  creador: users_user,
  company: companies_company,
  prisma: PrismaClient
) => {
  try {
    let plantilla = fs.readFileSync("CrearCP.html", "utf-8");
    let companyBuyer, fiscalresidence;
    if (order.companyIdBuyer) {
      companyBuyer = await prisma.companies_company.findUnique({
        where: { id: order.companyIdBuyer },
      });
    } else {
      fiscalresidence = await prisma.users_fiscalresidence.findFirst({
        where: { user_id: buyer.id },
      });
    }
    const data = {
      Document_date: new Date().toDateString(),
      Empresa_name: company.social_denomination,
      Empresa_Country: company.country,
      Empresa_City: company.city,
      Empresa_address: company.street_address,
      Empresa_NIF: company.cif,
      Empresa_ciudad_notario: company.registration_data_notary_city,
      Empresa_fullname_notario: company.registration_data_notary_full_name,
      Empresa_date_registro: new Date(
        company.registration_data_date
          ? company.registration_data_date.toString()
          : ""
      ).toDateString(),
      Empresa_num_protocolo: company.registration_data_number,
      Empresa_inscrita_date: new Date(
        company.registration_data_inscription_date
          ? company.registration_data_inscription_date
          : ""
      ).toDateString(),
      Empresa_ciudad_provincia: company.state,
      Empresa_tomo_numero: company.registration_data_volume_number,
      Empresa_folio: company.registration_data_sheet_number,
      Empresa_hoja_numero: company.registration_data_page_number,
      Empresa_inscripcion_numero: company.registration_data_inscription_number,
      Empresa_apoderado:
        company.governing_bodies_legal_representative_full_name,
      Empresa_apoderado_cargo:
        company.governing_bodies_legal_representative_position,
      Empresa_apoderamiento_date: new Date(
        company.governing_bodies_legal_representative_powers_date
          ? company.governing_bodies_legal_representative_powers_date
          : ""
      ).toDateString(),
      Empresa_ciudad_notario_apoderamiento:
        company.governing_bodies_notary_city,
      Empresa_fullname_notario_apoderamiento:
        company.governing_bodies_notary_full_name,
      Empresa_num_protocolo_apoderamiento:
        company.governing_bodies_notary_number,
      Client_datos: companyBuyer
        ? textoSociedad(
            companyBuyer.social_denomination,
            companyBuyer.country,
            companyBuyer.registration_data_notary_full_name,
            companyBuyer.registration_data_volume_number,
            companyBuyer.registration_data_page_number,
            companyBuyer.registration_data_sheet_number,
            companyBuyer.registration_data_inscription_number,
            companyBuyer.street_address,
            companyBuyer.cif,
            companyBuyer.registration_data_notary_city,
            companyBuyer.registration_data_date?.toDateString(),
            companyBuyer.registration_data_number,
            companyBuyer.registration_data_inscription_date?.toDateString(),
            companyBuyer.registration_data_state,
            companyBuyer.governing_bodies_legal_representative_powers_date?.toDateString(),
            companyBuyer.governing_bodies_legal_representative_full_name,
            companyBuyer.governing_bodies_notary_city,
            companyBuyer.governing_bodies_notary_number,
            companyBuyer.governing_bodies_notary_full_name,
            companyBuyer.governing_bodies_legal_representative_position
          )
        : textoCliente(
            `${buyer.first_name} ${buyer.last_name}`,
            buyer.marital_status,
            buyer.profession,
            `${fiscalresidence?.country} ${fiscalresidence?.city} ${fiscalresidence?.state} ${fiscalresidence?.street_address} ${fiscalresidence?.postal_code}`,
            buyer.id_document_number
          ),
      Empresa_descripcion: company.description,
      Proyecto_descripcion: cuenta.descripcion,
      Client_aporte: order.precio_total,
      Clausulas: cuenta.clausulas,
    };
    console.log("llegue aqui");
    // Ajusta las opciones según tus necesidades
    const options = { format: "Letter" };
    fs.writeFileSync("createdCP.html", mustache.render(plantilla, data));
    const created = fs.readFileSync("createdCP.html", "utf-8");
    pdf
      .create(created)
      .toFile("crearCP.pdf", (err: any, res: { filename: any }) => {
        if (err) return console.log(err);
        console.log("PDF creado exitosamente en", res.filename);
      });
    const document = await client.createSignature("crearCP.pdf", [
      {
        name: creador.first_name,
        email: creador.email,
        role: "Signer 1",
        delivery_type: "url",
      },
      {
        name: buyer.first_name,
        email: buyer.email,
        role: "Signer 2",
        delivery_type: "url",
      },
    ]);
    console.log(document);
    return document;
  } catch (e) {
    console.log(e);
    return false;
  }
};

export const isCompleted = async (signatureId: string) => {
  const signature = await client.getSignature(signatureId);
  let data = [];
  for (let docs of signature.documents) {
    if (docs.status == "completed") {
      data.push({
        docs,
      });
    }
  }
  console.log(data, "firma");
  return data;
};

export const createDocReVenta = async (
  seller: users_user,
  buyer: users_user,
  participacion: participacion,
  cuenta: cuentas_participes,
  prisma: PrismaClient
) => {
  try {
    let plantilla = fs.readFileSync("reventaDoc.html", "utf-8");
    let fiscalresidenceBuyer, fiscalresidenceSeller;

    fiscalresidenceBuyer = await prisma.users_fiscalresidence.findFirst({
      where: { user_id: buyer.id },
    });

    fiscalresidenceSeller = await prisma.users_fiscalresidence.findFirst({
      where: { user_id: seller.id },
    });
    const data = {
      fecha_anterior: participacion.buy_date,
      localidad: `España`,
      fecha: "Fecha de hyo",
      fullname_seller: `${seller.first_name} ${seller.last_name}`,
      edo_seller: seller.marital_status,
      num_dni_seller: seller.id_document_number,
      domicilio_seller: `${fiscalresidenceSeller?.street_address} ${fiscalresidenceSeller?.state} ${fiscalresidenceSeller?.city} ${fiscalresidenceSeller?.postal_code} ${fiscalresidenceSeller?.country}`,
      email_seller: seller.email,
      fullname_buyer: `${buyer.first_name} ${buyer.last_name}`,
      edo_buyer: buyer.marital_status,
      buyer_dni: buyer.id_document_number,
      buyer_domicilio: `${fiscalresidenceBuyer?.street_address} ${fiscalresidenceBuyer?.state} ${fiscalresidenceBuyer?.city} ${fiscalresidenceBuyer?.postal_code} ${fiscalresidenceBuyer?.country}`,
      buyer_email: buyer.email,
      cuenta_descripcion: cuenta.descripcion,
    };
    console.log("llegue aqui");
    // Ajusta las opciones según tus necesidades
    fs.writeFileSync("reventaDocMaq.html", mustache.render(plantilla, data));
    const created = fs.readFileSync("reventaDocMaq.html", "utf-8");
    pdf
      .create(created)
      .toFile("reventa.pdf", (err: any, res: { filename: any }) => {
        if (err) return console.log(err);
        console.log("PDF creado exitosamente en", res.filename);
      });
    const document = await client.createSignature("reventa.pdf", [
      {
        name: seller.first_name,
        email: seller.email,
        role: "Signer 1",
        delivery_type: "url",
      },
      {
        name: buyer.first_name,
        email: buyer.email,
        role: "Signer 2",
        delivery_type: "url",
      },
    ]);
    console.log(document);
    return document;
  } catch (e) {
    console.log(e);
    return false;
  }
};

export const createDocNotaConvertible = async (
  seller: users_user,
  buyer: users_user,
  participacion: participacion,
  cuenta: cuentas_participes,
  prisma: PrismaClient
) => {
  try {
    let plantilla = fs.readFileSync("reventaDoc.html", "utf-8");
    let fiscalresidenceBuyer, fiscalresidenceSeller;

    fiscalresidenceBuyer = await prisma.users_fiscalresidence.findFirst({
      where: { user_id: buyer.id },
    });

    fiscalresidenceSeller = await prisma.users_fiscalresidence.findFirst({
      where: { user_id: seller.id },
    });
    const data = {
      fecha_anterior: participacion.buy_date,
      localidad: `España`,
      fecha: "Fecha de hyo",
      fullname_seller: `${seller.first_name} ${seller.last_name}`,
      edo_seller: seller.marital_status,
      num_dni_seller: seller.id_document_number,
      domicilio_seller: `${fiscalresidenceSeller?.street_address} ${fiscalresidenceSeller?.state} ${fiscalresidenceSeller?.city} ${fiscalresidenceSeller?.postal_code} ${fiscalresidenceSeller?.country}`,
      email_seller: seller.email,
      fullname_buyer: `${buyer.first_name} ${buyer.last_name}`,
      edo_buyer: buyer.marital_status,
      buyer_dni: buyer.id_document_number,
      buyer_domicilio: `${fiscalresidenceBuyer?.street_address} ${fiscalresidenceBuyer?.state} ${fiscalresidenceBuyer?.city} ${fiscalresidenceBuyer?.postal_code} ${fiscalresidenceBuyer?.country}`,
      buyer_email: buyer.email,
      cuenta_descripcion: cuenta.descripcion,
    };
    console.log("llegue aqui");
    // Ajusta las opciones según tus necesidades
    fs.writeFileSync("reventaDocMaq.html", mustache.render(plantilla, data));
    const created = fs.readFileSync("reventaDocMaq.html", "utf-8");
    pdf
      .create(created)
      .toFile("reventa.pdf", (err: any, res: { filename: any }) => {
        if (err) return console.log(err);
        console.log("PDF creado exitosamente en", res.filename);
      });
    const document = await client.createSignature("reventa.pdf", [
      {
        name: seller.first_name,
        email: seller.email,
        role: "Signer 1",
        delivery_type: "url",
      },
      {
        name: buyer.first_name,
        email: buyer.email,
        role: "Signer 2",
        delivery_type: "url",
      },
    ]);
    console.log(document);
    return document;
  } catch (e) {
    console.log(e);
    return false;
  }
};
