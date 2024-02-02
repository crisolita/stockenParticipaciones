-- CreateEnum
CREATE TYPE "StatusActivo" AS ENUM ('ACTIVO', 'FINALIZADO', 'CANCELADO');

-- AlterTable
ALTER TABLE "nota_convertible" ADD COLUMN     "status" "StatusActivo";

-- AlterTable
ALTER TABLE "participacion" ADD COLUMN     "status" "StatusActivo";
