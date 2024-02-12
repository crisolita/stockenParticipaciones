-- CreateEnum
CREATE TYPE "TypeOfMedia" AS ENUM ('IMAGE', 'DOC', 'LINK');

-- CreateTable
CREATE TABLE "media" (
    "id" SERIAL NOT NULL,
    "cuenta_participe_id" INTEGER NOT NULL,
    "path" TEXT NOT NULL,
    "type" "TypeOfMedia" NOT NULL,

    CONSTRAINT "media_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "media" ADD CONSTRAINT "media_cuenta_participe_id_fkey" FOREIGN KEY ("cuenta_participe_id") REFERENCES "cuentas_participes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
