import express from "express";
import { authenticateToken } from "../middleware/auth";
import { isAdmin } from "../middleware/isAdmin";
import Joivalidator from "express-joi-validation";
import { crearVentaNotaConvertible } from "../service/notasConvertibles";
import {
  aceptarCompraNotaConvertible,
  asignarNota,
  comprarNotaConvertible,
  crearNotaConvertible,
  rechazarCompraNotaConvertible,
  signCompraDoc,
} from "../controllers/notasConvertibles";
const validator = Joivalidator.createValidator();

const router = express.Router();
router.post("/crearVentaDeNotaConvertible", crearNotaConvertible);
router.post("/comprarNota", comprarNotaConvertible);
router.post("/rechazarOrdenNC", rechazarCompraNotaConvertible);
router.post("/aceptarOrdenNC", aceptarCompraNotaConvertible);
router.post("/signDocNC", signCompraDoc);
router.post("/asignarNota", asignarNota);

export default router;
