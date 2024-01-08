/*
  Warnings:

  - You are about to drop the column `document_id` on the `cuentas_participes` table. All the data in the column will be lost.
  - You are about to drop the column `document_link` on the `cuentas_participes` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "cuentas_participes" DROP COLUMN "document_id",
DROP COLUMN "document_link";
