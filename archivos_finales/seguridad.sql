--AUTORES: Ortega de la Cruz Luis Angel 
--		   Quezada Yépez Leonardo André 
--		   Rodríguez Ruiz Diana Carolina
--FECHA: 30/05/2026
--DESCRIPCIÓN: 
/*
SEGURIDAD PARA LA BASE DE DATOS guarderia_mascotas
Crear roles, usuarios, permisos y procedimiento de seguridad.

Roles:
- consulta: solo puede consultar información.
- gestor: puede consultar, insertar y actualizar información.
- administrador: tiene control sobre la base de datos.
*/

use [guarderia_mascotas]
go

--CREACIÓN DE ROLES
--Crea los roles si estos no existen

if not exists(select 1 from sys.database_principals where name = 'consulta' and type = 'R')
begin
    create role consulta
end
go

if not exists(select 1 from sys.database_principals where name = 'gestor' and type = 'R')
begin
    create role gestor
end
go

if not exists(select 1 from sys.database_principals where name = 'administrador' and type = 'R')
begin
    create role administrador
end
go



--  PERMISOS PARA EL ROL consulta

grant select on schema :: operacion to consulta
go

grant select on schema :: ventas to consulta
go



-- PERMISOS PARA EL ROL gestor


grant select, insert, update on schema :: operacion to gestor
go

grant select, insert, update on schema :: ventas to gestor
go

grant execute to gestor
go



--  PERMISOS PARA EL ROL administrador


grant control on database :: guarderia_mascotas to administrador
go



--  USUARIO: usuarioConsulta

if not exists(select 1 from sys.server_principals where name = 'usuarioConsulta')
begin
    create login usuarioConsulta with password = N'1234Zaq*',
        default_database = guarderia_mascotas,
        check_expiration = off,
        check_policy = off
end
go

if not exists(select 1 from sys.database_principals where name = 'usuarioConsulta')
begin
    create user usuarioConsulta for login usuarioConsulta
end
go

alter role consulta add member usuarioConsulta
go



--USUARIO: usuarioGestor


if not exists(select 1 from sys.server_principals where name = 'usuarioGestor')
begin
    create login usuarioGestor with password = N'1234Zaq*',
        default_database = guarderia_mascotas,
        check_expiration = off,
        check_policy = off
end
go

if not exists(select 1 from sys.database_principals where name = 'usuarioGestor')
begin
    create user usuarioGestor for login usuarioGestor
end
go

alter role gestor add member usuarioGestor
go



--  USUARIO: usuarioAdministrador


if not exists(select 1 from sys.server_principals where name = 'usuarioAdministrador')
begin
    create login usuarioAdministrador with password = N'1234Zaq*',
        default_database = guarderia_mascotas,
        check_expiration = off,
        check_policy = off
end
go

if not exists(select 1 from sys.database_principals where name = 'usuarioAdministrador')
begin
    create user usuarioAdministrador for login usuarioAdministrador
end
go

alter role administrador add member usuarioAdministrador
go



--  PROCEDIMIENTO PARA CREAR USUARIOS
-- Recibe:, nombre de usuario, contraseña, función: consulta, gestor o administrador


create or alter procedure procSeguridad
(
    @usuario varchar(40),
    @contrasena varchar(40),
    @funcion varchar(20)
)
as
begin
    
    declare @comando varchar(max)
    declare @rol varchar(30)

    /* validar función */
    if lower(@funcion) = 'consulta'
    begin
        set @rol = 'consulta'
    end
    else if lower(@funcion) = 'gestor'
    begin
        set @rol = 'gestor'
    end
    else if lower(@funcion) in ('administrador', 'admin')
    begin
        set @rol = 'administrador'
    end
    else
    begin
        print 'La función debe ser consulta, gestor o administrador'
        return
    end

    --crear login si no existe
    if not exists(select 1 from sys.server_principals where name = @usuario)
    begin
        set @comando = 'create login ' + quotename(@usuario) +
                       ' with password = ' + quotename(@contrasena, '''') +
                       ', default_database = guarderia_mascotas, check_expiration = off, check_policy = off'

        execute(@comando)
    end

    --crear usuario dentro de la base de datos si no existe
    if not exists(select 1 from sys.database_principals where name = @usuario)
    begin
        set @comando = 'create user ' + quotename(@usuario) +
                       ' for login ' + quotename(@usuario)

        execute(@comando)
    end

    --agrega usuario al rol indicado
    if not exists(
        select 1
        from sys.database_role_members drm
        inner join sys.database_principals r
            on r.principal_id = drm.role_principal_id
        inner join sys.database_principals u
            on u.principal_id = drm.member_principal_id
        where r.name = @rol
          and u.name = @usuario
    )
    begin
        set @comando = 'alter role ' + quotename(@rol) +
                       ' add member ' + quotename(@usuario)

        execute(@comando)
    end

    print 'Usuario creado correctamente'
end
go



---CREACIÓN DE USUARIOS

exec procSeguridad 'nuevoConsulta', '1234Zaq*', 'consulta'
go

exec procSeguridad 'nuevoGestor', '1234Zaq*', 'gestor'
go

exec procSeguridad 'nuevoAdmin', '1234Zaq*', 'administrador'
go

