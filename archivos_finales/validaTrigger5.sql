--AUTORES: Ortega de la Cruz Luis Angel 
--		   Quezada Yépez Leonardo André 
--		   Rodríguez Ruiz Diana Carolina
--FECHA: 30/05/2026
--DESCRIPCIÓN: Se incluyen la pruebas necesarias para validar el trigger 5
--TRIGGER 5: Actualiza la comision de una venta física y suma dicha comision al sueldo del encargado de 
--la tienda que hizo la venta.

use [guarderia_mascotas]
go

begin transaction 

	declare @venta_generada numeric(10,0);

	--Sueldo original
	select sueldo as sueldo_original from EMPLEADO
	where EMPLEADO_id = 1009;

	--Creación de venta física
	exec SP_REGISTRAR_VENTA_FISICA
		@cliente_id = 13,
		@id_encargado_tienda = 1009,
		@comision = 0,
		@inventario_id = 3,
		@cantidad = 2,
		@venta_id = @venta_generada output;

	exec SP_AGREGAR_PRODUCTO_CARRITO
		@VENTA_ID = @venta_generada,
		@INVENTARIO_ID = 5,
		@CANTIDAD = 1;

	--Comision resultante
	select venta_id, comision from FISICA
	where VENTA_ID = @venta_generada;

	--Nuevo sueldo
	select sueldo from EMPLEADO
	where EMPLEADO_id = 1009;

	--Confirmar que se hizo compra
	select * 
	from CLIENTE c
	left join venta v
	on c.CLIENTE_ID = v.CLIENTE_ID
	where c.CLIENTE_ID = 13;

rollback transaction;