/*
  Warnings:

  - You are about to drop the column `participe_id` on the `paticipacion` table. All the data in the column will be lost.
  - Added the required column `cuenta_participe_id` to the `paticipacion` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "paticipacion" DROP CONSTRAINT "paticipacion_participe_id_fkey";

-- AlterTable
ALTER TABLE "paticipacion" DROP COLUMN "participe_id",
ADD COLUMN     "cuenta_participe_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "paticipacion" ADD CONSTRAINT "paticipacion_cuenta_participe_id_fkey" FOREIGN KEY ("cuenta_participe_id") REFERENCES "cuentas_participes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
