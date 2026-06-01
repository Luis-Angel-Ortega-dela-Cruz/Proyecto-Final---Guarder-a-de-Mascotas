
use [guarderia_mascotas]
go

-------------
--ESTADÍSTICAS SQL
-------------------

--1) Tipo de mascota que más se deja en la guardería

SELECT TOP 10
       E.NOMBRE AS TIPO_MASCOTA,
       COUNT(*) AS CANTIDAD
FROM ESTANCIA ES
INNER JOIN MASCOTA M
       ON ES.MASCOTA_ID = M.MASCOTA_ID
INNER JOIN RAZA R
       ON M.RAZA_ID = R.RAZA_ID
INNER JOIN ESPECIE E
       ON R.ESPECIE_ID = E.ESPECIE_ID
GROUP BY E.NOMBRE
ORDER BY CANTIDAD DESC;


--2) Época del año en que más mascotas se dejan
SELECT TOP 10
       EA.NOMBRE AS ESTACION,
       COUNT(*) AS TOTAL_MASCOTAS
FROM ESTANCIA E
INNER JOIN ESTACION_AÑO EA
       ON E.ESTACION_ID = EA.ESTACION_ID
GROUP BY EA.NOMBRE
ORDER BY TOTAL_MASCOTAS DESC;

--por histórico y no solo las estancias actuales:
SELECT TOP 10
       EA.NOMBRE AS ESTACION,
       COUNT(*) AS TOTAL_ESTANCIAS
FROM HISTORICO_ESTANCIA H
INNER JOIN ESTACION_AÑO EA
       ON H.ESTACION_ID = EA.ESTACION_ID
GROUP BY EA.NOMBRE
ORDER BY TOTAL_ESTANCIAS DESC;
go

--3. Listado de las mascotas y su dueño datos generales, número de días en la guardería, datos generales de ambos. 
-- EL reporte se obtiene en un periodo de fechas


declare @fecha_inicio date = '2020-05-01';
declare @fecha_fin date = '2030-05-31';

select m.MASCOTA_ID, m.NOMBRE as NOMBRE_MASCOTA, m.GENERO as GENERO_MASCOTA,
    m.RASGO, r.NOMBRE as RAZA, c.CLIENTE_ID, c.NOMBRE + ' ' + c.AP_PAT + ' ' + c.AP_MAT as NOMBRE_DUENO,
    c.DOMICILIO, c.CURP, c.GENERO as GENERO_DUENO, c.CORREO, c.USUARIO, ce.CENTRO_ID,
    ce.NOMBRE as NOMBRE_CENTRO, ce.DIRECCION as DIRECCION_CENTRO, e.FECHA_INICIO,
    e.FECHA_FIN, e.DIAS_ESTANCIA, e.COSTO, 'actual' as TIPO_REGISTRO
from ESTANCIA e
inner join MASCOTA m
    on m.MASCOTA_ID = e.MASCOTA_ID
inner join CLIENTE c
    on c.CLIENTE_ID = m.CLIENTE_ID
inner join RAZA r
    on r.RAZA_ID = m.RAZA_ID
inner join CENTRO ce
    on ce.CENTRO_ID = e.CENTRO_ID
where cast(e.FECHA_INICIO as date) <= @fecha_fin
  and cast(e.FECHA_FIN as date) >= @fecha_inicio

union all

select m.MASCOTA_ID, m.NOMBRE as NOMBRE_MASCOTA, m.GENERO as GENERO_MASCOTA, m.RASGO, r.NOMBRE as RAZA, c.CLIENTE_ID,
    c.NOMBRE + ' ' + c.AP_PAT + ' ' + c.AP_MAT as NOMBRE_DUENO, c.DOMICILIO, c.CURP, c.GENERO as GENERO_DUENO, c.CORREO,
    c.USUARIO, ce.CENTRO_ID, ce.NOMBRE as NOMBRE_CENTRO, ce.DIRECCION as DIRECCION_CENTRO, he.FECHA_INICIO,
    he.FECHA_FIN, he.DIAS_ESTANCIA, he.COSTO, 'historico' as TIPO_REGISTRO
