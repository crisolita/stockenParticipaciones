/*
  Warnings:

  - You are about to drop the `paticipacion` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "paticipacion" DROP CONSTRAINT "paticipacion_cuenta_participe_id_fkey";

-- DropForeignKey
ALTER TABLE "paticipacion" DROP CONSTRAINT "paticipacion_owner_id_fkey";

-- DropForeignKey
ALTER TABLE "record_participaciones" DROP CONSTRAINT "record_participaciones_participacion_id_fkey";

-- DropTable
DROP TABLE "paticipacion";

-- CreateTable
CREATE TABLE "participacion" (
    "id" SERIAL NOT NULL,
    "cuenta_participe_id" INTEGER NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "monto_pagado" INTEGER NOT NULL,
    "document_id" TEXT NOT NULL,
    "document_link" TEXT NOT NULL,
    "owner_id" INTEGER NOT NULL,

    CONSTRAINT "participacion_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "participacion" ADD CONSTRAINT "participacion_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "participacion" ADD CONSTRAINT "participacion_cuenta_participe_id_fkey" FOREIGN KEY ("cuenta_participe_id") REFERENCES "cuentas_participes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "record_participaciones" ADD CONSTRAINT "record_participaciones_participacion_id_fkey" FOREIGN KEY ("participacion_id") REFERENCES "participacion"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
