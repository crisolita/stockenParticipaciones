import Joi from "joi";
export const querySchemaCrearCuentaPartiipe = Joi.object({
  jwtCreador: Joi.string().required(),
  companyID: Joi.number().required(),
  nombre_del_proyecto: Joi.string().required(),
  descripcion: Joi.string().required(),
  cantidad_a_vender: Joi.number().required(),
  cesion: Joi.boolean().required(),
  duracion: Joi.string().required(),
  ticket_minimo: Joi.number().required(),
  fecha_lanzamiento: Joi.string().required(),
  media: Joi.array().items(
    Joi.object({
      type: Joi.string().required(),
      base64: Joi.string().required(),
    })
  ),
  Clausulas: Joi.custom((value, helpers) => {
    // Aquí puedes implementar la lógica para validar el HTML
    // Por ejemplo, podrías utilizar una expresión regular para verificar si es HTML válido
    if (isValidHTML(value)) {
      return value;
    } else {
      return helpers.error("HTML.invalid");
    }
  }, "Custom HTML Validation"),
});
export const querySchemaComprarCP = Joi.object({
  participe_id: Joi.number().required(),
  aportacion: Joi.number().required(),
  jwtUser: Joi.string().required(),
  companyIdBuyer: Joi.number(),
});
export const querySchemaAceptarCP = Joi.object({
  jwtCreador: Joi.string().required(),
  orderId: Joi.number().required(),
});
export const querySchemaRechazarCP = Joi.object({
  jwtCreador: Joi.string().required(),
  orderId: Joi.number().required(),
});
export const querySchemaSignDocCP = Joi.object({
  jwtCreador: Joi.string().required(),
  orderId: Joi.number().required(),
});
export const querySchemaVerCP = Joi.object({
  jwtUser: Joi.string().required(),
});
export const querySchemaAsignarCP = Joi.object({
  jwtCreador: Joi.string().required(),
  cuenta_participe_id: Joi.number().required(),
  aportacion: Joi.number().required(),
  user_id: Joi.number().required,
  companyIdBuyer: Joi.number(),
});
export const querySchemaVenderCP = Joi.object({
  participacion_id: Joi.number().required(),
  jwtUser: Joi.string().required(),
  precio: Joi.number().required(),
  companyIDSeller: Joi.number(),
});
export const querySchemaComprarParticipe = Joi.object({
  orderId: Joi.number().required(),
  jwtUser: Joi.string().required(),
  companyIdBuyer: Joi.number(),
});
export const querySchemaVerOrdenesSell = Joi.object({
  jwtUser: Joi.string().required(),
  companyId: Joi.number(),
});
export const querySchemaVerOrdenesBuy = Joi.object({
  jwtUser: Joi.string().required(),
});

//// NOTAS CONVERTIBLES
export const querySchemaCrearVentaNC = Joi.object({
  jwtCreador: Joi.string().required(),
  companyID: Joi.number().required(),
  cantidad_a_vender: Joi.number().required(),
  ticket_minimo: Joi.number().required(),
  interes_fijo: Joi.number(),
  interes_variable: Joi.number(),
  tipodeinteres: Joi.string().required(),
  vence_date: Joi.string(),
  vence_cantidad: Joi.number(),
  tasa_descuento: Joi.number(),
  capitulacion: Joi.string(),
  CAP_no_ronda: Joi.string(),
  floor: Joi.string(),
  media: Joi.array().items(
    Joi.object({
      type: Joi.string().required(),
      base64: Joi.string().required(),
    })
  ),
  fecha_devolucion: Joi.string(),
  negociar: Joi.boolean(),
});
export const querySchemaComprarNC = Joi.object({
  venta_id: Joi.number().required(),
  aportacion: Joi.number().required(),
  jwtUser: Joi.string().required(),
  companyIdBuyer: Joi.number(),
});
export const querySchemaAceptarNC = Joi.object({
  jwtCreador: Joi.string().required(),
  orderId: Joi.number().required(),
});
export const querySchemaRechazarNC = Joi.object({
  jwtCreador: Joi.string().required(),
  orderId: Joi.number().required(),
});
export const querySchemaSignDocNC = Joi.object({
  jwtCreador: Joi.string().required(),
  orderId: Joi.number().required(),
});
export const querySchemaVerNC = Joi.object({
  jwtUser: Joi.string().required(),
});
export const querySchemaAsignarNC = Joi.object({
  jwtCreador: Joi.string().required(),
  venta_nc_id: Joi.number().required(),
  aportacion: Joi.number().required(),
  user_id: Joi.number().required(),
  companyIdBuyer: Joi.number(),
});
function isValidHTML(html: any) {
  const htmlRegex = /<[a-z][\s\S]*>/i; // Expresión regular simple para verificar si hay etiquetas HTML
  return htmlRegex.test(html);
}

export const querySchemaEditarCta = Joi.object({
  jwtCreador: Joi.string().required(),
  cuenta_participe_id: Joi.number().required(),
  cesion: Joi.boolean(),
});
