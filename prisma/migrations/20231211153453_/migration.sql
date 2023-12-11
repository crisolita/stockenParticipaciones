-- CreateEnum
CREATE TYPE "StatusOrderCtaParticipe" AS ENUM ('SALDO_BLOQUEADO', 'PENDIENTE_FIRMA_VENDEDOR_COMPRADOR', 'PENDIENTE_FIRMA_VENDEDOR', 'PENDIENTE_FIRMA_COMPRADOR', 'COMPRA_TERMINADA');

-- CreateTable
CREATE TABLE "orders" (
    "id" SERIAL NOT NULL,
    "precio_total" DOUBLE PRECISION NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "url_sign" TEXT NOT NULL,
    "participe_id" INTEGER NOT NULL,
    "buyerID" INTEGER NOT NULL,
    "sellerID" INTEGER NOT NULL,
    "status" "StatusOrderCtaParticipe" NOT NULL,
    "create_date" TIMESTAMP(3) NOT NULL,
    "complete_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);
