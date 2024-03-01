import { PrismaClient, Tipodeinteres } from "@prisma/client";
// replace it with your API key

export const crearVentaNotaConvertible = async (
  data: {
    cantidad_a_vender: number;
    ticket_minimo: number;
    companyID: number;
    interes_fijo?: number;
    interes_variable?: number;
    vence_date?: Date;
    vence_cantidad?: number;
    tasa_descuento?: number;
    capitulacion?: string;
    CAP_no_ronda?: string;
    floor?: string;
    tipodeinteres: Tipodeinteres;
    fecha_devolucion?: Date;
    negociar: boolean;
    creador_id: number;
    cantidad_restante: number;
    clausulas?: string;
  },
  prisma: PrismaClient
) => {
  try {
    const nota = await prisma.venta_de_notas_convertibles.create({
      data: {
        ...data,
      },
    });
    return nota;
  } catch (e) {
    console.log(e);
    return false;
  }
};
