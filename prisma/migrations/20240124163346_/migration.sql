/*
  Warnings:

  - You are about to drop the column `companyID` on the `nota_convertible` table. All the data in the column will be lost.
  - You are about to drop the column `user_id` on the `nota_convertible` table. All the data in the column will be lost.
  - You are about to alter the column `cantidad` on the `orderNotaConvertible` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Integer`.
  - Added the required column `buy_date` to the `nota_convertible` table without a default value. This is not possible if the table is not empty.
  - Added the required column `owner_id` to the `nota_convertible` table without a default value. This is not possible if the table is not empty.
  - Added the required column `creador_id` to the `venta_de_notas_convertibles` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "nota_convertible" DROP CONSTRAINT "nota_convertible_user_id_fkey";

-- AlterTable
ALTER TABLE "nota_convertible" DROP COLUMN "companyID",
DROP COLUMN "user_id",
ADD COLUMN     "buy_date" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "document_id_first" TEXT,
ADD COLUMN     "document_id_second" TEXT,
ADD COLUMN     "owner_id" INTEGER NOT NULL,
ADD COLUMN     "signature_id" TEXT,
ADD COLUMN     "venta_nc_id" INTEGER;

-- AlterTable
ALTER TABLE "orderNotaConvertible" ALTER COLUMN "cantidad" SET DATA TYPE INTEGER;

-- AlterTable
ALTER TABLE "venta_de_notas_convertibles" ADD COLUMN     "creador_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "venta_de_notas_convertibles" ADD CONSTRAINT "venta_de_notas_convertibles_creador_id_fkey" FOREIGN KEY ("creador_id") REFERENCES "users_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "nota_convertible" ADD CONSTRAINT "nota_convertible_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
