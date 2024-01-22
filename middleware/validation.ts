import Joi from "joi";
export const querySchemaCrearCuentaPartiipe = Joi.object({
  jwtCreador: Joi.string().required(),
  companyID: Joi.number().required(),
  nombre_del_proyecto: Joi.string().required(),
  descripcion: Joi.string().required(),
  cantidad_a_vender: Joi.number().required(),
  precio_unitario: Joi.number().required(),
  cesion: Joi.boolean().required(),
  duracion: Joi.string().required(),
  remuneracion: Joi.string().required(),
  plazos_remuneracion: Joi.string().required(),
  resultado: Joi.string().required(),
  determinacion: Joi.string().required(),
  juridicion: Joi.string().required(),
  fecha_lanzamiento: Joi.string().required(),
  liquidacion: Joi.string().required(),
  Clausulas: Joi.string(),
});
