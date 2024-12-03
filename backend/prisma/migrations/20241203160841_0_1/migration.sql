-- DropForeignKey
ALTER TABLE "Account" DROP CONSTRAINT "Account_mouthPaymentId_fkey";

-- AlterTable
ALTER TABLE "Account" ALTER COLUMN "mouthPaymentId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_mouthPaymentId_fkey" FOREIGN KEY ("mouthPaymentId") REFERENCES "MouthPayment"("id") ON DELETE SET NULL ON UPDATE CASCADE;
