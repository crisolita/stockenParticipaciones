/*
  Warnings:

  - Added the required column `cantidad_restante` to the `venta_de_notas_convertibles` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "venta_de_notas_convertibles" ADD COLUMN     "cantidad_restante" INTEGER NOT NULL;
