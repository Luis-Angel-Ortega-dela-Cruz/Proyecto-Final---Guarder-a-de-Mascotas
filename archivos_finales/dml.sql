--AUTORES: Ortega de la Cruz Luis Angel 
--		   Quezada Yépez Leonardo André 
--		   Rodríguez Ruiz Diana Carolina
--FECHA: 30/05/2026
--DESCRIPCIÓN: Creación de triggers, procedimientos almacenados, funciones y vistas solicitadas.
--				Las pruebas son realizadas en trigger.sql


use [guarderia_mascotas]
go


---------------------------------------------------------------
--VISTAS
---------------------------------------------------------------

/*
VISTA 1
Muestra mascotas junto con la informacion de su dueño.
*/

CREATE VIEW vw_MascotasClientes AS
SELECT m.MASCOTA_ID, m.NOMBRE AS NOMBRE_MASCOTA, r.NOMBRE AS RAZA, e.NOMBRE AS ESPECIE, c.CLIENTE_ID,
c.NOMBRE + ' ' + c.AP_PAT + ' ' + c.AP_MAT AS PROPIETARIO, c.CORREO, c.DOMICILIO

FROM MASCOTA m
INNER JOIN CLIENTE c
ON m.CLIENTE_ID = c.CLIENTE_ID
INNER JOIN RAZA r
ON m.RAZA_ID = r.RAZA_ID
INNER JOIN ESPECIE e
ON r.ESPECIE_ID = e.ESPECIE_ID;

GO

---ejecutar VISTA
SELECT * FROM vw_MascotasClientes;


/*
VISTA 2
Consulta a la veterinaria con mascota y su veterinario.
*/

CREATE VIEW vw_ConsultasVeterinarias AS
SELECT co.CONSULTA_ID, co.FECHA, co.DIAGNOSTICO, co.DETALLES, co.COSTO,
m.NOMBRE AS MASCOTA, emp.NOMBRE + ' ' + emp.AP_PAT + ' ' + emp.AP_MAT AS VETERINARIO

FROM CONSULTA co
INNER JOIN MASCOTA m
ON co.MASCOTA_ID = m.MASCOTA_ID
INNER JOIN EMPLEADO emp
ON co.EMPLEADO_ID = emp.EMPLEADO_ID;
GO

---EJECUTAR VISTA
SELECT * FROM vw_ConsultasVeterinarias;



/*
VISTA 3
Informacion completa de las estancias en guarderia.
*/

CREATE VIEW vw_EstanciasGuarderia AS
SELECT es.ID_ESTANCIA, es.FECHA_INICIO, es.FECHA_FIN, es.DIAS_ESTANCIA, es.COSTO, m.NOMBRE AS MASCOTA, 
cli.NOMBRE + ' ' + cli.AP_PAT + ' ' + cli.AP_MAT AS PROPIETARIO, c.NOMBRE AS CENTRO,
emp.NOMBRE + ' ' + emp.AP_PAT + ' ' + emp.AP_MAT AS CUIDADOR

FROM ESTANCIA es
INNER JOIN MASCOTA m
ON es.MASCOTA_ID = m.MASCOTA_ID
INNER JOIN CLIENTE cli
ON m.CLIENTE_ID = cli.CLIENTE_ID
INNER JOIN CENTRO c
ON es.CENTRO_ID = c.CENTRO_ID
INNER JOIN EMPLEADO emp
ON es.ID_CUIDADOR = emp.EMPLEADO_ID;
GO

---EJECUTAR VISTA
SELECT * FROM vw_EstanciasGuarderia;

---------------------------------------------------------------
--TRIGGERS
---------------------------------------------------------------

--TRIGGER 1
--Permite actualizar el precio de una consulta, sumando el precio de los medicamentos
--incluidos en cada consulta.

create trigger tr_actualiza_costo_consulta
on ventas.INV_MED_CONSULTA
after insert
as
begin
    update CONSULTA
    set COSTO = 350 + q.total_medicamentos
    from CONSULTA c
    inner join (
        select imc.CONSULTA_ID, sum(imc.COSTO_TOTAL) as total_medicamentos
        from INV_MED_CONSULTA imc
        where imc.CONSULTA_ID in (select CONSULTA_ID
									from inserted)
        group by imc.CONSULTA_ID) q
        on q.CONSULTA_ID = c.CONSULTA_ID;
