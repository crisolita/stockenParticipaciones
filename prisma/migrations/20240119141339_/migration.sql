/*
  Warnings:

  - You are about to drop the column `url_sign_first` on the `orders` table. All the data in the column will be lost.
  - You are about to drop the column `url_sign_second` on the `orders` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "orders" DROP COLUMN "url_sign_first",
DROP COLUMN "url_sign_second";
