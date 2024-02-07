/*
  Warnings:

  - Made the column `ticket_minimo` on table `cuentas_participes` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "cuentas_participes" ALTER COLUMN "ticket_minimo" SET NOT NULL;
