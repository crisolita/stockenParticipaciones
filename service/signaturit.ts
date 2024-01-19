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
import { user } from "mangopay2-nodejs-sdk";

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
export const defaultClausula = (
  cuenta_descripcion_resultado_calculo: string,
  cuenta_descripcion_liquidacion_pago: string,
  cuenta_determinacion_resultado: string,
  cuenta_duracion: string,
  cuenta_cesion_permitidad: boolean,
  cuenta_jurisdiccion: string
) => {
  return `<p>${`CLÁUSULAS
    OBJETO.
    Este Contrato tiene por objeto regular los términos y condiciones de la participación del Cuentapartícipe en los resultados económicos, ya sean, beneficios o pérdidas, derivados del Proyecto; que será desarrollada por el Gestor bajo la forma jurídica de un contrato de cuentas en participación. 
    Las Partes declaran expresamente que las relaciones que se deriven del presente Contrato serán las propias de un gestor (para el Gestor) y de un partícipe (para el Cuentapartícipe) dentro del marco jurídico de una cuenta en participación de naturaleza mercantil; siendo la voluntad de las Partes que la relación de cuentas en participación regulada mediante el presente Contrato carezca de personalidad jurídica propia, existiendo una relación obligatoria entre las Partes, y  siendo en cualquier caso el Gestor el único que ejercerá el Proyecto, que es de naturaleza mercantil, y quien llevará a cabo las distintas actuaciones con y frente a terceros.  
    PARTICIPACIÓN EN EL RESULTADO. 
    En contraprestación a su Aportación, el Cuentapartícipe, a su riesgo y ventura, junto con el Gestor, adquiere el derecho a participar en el resultado del Proyecto en el mismo porcentaje que representa la Aportación, esto es, en
    ${cuenta_descripcion_resultado_calculo} (los “Derechos Económicos”). 
    El Gestor, una vez concluido el Proyecto, procederá a liquidar el Contrato restituyendo y abonando al Cuentapartícipe, el resultado del Proyecto en atención a los Derechos Económicos. 
    En la liquidación, el Gestor indicará la parte que corresponda a la restitución de la Aportación, y la parte correspondiente al resultado positivo del Proyecto. En caso de resultados negativos, indicará la ausencia de resultados positivos, y procederá a señalar la parte de la Aportación que es restituida. 
    El Gestor entregará al Cuentaparticipe un informe detallado del resultado del Proyecto con anterioridad a la liquidación de su resultado. 
    La liquidación y su pago serán efectuados
    ${cuenta_descripcion_liquidacion_pago}. A la liquidación le serán aplicados los impuestos y retenciones que correspondan en atención a la normativa vigente en el momento de producirse aquella. 
    En el supuesto de discrepancia sobre el resultado del Proyecto cualquiera de las partes podrá solicitar a la firma de auditoría que estime conveniente la emisión de un informe de cuantificación. El Gestor se obliga a suministrar a los auditores seleccionados por el Cuentaparticipe la documentación necesaria para esa tarea. El coste del informe de auditoría será asumido por la parte solicitante salvo en el supuesto de que este confirmase su criterio, con un margen de desviación inferior al cinco por ciento (5%), en cuyo caso será soportado por la parte contraria. 
     
    DETERMINACIÓN DEL RESULTADO. 
    ${cuenta_determinacion_resultado}
    Se entenderá por beneficio los rendimientos económicos positivos procedentes del Proyecto, entendido como el resultado de la diferencia entre la inversión en el mismo y el resultado obtenido minorado por las siguientes partidas: 
    Gastos vinculados directa o indirectamente con la puesta en marcha del Proyecto, incluyendo a título meramente enunciativo los siguientes: gastos de representación, dietas, viajes, consultas, asesoramiento, tasas e impuestos vinculados al Proyecto y, en su caso, honorarios de notarios, asesores o abogados. 
    Gastos asociados a la explotación del Proyecto, tales como gastos de promoción y publicidad.  
     
    Si como resultado de la gestión se obtuvieran pérdidas, éstas se calcularían siguiendo el mismo procedimiento señalado en el apartado anterior, participando en las mismas el Cuentapartícipe, con el límite de la Aportación. 
    OBLIGACIONES DEL GESTOR. 
     
    En virtud del presente Contrato, el Gestor se compromete frente al Cuentapartícipe, al cumplimiento de las siguientes obligaciones: 
    A destinar íntegramente la Aportación a la implementación del Proyecto. 
    A conducir el Proyecto con la responsabilidad propia de un ordenado gestor, en la búsqueda del mayor resultado posible en atención a las circunstancias concurrentes en cada momento. 
    A mantener informado  al Cuentapartícipe sobre las actuaciones más relevantes llevadas a cabo en el Proyecto con una periodicidad mínima trimestral. 
    A liquidar el resultado positivo o negativo del Proyecto en la forma, plazo y cuantía convenidas en este Contrato. 
    El Gestor podrá realizar la emisión de un criptoactivo no fungible (en adelante, “NFT”) sobre tecnología de registros distribuidos a través de su página web corporativa entregándoselo al Cuentapartícipe o permitiéndole acceso al mismo. Dicho NFT actuará como resguardo y elemento que habilita a acceder la información entregada por el Gestor en relación al Proyecto en el marco del presente Contrato pero no dará en ningún caso lugar a la asociación de derechos económicos derivados del Contrato con el mismo.
     
    DURACIÓN. 
     
    El Contrato entrará en vigor el día de su firma y tendrá una duración coincidente con la duración del Proyecto. ${cuenta_duracion}
    El vencimiento del presente Contrato se producirá en el momento en que se produzca la liquidación y pago del resultado del Proyecto.  
    Sin perjuicio de lo anterior, el presente Contrato finalizará anticipadamente en los términos y condiciones establecidos en la siguiente Cláusula.  
     
    CAUSAS DE EXTINCIÓN DEL CONTRATO. 
    Las partes acuerdan que sean causas de extinción del Contrato las siguientes: 
    Mutuo acuerdo de las Partes. 
    Consecución del objeto del Proyecto que justificó su constitución. 
    Quiebra, concurso o suspensión de pagos del Gestor. 
     
    Las Partes no podrán desistir unilateralmente del Contrato. 
     
    DOMICILIO Y NOTIFICACIONES. 
     
    Todas las notificaciones y comunicaciones que deban hacerse entre las Partes en el marco de este Contrato se realizarán por escrito o por correo electrónico con acuse de recibo a las direcciones de correo designadas por las Partes o por cualquier otro medio de comunicación fehaciente a las direcciones indicadas en el encabezamiento. 
    Las Partes acuerdan que, cuando el Gestor cuente con una página web corporativa que permita la identificación de usuarios y cuente con un sistema de comunicaciones interno, dichas comunicaciones relacionadas con el presente Contrato -incluida la rendición de cuentas- se podrán realizar mediante medios telemáticos vía dicha página web corporativa.
     
     
    NATURALEZA DEL CONTRATO Y RESPONSABILIDAD. 
     
    La relación que vincula al Gestor y al Cuentapartícipe a través de este contrato es meramente interna y es por ello que, de conformidad con lo dispuesto en el artículo 242 del Código de Comercio, los terceros con los que contrate el Gestor no podrán en ningún caso emprender acción alguna contra el Cuentapartícipe por causa de la relación regulada en este Contrato, quien tampoco la tendrá acción alguna contra el tercero que contrató con el Gestor salvo, en su caso, las que se deriven de la firma por el Cuentapartícipe de las garantías, contragarantías o seguros de caución que éste suscriba por razón de las garantías en cumplimiento de su obligación de realizar la Aportación o las derivadas de la cesión formal de los derechos del Gestor en favor del Cuentapartícipe.  
     
    NULIDAD DE ALGUNA ESTIPULACIÓN. 
     
    La nulidad o invalidez de alguna de las estipulaciones contenidas en el presente Contrato, no afectará en forma alguna, la validez de las demás estipulaciones, ni causará, en ningún caso, la nulidad o invalidez del presente Contrato. 
     
    MODIFICACIONES. 
     
    ${
      cuenta_cesion_permitidad
        ? `El presente Contrato contiene el acuerdo íntegro entre las Partes respecto a la materia objeto del presente Contrato. Carecerá de validez y eficacia cualquier modificación del presente Contrato, que no se recoja por escrito y que no sea formalizada por las Partes. 
    El Cuentapartícipe tendrá derecho a ceder sus derechos frente al Gestor en este Contrato. Dicha cesión deberá recogerse en un documento convencional firmado entre el Cuentapartícipe y el tercero cesionario que se anexará a este Contrato.`
        : ""
    }
    
    CONFIDENCIALIDAD. 
     ​
    Las Partes se obligan a no divulgar el presente documento y demás información confidencial recibida de la otra parte a terceros y a no utilizarla para otras actividades propias. El deber de confidencialidad no se hará extensivo cuando la información haya devenido de dominio público. 
     
    INTERVENCIÓN DE FEDATARIO PÚBLICO. 
     
    A solicitud de cualquiera de las Partes, ambos procederán a elevar el presente Contrato ante fedatario público. Todos los gastos e impuestos ocasionados serán a cuenta del solicitante.  
     
    JURISDICCIÓN. 
     
    Este Contrato se regirá e interpretará por la legislación española. 
    Las Partes, con renuncia expresa a sus derechos a cualquier otra jurisdicción que les pudiera corresponder, se someten de forma expresa a los Juzgados y Tribunales de
    ${cuenta_jurisdiccion}, para la resolución de los conflictos que puedan surgir con respecto a la interpretación o ejecución de este Contrato. 
    En virtud de lo anterior, las Partes reconocen estar conformes con todos los términos del presente Contrato, y para que así conste a los efectos que convenga firman el mismo en tantos ejemplares como son necesarios igualmente auténticos y originales, pero a un solo efecto en el lugar y fecha arriba indicados.
    `}</p>`;
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
      Clausulas: cuenta.clausulas
        ? cuenta.clausulas
        : defaultClausula(
            cuenta.resultado,
            cuenta.liquidacion,
            cuenta.determinacion,
            cuenta.duracion.toString(),
            cuenta.cesion,
            cuenta.juridicion
          ),
    };
    plantilla = mustache.render(plantilla, data);

    console.log("llegue aqui");
    // Ajusta las opciones según tus necesidades
    const options = { format: "Letter" };
    fs.writeFileSync("createCP.html", plantilla);

    pdf
      .create(plantilla)
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
