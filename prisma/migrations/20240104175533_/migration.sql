/*
  Warnings:

  - Added the required column `cuenta_participe_id` to the `mangopay_mangopaytransfer_cuenta_participe` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "mangopay_mangopaytransfer_cuenta_participe" ADD COLUMN     "cuenta_participe_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "mangopay_mangopaytransfer_cuenta_participe" ADD CONSTRAINT "mangopay_mangopaytransfer_cuenta_participe_cuenta_particip_fkey" FOREIGN KEY ("cuenta_participe_id") REFERENCES "cuentas_participes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
