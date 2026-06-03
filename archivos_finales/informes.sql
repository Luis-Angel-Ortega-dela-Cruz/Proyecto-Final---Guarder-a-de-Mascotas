--AUTORES: Ortega de la Cruz Luis Angel 
--		   Quezada Yépez Leonardo André 
--		   Rodríguez Ruiz Diana Carolina
--FECHA: 30/05/2026
--DESCRIPCIÓN: Se incluyen las consulta necesarias para la generación de los reportes solicitados

use [guarderia_mascotas]
go


---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION: 1) Tipo de mascota que más se deja en la guardería
---------------------------

create or alter procedure pusuTipoMascotaMasGuarderia
as
begin
    select top 10
        E.NOMBRE as TIPO_MASCOTA,
        count(*) as CANTIDAD
    from ESTANCIA ES
    inner join MASCOTA M
        on ES.MASCOTA_ID = M.MASCOTA_ID
    inner join RAZA R
        on M.RAZA_ID = R.RAZA_ID
    inner join ESPECIE E
        on R.ESPECIE_ID = E.ESPECIE_ID
    group by E.NOMBRE
    order by CANTIDAD desc;
end;
go

exec pusuTipoMascotaMasGuarderia;
go 

---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION: 2) Época del año en que más mascotas se dejan
---------------------------
create or alter procedure pusuEpocaMasMascotasGuarderia
as
begin
    select top 10
        q.ESTACION,
        sum(q.TOTAL_ESTANCIAS) as TOTAL_ESTANCIAS
    from (
        select
            EA.NOMBRE as ESTACION,
            count(*) as TOTAL_ESTANCIAS
        from ESTANCIA E
        inner join [ESTACION_AÑO] EA
            on E.ESTACION_ID = EA.ESTACION_ID
        group by EA.NOMBRE

        union all

        select
            EA.NOMBRE as ESTACION,
            count(*) as TOTAL_ESTANCIAS
        from HISTORICO_ESTANCIA H
        inner join [ESTACION_AÑO] EA
            on H.ESTACION_ID = EA.ESTACION_ID
        group by EA.NOMBRE
    ) q
    group by q.ESTACION
    order by TOTAL_ESTANCIAS desc;
end;
go

exec pusuEpocaMasMascotasGuarderia;
go


---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION: 3) Listado de mascotas y dueño en un periodo de fechas 
----------------------------
create or alter procedure pusuListadoMascotasDuenosPeriodo
(
    @fecha_inicio date,
    @fecha_fin date
)
as
begin
    select m.MASCOTA_ID, m.NOMBRE as NOMBRE_MASCOTA, m.GENERO as GENERO_MASCOTA, m.RASGO, r.NOMBRE as RAZA,
        c.CLIENTE_ID, c.NOMBRE + ' ' + c.AP_PAT + ' ' + c.AP_MAT as NOMBRE_DUENO, c.DOMICILIO, c.CURP,
        c.GENERO as GENERO_DUENO, c.CORREO, c.USUARIO, ce.CENTRO_ID, ce.NOMBRE as NOMBRE_CENTRO,
        ce.DIRECCION as DIRECCION_CENTRO, e.FECHA_INICIO, e.FECHA_FIN, e.DIAS_ESTANCIA, e.COSTO,
        'actual' as TIPO_REGISTRO
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
        c.NOMBRE + ' ' + c.AP_PAT + ' ' + c.AP_MAT as NOMBRE_DUENO, c.DOMICILIO, c.CURP, c.GENERO as GENERO_DUENO,
        c.CORREO, c.USUARIO, ce.CENTRO_ID, ce.NOMBRE as NOMBRE_CENTRO, ce.DIRECCION as DIRECCION_CENTRO,
        he.FECHA_INICIO, he.FECHA_FIN, he.DIAS_ESTANCIA, he.COSTO, 'historico' as TIPO_REGISTRO
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
end;
go

exec pusuListadoMascotasDuenosPeriodo '2020-05-01', '2030-05-31';
go


---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION: 4) Enfermedades más frecuentes
----------------------------
create or alter procedure pusuEnfermedadesFrecuentes
as
begin
    select top 5
        e.ENFERMEDAD_ID,
        e.NOMBRE as NOMBRE_ENFERMEDAD,
        count(me.MASCOTA_ID) as TOTAL_ANIMALES
    from MASCOTA_ENFERMEDAD me
    inner join ENFERMEDAD e
        on e.ENFERMEDAD_ID = me.ENFERMEDAD_ID
    group by e.ENFERMEDAD_ID, e.NOMBRE
    order by TOTAL_ANIMALES desc;
end;
go

exec pusuEnfermedadesFrecuentes;
go



