-- AlterTable
ALTER TABLE "orders" ALTER COLUMN "url_sign" DROP NOT NULL,
ALTER COLUMN "buyerID" DROP NOT NULL,
ALTER COLUMN "complete_at" DROP NOT NULL;

-- CreateTable
CREATE TABLE "paticipacion" (
    "id" SERIAL NOT NULL,
    "participe_id" INTEGER NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "monto_pagado" INTEGER NOT NULL,
    "document_id" TEXT NOT NULL,
    "document_link" TEXT NOT NULL,
    "owner_id" INTEGER NOT NULL,

    CONSTRAINT "paticipacion_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "paticipacion" ADD CONSTRAINT "paticipacion_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "paticipacion" ADD CONSTRAINT "paticipacion_participe_id_fkey" FOREIGN KEY ("participe_id") REFERENCES "cuentas_participes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
