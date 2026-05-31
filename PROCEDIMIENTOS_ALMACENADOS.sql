use [guarderia_mascotas]

---1. Registrar una mascota (su estancia) y su brazalete.
CREATE PROCEDURE RegistrarMascotaEstanciaBrazalete
(
    -- MASCOTA
    @MascotaId      NUMERIC(10,0),
    @Genero         CHAR(1),
    @Rasgo          VARCHAR(400),
    @Nombre         VARCHAR(40),
    @ClienteId      NUMERIC(10,0),
    @RazaId         NUMERIC(10,0),

    -- ESTANCIA
    @IdEstancia     NUMERIC(10,0),
    @DiasEstancia   NUMERIC(3,0),
    @CentroId       NUMERIC(5,0),
    @CuidadorId     NUMERIC(10,0),
    @EstacionId     NUMERIC(1,0),

    -- BRAZALETE
    @BrazaleteId        NUMERIC(10,0),
    @Medicamento        VARCHAR(50),
    @Cuidados           VARCHAR(400),
    @TipoAlimentacion   VARCHAR(40),
    @CantidadComida     NUMERIC(3,0),
    @Estado             VARCHAR(40)
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN

        -- Registrar mascota
        INSERT INTO MASCOTA (MASCOTA_ID, GENERO, RASGO, NOMBRE, CLIENTE_ID, RAZA_ID)
        VALUES (@MascotaId, @Genero, @Rasgo, @Nombre, @ClienteId, @RazaId);

        -- Registrar estancia
        INSERT INTO ESTANCIA (ID_ESTANCIA, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
        VALUES (@IdEstancia, @DiasEstancia, @CentroId, @MascotaId, @CuidadorId, @EstacionId);

        -- Registrar brazalete
        INSERT INTO BRAZALETE
        (BRAZALETE_ID, MEDICAMENTO, CUIDADOS, TIPO_ALIMENTACION, CANTIDAD_COMIDA, ESTADO, MASCOTA_ID)
        VALUES
        (@BrazaleteId, @Medicamento, @Cuidados, @TipoAlimentacion, @CantidadComida, @Estado, @MascotaId
        );
		
		COMMIT TRANSACTION;
		PRINT 'Mascota, estancia y brazalete registrados correctamente';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
		PRINT 'Error al registrar la mascota';
		THROW;
    END CATCH
END;
GO



--- 6. Cancelar una venta en línea (no olvide actualizar el stock y la regla de negocio)
CREATE PROCEDURE SP_CANCELAR_VENTA_LINEA
    @VENTA_ID NUMERIC(10,0)
AS
BEGIN
    DECLARE @TARIFA NUMERIC(10,2);

    /* Se verifica que exista la venta en línea */
    IF NOT EXISTS(SELECT * FROM VENTA
    WHERE VENTA_ID = @VENTA_ID AND TIPO = 'L')
    BEGIN
        PRINT 'La venta en linea no existe';
        RETURN;
    END

    /* Se verifica que no esté cancelada */
    IF EXISTS(SELECT * FROM LINEA
    WHERE VENTA_ID = @VENTA_ID AND ESTADO_ID = 4)
    BEGIN
        PRINT 'La venta ya se encuentra cancelada';
        RETURN;
    END

    /* Calcular tarifa de cancelación (CS15) */
    SELECT @TARIFA = ISNULL(SUM(COSTO_TOTAL),0) * 0.20
    FROM CARRITO_LINEA
    WHERE VENTA_ID = @VENTA_ID;
    BEGIN TRANSACTION;
        /* Regresar productos al inventario */
		UPDATE I
        SET I.EXISTENCIAS = I.EXISTENCIAS + C.CANTIDAD
        FROM INV_CENTRO_REGIONAL I
        INNER JOIN CARRITO_LINEA C
        ON I.INV_CRETRO_REGIONAL_ID = C.INV_CRETRO_REGIONAL_ID
        WHERE C.VENTA_ID = @VENTA_ID;

        /* Actualizar estado y tarifa */
        UPDATE LINEA
        SET TARIFA_CANCELACION = @TARIFA, ESTADO_ID = 4
        WHERE VENTA_ID = @VENTA_ID;
    COMMIT TRANSACTION;
    PRINT 'Venta cancelada correctamente';
END
GO


--- 8. Registrar productos en un carrito

CREATE PROCEDURE SP_AGREGAR_PRODUCTO_CARRITO( 
  @VENTA_ID NUMERIC(10,0),
  @INVENTARIO_ID NUMERIC(10,0),
  @CANTIDAD NUMERIC(5,0))
AS
BEGIN
    DECLARE @PRECIO NUMERIC(10,2);
    DECLARE @EXISTENCIAS NUMERIC(5,0);

    /* ===== VENTA EN LINEA ===== */
    IF EXISTS (SELECT * FROM LINEA WHERE VENTA_ID = @VENTA_ID)
    BEGIN
        SELECT @EXISTENCIAS = I.EXISTENCIAS, @PRECIO = P.COSTO
        FROM INV_CENTRO_REGIONAL I
        INNER JOIN PRODUCTO P
        ON P.PRODUCTO_ID = I.PRODUCTO_ID
        WHERE I.INV_CRETRO_REGIONAL_ID = @INVENTARIO_ID;

        IF @EXISTENCIAS < @CANTIDAD
        BEGIN
            PRINT 'Existencias insuficientes';
            RETURN;
        END

		/*Verifica si el producto está en el carrito*/
        IF EXISTS (SELECT * FROM CARRITO_LINEA WHERE VENTA_ID = @VENTA_ID
        AND INV_CRETRO_REGIONAL_ID = @INVENTARIO_ID)
        BEGIN
            UPDATE CARRITO_LINEA
            SET CANTIDAD = CANTIDAD + @CANTIDAD, COSTO_TOTAL = @PRECIO * (CANTIDAD + @CANTIDAD)
            WHERE VENTA_ID = @VENTA_ID AND INV_CRETRO_REGIONAL_ID = @INVENTARIO_ID;
        END

		/*Si el producto no existe en el carrito*/
        ELSE
        BEGIN
            INSERT INTO CARRITO_LINEA(VENTA_ID, INV_CRETRO_REGIONAL_ID, CANTIDAD, COSTO_TOTAL)
            VALUES (@VENTA_ID, @INVENTARIO_ID, @CANTIDAD, @PRECIO * @CANTIDAD);
        END

		/*Actualiza las existencias*/
        UPDATE INV_CENTRO_REGIONAL
        SET EXISTENCIAS = EXISTENCIAS - @CANTIDAD
        WHERE INV_CRETRO_REGIONAL_ID = @INVENTARIO_ID;
		PRINT 'Producto agregado al carrito en linea';
        RETURN;
    END

    /* ===== VENTA FISICA ===== */
    IF EXISTS (SELECT * FROM FISICA WHERE VENTA_ID = @VENTA_ID)
    BEGIN
        SELECT @EXISTENCIAS = I.EXISTENCIAS, @PRECIO = P.COSTO
        FROM INV_CENTRO_NORMAL I
        INNER JOIN PRODUCTO P
        ON P.PRODUCTO_ID = I.PRODUCTO_ID
        WHERE I.INV_CRETRO_NORMAL_ID = @INVENTARIO_ID;

        IF @EXISTENCIAS < @CANTIDAD
        BEGIN
            PRINT 'Existencias insuficientes';
            RETURN;
        END

        IF EXISTS (SELECT * FROM CARRITO_FISICO WHERE VENTA_ID = @VENTA_ID 
		AND INV_CRETRO_NORMAL_ID = @INVENTARIO_ID)
        BEGIN
            UPDATE CARRITO_FISICO
            SET CANTIDAD = CANTIDAD + @CANTIDAD, COSTO_TOTAL = @PRECIO * (CANTIDAD + @CANTIDAD)
            WHERE VENTA_ID = @VENTA_ID AND INV_CRETRO_NORMAL_ID = @INVENTARIO_ID;
        END
        ELSE
        BEGIN
            INSERT INTO CARRITO_FISICO(VENTA_ID, INV_CRETRO_NORMAL_ID, CANTIDAD, COSTO_TOTAL)
            VALUES(@VENTA_ID, @INVENTARIO_ID, @CANTIDAD, @PRECIO * @CANTIDAD);
		END

        UPDATE INV_CENTRO_NORMAL
        SET EXISTENCIAS = EXISTENCIAS - @CANTIDAD
        WHERE INV_CRETRO_NORMAL_ID = @INVENTARIO_ID;
        PRINT 'Producto agregado al carrito fisico';
        RETURN;
    END
    PRINT 'La venta no existe';
END
GO