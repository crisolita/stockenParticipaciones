/*
  Warnings:

  - You are about to drop the column `old_document_id` on the `record_participaciones` table. All the data in the column will be lost.
  - You are about to drop the column `old_document_link` on the `record_participaciones` table. All the data in the column will be lost.
  - Added the required column `old_document_id_first` to the `record_participaciones` table without a default value. This is not possible if the table is not empty.
  - Added the required column `old_document_second` to the `record_participaciones` table without a default value. This is not possible if the table is not empty.
  - Added the required column `old_signature_id` to the `record_participaciones` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "record_participaciones" DROP COLUMN "old_document_id",
DROP COLUMN "old_document_link",
ADD COLUMN     "old_document_id_first" TEXT NOT NULL,
ADD COLUMN     "old_document_second" TEXT NOT NULL,
ADD COLUMN     "old_signature_id" TEXT NOT NULL;
