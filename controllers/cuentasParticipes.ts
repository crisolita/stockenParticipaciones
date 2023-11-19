import { PrismaClient } from "@prisma/client";
import { Request, Response } from "express";

export const crearCuentaParticipe= async (req:Request,res: Response) => {
    try {
       // @ts-ignore
       const prisma = req.prisma as PrismaClient;
       const {creator_id,
        nombre_del_proyecto,
        descripcion,
        cantidad_recaudar_euros,
        aportacion_minima_euros,
        cantidad_restante,
        cesion,
        duracion,
        remuneracion,
        resultado,
        determinacion,
        juridicion,
        templateID }= req.body;
///REVISAR SI LA EMPRESA QUE LLAMA ESTA VERIFICADA
const cuenta= await prisma.cuentas_participes.create({
  data:{
    creator_id,
        nombre_del_proyecto,
        descripcion,
        cantidad_recaudar_euros,
        aportacion_minima_euros,
        cantidad_restante,
        cesion,
        duracion,
        remuneracion,
        resultado,
        determinacion,
        juridicion,
        templateID
  }
})
    return res.json(cuenta)
    } catch (e) {
      res.status(500).json(e)
    }
    }
    export const comprarParticipacion= async (req:Request,res: Response) => {
      try {
         // @ts-ignore
         const prisma = req.prisma as PrismaClient;
         // @ts-ignore
       const USER = req.user as User;
         const {participe_id, cantidad,metodo_de_pago}= req.body;
        const cuenta_participe= await prisma.cuentas_participes.findUnique({where:{id:participe_id}})
        if(!cuenta_participe) return res.status(400).json({error:"No existe cuenta participe"})
        ///EJECUTAR EL PAGO
      const compra= await prisma.compras.create({
        data:{
          user_id:USER.id,
          metodo_de_pago,
          participe_id
        }
      })
      return res.json(compra)
      } catch (e) {
        res.status(500).json(e)
      }
      }