from HISTORICO_ESTANCIA he
inner join MASCOTA m
    on m.MASCOTA_ID = he.MASCOTA_ID
inner join CLIENTE c
    on c.CLIENTE_ID = m.CLIENTE_ID
inner join RAZA r
    on r.RAZA_ID = m.RAZA_ID
inner join CENTRO ce
    on ce.CENTRO_ID = he.CENTRO_ID
where he.FECHA_INICIO <= @fecha_fin
  and he.FECHA_FIN >= @fecha_inicio
order by NOMBRE_DUENO, NOMBRE_MASCOTA, FECHA_INICIO;
go

-- 4)Enfermedades más frecuentes (5), total de animales con dicha enfermedad ordenados de mayor a menor
select top 5 e.ENFERMEDAD_ID, e.NOMBRE as NOMBRE_ENFERMEDAD, count(me.MASCOTA_ID) as total_animales
from MASCOTA_ENFERMEDAD me
inner join ENFERMEDAD e
    on e.ENFERMEDAD_ID = me.ENFERMEDAD_ID
group by e.ENFERMEDAD_ID, e.NOMBRE, e.DESCRIPCION
order by total_animales desc;

--5)Gastos de cada mascota, datos de la mascota, fechas y días de estancia, descripción de gatos y costo.
select m.MASCOTA_ID, m.NOMBRE as NOMBRE_MASCOTA, m.GENERO, m.RASGO, r.NOMBRE as RAZA, 'consulta' as TIPO_GASTO,
    c.FECHA as FECHA_INICIO, c.FECHA as FECHA_FIN, null as DIAS_ESTANCIA, c.DIAGNOSTICO as DESCRIPCION_GASTO,
    c.COSTO as COSTO
from MASCOTA m
inner join RAZA r
    on r.RAZA_ID = m.RAZA_ID
inner join CONSULTA c
    on c.MASCOTA_ID = m.MASCOTA_ID

union all

select m.MASCOTA_ID, m.NOMBRE as NOMBRE_MASCOTA, m.GENERO, m.RASGO, r.NOMBRE as RAZA, 'estancia actual' as TIPO_GASTO,
    e.FECHA_INICIO, e.FECHA_FIN, e.DIAS_ESTANCIA, 'Estancia en guardería' as DESCRIPCION_GASTO, e.COSTO
from MASCOTA m
inner join RAZA r
    on r.RAZA_ID = m.RAZA_ID
inner join ESTANCIA e
    on e.MASCOTA_ID = m.MASCOTA_ID

union all

select m.MASCOTA_ID, m.NOMBRE as NOMBRE_MASCOTA,m.GENERO, m.RASGO, r.NOMBRE as RAZA, 'estancia historica' as TIPO_GASTO,
    he.FECHA_INICIO, he.FECHA_FIN, he.DIAS_ESTANCIA, 'Estancia en guardería' as DESCRIPCION_GASTO, he.COSTO
from MASCOTA m
inner join RAZA r
    on r.RAZA_ID = m.RAZA_ID
inner join HISTORICO_ESTANCIA he
    on he.MASCOTA_ID = m.MASCOTA_ID
order by MASCOTA_ID, FECHA_INICIO;
go

--6)Listado con datos generales de las consultas por periodos de tiempo, 
-- incluyendo veterinario que lo atendió, diagnóstico y medicamento.

select c.*, e.NOMBRE + ' ' + e.AP_PAT as nombre_veterinario, m.NOMBRE as medicamento, inv.CANTIDAD as cantidad_solicitada
from CONSULTA c
join VETERINARIO v
  on v.EMPLEADO_ID = c.EMPLEADO_ID
