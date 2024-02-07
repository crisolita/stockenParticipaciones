/*
  Warnings:

  - You are about to drop the column `cantidad` on the `participacion` table. All the data in the column will be lost.
  - You are about to drop the column `monto_pagado` on the `participacion` table. All the data in the column will be lost.
  - Added the required column `aportacion` to the `participacion` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "participacion" DROP COLUMN "cantidad",
DROP COLUMN "monto_pagado",
ADD COLUMN     "aportacion" DOUBLE PRECISION NOT NULL;
