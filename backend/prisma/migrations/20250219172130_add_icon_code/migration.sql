/*
  Warnings:

  - The `iconCode` column on the `PaymentList` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "PaymentList" DROP COLUMN "iconCode",
ADD COLUMN     "iconCode" INTEGER NOT NULL DEFAULT 0;
