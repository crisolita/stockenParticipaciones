/*
  Warnings:

  - The values [PENDIENTE_FIRMA_COMPRADOR] on the enum `StatusOrderCtaParticipe` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "StatusOrderCtaParticipe_new" AS ENUM ('VENTA_ACTIVA', 'SALDO_BLOQUEADO', 'PENDIENTE_FIRMA', 'COMPRA_TERMINADA', 'RECHAZADA');
ALTER TABLE "orders" ALTER COLUMN "status" TYPE "StatusOrderCtaParticipe_new" USING ("status"::text::"StatusOrderCtaParticipe_new");
ALTER TYPE "StatusOrderCtaParticipe" RENAME TO "StatusOrderCtaParticipe_old";
ALTER TYPE "StatusOrderCtaParticipe_new" RENAME TO "StatusOrderCtaParticipe";
DROP TYPE "StatusOrderCtaParticipe_old";
COMMIT;
