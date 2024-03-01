/*
  Warnings:

  - You are about to drop the column `clausulas` on the `nota_convertible` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "nota_convertible" DROP COLUMN "clausulas";

-- AlterTable
ALTER TABLE "venta_de_notas_convertibles" ADD COLUMN     "clausulas" TEXT;
