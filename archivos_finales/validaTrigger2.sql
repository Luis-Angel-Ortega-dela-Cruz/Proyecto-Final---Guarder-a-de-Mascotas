--AUTORES: Ortega de la Cruz Luis Angel 
--		   Quezada Yépez Leonardo André 
--		   Rodríguez Ruiz Diana Carolina
--FECHA: 30/05/2026
--DESCRIPCIÓN: Se incluyen la pruebas necesarias para validar el trigger 2
--TRIGGER 2: Permite actualizar el precio de un venta, sumando el precio de los productos incluidos en el carrito

use [guarderia_mascotas]
go

begin transaction
	--Cliente sin compras físicas
	select c.NOMBRE, v.VENTA_ID, v.TIPO
	from CLIENTE c
	left join VENTA v
	on v.CLIENTE_ID = c.CLIENTE_ID
	where c.CLIENTE_ID = 20;

	--Revisión del inventario 
	select inv.CENTRO_ID, inv.PRODUCTO_ID, inv.EXISTENCIAS
	from INV_CENTRO_NORMAL inv
	left join PRODUCTO p
	on inv.PRODUCTO_ID = p.PRODUCTO_ID
	where inv.CENTRO_ID = (select CENTRO_ID from INV_CENTRO_NORMAL 
							where INV_CRETRO_NORMAL_ID = 3); 

	--Ingreso de venta física y 3 productos
	declare @venta_generada numeric(10,0);

	exec SP_REGISTRAR_VENTA_FISICA
		@cliente_id = 20,
		@id_encargado_tienda = 1009,
		@comision = 0,
		@inventario_id = 3,
		@cantidad = 2,
		@venta_id = @venta_generada output;

	exec SP_AGREGAR_PRODUCTO_CARRITO
		@VENTA_ID = @venta_generada,
		@INVENTARIO_ID = 5,
		@CANTIDAD = 1;

	exec SP_AGREGAR_PRODUCTO_CARRITO
		@VENTA_ID = @venta_generada,
		@INVENTARIO_ID = 7,
		@CANTIDAD = 3;

	--Resultado posterior a la venta física
	select c.NOMBRE as nombre_cliente,v.VENTA_ID,v.TIPO as tipo_venta,v.COSTO as costo_venta, 
	 cf.CANTIDAD as cantidad_producto, cf.COSTO_TOTAL as costo_por_productos, icn.PRODUCTO_ID, icn.INV_CRETRO_NORMAL_ID,  icn.EXISTENCIAS, v.FECHA
	from CLIENTE c
	left join VENTA v
	on v.CLIENTE_ID = c.CLIENTE_ID
	left join CARRITO_FISICO cf
	on cf.VENTA_ID = v.VENTA_ID
	left join INV_CENTRO_NORMAL icn
	on cf.INV_CRETRO_NORMAL_ID = icn.INV_CRETRO_NORMAL_ID
	where c.CLIENTE_ID = 20 
	and v.TIPO = 'F' ; 

rollback transaction;