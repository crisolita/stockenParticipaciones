/*
  Warnings:

  - Added the required column `companyIDSeller` to the `cuentas_participes` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "cuentas_participes" ADD COLUMN     "companyIDSeller" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "orders" ADD COLUMN     "companyIdBuyer" INTEGER;
