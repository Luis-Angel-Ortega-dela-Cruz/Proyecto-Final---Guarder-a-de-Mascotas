---Pruebas para procedimientos almacenados


------------------------------------------------
---Prueba de SP 4
------------------------------------------------
--Nueva consulta para probar:
INSERT INTO CONSULTA (CONSULTA_ID,DIAGNOSTICO, FECHA,DETALLES,EMPLEADO_ID,MASCOTA_ID)
VALUES(NEXT VALUE FOR seq_consulta,'Infección estomacal',GETDATE(),'Se receta medicamento y revisión posterior',1004,2);

--Validar stock actual de medicamento
select * from INVENTARIO_MEDICO where centro_id = 1;
go

--Prueba de la ejecución del sp
EXEC sp_registra_medicamento_consulta
    @consulta_id = 25,
    @medicamento_id = 10,
    @centro_id = 1,
    @cantidad = 3;

--Ver que se actualizo correctamente la consulta
select * from INV_MED_CONSULTA im
right join CONSULTA c on c.CONSULTA_ID = im.CONSULTA_ID
where c.consulta_id = 25;

--Ver que se redujo el stock del medicamento empleado
select * from INVENTARIO_MEDICO where centro_id = 1;
go

------------------------------------------------
---Prueba de SP 3
------------------------------------------------
DECLARE @id_consulta numeric(10,0);

--Permite la creación de la consulta, y de un medicamento para dicha consulta
EXEC sp_registra_consulta_tratamiento
    @diagnostico = 'Infección estomacal',
    @tratamiento = 'Administrar medicamento cada 12 horas durante 5 días.',
    @empleado_id = 1004,
    @mascota_id = 2,
    @centro_id = 1,
    @medicamento_id = 4,
    @cantidad = 2,
    @consulta_id = @id_consulta OUTPUT;

--Para agregar más medicamentos, se empela el procedimeinto almacenado 3 (sp_registra_medicamento_consulta)
EXEC sp_registra_medicamento_consulta
    @consulta_id = @id_consulta,
    @medicamento_id = 5,
    @centro_id = 1,
    @cantidad = 2;

--Permite observar el correcto funcionamiento de los procedimeintos, y el tigger tr_actualiza_costo_consulta
select c.CONSULTA_ID,c.DIAGNOSTICO, c.DETALLES, c.MASCOTA_ID, c.COSTO as costo_consulta, im.CANTIDAD as cantidad_medicamento,
  inv.MEDICAMENTO_ID, im.COSTO_TOTAL as costo_medicamentos, inv.CANTIDAD as cantidad_existencias, 
  inv.CENTRO_ID as centro_inventarioMedico
from CONSULTA c
join INV_MED_CONSULTA im
on c.CONSULTA_ID = im.CONSULTA_ID
join INVENTARIO_MEDICO inv
on im.INV_MED_ID = inv.INV_MED_ID
where c.CONSULTA_ID=@id_consulta;
go

