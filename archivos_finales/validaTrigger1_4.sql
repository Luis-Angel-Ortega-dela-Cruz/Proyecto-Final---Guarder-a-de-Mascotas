--AUTORES: Ortega de la Cruz Luis Angel 
--		   Quezada Yépez Leonardo André 
--		   Rodríguez Ruiz Diana Carolina
--FECHA: 30/05/2026
--DESCRIPCIÓN: Se incluyen la pruebas necesarias para validar el trigger 1 y 4
--TRIGGER 1
--Permite actualizar el precio de una consulta, sumando el precio de los medicamentos
--incluidos en cada consulta.
--TRIGGER 4
---Controla el inventario de medicamentos al registrar una consulta.
-- Valida que haya suficiente stock antes de recetar y descuenta
-- automáticamente la cantidad del inventario del centro.

use [guarderia_mascotas]
go


---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION: Valida el funcionamiento del trigger tr_actualiza_costo_consulta 
---------------------------

begin transaction;


DECLARE @id_consulta numeric(10,0);

	--Consultas antes de crear una nueva
	select * from CONSULTA;

	--Inventario de medicamentos
	select * from INVENTARIO_MEDICO;

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

rollback transaction;

