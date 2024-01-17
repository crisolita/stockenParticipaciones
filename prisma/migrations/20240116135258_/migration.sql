/*
  Warnings:

  - Made the column `ticket_minimo` on table `venta_de_notas_convertibles` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "venta_de_notas_convertibles" ALTER COLUMN "ticket_minimo" SET NOT NULL;
