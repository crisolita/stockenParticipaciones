-- CreateTable
CREATE TABLE "cuentas_participes" (
    "id" SERIAL NOT NULL,
    "creator_id" INTEGER NOT NULL,
    "nombre_del_proyecto" TEXT NOT NULL,
    "descripcion" TEXT NOT NULL,
    "cantidad_a_vender" INTEGER NOT NULL,
    "precio_unitario" DOUBLE PRECISION NOT NULL,
    "cantidad_restante" INTEGER NOT NULL,
    "cesion" BOOLEAN NOT NULL,
    "duracion" TIMESTAMP(3) NOT NULL,
    "remuneracion" TEXT NOT NULL,
    "resultado" TEXT NOT NULL,
    "determinacion" TEXT NOT NULL,
    "plazos_remuneracion" TEXT NOT NULL,
    "juridicion" TEXT NOT NULL,
    "templateID" TEXT NOT NULL,
    "fecha_lanzamiento" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "cuentas_participes_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "cuentas_participes" ADD CONSTRAINT "cuentas_participes_creator_id_fkey" FOREIGN KEY ("creator_id") REFERENCES "users_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
