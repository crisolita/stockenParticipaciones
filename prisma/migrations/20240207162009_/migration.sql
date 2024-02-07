/*
  Warnings:

  - You are about to drop the column `juridicion` on the `cuentas_participes` table. All the data in the column will be lost.
  - You are about to drop the column `liquidacion` on the `cuentas_participes` table. All the data in the column will be lost.
  - You are about to drop the column `plazos_remuneracion` on the `cuentas_participes` table. All the data in the column will be lost.
  - You are about to drop the column `remuneracion` on the `cuentas_participes` table. All the data in the column will be lost.
  - You are about to drop the column `resultado` on the `cuentas_participes` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "cuentas_participes" DROP COLUMN "juridicion",
DROP COLUMN "liquidacion",
DROP COLUMN "plazos_remuneracion",
DROP COLUMN "remuneracion",
DROP COLUMN "resultado";
