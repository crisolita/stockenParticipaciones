import express from "express";
import { authenticateToken } from "../middleware/auth";
import { isAdmin } from "../middleware/isAdmin";
import Joivalidator from "express-joi-validation";
import { aceptarCompras, comprarParticipacion, crearCuentaParticipe, getTemplatesByPandaDoc, rechazarCompras, verOrdenesBySell } from "../controllers/cuentasParticipes";
import { querySchemaCrearCuentaPartiipe } from "../middleware/validation";
const validator = Joivalidator.createValidator();


const router = express.Router();
router.post("/crearCuenta", validator.body(querySchemaCrearCuentaPartiipe),crearCuentaParticipe);
router.post("/comprarCuentaParticipe",comprarParticipacion);
router.post("/verOrdenesBySell",verOrdenesBySell)
router.post("/aceptarOrden",aceptarCompras)
router.post("/rechazarOrden",rechazarCompras)

router.get("/templates",getTemplatesByPandaDoc);


export default router;
