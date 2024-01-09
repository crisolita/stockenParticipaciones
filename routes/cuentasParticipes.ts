import express from "express";
import { authenticateToken } from "../middleware/auth";
import { isAdmin } from "../middleware/isAdmin";
import Joivalidator from "express-joi-validation";
import {
  aceptarComprasCuentaParticipe,
  comprarParticipacion,
  crearCuentaParticipe,
  getTemplatesByPandaDoc,
  rechazarComprasCuentaParticipe,
  verOrdenesBySell,
} from "../controllers/cuentasParticipes";
import { querySchemaCrearCuentaPartiipe } from "../middleware/validation";
const validator = Joivalidator.createValidator();

const router = express.Router();
router.post(
  "/crearCuenta",
  validator.body(querySchemaCrearCuentaPartiipe),
  crearCuentaParticipe
);
router.post("/comprarCuentaParticipe", comprarParticipacion);
router.post("/verOrdenesBySell", verOrdenesBySell);
router.post("/aceptarOrden", aceptarComprasCuentaParticipe);
router.post("/rechazarOrden", rechazarComprasCuentaParticipe);

router.get("/templates", getTemplatesByPandaDoc);

export default router;
