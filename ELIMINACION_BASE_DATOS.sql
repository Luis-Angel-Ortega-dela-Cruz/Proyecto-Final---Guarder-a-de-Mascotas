--- eliminacion base de datos

--PARA BORRAR LA BASE DE DATOS
USE master;
GO

ALTER DATABASE [guarderia_mascotas]
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE [guarderia_mascotas];
GO