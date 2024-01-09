-- CreateTable
CREATE TABLE "record_participaciones" (
    "id" SERIAL NOT NULL,
    "participacion_id" INTEGER NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "monto_pagado" INTEGER NOT NULL,
    "old_document_id" TEXT NOT NULL,
    "old_document_link" TEXT NOT NULL,
    "old_owner_id" INTEGER NOT NULL,
    "change_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "record_participaciones_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "record_participaciones" ADD CONSTRAINT "record_participaciones_participacion_id_fkey" FOREIGN KEY ("participacion_id") REFERENCES "paticipacion"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
