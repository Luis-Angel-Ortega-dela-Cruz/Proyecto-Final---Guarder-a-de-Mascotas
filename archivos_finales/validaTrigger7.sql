--AUTORES: Ortega de la Cruz Luis Angel 
--		   Quezada Yépez Leonardo André 
--		   Rodríguez Ruiz Diana Carolina
--FECHA: 30/05/2026
--DESCRIPCIÓN: Se incluyen la pruebas necesarias para validar el trigger 7
--TRIGGER 7: Permite que estancia solo mantenga la estancia actual de una mascota en un determinado centro. El histórico es pasado a
--Historico_estancia

use [guarderia_mascotas]
go


begin transaction 

	--Registro anterior actual en estancia
	select * from ESTANCIA where MASCOTA_ID = 1;
	--Registro anterior de historico_estancia
	select * from HISTORICO_ESTANCIA where MASCOTA_ID = 1;

	--Ingresamos una nueva instancia para una mascota que ya tenía una estancia
	insert into ESTANCIA(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
	values(30, getdate(), 5, 1, 1, 1007, 1);

	--Nuevo registro estancia actual
	select * from ESTANCIA where MASCOTA_ID = 1;

	--Nuevo registro estancia historico
	select * from HISTORICO_ESTANCIA where MASCOTA_ID = 1;
rollback transaction