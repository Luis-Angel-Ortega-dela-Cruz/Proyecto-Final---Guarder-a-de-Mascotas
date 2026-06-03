--AUTORES: Ortega de la Cruz Luis Angel 
--		   Quezada Yépez Leonardo André 
--		   Rodríguez Ruiz Diana Carolina
--FECHA: 30/05/2026
--DESCRIPCIÓN: Se incluyen la pruebas necesarias para validar el trigger 6
--TRIGGER 6: Permite actualizar el precio de un venta en linea, sumando el precio de los productos incluidos en el carrito

use [guarderia_mascotas]
go

begin transaction

	--Ventas en linea de cliente 16
	select * from CLIENTE c
	left join VENTA l
	on l.CLIENTE_ID = c.CLIENTE_ID
	where C.CLIENTE_ID=16;

	--Insertar venta en linea
	declare @venta_generada numeric(10,0);

	--Inventario centro regional, permite ver que las existencias disminuyeron
	select * from INV_CENTRO_REGIONAL;

	exec SP_REGISTRAR_VENTA_LINEA
		@cliente_id = 16,
		@estado_id = 1,
		@tarifa_cancelacion = null,
		@inventario_id = 2,
		@cantidad = 3,
		@venta_id = @venta_generada output;

	exec SP_AGREGAR_PRODUCTO_CARRITO
		@VENTA_ID = @venta_generada,
		@INVENTARIO_ID = 4,
		@CANTIDAD = 2;

	--Verificar que se haya creado la venta en línea
	select * from CLIENTE c
	left join VENTA l
	on l.CLIENTE_ID = c.CLIENTE_ID
	where C.CLIENTE_ID=16;

	--Verificar que se actualizó el stock
	select * from INV_CENTRO_REGIONAL;
	GO

rollback transaction;

