-- CreateEnum
CREATE TYPE "METODODEPAGO" AS ENUM ('TARJETA', 'CRIPTO');

-- CreateTable
CREATE TABLE "Cuentas_participes" (
    "id" SERIAL NOT NULL,
    "creator_id" TEXT NOT NULL,
    "nombre_del_proyecto" TEXT NOT NULL,
    "descripcion" TEXT NOT NULL,
    "cantidad_recaudar_euros" DOUBLE PRECISION NOT NULL,
    "aportacion_minima_euros" DOUBLE PRECISION NOT NULL,
    "cantidad_restante" DOUBLE PRECISION NOT NULL,
    "cesion" BOOLEAN NOT NULL,
    "duracion" TIMESTAMP(3) NOT NULL,
    "remuneracion" TEXT NOT NULL,
    "resultado" TEXT NOT NULL,
    "determinacion" TEXT NOT NULL,
    "juridicion" TEXT NOT NULL,
    "templateID" TEXT NOT NULL,

    CONSTRAINT "Cuentas_participes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Compras" (
    "id" SERIAL NOT NULL,
    "user_id" TEXT NOT NULL,
    "metodo_de_pago" "METODODEPAGO" NOT NULL,
    "participe_id" INTEGER NOT NULL,

    CONSTRAINT "Compras_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Compras" ADD CONSTRAINT "Compras_participe_id_fkey" FOREIGN KEY ("participe_id") REFERENCES "Cuentas_participes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
