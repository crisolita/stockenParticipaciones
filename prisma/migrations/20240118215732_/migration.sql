/*
  Warnings:

  - You are about to drop the column `documentId` on the `orders` table. All the data in the column will be lost.
  - You are about to drop the column `url_sign` on the `orders` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "orders" DROP COLUMN "documentId",
DROP COLUMN "url_sign",
ADD COLUMN     "documentId_first" TEXT,
ADD COLUMN     "documentId_second" TEXT,
ADD COLUMN     "url_sign_first" TEXT,
ADD COLUMN     "url_sign_second" TEXT;