join EMPLEADO e
  on e.EMPLEADO_ID = v.EMPLEADO_ID
left join INV_MED_CONSULTA inv
  on inv.CONSULTA_ID = c.CONSULTA_ID
left join INVENTARIO_MEDICO im
  on im.INV_MED_ID = inv.INV_MED_ID
left join MEDICAMENTO m
  on m.MEDICAMENTO_ID = im.MEDICAMENTO_ID
order by c.FECHA ;


--7) Inventario de medicamentos con su costo por centro
SELECT TOP 10
       C.NOMBRE AS CENTRO,
       M.NOMBRE AS MEDICAMENTO,
       IM.CANTIDAD AS EXISTENCIA,
       M.COSTO,
       (IM.CANTIDAD * M.COSTO) AS VALOR_INVENTARIO
FROM INVENTARIO_MEDICO IM
INNER JOIN MEDICAMENTO M
       ON IM.MEDICAMENTO_ID = M.MEDICAMENTO_ID
INNER JOIN CENTRO C
       ON IM.CENTRO_ID = C.CENTRO_ID
ORDER BY C.NOMBRE,
         M.NOMBRE;

--9) Reporte de ventas y medicamentos en un periodo de tiempo, incluyendo cantidad y monto total

select 
    m.MEDICAMENTO_ID,
    m.NOMBRE,
    sum(imc.CANTIDAD) as CANTIDAD_TOTAL,
    sum(imc.COSTO_TOTAL) as MONTO_TOTAL
from INV_MED_CONSULTA imc
inner join CONSULTA c
    on c.CONSULTA_ID = imc.CONSULTA_ID
inner join INVENTARIO_MEDICO im
    on im.INV_MED_ID = imc.INV_MED_ID
inner join MEDICAMENTO m
    on m.MEDICAMENTO_ID = im.MEDICAMENTO_ID
--where c.FECHA between '2026-05-01' and '2026-05-31' --Se puede filtrar por cierto periodo de tiempo
group by m.MEDICAMENTO_ID, m.NOMBRE
order by MONTO_TOTAL desc;

--10 El centro con mayor número de ventas en un periodo de tiempo.  
--(separar las ventas en línea de las ventas físicas de cada centro incluir nombre del dentro, domicilio y 
--nombre del administrador del centro). 

--MAYOR EN VENTAS FÍSICAS

declare @fecha_inicio datetime = '2026-05-01';
declare @fecha_fin datetime = '2026-05-31';

select top 1 c.CENTRO_ID, c.NOMBRE as NOMBRE_CENTRO, c.DIRECCION,
    e.NOMBRE + ' ' + e.AP_PAT + ' ' + e.AP_MAT as NOMBRE_ADMINISTRADOR,
    count(distinct v.VENTA_ID) as TOTAL_VENTAS_FISICAS
from VENTA v
inner join FISICA f
    on f.VENTA_ID = v.VENTA_ID
inner join CARRITO_FISICO cf
    on cf.VENTA_ID = v.VENTA_ID
inner join INV_CENTRO_NORMAL icn
    on icn.INV_CRETRO_NORMAL_ID = cf.INV_CRETRO_NORMAL_ID
inner join CENTRO c
    on c.CENTRO_ID = icn.CENTRO_ID
left join EMPLEADO e
    on e.EMPLEADO_ID = c.GERENTE_ENCARGADO_ID
where v.FECHA >= @fecha_inicio
  and v.FECHA < dateadd(day, 1, @fecha_fin)
group by c.CENTRO_ID, c.NOMBRE, c.DIRECCION, e.NOMBRE, e.AP_PAT, e.AP_MAT
order by TOTAL_VENTAS_FISICAS desc;
GO

--MAYOR EN VENTAS EN LÍNEA

declare @fecha_inicio datetime = '2026-05-01';
declare @fecha_fin datetime = '2026-05-31';

