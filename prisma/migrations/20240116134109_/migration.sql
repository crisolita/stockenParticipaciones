-- CreateTable
CREATE TABLE "venta_de_notas_convertibles" (
    "id" SERIAL NOT NULL,
    "cantidad_a_vender" INTEGER NOT NULL,
    "ticket_minimo" DOUBLE PRECISION,
    "companyID" INTEGER NOT NULL,
    "interes_fijo" DOUBLE PRECISION,
    "interes_variable" DOUBLE PRECISION,
    "vence_date" TIMESTAMP(3),
    "vence_cantidad" INTEGER,
    "tasa_descuento" DOUBLE PRECISION,
    "capitulacion" DOUBLE PRECISION,
    "CAP_no_ronda" DOUBLE PRECISION,
    "floor" DOUBLE PRECISION,
    "fecha_devolucion" TIMESTAMP(3),
    "negociar" BOOLEAN NOT NULL,

    CONSTRAINT "venta_de_notas_convertibles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "nota_convertible" (
    "id" SERIAL NOT NULL,
    "valor" DOUBLE PRECISION NOT NULL,
    "companyID" INTEGER NOT NULL,
    "interes_fijo" DOUBLE PRECISION,
    "interes_variable" DOUBLE PRECISION,
    "vence_date" TIMESTAMP(3),
    "tasa_descuento" DOUBLE PRECISION,
    "capitulacion" DOUBLE PRECISION,
    "CAP_no_ronda" DOUBLE PRECISION,
    "floor" DOUBLE PRECISION,
    "fecha_devolucion" TIMESTAMP(3),
    "negociar" BOOLEAN NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "nota_convertible_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "nota_convertible" ADD CONSTRAINT "nota_convertible_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