end;
go

--TRIGGER 2
--Permite actualizar el precio de un venta, sumando el precio de los productos incluidos en el carrito
create trigger tr_actualiza_costo_venta_fisica
on ventas.CARRITO_FISICO
after insert, update, delete
as
begin
    
    update VENTA
    set COSTO = isnull(q.total_productos, 0)
    from VENTA v
    left join (
        select VENTA_ID, sum(COSTO_TOTAL) as total_productos
        from CARRITO_FISICO
        group by VENTA_ID) q
    on q.VENTA_ID = v.VENTA_ID
    where v.VENTA_ID in (
        select VENTA_ID from inserted
        union
        select VENTA_ID from deleted
    );
end;
go

--TRIGGER 3
--Trigger que valida que un cuidador no tenga más de 5 mascotas asignadas en una misma fecha. 

CREATE OR ALTER TRIGGER trg_ValidarLimiteCuidador
ON operacion.ESTANCIA
AFTER INSERT, UPDATE
AS
BEGIN    
    -- Verificar solo si se modificó el ID_CUIDADOR o FECHA_INICIO
    IF UPDATE(ID_CUIDADOR) OR UPDATE(FECHA_INICIO)
    BEGIN
        IF EXISTS (SELECT 1 FROM 
		(
                -- Contar mascotas por cuidador en cada fecha
                SELECT e.ID_CUIDADOR, CAST(e.FECHA_INICIO AS DATE) AS FECHA, COUNT(*) AS TOTAL_MASCOTAS
                FROM ESTANCIA e
                WHERE e.ID_CUIDADOR IN (SELECT ID_CUIDADOR FROM inserted)
                GROUP BY e.ID_CUIDADOR, CAST(e.FECHA_INICIO AS DATE)
            ) AS Conteo
            WHERE Conteo.TOTAL_MASCOTAS > 5
        )
        BEGIN
            RAISERROR('ERROR: Un cuidador no puede tener más de 5 mascotas asignadas en un mismo día.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
    END
END;
GO

--TRIGGER 4
---Controla el inventario de medicamentos al registrar una consulta.
-- Valida que haya suficiente stock antes de recetar y descuenta
-- automáticamente la cantidad del inventario del centro.
CREATE TRIGGER tr_ActualizarInventarioMedicoConsulta
ON ventas.INV_MED_CONSULTA
AFTER INSERT
AS
BEGIN
    
    IF EXISTS (SELECT 1
        FROM INVENTARIO_MEDICO im
        JOIN inserted ins ON im.INV_MED_ID = ins.INV_MED_ID
        WHERE im.CANTIDAD < ins.CANTIDAD
    )
    BEGIN
        RAISERROR ('No hay suficiente stock de este medicamento en el inventario del centro.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    UPDATE im
    SET im.CANTIDAD = im.CANTIDAD - ins.CANTIDAD
    FROM INVENTARIO_MEDICO im
    JOIN inserted ins ON im.INV_MED_ID = ins.INV_MED_ID;
END;
GO

--TRIGGER 5
--Actualiza la comision de una venta física y suma dicha comision al sueldo del encargado de 
--la tienda que hizo la venta.
create trigger TR_ACTUALIZA_COMISION_VENTA_FISICA
on ventas.VENTA
after update
as
begin
    update e
    set e.SUELDO = e.SUELDO + ((i.COSTO * 0.15) - f.COMISION)
    from EMPLEADO e
    inner join FISICA f
        on f.ID_ENCARGADO_TIENDA = e.EMPLEADO_ID
    inner join inserted i
        on i.VENTA_ID = f.VENTA_ID
    inner join deleted d
        on d.VENTA_ID = i.VENTA_ID
    where i.TIPO = 'F'
      and i.COSTO <> d.COSTO;

    update f
    set f.COMISION = i.COSTO * 0.15
    from FISICA f
    inner join inserted i
        on i.VENTA_ID = f.VENTA_ID
    inner join deleted d
        on d.VENTA_ID = i.VENTA_ID
    where i.TIPO = 'F'
      and i.COSTO <> d.COSTO;
end;
go


--TRIGGER 6
--Permite actualizar el precio de un venta en linea, sumando el precio de los productos incluidos en el carrito
create trigger TR_ACTUALIZA_COSTO_VENTA_LINEA
on ventas.CARRITO_LINEA
after insert, update, delete
as
begin
   
    update v
    set v.COSTO = isnull(q.TOTAL_PRODUCTOS, 0)
    from VENTA v
    left join (
        select VENTA_ID, sum(COSTO_TOTAL) as TOTAL_PRODUCTOS
        from CARRITO_LINEA
        group by VENTA_ID) q
    on q.VENTA_ID = v.VENTA_ID
    where v.VENTA_ID in (
        select VENTA_ID from inserted
        union
        select VENTA_ID from deleted
    );
end;
go


--TRIGGER 7
--Permite que estancia solo mantenga la estancia actual de una mascota en un determinado centro. El histórico es pasado a
--Historico_estancia
create trigger TR_ESTANCIA_ACTUAL_HISTORICO
on operacion.ESTANCIA
instead of insert
as
begin
    -- evita que en el mismo insert venga repetida la misma mascota en el mismo centro
    if exists (
        select 1
        from inserted
        group by MASCOTA_ID, CENTRO_ID
        having count(*) > 1
    )
    begin
        throw 56001, 'No se puede registrar la misma mascota más de una vez en el mismo centro dentro del mismo insert.', 1;
    end;

    -- primero manda al histórico la estancia actual si ya existe esa mascota en ese centro
    insert into HISTORICO_ESTANCIA(HISTRICIO_ESTANCIA_ID, COSTO, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, 
	  ESTACION_ID, FECHA_INICIO, FECHA_FIN, DIAS_ESTANCIA, ID_ESTANCIA)
    select 
        next value for seq_historico_estancia,
        e.COSTO,
        e.CENTRO_ID,
        e.MASCOTA_ID,
        e.ID_CUIDADOR,
        e.ESTACION_ID,
        cast(e.FECHA_INICIO as date),
        cast(e.FECHA_FIN as date),
        e.DIAS_ESTANCIA,
        e.ID_ESTANCIA
    from ESTANCIA e
    inner join inserted i
        on i.MASCOTA_ID = e.MASCOTA_ID
       and i.CENTRO_ID = e.CENTRO_ID;

    -- actualiza la estancia actual con los nuevos datos
    update e
    set e.FECHA_INICIO = isnull(i.FECHA_INICIO, getdate()),
        e.DIAS_ESTANCIA = i.DIAS_ESTANCIA,
        e.ID_CUIDADOR = i.ID_CUIDADOR,
        e.ESTACION_ID = i.ESTACION_ID
    from ESTANCIA e
    inner join inserted i
        on i.MASCOTA_ID = e.MASCOTA_ID
       and i.CENTRO_ID = e.CENTRO_ID;


    -- inserta normalmente las mascotas que no tenían estancia actual en ese centro
    insert into ESTANCIA(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
    select 
        i.ID_ESTANCIA,
        isnull(i.FECHA_INICIO, getdate()),
        i.DIAS_ESTANCIA,
        i.CENTRO_ID,
        i.MASCOTA_ID,
        i.ID_CUIDADOR,
        i.ESTACION_ID
    from inserted i
    where not exists (
        select 1
        from ESTANCIA e
        where e.MASCOTA_ID = i.MASCOTA_ID
          and e.CENTRO_ID = i.CENTRO_ID
    );

end;
go
---------------------------------------------------------------
--PROCEDIMIENTOS ALMACENADOS
---------------------------------------------------------------

--PROCEDIMIENTO ALMACENADO 1
--Registra una mascota (su estancia) y su brazalete.
CREATE PROCEDURE sp_RegistrarMascotaEstanciaBrazalete
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


--PROCEDIMIENTO ALMACENADO 4
--Permite incluir mediacamentos recetados para cada consulta, y actuliza el stock de los
--medicamentos utilizados
create procedure sp_registra_medicamento_consulta
(
    @consulta_id numeric(10,0),
    @medicamento_id numeric(10,0),
    @centro_id numeric(5,0),
    @cantidad numeric(3,0)
)
as
begin

    declare @inv_med_id numeric(10,0),
	  @stock_actual numeric(5,0),
      @costo_unitario numeric(10,2),
      @costo_total numeric(10,2);

    begin try
        begin transaction;

        -- Validar que la consulta exista
        if not exists ( select 1 from CONSULTA
                         where CONSULTA_ID = @consulta_id)
        begin
            throw 50001, 'La consulta indicada no existe.', 1;
        end;

        -- Validar cantidad
        if @cantidad <= 0
        begin
            throw 50002, 'La cantidad debe ser mayor a cero.', 1;
        end;

        -- Buscar inventario del medicamento en el centro
        select 
            @inv_med_id = im.INV_MED_ID,
            @stock_actual = im.CANTIDAD,
            @costo_unitario = m.COSTO
        from INVENTARIO_MEDICO im
        join MEDICAMENTO m
            on m.MEDICAMENTO_ID = im.MEDICAMENTO_ID
        where im.MEDICAMENTO_ID = @medicamento_id
          and im.CENTRO_ID = @centro_id;

        -- Validar que exista en inventario
        if @inv_med_id is null
        begin
            throw 50003, 'El medicamento no existe en el inventario del centro indicado.', 1;
        end;

        -- Validar stock
        if @stock_actual < @cantidad
        begin
            throw 50004, 'No hay stock suficiente del medicamento indicado.', 1;
        end;

        set @costo_total = @cantidad * @costo_unitario;

        -- Validar si ese medicamento ya fue registrado en la consulta
        if exists ( select 1 from INV_MED_CONSULTA
                    where INV_MED_ID = @inv_med_id
                    and CONSULTA_ID = @consulta_id)
        begin
            throw 50005, 'Ese medicamento ya fue registrado en esta consulta.', 1;
        end;

        -- Registrar medicamento vendido en la consulta
        insert into INV_MED_CONSULTA (INV_MED_ID, CONSULTA_ID, CANTIDAD, COSTO_TOTAL)
        values( @inv_med_id, @consulta_id, @cantidad, @costo_total);

        -- Actualiza el stock
        update INVENTARIO_MEDICO
        set cantidad = cantidad - @cantidad
        where INV_MED_ID = @inv_med_id;

        commit transaction;
    end try
    begin catch
        rollback transaction;

        throw;
    end catch;
end;
GO

---PROCEDIMIENTO ALMACENADO 3
--Permite registrar lista de medicamentos y consulta, actualizando stock para los médicamentos 
-- incluidos en la consulta

create procedure sp_registra_consulta_tratamiento
(
    @diagnostico varchar(400),
    @tratamiento varchar(400) = null,
    @empleado_id numeric(10,0),
    @mascota_id numeric(10,0),

    @centro_id numeric(5,0) = null,
    @medicamento_id numeric(10,0) = null,
    @cantidad numeric(3,0) = null,

    @consulta_id numeric(10,0) output
)
as
begin
    begin try
        begin transaction;

        -- validar que exista el veterinario
        if not exists (select 1 from VETERINARIO
                       where EMPLEADO_ID = @empleado_id)
        begin
            throw 51001, 'El veterinario indicado no existe.', 1;
        end;

        -- validar que exista la mascota
        if not exists (select 1 from MASCOTA 
		               where MASCOTA_ID = @mascota_id)
        begin
            throw 51002, 'La mascota indicada no existe.', 1;
        end;

        -- Siguiente id de consulta
        set @consulta_id = next value for seq_consulta;

        insert into CONSULTA(CONSULTA_ID, DIAGNOSTICO, FECHA, DETALLES, EMPLEADO_ID, MASCOTA_ID)
        values(@consulta_id, @diagnostico, getdate(), isnull(nullif(@tratamiento, ''),'Sin tratamiento indicado'), 
		  @empleado_id, @mascota_id);

        -- si hay medicamento, se llama al procedimiento que registra el medicamento y actualiza el stock
        if @centro_id is not null
           and @medicamento_id is not null
           and @cantidad is not null
        begin
            exec sp_registra_medicamento_consulta
                @consulta_id = @consulta_id,
                @medicamento_id = @medicamento_id,
                @centro_id = @centro_id,
                @cantidad = @cantidad;
        end;

        commit transaction;
    end try
    begin catch

        rollback transaction;

        throw;
    end catch;
end;
go

---PROCEDIMIENTO ALMACENADO 6
---Cancelar una venta en línea (no olvide actualizar el stock y la regla de negocio)
CREATE PROCEDURE SP_CANCELAR_VENTA_LINEA
    @VENTA_ID NUMERIC(10,0)
AS
BEGIN
    DECLARE @TARIFA NUMERIC(10,2);

    -- Se verifica que exista la venta en línea 
    IF NOT EXISTS(SELECT * FROM VENTA
    WHERE VENTA_ID = @VENTA_ID AND TIPO = 'L')
    BEGIN
        PRINT 'La venta en linea no existe';
        RETURN;
    END

    --Se verifica que no esté cancelada
    IF EXISTS(SELECT * FROM LINEA
    WHERE VENTA_ID = @VENTA_ID AND ESTADO_ID = 4)
    BEGIN
        PRINT 'La venta ya se encuentra cancelada';
        RETURN;
    END

    -- Calcular tarifa de cancelación (CS15)
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

--PROCEDIMIENTO ALMACENADO 8
--Registrar productos en un carrito

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

---PROCEDIMIENTO ALMACENADO 5
--Registrar una venta física, incluyendo sus productos incluyendo la actualización del stock
--Para esto, reutiliza el procedimiento almacenado 8.
create or alter procedure sp_registrar_venta_fisica
(
    @cliente_id numeric(10,0),
    @id_encargado_tienda numeric(10,0),
    @comision numeric(10,2),

    @inventario_id numeric(10,0),
    @cantidad numeric(5,0),

    @venta_id numeric(10,0) output
)
as
begin

    begin try
        begin transaction;

        -- validar cliente
        if not exists ( select 1 from CLIENTE
                        where CLIENTE_ID = @cliente_id)
        begin
            throw 53001, 'El cliente indicado no existe.', 1;
        end;

        -- Determina si existe el encargado de la tienda
        if not exists (select 1 from ENCARGADOR_TIENDA
						where EMPLEADO_ID = @id_encargado_tienda)
        begin
            throw 53002, 'El encargado de tienda indicado no existe.', 1;
        end;

        --Registro de venta en tabla VENTA
        insert into VENTA(TIPO, COSTO, FECHA, CLIENTE_ID)
        values('F', 0, getdate(), @cliente_id);

        set @venta_id = scope_identity();

        --Registro en tabla VENTA_FISICA
        insert into FISICA(VENTA_ID, COMISION, ID_ENCARGADO_TIENDA)
        values(@venta_id, @comision, @id_encargado_tienda);

        --Agrega producto al carrito físico y actualizar stock
        exec SP_AGREGAR_PRODUCTO_CARRITO
            @VENTA_ID = @venta_id,
            @INVENTARIO_ID = @inventario_id,
            @CANTIDAD = @cantidad;

        commit transaction;
    end try
    begin catch
        
        rollback transaction;
        throw;
    end catch;
end;
go

--PROCEDIMIENTO ALMACENADO 7
--Borrar usuario por nombre de usuario 

CREATE PROCEDURE pusuBorrarUsuario
    @Usuario VARCHAR(40)
AS
BEGIN
    BEGIN TRY
        DELETE FROM CLIENTE
        WHERE USUARIO = @Usuario;

        PRINT 'Usuario eliminado correctamente';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

---PROCEDIMIENTO ALMACENADO 9
--Actualizar carrito y stock, en este caso físico
CREATE OR ALTER PROCEDURE SP_ACTUALIZAR_CARRITO_STOCK
    @ID_CARRITO INT,
    @CANTIDAD INT,
    @PRODUCTO_ID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validamos el stock
    IF NOT EXISTS (
        SELECT 1
        FROM PRODUCTO
        WHERE PRODUCTO_ID = @PRODUCTO_ID
          AND STOCK >= @CANTIDAD
    )
    BEGIN
        PRINT 'No hay suficiente stock';
        RETURN;
    END

    -- Se actualiza el carrito fisico
    IF EXISTS (
        SELECT 1 FROM CARRITO_FISICO WHERE ID_CARRITO = @ID_CARRITO
    )
    BEGIN
        UPDATE CARRITO_FISICO
        SET CANTIDAD = @CANTIDAD
        WHERE ID_CARRITO = @ID_CARRITO;
    END

    -- Se actualiza el carrito en linea
    ELSE IF EXISTS (
        SELECT 1 FROM CARRITO_EN_LINEA WHERE ID_CARRITO = @ID_CARRITO
    )
    BEGIN
        UPDATE CARRITO_EN_LINEA
        SET CANTIDAD = @CANTIDAD
        WHERE ID_CARRITO = @ID_CARRITO;
    END

    -- Se descuenta el stock
    UPDATE PRODUCTO
    SET STOCK = STOCK - @CANTIDAD
    WHERE PRODUCTO_ID = @PRODUCTO_ID;

    PRINT 'Carrito y stock actualizados correctamente';
END;
GO


--PROCEDIMIENTO ALMACENADO 10
--Registrar una venta en línea. Emplea el procedimiento almacenado 8 para el manejo de productos en el carrito

create procedure SP_REGISTRAR_VENTA_LINEA
(
    @cliente_id numeric(10,0),
    @estado_id numeric(3,0),
    @tarifa_cancelacion numeric(10,2) = null,

    @inventario_id numeric(10,0),
    @cantidad numeric(5,0),

    @venta_id numeric(10,0) output
)
as
begin
    
    begin try
        begin transaction;

        if not exists (select 1 from CLIENTE
						where CLIENTE_ID = @cliente_id)
        begin
            throw 54001, 'El cliente indicado no existe.', 1;
        end;

        if not exists (
            select 1
            from ESTADO_VENTA
            where ESTADO_ID = @estado_id
        )
        begin
            throw 54002, 'El estado de venta indicado no existe.', 1;
        end;

        if @cantidad <= 0
        begin
            throw 54003, 'La cantidad debe ser mayor a cero.', 1;
        end;

        insert into VENTA(TIPO, COSTO, FECHA, CLIENTE_ID)
        values('L', 0, getdate(), @cliente_id);

        set @venta_id = scope_identity();

        insert into LINEA(VENTA_ID, TARIFA_CANCELACION, ESTADO_ID)
        values(@venta_id, @tarifa_cancelacion, @estado_id);

        exec SP_AGREGAR_PRODUCTO_CARRITO
            @VENTA_ID = @venta_id,
            @INVENTARIO_ID = @inventario_id,
            @CANTIDAD = @cantidad;

        commit transaction;
    end try
    begin catch
        
        rollback transaction;

        throw;
    end catch;
end;
go

--PROCEDIMIENTO ALMACENADO 11
--Borrar el carrito 

CREATE OR ALTER PROCEDURE SP_ELIMINAR_CARRITO
    @ID_CARRITO INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Eliminamos el carrito fisico
    IF EXISTS (
        SELECT 1 FROM CARRITO_FISICO WHERE ID_CARRITO = @ID_CARRITO
    )
    BEGIN
        DELETE FROM CARRITO_FISICO
        WHERE @ID_CARRITO = @ID_CARRITO;

        PRINT 'El carrito físico fue eliminado';
        RETURN;
    END

    -- Eliminamos el carrito en line
    IF EXISTS (
        SELECT 1 FROM CARRITO_LINEA WHERE ID_CARRITO = @ID_CARRITO
    )
    BEGIN
        DELETE FROM CARRITO_LINEA
        WHERE ID_CARRITO = @ID_CARRITO;

        PRINT 'El carrito en línea  fue eliminado';
        RETURN;
    END

    PRINT 'No se encontró el carrito';
END;
GO

--PROCEDIMIENTO ALMACENADO 12
--Buscador de productos usando like

CREATE PROCEDURE pusuBuscarProducto
    @Nombre VARCHAR(40)
AS
BEGIN
    SELECT
        PRODUCTO_ID,
        NOMBRE,
        COSTO,
        DESCRIPCION
    FROM PRODUCTO
    WHERE NOMBRE LIKE '%' + @Nombre + '%';
END
GO
