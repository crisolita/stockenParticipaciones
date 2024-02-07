/*
  Warnings:

  - You are about to drop the column `cantidad` on the `record_participaciones` table. All the data in the column will be lost.
  - You are about to drop the column `monto_pagado` on the `record_participaciones` table. All the data in the column will be lost.
  - Added the required column `aportacion` to the `record_participaciones` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "record_participaciones" DROP COLUMN "cantidad",
DROP COLUMN "monto_pagado",
ADD COLUMN     "aportacion" DOUBLE PRECISION NOT NULL;
