import express from "express";
import Joivalidator from "express-joi-validation";
import {
  aceptarComprasCuentaParticipe,
  comprarParticipacion,
  comprarParticipacionPorOrden,
  crearCuentaParticipe,
  crearVentaDeParticipacion,
  rechazarComprasCuentaParticipe,
  signCompraDoc,
  verCuentasParticipes,
  verOrdenesByBuyer,
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
router.post("/aceptarOrden", aceptarComprasCuentaParticipe);
router.post("/rechazarOrden", rechazarComprasCuentaParticipe);
router.post("/signDoc", signCompraDoc);

router.post("/verOrdenesBySell", verOrdenesBySell);
router.post("/verOrdenesByBuyer", verOrdenesByBuyer);

router.post("/verCuentasParticipes", verCuentasParticipes);

//// MARKETPLACE

router.post("/venderParticipacion", crearVentaDeParticipacion);
router.post("/comprarParticipacion", comprarParticipacionPorOrden);

export default router;