---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION: 5) Gastos de cada mascota
----------------------------
create or alter procedure pusuGastosMascota
as
begin
    select
        m.MASCOTA_ID,
        m.NOMBRE as NOMBRE_MASCOTA,
        m.GENERO,
        m.RASGO,
        r.NOMBRE as RAZA,
        'consulta' as TIPO_GASTO,
        c.FECHA as FECHA_INICIO,
        c.FECHA as FECHA_FIN,
        null as DIAS_ESTANCIA,
        c.DIAGNOSTICO as DESCRIPCION_GASTO,
        c.COSTO
    from MASCOTA m
    inner join RAZA r
        on r.RAZA_ID = m.RAZA_ID
    inner join CONSULTA c
        on c.MASCOTA_ID = m.MASCOTA_ID

    union all

    select
        m.MASCOTA_ID,
        m.NOMBRE as NOMBRE_MASCOTA,
        m.GENERO,
        m.RASGO,
        r.NOMBRE as RAZA,
        'estancia actual' as TIPO_GASTO,
        e.FECHA_INICIO,
        e.FECHA_FIN,
        e.DIAS_ESTANCIA,
        'Estancia en guardería' as DESCRIPCION_GASTO,
        e.COSTO
    from MASCOTA m
    inner join RAZA r
        on r.RAZA_ID = m.RAZA_ID
    inner join ESTANCIA e
        on e.MASCOTA_ID = m.MASCOTA_ID

    union all

    select
        m.MASCOTA_ID,
        m.NOMBRE as NOMBRE_MASCOTA,
        m.GENERO,
        m.RASGO,
        r.NOMBRE as RAZA,
        'estancia historica' as TIPO_GASTO,
        he.FECHA_INICIO,
        he.FECHA_FIN,
        he.DIAS_ESTANCIA,
        'Estancia en guardería' as DESCRIPCION_GASTO,
        he.COSTO
    from MASCOTA m
    inner join RAZA r
        on r.RAZA_ID = m.RAZA_ID
    inner join HISTORICO_ESTANCIA he
        on he.MASCOTA_ID = m.MASCOTA_ID
    order by MASCOTA_ID, FECHA_INICIO;
end;
go

exec pusuGastosMascota;
go


---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION: 6) Consultas por periodo, incluyendo veterinario, diagnóstico y medicamento
----------------------------
create or alter procedure pusuConsultasPeriodo
(
    @fecha_inicio datetime,
    @fecha_fin datetime
)
as
begin
    select
        c.CONSULTA_ID,
        c.FECHA,
        c.DIAGNOSTICO,
        c.DETALLES,
        c.COSTO,
        e.NOMBRE + ' ' + e.AP_PAT + ' ' + e.AP_MAT as NOMBRE_VETERINARIO,
        med.NOMBRE as MEDICAMENTO,
        inv.CANTIDAD as CANTIDAD_SOLICITADA
    from CONSULTA c
    inner join VETERINARIO v
        on v.EMPLEADO_ID = c.EMPLEADO_ID
    inner join EMPLEADO e
        on e.EMPLEADO_ID = v.EMPLEADO_ID
    left join INV_MED_CONSULTA inv
        on inv.CONSULTA_ID = c.CONSULTA_ID
    left join INVENTARIO_MEDICO im
        on im.INV_MED_ID = inv.INV_MED_ID
    left join MEDICAMENTO med
        on med.MEDICAMENTO_ID = im.MEDICAMENTO_ID
    where c.FECHA >= @fecha_inicio
      and c.FECHA < dateadd(day, 1, @fecha_fin)
    order by c.FECHA;
end;
go

exec pusuConsultasPeriodo '2020-05-01', '2030-05-31';
go

---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION: 7) Inventario de medicamentos con su costo por centro
----------------------------

create or alter procedure pusuInventarioMedicamentosCentro
as
begin
    select
        C.NOMBRE as CENTRO,
        M.NOMBRE as MEDICAMENTO,
        IM.CANTIDAD as EXISTENCIA,
        M.COSTO,
        (IM.CANTIDAD * M.COSTO) as VALOR_INVENTARIO
    from INVENTARIO_MEDICO IM
    inner join MEDICAMENTO M
        on IM.MEDICAMENTO_ID = M.MEDICAMENTO_ID
    inner join CENTRO C
        on IM.CENTRO_ID = C.CENTRO_ID
    order by C.NOMBRE, M.NOMBRE;
end;
go

exec pusuInventarioMedicamentosCentro;
go

