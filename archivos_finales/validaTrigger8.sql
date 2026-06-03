--AUTORES: Ortega de la Cruz Luis Angel 
--		   Quezada Yépez Leonardo André 
--		   Rodríguez Ruiz Diana Carolina
--FECHA: 30/05/2026
--DESCRIPCIÓN: Se incluyen la pruebas necesarias para validar el trigger 7
--TRIGGER 8: Valida que solo haya un máximo de 3 veterinarios por centro.

use [guarderia_mascotas]
go


begin try
    begin transaction;

    declare @centro_id numeric(5,0);

    select @centro_id= 9;

    insert into EMPLEADO(EMPLEADO_ID, TIPO_EMPLEADO, NOMBRE, AP_PAT, AP_MAT, CURP, CENTRO_ID, DOMICILIO, USUARIO, CONTRASEÑA, SUELDO)
    values(9901, 'V', 'VetPrueba1', 'Prueba', 'Uno', 'CURPTESTVET001', @centro_id, 'Domicilio prueba', 'vetprueba1', '1234', 10000);

    insert into EMPLEADO(EMPLEADO_ID, TIPO_EMPLEADO, NOMBRE, AP_PAT, AP_MAT, CURP, CENTRO_ID, DOMICILIO, USUARIO, CONTRASEÑA, SUELDO)
    values(9902, 'V', 'VetPrueba2', 'Prueba', 'Dos', 'CURPTESTVET002', @centro_id, 'Domicilio prueba', 'vetprueba2', '1234', 10000);

    insert into EMPLEADO(EMPLEADO_ID, TIPO_EMPLEADO, NOMBRE, AP_PAT, AP_MAT, CURP, CENTRO_ID, DOMICILIO, USUARIO, CONTRASEÑA, SUELDO)
    values(9903, 'V', 'VetPrueba3', 'Prueba', 'Tres', 'CURPTESTVET003', @centro_id, 'Domicilio prueba', 'vetprueba3', '1234', 10000);

    insert into EMPLEADO(EMPLEADO_ID, TIPO_EMPLEADO, NOMBRE, AP_PAT, AP_MAT, CURP, CENTRO_ID, DOMICILIO, USUARIO, CONTRASEÑA, SUELDO)
    values(9904, 'V', 'VetPrueba4', 'Prueba', 'Cuatro', 'CURPTESTVET004', @centro_id, 'Domicilio prueba', 'vetprueba4', '1234', 10000);

    insert into VETERINARIO(EMPLEADO_ID, CEDULA, ESPECIALIDAD)
    values(9901, 'CED9901', 'General');

    insert into VETERINARIO(EMPLEADO_ID, CEDULA, ESPECIALIDAD)
    values(9902, 'CED9902', 'General');

    insert into VETERINARIO(EMPLEADO_ID, CEDULA, ESPECIALIDAD)
    values(9903, 'CED9903', 'General');

    select 
        e.CENTRO_ID,
        count(*) as TOTAL_VETERINARIOS
    from VETERINARIO v
    inner join EMPLEADO e
        on e.EMPLEADO_ID = v.EMPLEADO_ID
    where e.CENTRO_ID = @centro_id
    group by e.CENTRO_ID;

    -- Este insert debe activar el trigger
    insert into VETERINARIO(EMPLEADO_ID, CEDULA, ESPECIALIDAD)
    values(9904, 'CED9904', 'General');

    -- Si por alguna razón no fallara, de todos modos no guardamos nada
    rollback transaction;
end try
begin catch
    print error_message();

    rollback transaction;
end catch;
go