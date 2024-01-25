-- CreateTable
CREATE TABLE "orderNotaConvertible" (
    "id" SERIAL NOT NULL,
    "nota_convertible_id" INTEGER,
    "cantidad" DOUBLE PRECISION NOT NULL,
    "precio_total" DOUBLE PRECISION NOT NULL,
    "venta_nc_id" INTEGER,
    "signature_id" TEXT,
    "document_id_first" TEXT,
    "document_id_second" TEXT,
    "create_date" TIMESTAMP(3) NOT NULL,
    "complete_at" TIMESTAMP(3),
    "status" "StatusOrderCtaParticipe" NOT NULL,

    CONSTRAINT "orderNotaConvertible_pkey" PRIMARY KEY ("id")
);
