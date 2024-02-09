-- CreateEnum
CREATE TYPE "Tipodeinteres" AS ENUM ('FIJO', 'VARIABLE', 'COMPUESTO');

-- AlterTable
ALTER TABLE "venta_de_notas_convertibles" ADD COLUMN     "tipodeinteres" "Tipodeinteres";
