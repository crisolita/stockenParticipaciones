import * as pd_api from "pandadoc-node-client";
import { PrismaClient} from "@prisma/client";
// replace it with your API key
const API_KEY = process.env.PANDADOC_KEY;

const configuration = pd_api.createConfiguration(
    { authMethods: {apiKey: `API-Key ${API_KEY}`} }
);

const apiInstanceDocuments = new pd_api.DocumentsApi(configuration);
const apiInstanceTemplate= new pd_api.TemplatesApi(configuration)
export const ensureSentDocument= async (documentId:string) =>{
  const MAX_CHECK_RETRIES=6;
  let retries=0;
  while (retries < MAX_CHECK_RETRIES) {
    await new Promise((r) => setTimeout(r, 2000));
    retries++;

    let response = await apiInstanceDocuments.statusDocument({
      id: String(documentId),
    });
    if (response.status === "document.draft") {
      return true;
    }
  }
}

export const isCompleted= async (documentId:string) =>{

    let response = await apiInstanceDocuments.statusDocument({
      id: String(documentId),
    });
    if (response.status === "document.completed") {
      return true;
    }
}


export const crearDocumentoDeCompra= async (userId:number,participe_id:number,prisma:PrismaClient) => {
    // const cuenta_participe= await prisma.cuentas_participes.findUnique({where:{id:participe_id}})
        const documentCreateRequest: pd_api.DocumentCreateRequest = {
            name: "Documento de Compra",
            // templateUuid:cuenta_participe?.templateID,
            tags: ["Esta es una Compra de cuenta participe"],
          //   recipients: [
          //     {
          //       email: user.email,
          //       firstName: kycInfo.name,
          //       role:"Client",
          //       signingOrder: 1,
          //     }
          //   ],
          //   "tokens": [
          //     {
          //         "name": "Client.nombre",
          //         "value": `${kycInfo.name}`
          //     },
          // ],
          };
          const document= await apiInstanceDocuments.createDocument({
            documentCreateRequest: documentCreateRequest,
          });
          if(document.id){
           const sure= await ensureSentDocument(document.id)
            if(!sure) return undefined
            const sent= await apiInstanceDocuments.sendDocument({
                  id: String(document.id),
                  documentSendRequest: {
                    silent: true,
                    subject: "Contrato de venta pendiente por firmar",
                    message: "Para continuar con el proceso de venta usted debe firmar el siguiente contrato",
                  },
                });
                console.log(sent)
                const doc= await apiInstanceDocuments.detailsDocument({id:document.id})
                return {id:document.id,link:doc.recipients? doc.recipients[0].sharedLink : undefined}
          }
    }
 export const crearDocumentoCreacionCuentaParticipe= async (useremail:string,username:string,templateID:string,prisma:PrismaClient) => {
      // const cuenta_participe= await prisma.cuentas_participes.findUnique({where:{id:participe_id}})
          const documentCreateRequest: pd_api.DocumentCreateRequest = {
              name: "Documento de Compra",
              templateUuid:templateID,
              tags: ["Esta es una Compra de cuenta participe"],
              recipients: [
                {
                  email: useremail,
                  firstName: username,
                  role:"Signer",
                  signingOrder: 1,
                }
              ],
            //   "tokens": [
            //     {
            //         "name": "Client.nombre",
            //         "value": `${kycInfo.name}`
            //     },
            // ],
            };
            const document= await apiInstanceDocuments.createDocument({
              documentCreateRequest: documentCreateRequest,
            });
            if(document.id){
             const sure= await ensureSentDocument(document.id)
              if(!sure) return undefined
              const sent= await apiInstanceDocuments.sendDocument({
                    id: String(document.id),
                    documentSendRequest: {
                      silent: true,
                      subject: "Contrato de creacion de participaciones pendiente por firmar",
                      message: "Para continuar con el proceso de creacion usted debe firmar el siguiente contrato",
                    },
                  });
                  console.log(sent)
                  const doc= await apiInstanceDocuments.detailsDocument({id:document.id})
                  return {id:document.id,link:doc.recipients? doc.recipients[0].sharedLink : undefined}
            }
      }
      export const getTemplates= async () => {
        return apiInstanceTemplate.listTemplates()
        }