---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION: 8) Enfermedades más frecuentes por centro
----------------------------
create or alter procedure pusuEnfermedadesFrecuentesCentro
as
begin
    select
        C.CENTRO_ID,
        C.NOMBRE as NOMBRE_CENTRO,
        E.NOMBRE as NOMBRE_ENFERMEDAD,
        count(ME.MASCOTA_ID) as TOTAL_CASOS
    from CENTRO C
    inner join ESTANCIA ES
        on C.CENTRO_ID = ES.CENTRO_ID
    inner join MASCOTA M
        on ES.MASCOTA_ID = M.MASCOTA_ID
    inner join MASCOTA_ENFERMEDAD ME
        on M.MASCOTA_ID = ME.MASCOTA_ID
    inner join ENFERMEDAD E
        on ME.ENFERMEDAD_ID = E.ENFERMEDAD_ID
    group by C.CENTRO_ID, C.NOMBRE, E.NOMBRE
    order by C.CENTRO_ID asc, TOTAL_CASOS desc;
end;
go

exec pusuEnfermedadesFrecuentesCentro;
go

---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION: 9) Reporte de ventas de medicamentos en un periodo
----------------------------
create or alter procedure pusuVentasMedicamentosPeriodo
(
    @fecha_inicio datetime,
    @fecha_fin datetime
)
as
begin
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
    where c.FECHA >= @fecha_inicio
      and c.FECHA < dateadd(day, 1, @fecha_fin)
    group by m.MEDICAMENTO_ID, m.NOMBRE
    order by MONTO_TOTAL desc;
end;
go

exec pusuVentasMedicamentosPeriodo '2020-05-01', '2030-05-31';
go

---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION: 10) Centro con mayor número de ventas en un periodo
----------------------------
create or alter procedure pusuCentroMayorVentasPeriodo
(
    @fecha_inicio datetime,
    @fecha_fin datetime
)
as
begin
    select top 1
        'fisica' as TIPO_VENTA,
        c.CENTRO_ID,
        c.NOMBRE as NOMBRE_CENTRO,
        c.DIRECCION,
        e.NOMBRE + ' ' + e.AP_PAT + ' ' + e.AP_MAT as NOMBRE_ADMINISTRADOR,
        count(distinct v.VENTA_ID) as TOTAL_VENTAS
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
    order by TOTAL_VENTAS desc;

    select top 1
        'linea' as TIPO_VENTA,
        c.CENTRO_ID,
        c.NOMBRE as NOMBRE_CENTRO,
        c.DIRECCION,
        e.NOMBRE + ' ' + e.AP_PAT + ' ' + e.AP_MAT as NOMBRE_ADMINISTRADOR,
        count(distinct v.VENTA_ID) as TOTAL_VENTAS
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
    order by TOTAL_VENTAS desc;
end;
go

exec pusuCentroMayorVentasPeriodo '2020-05-01', '2030-05-31';
go


---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION: 11) Artículos más vendidos y menos vendidos por categoría
----------------------------
create or alter procedure pusuArticulosVendidosCategoria
as
begin
    ;with VENTAS_PRODUCTO as
    (
        select
            P.PRODUCTO_ID,
            P.NOMBRE as PRODUCTO,
            C.NOMBRE as CATEGORIA,
            CF.CANTIDAD
        from CARRITO_FISICO CF
        inner join INV_CENTRO_NORMAL ICN
            on CF.INV_CRETRO_NORMAL_ID = ICN.INV_CRETRO_NORMAL_ID
        inner join PRODUCTO P
            on ICN.PRODUCTO_ID = P.PRODUCTO_ID
        inner join CATEGORIA C
            on P.CATEGORIA_ID = C.CATEGORIA_ID

        union all

        select
            P.PRODUCTO_ID,
            P.NOMBRE,
            C.NOMBRE,
            CL.CANTIDAD
        from CARRITO_LINEA CL
        inner join INV_CENTRO_REGIONAL ICR
            on CL.INV_CRETRO_REGIONAL_ID = ICR.INV_CRETRO_REGIONAL_ID
        inner join PRODUCTO P
            on ICR.PRODUCTO_ID = P.PRODUCTO_ID
        inner join CATEGORIA C
            on P.CATEGORIA_ID = C.CATEGORIA_ID
    )
    select top 5
        CATEGORIA,
        PRODUCTO,
        sum(CANTIDAD) as TOTAL_VENDIDO
    from VENTAS_PRODUCTO
    group by CATEGORIA, PRODUCTO
    order by TOTAL_VENDIDO desc;

    ;with VENTAS_PRODUCTO as
    (
        select
            P.PRODUCTO_ID,
            P.NOMBRE as PRODUCTO,
            C.NOMBRE as CATEGORIA,
            CF.CANTIDAD
        from CARRITO_FISICO CF
        inner join INV_CENTRO_NORMAL ICN
            on CF.INV_CRETRO_NORMAL_ID = ICN.INV_CRETRO_NORMAL_ID
        inner join PRODUCTO P
            on ICN.PRODUCTO_ID = P.PRODUCTO_ID
        inner join CATEGORIA C
            on P.CATEGORIA_ID = C.CATEGORIA_ID

        union all

        select
            P.PRODUCTO_ID,
            P.NOMBRE,
            C.NOMBRE,
            CL.CANTIDAD
        from CARRITO_LINEA CL
        inner join INV_CENTRO_REGIONAL ICR
            on CL.INV_CRETRO_REGIONAL_ID = ICR.INV_CRETRO_REGIONAL_ID
        inner join PRODUCTO P
            on ICR.PRODUCTO_ID = P.PRODUCTO_ID
        inner join CATEGORIA C
            on P.CATEGORIA_ID = C.CATEGORIA_ID
    )
    select top 5
        CATEGORIA,
        PRODUCTO,
        sum(CANTIDAD) as TOTAL_VENDIDO
    from VENTAS_PRODUCTO
    group by CATEGORIA, PRODUCTO
    order by TOTAL_VENDIDO asc;
