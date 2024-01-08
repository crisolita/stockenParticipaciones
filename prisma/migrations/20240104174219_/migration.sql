-- CreateTable
CREATE TABLE "mangopay_basemangopaytransaction_cuenta_participe" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "transaction_id" VARCHAR(32) NOT NULL,
    "status" VARCHAR(32) NOT NULL,
    "amount" DECIMAL(20,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL,
    "fees" DECIMAL(20,2) NOT NULL,
    "cod" VARCHAR(30) NOT NULL,

    CONSTRAINT "mangopay_basemangopaytransaction_cuenta_participe_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mangopay_mangopaytransfer_cuenta_participe" (
    "from_user_id" INTEGER NOT NULL,
    "to_user_id" INTEGER NOT NULL,
    "basemangopaytransaction_ptr_id" INTEGER NOT NULL,
    "from_cod" VARCHAR(255),
    "to_cod" VARCHAR(255),
    "total_amount" DECIMAL(20,2),

    CONSTRAINT "mangopay_mangopaytransfer_cuenta_participe_pkey" PRIMARY KEY ("basemangopaytransaction_ptr_id")
);

-- AddForeignKey
ALTER TABLE "mangopay_mangopaytransfer_cuenta_participe" ADD CONSTRAINT "mangopay_mangopaytra_basemangopaytransact_d76323ba_fk_mangopay_" FOREIGN KEY ("basemangopaytransaction_ptr_id") REFERENCES "mangopay_basemangopaytransaction_cuenta_participe"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
