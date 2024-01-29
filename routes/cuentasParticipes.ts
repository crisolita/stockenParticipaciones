import express from "express";
import Joivalidator from "express-joi-validation";
import {
  aceptarComprasCuentaParticipe,
  asignarCtaParticipe,
  comprarParticipacion,
  comprarParticipacionPorOrden,
  crearCuentaParticipe,
  crearVentaDeParticipacion,
  prueba_del_doc,
  rechazarComprasCuentaParticipe,
  signCompraDoc,
  verCuentasParticipes,
  verOrdenesByBuyer,
  verOrdenesBySell,
} from "../controllers/cuentasParticipes";
import {
  querySchemaAceptarCP,
  querySchemaAsignarCP,
  querySchemaComprarCP,
  querySchemaComprarParticipe,
  querySchemaCrearCuentaPartiipe,
  querySchemaRechazarCP,
  querySchemaSignDocCP,
  querySchemaVenderCP,
  querySchemaVerCP,
  querySchemaVerOrdenesBuy,
  querySchemaVerOrdenesSell,
} from "../middleware/validation";
const validator = Joivalidator.createValidator();

const router = express.Router();
router.post(
  "/crearCuenta",
  validator.body(querySchemaCrearCuentaPartiipe),
  crearCuentaParticipe
);
router.post(
  "/comprarCuentaParticipe",
  validator.body(querySchemaComprarCP),
  comprarParticipacion
);
router.post(
  "/aceptarOrden",
  validator.body(querySchemaAceptarCP),
  aceptarComprasCuentaParticipe
);
router.post(
  "/rechazarOrden",
  validator.body(querySchemaRechazarCP),
  rechazarComprasCuentaParticipe
);
router.post("/signDoc", validator.body(querySchemaSignDocCP), signCompraDoc);

router.post(
  "/verOrdenesBySell",
  validator.body(querySchemaVerOrdenesSell),
  verOrdenesBySell
);
router.post(
  "/verOrdenesByBuyer",
  validator.body(querySchemaVerOrdenesBuy),
  verOrdenesByBuyer
);

router.post(
  "/verCuentasParticipes",
  validator.body(querySchemaVerCP),
  verCuentasParticipes
);

router.post(
  "/asignarCuenta",
  validator.body(querySchemaAsignarCP),
  asignarCtaParticipe
);

//// MARKETPLACE

router.post(
  "/venderParticipacion",
  validator.body(querySchemaVenderCP),
  crearVentaDeParticipacion
);
router.post(
  "/comprarParticipacion",
  validator.body(querySchemaComprarParticipe),
  comprarParticipacionPorOrden
);
router.post("/pruebaDoc", prueba_del_doc);
export default router;