select top 1 c.CENTRO_ID, c.NOMBRE as NOMBRE_CENTRO, c.DIRECCION,
    e.NOMBRE + ' ' + e.AP_PAT + ' ' + e.AP_MAT as NOMBRE_ADMINISTRADOR,
    count(distinct v.VENTA_ID) as TOTAL_VENTAS_LINEA
from VENTA v
inner join LINEA l
    on l.VENTA_ID = v.VENTA_ID
inner join CARRITO_LINEA cl
    on cl.VENTA_ID = v.VENTA_ID
inner join INV_CENTRO_REGIONAL icr
    on icr.INV_CRETRO_REGIONAL_ID = cl.INV_CRETRO_REGIONAL_ID
inner join CENTRO c
    on c.CENTRO_ID = icr.CENTRO_ID
left join EMPLEADO e
    on e.EMPLEADO_ID = c.GERENTE_ENCARGADO_ID
where v.FECHA >= @fecha_inicio
  and v.FECHA < dateadd(day, 1, @fecha_fin)
group by c.CENTRO_ID, c.NOMBRE, c.DIRECCION, e.NOMBRE, e.AP_PAT, e.AP_MAT
order by TOTAL_VENTAS_LINEA desc;
GO

--11 Artículos más vendidos (Top 5) y menos vendidos por categoría
-- top 5 mas vendidos
WITH VENTAS_PRODUCTO AS
(
    -- tomamos ventas físicas
    SELECT
        P.PRODUCTO_ID,
        P.NOMBRE AS PRODUCTO,
        C.NOMBRE AS CATEGORIA,
        CF.CANTIDAD
    FROM CARRITO_FISICO CF
    INNER JOIN INV_CENTRO_NORMAL ICN
        ON CF.INV_CRETRO_NORMAL_ID = ICN.INV_CRETRO_NORMAL_ID
    INNER JOIN PRODUCTO P
        ON ICN.PRODUCTO_ID = P.PRODUCTO_ID
    INNER JOIN CATEGORIA C
        ON P.CATEGORIA_ID = C.CATEGORIA_ID

    UNION ALL

    -- tomamos ventas en linea
    SELECT
        P.PRODUCTO_ID,
        P.NOMBRE,
        C.NOMBRE,
        CL.CANTIDAD
    FROM CARRITO_LINEA CL
    INNER JOIN INV_CENTRO_REGIONAL ICR
        ON CL.INV_CRETRO_REGIONAL_ID =
           ICR.INV_CRETRO_REGIONAL_ID
    INNER JOIN PRODUCTO P
        ON ICR.PRODUCTO_ID = P.PRODUCTO_ID
    INNER JOIN CATEGORIA C
        ON P.CATEGORIA_ID = C.CATEGORIA_ID
)
SELECT TOP 5
       CATEGORIA,
       PRODUCTO,
       SUM(CANTIDAD) AS TOTAL_VENDIDO
FROM VENTAS_PRODUCTO
GROUP BY CATEGORIA, PRODUCTO
ORDER BY TOTAL_VENDIDO DESC;


--menos vendidos
WITH VENTAS_PRODUCTO AS
(
    SELECT
        P.PRODUCTO_ID,
        P.NOMBRE AS PRODUCTO,
        C.NOMBRE AS CATEGORIA,
        CF.CANTIDAD
    FROM CARRITO_FISICO CF
    INNER JOIN INV_CENTRO_NORMAL ICN
        ON CF.INV_CRETRO_NORMAL_ID = ICN.INV_CRETRO_NORMAL_ID
    INNER JOIN PRODUCTO P
        ON ICN.PRODUCTO_ID = P.PRODUCTO_ID
    INNER JOIN CATEGORIA C
        ON P.CATEGORIA_ID = C.CATEGORIA_ID

    UNION ALL

    SELECT
        P.PRODUCTO_ID,
        P.NOMBRE,
        C.NOMBRE,
        CL.CANTIDAD
    FROM CARRITO_LINEA CL
    INNER JOIN INV_CENTRO_REGIONAL ICR
        ON CL.INV_CRETRO_REGIONAL_ID =
           ICR.INV_CRETRO_REGIONAL_ID
    INNER JOIN PRODUCTO P
        ON ICR.PRODUCTO_ID = P.PRODUCTO_ID
    INNER JOIN CATEGORIA C
        ON P.CATEGORIA_ID = C.CATEGORIA_ID
)
SELECT TOP 5
       CATEGORIA,
       PRODUCTO,
       SUM(CANTIDAD) AS TOTAL_VENDIDO
