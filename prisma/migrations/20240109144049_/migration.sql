/*
  Warnings:

  - Added the required column `buy_date` to the `participacion` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "participacion" ADD COLUMN     "buy_date" TIMESTAMP(3) NOT NULL;
