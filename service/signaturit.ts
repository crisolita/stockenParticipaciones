//@ts-ignore
import SignaturitClient from "signaturit-sdk";
import {
  PrismaClient,
  Tipodeinteres,
  companies_company,
  cuentas_participes,
  orderNotaConvertible,
  orders,
  participacion,
  users_fiscalresidence,
  users_user,
  venta_de_notas_convertibles,
} from "@prisma/client";
import fs from "fs";
import mustache from "mustache";
import pdf from "html-pdf";
// replace it with your API key
const API_KEY = process.env.SIGNATURITKEY;
const client = new SignaturitClient(API_KEY);
const options = {
  weekday: "long",
  year: "numeric",
  month: "long",
  day: "numeric",
};

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
      Document_date: new Date().toLocaleDateString("es-ES"),
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
      ).toLocaleDateString("es-ES"),
      Empresa_num_protocolo: company.registration_data_number,
      Empresa_inscrita_date: new Date(
        company.registration_data_inscription_date
          ? company.registration_data_inscription_date
          : ""
      ).toLocaleDateString("es-ES"),
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
      ).toLocaleDateString("es-ES"),
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
            companyBuyer.registration_data_date?.toLocaleDateString("es-ES"),
            companyBuyer.registration_data_number,
            companyBuyer.registration_data_inscription_date?.toLocaleDateString(
              "es-ES"
            ),
            companyBuyer.registration_data_state,
            companyBuyer.governing_bodies_legal_representative_powers_date?.toLocaleDateString(
              "es-ES"
            ),
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
      Client_aporte: order.aportacion,
      Clausulas: cuenta.clausulas,
    };
    const options = {
      border: {
        top: "0.5in",
        bottom: "0.5in",
      },
    };
    // Ajusta las opciones según tus necesidades
    fs.writeFileSync("createdCP.html", mustache.render(plantilla, data));
    const created = fs.readFileSync("createdCP.html", "utf-8");
    const pdfPromise = new Promise((resolve, reject) => {
      pdf.create(created, options).toFile("crearCP.pdf", (err, res) => {
        if (err) reject(err);
        else resolve(res);
      });
    });

    const resultado = await pdfPromise;

    console.log(resultado, "Soy undefinde?");
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
    console.log(document, "os");
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
export const cancel = async (signatureId: string) => {
  const signature = await client.cancelSignature(signatureId);
  console.log(signature);
  return signature;
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
      fecha_anterior: new Date(participacion.buy_date).toLocaleDateString(
        "es-ES"
      ),
      localidad: `España`,
      fecha: new Date().toLocaleDateString(),
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
    const options = {
      border: {
        top: "0.5in",
        bottom: "0.5in",
      },
    };
    const pdfPromise = new Promise((resolve, reject) => {
      pdf.create(created, options).toFile("reventa.pdf", (err, res) => {
        if (err) reject(err);
        else resolve(res);
      });
    });

    const resultado = await pdfPromise;
    console.log(resultado);
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

///// DE AQUI EN ADELANTE NOTAS CONVERTIBLES
export const textoClientePersona = (
  user: users_user,
  fiscalresidence: users_fiscalresidence
) => {
  return `${user.first_name} ${user.last_name}, mayor de edad, con domicilio a estos efectos en ${fiscalresidence.street_address} ${fiscalresidence.city} ${fiscalresidence.country}, correo electrónico ${user.email}, y provisto de N.I.F. ${user.id_document_number}, en vigor, en su propio nombre y derecho (en adelante, el “Prestamista”).`;
};
export const textoClienteEmpresa = (
  user: users_user,
  company: companies_company
) => {
  return `${company.social_denomination}, sociedad de responsabilidad limitada, provista de N.I.F. ${company.cif}, con domicilio social en ${company.city}  y correo electrónico ${user.email} (en adelante, el “Prestamista”), representada en este acto por ${user.first_name} ${user.last_name} en su condición de ${company.governing_bodies_legal_representative_position}. `;
};
export const floor = (floor: string, floor_cifra: number) => {
  return `Valoración mínima de referencia (“Floor”) 
  En cualquier caso, la valoración resultante mínima de referencia que resultará aplicable (también denominada “Floor”) para la conversión, no podrá ser inferior a ${floor} euros (${floor_cifra} €).
  La conversión tendrá lugar con carácter inmediatamente anterior a la ejecución de la ampliación que la haya motivado.`;
};
export const devolucion = (devol: boolean, numero_meses: number) => {
  return devol
    ? `DEVOLUCIÓN.
  El Prestamista concede a la Sociedad una carencia de (${numero_meses}) meses a contar desde la fecha de firma del presente Contrato para la devolución del principal y en el pago de los intereses del Préstamo. 
  A la fecha de vencimiento del referido periodo de carencia, siempre y cuando el Prestamista no haya comunicado su intención de capitalizar el Préstamo, la Sociedad deberá pagar al Prestamista,
  mediante pago único, el principal con adición de los intereses devengados conforme a la cláusula 3 anterior.`
    : `Dada la naturaleza del Préstamo, la Sociedad no lo podrá amortizar anticipadamente, ya sea de forma parcial o total, excepto que la amortización se haga mediante la conversión del Préstamo en participaciones de la Sociedad, de acuerdo con lo dispuesto en la Cláusula 5.`;
};
export const interes = (
  type: Tipodeinteres | null,
  interes_fijo: number,
  interes_variable: number
) => {
  return type == "COMPUESTO"
    ? `Límite de los intereses: el importe total de los intereses devengados cada año (fijo + variable) no sobrepasará una rentabilidad máxima equivalente al ${
        interes_fijo + interes_variable
      }% anual del saldo medio pendiente de amortizar del año natural anterior.`
    : type == "VARIABLE"
      ? ` Variable: ${interes_variable} anual del beneficio antes de
  impuestos (BAI) obtenido por la Sociedad durante el ejercicio
  inmediatamente anterior al devengo de los intereses variables. Los
  intereses variables se devengarán el día en que la Junta General de
  Socios de la Sociedad apruebe el resultado del ejercicio anterior y en
  su defecto, el 30 de junio de cada año y serán pagaderos a la fecha de
  vencimiento; no obstante, en caso de que la fecha de vencimiento fuera
  anterior a la fecha de aprobación de las cuentas anuales del ejercicio
  inmediato anterior o, en su defecto, el 30 de junio de ese año, los
  intereses variables se devengarán a la fecha de aprobación de las
  cuentas anuales o el 30 de junio de ese ejercicio, la que antes
  tuviera lugar, y serán pagaderos en el plazo de un (1) mes desde la
  fecha de su devengo. Todo ello salvo que el Préstamo se capitalice, en
  cuyo caso el 100% de los intereses variables devengados hasta la fecha
  de capitalización se pagarán en participaciones sociales de la
  Sociedad conforme se indica en la Cláusula 6 siguiente y los intereses
  variables no devengados se pagarán conforme se indica en el párrafo
  anterior.`
      : `Fijo: ${interes_fijo} anual. Se devengará diariamente y liquidará
      y será pagadero a la fecha de vencimiento, salvo que el Préstamo se
      capitalice, en cuyo caso el 100% del interés fijo devengado hasta la
      fecha de capitalización se pagará en participaciones sociales de la
      Sociedad conforme se indica en la cláusula 5 siguiente.`;
};
export const amortizacion = (
  descuento: boolean,
  importe_cap_cifra: string,
  porcentaje_string?: number | null
) => {
  return descuento
    ? `En caso de que la conversión del Préstamo (principal + intereses devengados) tenga lugar en el marco de una ronda de inversión cualificada de la Operación de Financiación, de al menos (${importe_cap_cifra}.-€),
    la Prestamista convertirá el importe del Préstamo en capital social de la Sociedad por el número de participaciones que resulte de valorar la Sociedad a la valoración más baja entre:

    A) La valoración final de la ronda de inversión en curso, después de aplicar un descuento de  ${porcentaje_string} (X%) anual, respecto del valor final de la ronda de inversión, calculado día a día entre la fecha del desembolso del importe de este Préstamo y el día de cierre de la ronda de inversión ; y 
    
    B) Una valoración máxima de  (${importe_cap_cifra}.-€) (“CAP”).`
    : `
    En caso de que la conversión del Préstamo (principal + intereses devengados) tenga lugar en el marco de una ronda de inversión cualificada de la Operación de Financiación, de al menos IMPORTE RONDA LETRAS euros (IMPORTE RONDA CIFRAS.-€).
    
    En todo caso, si tras calcular la valoración pre-money de la Sociedad tomando como precio por participación el calculado conforme al párrafo anterior, ésta fuese superior a  (${importe_cap_cifra}.-€) el Préstamo (principal+ intereses devengados) se capitalizará a dicha valoración (“CAP”).)`;
};
export const createDocNotaConvertible = async (
  seller: users_user,
  buyer: users_user,
  fiscalresidenceBuyer: users_fiscalresidence,
  order: orderNotaConvertible,
  companySeller: companies_company,
  venta: venta_de_notas_convertibles,
  prisma: PrismaClient
) => {
  try {
    let plantilla = fs.readFileSync("venta_nota.html", "utf-8");
    let companyBuyer;
    if (order.companyIdBuyer) {
      companyBuyer = await prisma.companies_company.findUnique({
        where: { id: order.companyIdBuyer },
      });
    }
    const data = {
      Document_date: new Date().toLocaleDateString("es-Es"),
      Empresa_name: companySeller.social_denomination,
      Empresa_NIF: companySeller.cif,
      Empresa_address: `${companySeller.street_address} ${companySeller.state}`,
      Empresa_email: seller.email,
      Empresa_fullname_lr: `${seller.first_name} ${seller.last_name}`,
      Empresa_apoderado_cargo:
        companySeller.governing_bodies_legal_representative_position,
      Client_datos: companyBuyer
        ? textoClienteEmpresa(buyer, companySeller)
        : textoClientePersona(buyer, fiscalresidenceBuyer),
      Client_aporte: order.aportacion,
      intereses: interes(
        venta.tipodeinteres,
        venta.interes_fijo ? venta.interes_fijo : 0,
        venta.interes_variable ? venta.interes_variable : 0
      ),
      fecha_vencimiento: new Date(venta.vence_date ? venta.vence_date : ""),
      importe_ronda_letra: venta.capitulacion,
      importe_cap_no_ronda: venta.CAP_no_ronda,
      Amortizacion: amortizacion(
        venta.tasa_descuento ? true : false,
        venta.capitulacion ? venta.capitulacion : "0",
        venta.tasa_descuento
      ),
      floor: venta.floor ? floor(venta.floor, Number(venta.floor)) : "",
      Devolucion: devolucion(
        venta.fecha_devolucion ? true : false,
        new Date(
          venta.fecha_devolucion ? venta.fecha_devolucion : ""
        ).getMonth()
      ),
    };
    // Ajusta las opciones según tus necesidades
    fs.writeFileSync(
      "venta_nota_maqueta.html",
      mustache.render(plantilla, data)
    );
    const created = fs.readFileSync("venta_nota_maqueta.html", "utf-8");
    const options = {
      border: {
        top: "0.5in",
        bottom: "0.5in",
      },
    };
    const pdfPromise = new Promise((resolve, reject) => {
      pdf.create(created, options).toFile("venta_nota.pdf", (err, res) => {
        if (err) reject(err);
        else resolve(res);
      });
    });

    const resultado = await pdfPromise;
    console.log(resultado);
    const document = await client.createSignature("venta_nota.pdf", [
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
