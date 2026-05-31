

use [guarderia_mascotas]
go


---------------------------------------------------------------
--TRIGGERS
---------------------------------------------------------------

--TRIGGER 1
--Permite actualizar el precio de una consulta, sumando el precio de los medicamentos
--incluidos en cada consulta.

create trigger tr_actualiza_costo_consulta
on INV_MED_CONSULTA
after insert
as
begin
    update CONSULTA
    set c.COSTO = 350 + q.total_medicamentos
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
--Trigger que valida que un cuidador no tenga más de 5 mascotas asignadas en una misma fecha. 

CREATE OR ALTER TRIGGER trg_ValidarLimiteCuidador
ON ESTANCIA
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
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


--TRIGGER 3
---Controla el inventario de medicamentos al registrar una consulta.
-- Valida que haya suficiente stock antes de recetar y descuenta
-- automáticamente la cantidad del inventario del centro.
---(ES EL QUE YA HABIA HECHO. AL FINAL LE HICE UNOS CAMBIOS XD, PERO LO PONGO POR SI SIRVE)
CREATE TRIGGER tr_ActualizarInventarioMedicoConsulta
ON INV_MED_CONSULTA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

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

---------------------------------------------------------------
--PROCEDIMIENTOS ALMACENADOS
---------------------------------------------------------------

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

---PROCEDIMIENTO ALMACENADO 3
--Permite registrar lista de medicamentos y consulta, actualizando stock para los médicamentos 
-- incluidos en la consulta