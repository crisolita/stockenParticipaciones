/*
  Warnings:

  - You are about to drop the column `countMedia` on the `nota_convertible` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "nota_convertible" DROP COLUMN "countMedia";

-- AlterTable
ALTER TABLE "venta_de_notas_convertibles" ADD COLUMN     "countMedia" INTEGER;
