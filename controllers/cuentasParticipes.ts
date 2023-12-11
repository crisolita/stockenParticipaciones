import { PrismaClient } from "@prisma/client";
import { Request, Response } from "express";
import { crearDocumentoCreacionCuentaParticipe, crearDocumentoDeCompra, getTemplates, isCompleted } from "../service/pandadoc";
import axios from "axios";

export const crearCuentaParticipe= async (req:Request,res: Response) => {
    try {
       // @ts-ignore
       const prisma = req.prisma as PrismaClient;
       const {jwtCreador,companyID,
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
        templateID,
        fecha_lanzamiento} = req.body;
const user= await axios.get('https://pro.stockencapital.com/api/v1/users/me/', {
  headers: {
    'Authorization': `${jwtCreador}`
  }
})
console.log(user.data)
if(!user || user.data.status!='validated') return res.status(400).json({error:"Usuario no valido"})
const company= await prisma.companies_company.findUnique({where:{id:companyID}})
if(!company || company.legal_representative_id!=user.data.id || company.status!="validated") return res.status(400).json({error:"Compañia no existe, no pertenece al usuario o no esta validada"})

/// lo que falte de empresa pedirselo al usuario, en el documento?
// crear documento pandadoc
const doc= await crearDocumentoCreacionCuentaParticipe(user.data.email,user.data.name,templateID,prisma)
if(!doc || !doc.link) return res.status(400).json({error:"Error al crear documento"})
const cuenta= await prisma.cuentas_participes.create({
  data:{
    creator_id:user.data.id,
        nombre_del_proyecto,
        descripcion,
        cantidad_a_vender,
        precio_unitario,
        cantidad_restante:cantidad_a_vender,
        cesion,
        duracion:new Date(duracion),
        remuneracion,
        plazos_remuneracion,
        resultado,
        determinacion,
        juridicion,
        templateID,
        fecha_lanzamiento:new Date(fecha_lanzamiento),
        document_id:doc.id,
        document_link:doc.link
  }
})

res.json(cuenta)
    } catch (e) {
      console.log(e)
      res.status(500).json(e)
    }
 }
export const comprarParticipacion= async (req:Request,res: Response) => {
      try {
         // @ts-ignore
         const prisma = req.prisma as PrismaClient;
    
         const {participe_id, cantidad,jwtUser}= req.body;
        let cuenta_participe= await prisma.cuentas_participes.findUnique({where:{id:participe_id}})
        if(!cuenta_participe || !cuenta_participe.signed) return res.status(400).json({error:"No existe cuenta participe"})
      if(cantidad>cuenta_participe.cantidad_restante) return res.status(400).json({error:"No hay suficientes participaciones"})
      //create bloqueo mangopay user
      const user= await axios.get('https://pro.stockencapital.com/api/v1/users/me/', {
        headers: {
          'Authorization': `${jwtUser}`
        }
      })
      if(!user || user.data.status!='validated') return res.status(400).json({error:"Usuario no valido"})
    const order= await prisma.orders.create({
      data:{
        precio_total:cantidad*cuenta_participe.precio_unitario,
        cantidad:cantidad,
        cuenta_participe_id:cuenta_participe.id,
        sellerID:cuenta_participe.creator_id,
        buyerID:user.data.id,
        status:'SALDO_BLOQUEADO',
        create_date:new Date()
      }
    })
    cuenta_participe=await prisma.cuentas_participes.update({where:{id:cuenta_participe.id},data:{cantidad_restante:cuenta_participe.cantidad_restante-cantidad}})
    
    return res.json({cuenta_participe,order})
      } catch (e) {
        res.status(500).json(e)
      }
 }
export const verOrdenesBySell= async (req:Request,res: Response) => {
        try {
           // @ts-ignore
           const prisma = req.prisma as PrismaClient;
      
           const {jwtUser}= req.body;
           const user= await axios.get('https://pro.stockencapital.com/api/v1/users/me/', {
            headers: {
              'Authorization': `${jwtUser}`
            }
          })
          if(!user || user.data.status!='validated') return res.status(400).json({error:"Usuario no valido"})
          let cuentas_participes= await prisma.cuentas_participes.findMany({where:{creator_id:user.data.id}})
          if(!cuentas_participes) return res.status(400).json({error:"No existen cuentas participes"})
        //create bloqueo mangopay user
      let saldoBloqueado=[];
      let finalizadas=[];
      let porFirmarVendedor=[];
        for (let cuenta of cuentas_participes) {
           saldoBloqueado.push(await prisma.orders.findMany({where:{cuenta_participe_id:cuenta.id,status:"SALDO_BLOQUEADO"}}))
           finalizadas.push(await prisma.orders.findMany({where:{cuenta_participe_id:cuenta.id,status:"COMPRA_TERMINADA"}}))
           porFirmarVendedor.push(await prisma.orders.findMany({where:{cuenta_participe_id:cuenta.id,status:"PENDIENTE_FIRMA_VENDEDOR"}}))
        }
  
      return res.json({saldoBloqueado,finalizadas,porFirmarVendedor})
        } catch (e) {
          res.status(500).json(e)
        }
 }

