-- CreateTable
CREATE TABLE "User" (
    "cpf" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "accountId" INTEGER,

    CONSTRAINT "User_pkey" PRIMARY KEY ("cpf")
);

-- CreateTable
CREATE TABLE "Account" (
    "id" SERIAL NOT NULL,
    "sale" DOUBLE PRECISION NOT NULL,
    "credit" DOUBLE PRECISION NOT NULL,
    "credit_used" DOUBLE PRECISION NOT NULL,
    "paymentListId" INTEGER,
    "mouthPaymentId" INTEGER NOT NULL,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaymentList" (
    "id" SERIAL NOT NULL,
    "name_payment" TEXT NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "PaymentList_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MouthPayment" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "weekPaymentId" INTEGER NOT NULL,

    CONSTRAINT "MouthPayment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "weekPayment" (
    "id" SERIAL NOT NULL,
    "week" TEXT NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "weekPayment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_accountId_key" ON "User"("accountId");

-- CreateIndex
CREATE UNIQUE INDEX "Account_paymentListId_key" ON "Account"("paymentListId");

-- CreateIndex
CREATE UNIQUE INDEX "Account_mouthPaymentId_key" ON "Account"("mouthPaymentId");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentList_name_payment_key" ON "PaymentList"("name_payment");

-- CreateIndex
CREATE UNIQUE INDEX "MouthPayment_weekPaymentId_key" ON "MouthPayment"("weekPaymentId");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_paymentListId_fkey" FOREIGN KEY ("paymentListId") REFERENCES "PaymentList"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_mouthPaymentId_fkey" FOREIGN KEY ("mouthPaymentId") REFERENCES "MouthPayment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MouthPayment" ADD CONSTRAINT "MouthPayment_weekPaymentId_fkey" FOREIGN KEY ("weekPaymentId") REFERENCES "weekPayment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
