/*
  Warnings:

  - You are about to drop the column `accountId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Account` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MouthPayment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `weekPayment` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `userCpf` to the `PaymentList` table without a default value. This is not possible if the table is not empty.
  - Added the required column `credit` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `credit_used` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sale` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Account" DROP CONSTRAINT "Account_mouthPaymentId_fkey";

-- DropForeignKey
ALTER TABLE "Account" DROP CONSTRAINT "Account_paymentListId_fkey";

-- DropForeignKey
ALTER TABLE "MouthPayment" DROP CONSTRAINT "MouthPayment_weekPaymentId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_accountId_fkey";

-- DropIndex
DROP INDEX "User_accountId_key";

-- AlterTable
ALTER TABLE "PaymentList" ADD COLUMN     "userCpf" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "accountId",
ADD COLUMN     "credit" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "credit_used" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "sale" DOUBLE PRECISION NOT NULL;

-- DropTable
DROP TABLE "Account";

-- DropTable
DROP TABLE "MouthPayment";

-- DropTable
DROP TABLE "weekPayment";

-- AddForeignKey
ALTER TABLE "PaymentList" ADD CONSTRAINT "PaymentList_userCpf_fkey" FOREIGN KEY ("userCpf") REFERENCES "User"("cpf") ON DELETE RESTRICT ON UPDATE CASCADE;
