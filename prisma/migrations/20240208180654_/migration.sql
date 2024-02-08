/*
  Warnings:

  - You are about to drop the column `cantidad` on the `orderNotaConvertible` table. All the data in the column will be lost.
  - You are about to drop the column `precio_total` on the `orderNotaConvertible` table. All the data in the column will be lost.
  - You are about to drop the `nombre` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `aportacion` to the `orderNotaConvertible` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "orderNotaConvertible" DROP COLUMN "cantidad",
DROP COLUMN "precio_total",
ADD COLUMN     "aportacion" DOUBLE PRECISION NOT NULL;

-- AlterTable
ALTER TABLE "venta_de_notas_convertibles" ALTER COLUMN "cantidad_a_vender" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "cantidad_restante" SET DATA TYPE DOUBLE PRECISION;

-- DropTable
DROP TABLE "nombre";
