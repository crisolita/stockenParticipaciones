/*
  Warnings:

  - Added the required column `signature_id` to the `participacion` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "participacion" ADD COLUMN     "signature_id" TEXT NOT NULL;