FROM VENTAS_PRODUCTO
GROUP BY CATEGORIA, PRODUCTO
ORDER BY TOTAL_VENDIDO ASC;


-- En general mas vendidos y menos vendidos, enfocandonos en la categoria
-- no hay top 5 porque hay catergorias donde no hay 5 productos
WITH VENTAS_PRODUCTO AS
(
    SELECT
        C.CATEGORIA_ID,
        C.NOMBRE AS CATEGORIA,
        P.PRODUCTO_ID,
        P.NOMBRE AS PRODUCTO,
        CF.CANTIDAD
    FROM CARRITO_FISICO CF
    INNER JOIN INV_CENTRO_NORMAL I
        ON CF.INV_CRETRO_NORMAL_ID = I.INV_CRETRO_NORMAL_ID
    INNER JOIN PRODUCTO P
        ON I.PRODUCTO_ID = P.PRODUCTO_ID
    INNER JOIN CATEGORIA C
        ON P.CATEGORIA_ID = C.CATEGORIA_ID

    UNION ALL

    SELECT
        C.CATEGORIA_ID,
        C.NOMBRE,
        P.PRODUCTO_ID,
        P.NOMBRE,
        CL.CANTIDAD
    FROM CARRITO_LINEA CL
    INNER JOIN INV_CENTRO_REGIONAL I
        ON CL.INV_CRETRO_REGIONAL_ID = I.INV_CRETRO_REGIONAL_ID
    INNER JOIN PRODUCTO P
        ON I.PRODUCTO_ID = P.PRODUCTO_ID
    INNER JOIN CATEGORIA C
        ON P.CATEGORIA_ID = C.CATEGORIA_ID
)
SELECT
    CATEGORIA,
    PRODUCTO,
    SUM(CANTIDAD) AS TOTAL_VENDIDO
FROM VENTAS_PRODUCTO
GROUP BY CATEGORIA, PRODUCTO
ORDER BY CATEGORIA, TOTAL_VENDIDO DESC;
go


--13. Los 5 empleados con mayor comisión, este reporte se obtiene de manera mensual
declare @fecha_inicio datetime = '2026-05-01';
declare @fecha_fin datetime = '2026-05-31';

select top 5 e.EMPLEADO_ID, e.NOMBRE + ' ' + e.AP_PAT + ' ' + e.AP_MAT as NOMBRE_EMPLEADO,
    count(f.VENTA_ID) as TOTAL_VENTAS_FISICAS, sum(f.COMISION) as COMISION_TOTAL
from FISICA f
inner join VENTA v
    on v.VENTA_ID = f.VENTA_ID
inner join EMPLEADO e
    on e.EMPLEADO_ID = f.ID_ENCARGADO_TIENDA
where v.FECHA >= @fecha_inicio
  and v.FECHA < dateadd(day, 1, @fecha_fin)
group by e.EMPLEADO_ID, e.NOMBRE, e.AP_PAT, e.AP_MAT
order by COMISION_TOTAL desc;
go

-- 14. Inventario de las tiendas de cada tienda

--INVENTARIO DE TIENDAS FÍSICAS
select * from INV_CENTRO_NORMAL;

--INVENTARIO DE TIENDAS REGIONALES
select * from INV_CENTRO_REGIONAL;
