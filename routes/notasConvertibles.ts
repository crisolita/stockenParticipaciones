import express from "express";

import Joivalidator from "express-joi-validation";
import {
  aceptarCompraNotaConvertible,
  asignarNota,
  comprarNotaConvertible,
  crearNotaConvertible,
  rechazarCompraNotaConvertible,
  signCompraDoc,
  verNotasConvertibles,
} from "../controllers/notasConvertibles";
import {
  querySchemaAceptarNC,
  querySchemaAsignarNC,
  querySchemaComprarNC,
  querySchemaCrearVentaNC,
  querySchemaRechazarNC,
  querySchemaSignDocNC,
  querySchemaVerNC,
} from "../middleware/validation";
const validator = Joivalidator.createValidator();

const router = express.Router();
router.post(
  "/crearVentaDeNotaConvertible",
  validator.body(querySchemaCrearVentaNC),
  crearNotaConvertible
);
router.post(
  "/comprarNota",
  validator.body(querySchemaComprarNC),
  comprarNotaConvertible
);
router.post(
  "/rechazarOrdenNC",
  validator.body(querySchemaRechazarNC),
  rechazarCompraNotaConvertible
);
router.post(
  "/aceptarOrdenNC",
  validator.body(querySchemaAceptarNC),
  aceptarCompraNotaConvertible
);
router.post("/signDocNC", validator.body(querySchemaSignDocNC), signCompraDoc);
router.post("/asignarNota", validator.body(querySchemaAsignarNC), asignarNota);
router.post(
  "/verNotasConvertibles",
  validator.body(querySchemaVerNC),
  verNotasConvertibles
);

export default router;
