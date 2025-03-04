/*
  Warnings:

  - You are about to drop the column `name_payment` on the `PaymentList` table. All the data in the column will be lost.
  - You are about to drop the column `credit_used` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[namePayment]` on the table `PaymentList` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `namePayment` to the `PaymentList` table without a default value. This is not possible if the table is not empty.
  - Added the required column `creditUsed` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "PaymentList_name_payment_key";

-- AlterTable
ALTER TABLE "PaymentList" DROP COLUMN "name_payment",
ADD COLUMN     "namePayment" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "credit_used",
ADD COLUMN     "creditUsed" DOUBLE PRECISION NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "PaymentList_namePayment_key" ON "PaymentList"("namePayment");
