/*
  Warnings:

  - The values [PENDIENTE_FIRMA_VENDEDOR_COMPRADOR] on the enum `StatusOrderCtaParticipe` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `participe_id` on the `orders` table. All the data in the column will be lost.
  - Added the required column `cuenta_participe_id` to the `orders` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "StatusOrderCtaParticipe_new" AS ENUM ('SALDO_BLOQUEADO', 'PENDIENTE_FIRMA_VENDEDOR', 'PENDIENTE_FIRMA_COMPRADOR', 'COMPRA_TERMINADA');
ALTER TABLE "orders" ALTER COLUMN "status" TYPE "StatusOrderCtaParticipe_new" USING ("status"::text::"StatusOrderCtaParticipe_new");
ALTER TYPE "StatusOrderCtaParticipe" RENAME TO "StatusOrderCtaParticipe_old";
ALTER TYPE "StatusOrderCtaParticipe_new" RENAME TO "StatusOrderCtaParticipe";
DROP TYPE "StatusOrderCtaParticipe_old";
COMMIT;

-- AlterTable
ALTER TABLE "orders" DROP COLUMN "participe_id",
ADD COLUMN     "cuenta_participe_id" INTEGER NOT NULL,
ADD COLUMN     "participacion_id" INTEGER;
