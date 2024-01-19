/*
  Warnings:

  - Added the required column `document_id_second` to the `participacion` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "participacion" ADD COLUMN     "document_id_second" TEXT NOT NULL;
