---Pruebas para procedimientos almacenados
------------------------------------------------
---Prueba de SP 1
------------------------------------------------
EXEC RegistrarMascotaEstanciaBrazalete
    @MascotaId = 30,
    @Genero = 'M',
    @Rasgo = 'Muy jugueton',
    @Nombre = 'Firulais',
    @ClienteId = 1,
    @RazaId = 1,

    @IdEstancia = 29,
    @DiasEstancia = 5,
    @CentroId = 1,
    @CuidadorId = 1018,
    @EstacionId = 1,

    @BrazaleteId = 35,
    @Medicamento = 'Ninguno',
    @Cuidados = 'Paseo diario',
    @TipoAlimentacion = 'Croquetas',
    @CantidadComida = 160,
    @Estado = 'Estable';

-- Ver mascota insertada
select m.MASCOTA_ID, m.NOMBRE, m.GENERO, c.NOMBRE as DUENO
from MASCOTA m join CLIENTE c on m.CLIENTE_ID = c.CLIENTE_ID
where m.MASCOTA_ID = 30;

-- Ver estancia insertada
select e.ID_ESTANCIA, e.DIAS_ESTANCIA, e.COSTO, m.NOMBRE, emp.NOMBRE as CUIDADOR
from ESTANCIA e 
join MASCOTA m on e.MASCOTA_ID = m.MASCOTA_ID
join EMPLEADO emp on e.ID_CUIDADOR = emp.EMPLEADO_ID
where e.ID_ESTANCIA = 29;

-- Ver brazalete insertado
select b.BRAZALETE_ID, b.MEDICAMENTO, b.CUIDADOS, b.TIPO_ALIMENTACION, b.ESTADO, m.NOMBRE
from BRAZALETE b join MASCOTA m on b.MASCOTA_ID = m.MASCOTA_ID
where b.BRAZALETE_ID = 35;

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


------------------------------------------------
---Prueba de SP 6
------------------------------------------------
--Cancelar la venta en linea = 9
EXEC SP_CANCELAR_VENTA_LINEA 9;

-- Ver que quedó CANCELADA
select v.VENTA_ID, ev.NOMBRE as ESTADO, l.TARIFA_CANCELACION
from VENTA v
join LINEA l on v.VENTA_ID = l.VENTA_ID
join ESTADO_VENTA ev on l.ESTADO_ID = ev.ESTADO_ID
where v.VENTA_ID = 9;

-- Ver que el STOCK aumentó (se devolvieron los productos)
select p.NOMBRE, cl.CANTIDAD, icr.EXISTENCIAS as STOCK_NUEVO
from CARRITO_LINEA cl
join INV_CENTRO_REGIONAL icr on cl.INV_CRETRO_REGIONAL_ID = icr.INV_CRETRO_REGIONAL_ID
join PRODUCTO p on icr.PRODUCTO_ID = p.PRODUCTO_ID
where cl.VENTA_ID = 9;


------------------------------------------------
---Prueba de SP 8
------------------------------------------------
---VERIFICANDO
-- Agregar producto a CARRITO_FISICO
EXEC SP_AGREGAR_PRODUCTO_CARRITO
    @VENTA_ID = 1,
    @INVENTARIO_ID = 4,
    @CANTIDAD = 1;

-- Verificar que se agregó al CARRITO_FISICO
SELECT * from CARRITO_FISICO WHERE VENTA_ID = 1;

-- Verificar que bajó el stock en INV_CENTRO_NORMAL
SELECT EXISTENCIAS FROM INV_CENTRO_NORMAL WHERE INV_CRETRO_NORMAL_ID = 4;


-- Agregar producto a CARRITO_LINEA
EXEC SP_AGREGAR_PRODUCTO_CARRITO
    @VENTA_ID = 6,
    @INVENTARIO_ID = 4,
    @CANTIDAD = 1;

-- Verificar que se agregó al CARRITO_LINEA
SELECT * FROM CARRITO_LINEA WHERE VENTA_ID = 6;

-- Verificar que bajó el stock en INV_CENTRO_REGIONAL
SELECT EXISTENCIAS FROM INV_CENTRO_REGIONAL WHERE INV_CRETRO_REGIONAL_ID = 4;