end;
go

exec pusuArticulosVendidosCategoria;
go


---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION: 12) Época en la que más se vende
----------------------------
create or alter procedure pusuEpocaMasVentas
as
begin
    select
        ea.ESTACION_ID,
        ea.NOMBRE as EPOCA_DEL_AÑO,
        sum(v.COSTO) as MONTO_TOTAL_VENTAS
    from [ESTACION_AÑO] ea
    inner join ESTANCIA est
        on ea.ESTACION_ID = est.ESTACION_ID
    inner join MASCOTA m
        on est.MASCOTA_ID = m.MASCOTA_ID
    inner join VENTA v
        on m.CLIENTE_ID = v.CLIENTE_ID
    group by ea.ESTACION_ID, ea.NOMBRE
    order by MONTO_TOTAL_VENTAS desc;
end;
go

exec pusuEpocaMasVentas;
go

---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION:  13) Los 5 empleados con mayor comisión mensual
----------------------------
create or alter procedure pusuEmpleadosMayorComisionMensual
(
    @mes int,
    @anio int
)
as
begin
    declare @fecha_inicio date = datefromparts(@anio, @mes, 1);
    declare @fecha_fin date = dateadd(month, 1, @fecha_inicio);

    select top 5
        e.EMPLEADO_ID,
        e.NOMBRE + ' ' + e.AP_PAT + ' ' + e.AP_MAT as NOMBRE_EMPLEADO,
        count(f.VENTA_ID) as TOTAL_VENTAS_FISICAS,
        sum(f.COMISION) as COMISION_TOTAL
    from FISICA f
    inner join VENTA v
        on v.VENTA_ID = f.VENTA_ID
    inner join EMPLEADO e
        on e.EMPLEADO_ID = f.ID_ENCARGADO_TIENDA
    where v.FECHA >= @fecha_inicio
      and v.FECHA < @fecha_fin
    group by e.EMPLEADO_ID, e.NOMBRE, e.AP_PAT, e.AP_MAT
    order by COMISION_TOTAL desc;
end;
go

exec pusuEmpleadosMayorComisionMensual 5, 2026;
go


---------------------------
--CREADOR: ThePumitas
--FECHA CREACION: 30/05/2026
--DESCRIPCION:  14) Inventario de las tiendas
----------------------------
create or alter procedure pusuInventarioTiendas
as
begin
    select
        'fisica' as TIPO_INVENTARIO,
        icn.INV_CRETRO_NORMAL_ID as INVENTARIO_ID,
        c.CENTRO_ID,
        c.NOMBRE as CENTRO,
        p.PRODUCTO_ID,
        p.NOMBRE as PRODUCTO,
        icn.EXISTENCIAS
    from INV_CENTRO_NORMAL icn
    inner join CENTRO c
        on c.CENTRO_ID = icn.CENTRO_ID
    inner join PRODUCTO p
        on p.PRODUCTO_ID = icn.PRODUCTO_ID;

    select
        'regional' as TIPO_INVENTARIO,
        icr.INV_CRETRO_REGIONAL_ID as INVENTARIO_ID,
        c.CENTRO_ID,
        c.NOMBRE as CENTRO,
        p.PRODUCTO_ID,
        p.NOMBRE as PRODUCTO,
        icr.EXISTENCIAS
    from INV_CENTRO_REGIONAL icr
    inner join CENTRO c
        on c.CENTRO_ID = icr.CENTRO_ID
    inner join PRODUCTO p
        on p.PRODUCTO_ID = icr.PRODUCTO_ID;
end;
go

exec pusuInventarioTiendas;