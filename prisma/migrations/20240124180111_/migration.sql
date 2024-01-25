/*
  Warnings:

  - Added the required column `sellerId` to the `orderNotaConvertible` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "orderNotaConvertible" ADD COLUMN     "buyerId" INTEGER,
ADD COLUMN     "sellerId" INTEGER NOT NULL;
