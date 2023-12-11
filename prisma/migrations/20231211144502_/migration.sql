/*
  Warnings:

  - Added the required column `document_link` to the `cuentas_participes` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "cuentas_participes" ADD COLUMN     "document_link" TEXT NOT NULL;