export const verOrdenesByBuyer= async (req:Request,res: Response) => {
          try {
             // @ts-ignore
             const prisma = req.prisma as PrismaClient;
        
             const {jwtUser}= req.body;
             const user= await axios.get('https://pro.stockencapital.com/api/v1/users/me/', {
              headers: {
                'Authorization': `${jwtUser}`
              }
            })
            if(!user || user.data.status!='validated') return res.status(400).json({error:"Usuario no valido"})
       
        const saldoBloqueado= await prisma.orders.findMany({where:{buyerID:user.data.id,status:"SALDO_BLOQUEADO"}})
        const finalizadas= await prisma.orders.findMany({where:{buyerID:user.data.id,status:"COMPRA_TERMINADA"}})
        const porFirmarComprador= await prisma.orders.findMany({where:{buyerID:user.data.id,status:"PENDIENTE_FIRMA_COMPRADOR"}})
    
        return res.json({saldoBloqueado,finalizadas,porFirmarComprador})
          } catch (e) {
            res.status(500).json(e)
          }
 }
export const aceptarCompras= async (req:Request,res: Response) => {
            try {
               // @ts-ignore
               const prisma = req.prisma as PrismaClient;
               const {jwtCreador,companyID,orderId} = req.body;
        const user= await axios.get('https://pro.stockencapital.com/api/v1/users/me/', {
          headers: {
            'Authorization': `${jwtCreador}`
          }
        })
        if(!user || user.data.status!='validated') return res.status(400).json({error:"Usuario no valido"})
        const company= await prisma.companies_company.findUnique({where:{id:companyID}})
        if(!company || company.legal_representative_id!=user.data.id || company.status!="validated") return res.status(400).json({error:"Compañia no existe, no pertenece al usuario o no esta validada"})
        let order= await prisma.orders.findUnique({where:{id:orderId,status:"SALDO_BLOQUEADO"}})
        if(!order || order.sellerID!=user.data.id || !order.buyerID) return res.status(400).json({error:"Orden no encontrada"})
      
        const document= await crearDocumentoDeCompra(user.data.id,order.cuenta_participe_id,prisma)
        if(!document || !document.link) return res.status(500).json({error:"Error al crear documento"})
        /// DESBLOQUEAR SALDO MANGOPAY Y ENVIARSELO A VENDEDOR 
      const participacion= await prisma.paticipacion.create({data:{
        cuenta_participe_id:order.cuenta_participe_id,
        cantidad:order.cantidad,
        monto_pagado:order.precio_total,
        document_id:document.id,
        document_link:document.link,
        owner_id:order.buyerID
      }})
        order= await prisma.orders.update({where:{id:order.id},data:{url_sign:document.link,complete_at:new Date(),participacion_id:participacion.id,status:"PENDIENTE_FIRMA_VENDEDOR"}})
        res.json({order,participacion})
            } catch (e) {
              console.log(e)
              res.status(500).json(e)
            }
 }
export const rechazarCompras= async (req:Request,res: Response) => {
              try {
                 // @ts-ignore
                 const prisma = req.prisma as PrismaClient;
                 const {jwtCreador,companyID,orderId} = req.body;
          const user= await axios.get('https://pro.stockencapital.com/api/v1/users/me/', {
            headers: {
              'Authorization': `${jwtCreador}`
            }
          })
          if(!user || user.data.status!='validated') return res.status(400).json({error:"Usuario no valido"})
          const company= await prisma.companies_company.findUnique({where:{id:companyID}})
          if(!company || company.legal_representative_id!=user.data.id || company.status!="validated") return res.status(400).json({error:"Compañia no existe, no pertenece al usuario o no esta validada"})
          let order= await prisma.orders.findUnique({where:{id:orderId,status:"SALDO_BLOQUEADO"}})
          if(!order || order.sellerID!=user.data.id || !order.buyerID) return res.status(400).json({error:"Orden no encontrada"})
        
          /// DESBLOQUEAR SALDO MANGOPAY Y ENVIARSELO DE VUELTA AL USUARIO 
          order= await prisma.orders.update({where:{id:order.id},data:{complete_at:new Date(),status:"RECHAZADA"}})
          res.json(order)
              } catch (e) {
                console.log(e)
                res.status(500).json(e)
              }
}
export const confirmarCreacionCuentaParticipe= async (req:Request,res: Response) => {
  try {
     // @ts-ignore
     const prisma = req.prisma as PrismaClient;
     const {jwtCreador,companyID,cuenta_participe_id} = req.body;
const user= await axios.get('https://pro.stockencapital.com/api/v1/users/me/', {
headers: {
  'Authorization': `${jwtCreador}`
}
})
if(!user || user.data.status!='validated') return res.status(400).json({error:"Usuario no valido"})
const company= await prisma.companies_company.findUnique({where:{id:companyID}})
if(!company || company.legal_representative_id!=user.data.id || company.status!="validated") return res.status(400).json({error:"Compañia no existe, no pertenece al usuario o no esta validada"})
let cuenta_participe= await prisma.cuentas_participes.findUnique({where:{id:cuenta_participe_id}})
if(!cuenta_participe || cuenta_participe.signed) return res.status(400).json({error:"Ya ha firmado"})
const verify=await isCompleted(cuenta_participe.document_id)
cuenta_participe= await prisma.cuentas_participes.update({where:{id:cuenta_participe.id},data:{signed:verify}})
res.json(cuenta_participe)
  } catch (e) {
    console.log(e)
    res.status(500).json(e)
  }
}



export const getTemplatesByPandaDoc= async(req:Request,res:Response) => {
  try {    // @ts-ignore
    const prisma = req.prisma as PrismaClient;
    const data= await getTemplates()
    return res.json(data.results)
  } catch(e) {
    console.log(e)
    return res.status(500).json({error:e})
    }  
}
              