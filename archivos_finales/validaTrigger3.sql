--AUTORES: Ortega de la Cruz Luis Angel 
--		   Quezada Yépez Leonardo André 
--		   Rodríguez Ruiz Diana Carolina
--FECHA: 30/05/2026
--DESCRIPCIÓN: Se incluyen la pruebas necesarias para validar el trigger 3
--TRIGGER 3: Trigger que valida que un cuidador no tenga más de 5 mascotas asignadas en una misma fecha.


use [guarderia_mascotas]
go

begin transaction

INSERT INTO EMPLEADO VALUES
(1030,'C','Alma','Vega','Morales','VEMA960812MDFGRL00',9,
'Col. Doctores, Ciudad de México',
'avegas','Cuida1234',14500.00);

INSERT INTO CUIDADOR
(EMPLEADO_ID, CUIDADOR_LIDER, EDAD, ESPECIE_ASIGNADA_ID)
VALUES
(1030, null, 34, 1);

declare @fecha_prueba datetime = '2026-06-01';

insert into ESTANCIA(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
values(9001, @fecha_prueba, 3, 9, 1, 1030, 1);

insert into ESTANCIA(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
values(9002, @fecha_prueba, 3, 9, 2, 1030, 1);

insert into ESTANCIA(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
values(9003, @fecha_prueba, 3, 9, 3, 1030, 1);

insert into ESTANCIA(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
values(9004, @fecha_prueba, 3, 9, 4, 1030, 1);

insert into ESTANCIA(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
values(9005, @fecha_prueba, 3, 9, 5, 1030, 1);

select 
    ID_CUIDADOR,
    cast(FECHA_INICIO as date) as FECHA,
    count(*) as TOTAL_MASCOTAS
from ESTANCIA
where ID_CUIDADOR = 1030
  and cast(FECHA_INICIO as date) = cast(@fecha_prueba as date)
group by ID_CUIDADOR, cast(FECHA_INICIO as date);


rollback transaction;


begin transaction

INSERT INTO EMPLEADO VALUES
(1030,'C','Alma','Vega','Morales','VEMA960812MDFGRL00',9,
'Col. Doctores, Ciudad de México',
'avegas','Cuida1234',14500.00);

INSERT INTO CUIDADOR
(EMPLEADO_ID, CUIDADOR_LIDER, EDAD, ESPECIE_ASIGNADA_ID)
VALUES
(1030, null, 34, 1);

declare @fecha_prueba datetime = '2026-06-01';

insert into ESTANCIA(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
values(9001, @fecha_prueba, 3, 9, 1, 1030, 1);

insert into ESTANCIA(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
values(9002, @fecha_prueba, 3, 9, 2, 1030, 1);

insert into ESTANCIA(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
values(9003, @fecha_prueba, 3, 9, 3, 1030, 1);

insert into ESTANCIA(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
values(9004, @fecha_prueba, 3, 9, 4, 1030, 1);

insert into ESTANCIA(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
values(9005, @fecha_prueba, 3, 9, 5, 1030, 1);

insert into ESTANCIA(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA, CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
values(9006, @fecha_prueba, 3, 9, 6, 1030, 1);

select 
    ID_CUIDADOR,
    cast(FECHA_INICIO as date) as FECHA,
    count(*) as TOTAL_MASCOTAS
from ESTANCIA
where ID_CUIDADOR = 1030
  and cast(FECHA_INICIO as date) = cast(@fecha_prueba as date)
group by ID_CUIDADOR, cast(FECHA_INICIO as date);


rollback transaction;