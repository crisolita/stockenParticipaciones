import express from "express";
import { authenticateToken } from "../middleware/auth";
import { isAdmin } from "../middleware/isAdmin";
import Joivalidator from "express-joi-validation";
import { comprarParticipacion, confirmarCreacionCuentaParticipe, crearCuentaParticipe, getTemplatesByPandaDoc } from "../controllers/cuentasParticipes";
import { querySchemaCrearCuentaPartiipe } from "../middleware/validation";
const validator = Joivalidator.createValidator();


const router = express.Router();
router.post("/crearCuenta", validator.body(querySchemaCrearCuentaPartiipe),crearCuentaParticipe);
router.post("/comprarCuentaParticipe",comprarParticipacion);
router.post("/signCuenta",confirmarCreacionCuentaParticipe);


router.get("/templates",getTemplatesByPandaDoc);


export default router;
