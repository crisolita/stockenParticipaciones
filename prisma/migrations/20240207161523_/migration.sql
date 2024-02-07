/*
  Warnings:

  - You are about to drop the column `cantidad` on the `orders` table. All the data in the column will be lost.
  - You are about to drop the column `precio_total` on the `orders` table. All the data in the column will be lost.
  - Added the required column `aportacion` to the `orders` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "orders" DROP COLUMN "cantidad",
DROP COLUMN "precio_total",
ADD COLUMN     "aportacion" DOUBLE PRECISION NOT NULL;
