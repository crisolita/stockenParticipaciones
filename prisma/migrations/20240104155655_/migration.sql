/*
  Warnings:

  - Added the required column `liquidacion` to the `cuentas_participes` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "cuentas_participes" ADD COLUMN     "liquidacion" TEXT NOT NULL;
