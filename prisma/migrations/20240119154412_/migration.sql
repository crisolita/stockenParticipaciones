/*
  Warnings:

  - You are about to drop the column `document_id` on the `participacion` table. All the data in the column will be lost.
  - You are about to drop the column `document_link` on the `participacion` table. All the data in the column will be lost.
  - Added the required column `document_id_first` to the `participacion` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "participacion" DROP COLUMN "document_id",
DROP COLUMN "document_link",
ADD COLUMN     "document_id_first" TEXT NOT NULL;
