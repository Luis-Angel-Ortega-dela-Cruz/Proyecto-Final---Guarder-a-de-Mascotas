--AUTORES: Ortega de la Cruz Luis Angel 
--		   Quezada Yépez Leonardo André 
--		   Rodríguez Ruiz Diana Carolina
--FECHA: 30/05/2026
--DESCRIPCIÓN: Creación de la base de datos, esquemas y sinónimos para las tablas.

 create database [guarderia_mascotas];
 go

 use [guarderia_mascotas];
 go

CREATE TABLE GERENTE(
    EMPLEADO_ID    numeric(10, 0)    NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY NONCLUSTERED (EMPLEADO_ID), 
)
go



IF OBJECT_ID('GERENTE') IS NOT NULL
    PRINT '<<< CREATED TABLE GERENTE >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE GERENTE >>>'
go

/* 
 * TABLE: CENTRO 
 */

CREATE TABLE ESTADO(
	ESTADO_ID              numeric(5,0)      NOT NULL,
	NOMBRE                 varchar(50)       NOT NULL,
	CONSTRAINT estado_pk PRIMARY KEY (ESTADO_ID),
	CONSTRAINT estado_nombre_uk UNIQUE(NOMBRE)
)
GO

CREATE TABLE CENTRO(
    CENTRO_ID               numeric(5, 0)     NOT NULL,
    NOMBRE                  varchar(40)       NOT NULL,
    DIRECCION               varchar(100)      NOT NULL,
    TIPO                    char(1)           NOT NULL,
    GERENTE_ENCARGADO_ID    numeric(10, 0)    NULL,
	ESTADO_ID              numeric(5,0)      NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED (CENTRO_ID), 
    CONSTRAINT RefGERENTE33 FOREIGN KEY (GERENTE_ENCARGADO_ID)
    REFERENCES GERENTE(EMPLEADO_ID),
	CONSTRAINT centro_estado_id FOREIGN KEY (ESTADO_ID)
	REFERENCES ESTADO(ESTADO_ID),
	CONSTRAINT ck_tipo_centro check(tipo in('N', 'R'))
)
go



IF OBJECT_ID('CENTRO') IS NOT NULL
    PRINT '<<< CREATED TABLE CENTRO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CENTRO >>>'
go

/* 
 * TABLE: EMPLEADO 
 */

CREATE TABLE EMPLEADO(
    EMPLEADO_ID      numeric(10, 0)    NOT NULL,
    TIPO_EMPLEADO    char(1)           NOT NULL,
    NOMBRE           varchar(40)       NOT NULL,
    AP_PAT           varchar(40)       NOT NULL,
    AP_MAT           varchar(40)       NOT NULL,
    CURP             varchar(18)       NOT NULL,
    CENTRO_ID        numeric(5, 0)     NOT NULL,
    DOMICILIO        varchar(100)      NOT NULL,
    USUARIO          varchar(40)       NOT NULL,
    CONTRASEÑA       varchar(20)       NOT NULL,
    SUELDO           numeric(10, 2)    NOT NULL,
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (EMPLEADO_ID), 
    CONSTRAINT RefCENTRO10 FOREIGN KEY (CENTRO_ID)
    REFERENCES CENTRO(CENTRO_ID),
	CONSTRAINT ck_tipo_empleado_empleado
	  check(tipo_empleado in ('V','E','G','A','C')),
	CONSTRAINT uk_curp_empleado UNIQUE(curp),
	CONSTRAINT uk_usuario_empleado UNIQUE(usuario)
)
go

--Permite crear correctamente la tabla gerente:
alter table GERENTE add 
  CONSTRAINT RefEMPLEADO45 FOREIGN KEY (EMPLEADO_ID)
  REFERENCES EMPLEADO(EMPLEADO_ID);
go

IF OBJECT_ID('EMPLEADO') IS NOT NULL
    PRINT '<<< CREATED TABLE EMPLEADO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE EMPLEADO >>>'
go

/* 
 * TABLE: ADMINISTRATIVO 
 */

CREATE TABLE ADMINISTRATIVO(
    EMPLEADO_ID    numeric(10, 0)    NOT NULL,
    CONSTRAINT PK7 PRIMARY KEY NONCLUSTERED (EMPLEADO_ID), 
    CONSTRAINT RefEMPLEADO47 FOREIGN KEY (EMPLEADO_ID)
      REFERENCES EMPLEADO(EMPLEADO_ID)
)
go



IF OBJECT_ID('ADMINISTRATIVO') IS NOT NULL
    PRINT '<<< CREATED TABLE ADMINISTRATIVO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ADMINISTRATIVO >>>'
go

/* 
 * TABLE: BANCO 
 */

CREATE TABLE BANCO(
    BANCO_ID    numeric(10, 0)    NOT NULL,
    NOMBRE      varchar(40)       NOT NULL,
    CONSTRAINT PK12 PRIMARY KEY NONCLUSTERED (BANCO_ID)
)
go



IF OBJECT_ID('BANCO') IS NOT NULL
    PRINT '<<< CREATED TABLE BANCO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE BANCO >>>'
go

/* 
 * TABLE: CLIENTE 
 */

CREATE TABLE CLIENTE(
    CLIENTE_ID     numeric(10, 0)    identity(1,1),
    NOMBRE         varchar(40)       NOT NULL,
    AP_PAT         varchar(40)       NOT NULL,
    AP_MAT         varchar(40)       NOT NULL,
    DOMICILIO      varchar(100)      NOT NULL,
    CURP           varchar(18)       NOT NULL,
    GENERO         char(1)           NOT NULL,
    CORREO         varchar(40)       NOT NULL,
    USUARIO        varchar(40)       NOT NULL,
    EMPLEADO_ID    numeric(10, 0)    NOT NULL,
    CONSTRAINT PK9 PRIMARY KEY NONCLUSTERED (CLIENTE_ID), 
    CONSTRAINT RefADMINISTRATIVO50 FOREIGN KEY (EMPLEADO_ID)
      REFERENCES ADMINISTRATIVO(EMPLEADO_ID),
	CONSTRAINT uk_curp_cliente UNIQUE(curp),
	CONSTRAINT uk_usuario_cliente UNIQUE(usuario),
	CONSTRAINT ck_genero_cliente CHECK(genero in ('H','M')),
	CONSTRAINT uk_correo_cliente UNIQUE(correo)
)
go



IF OBJECT_ID('CLIENTE') IS NOT NULL
    PRINT '<<< CREATED TABLE CLIENTE >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CLIENTE >>>'
go

/* 
 * TABLE: VENTA 
 */

CREATE TABLE VENTA(
    VENTA_ID      numeric(10, 0)    identity(1,1),
    TIPO          char(1)           NOT NULL,
    COSTO         numeric(10, 2)    NOT NULL,
    FECHA         datetime          NOT NULL,
    CLIENTE_ID    numeric(10, 0)    NOT NULL,
    CONSTRAINT PK33 PRIMARY KEY NONCLUSTERED (VENTA_ID), 
    CONSTRAINT RefCLIENTE28 FOREIGN KEY (CLIENTE_ID)
    REFERENCES CLIENTE(CLIENTE_ID),
	CONSTRAINT ck_tipo_venta CHECK(tipo in ('F','L'))
)
go



IF OBJECT_ID('VENTA') IS NOT NULL
    PRINT '<<< CREATED TABLE VENTA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE VENTA >>>'
go

/* 
 * TABLE: ENCARGADOR_TIENDA 
 */

CREATE TABLE ENCARGADOR_TIENDA(
    EMPLEADO_ID    numeric(10, 0)    NOT NULL,
    CONSTRAINT PK8 PRIMARY KEY NONCLUSTERED (EMPLEADO_ID), 
    CONSTRAINT RefEMPLEADO44 FOREIGN KEY (EMPLEADO_ID)
    REFERENCES EMPLEADO(EMPLEADO_ID)
)
go



IF OBJECT_ID('ENCARGADOR_TIENDA') IS NOT NULL
    PRINT '<<< CREATED TABLE ENCARGADOR_TIENDA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ENCARGADOR_TIENDA >>>'
go

/* 
 * TABLE: FISICA 
 */

CREATE TABLE FISICA(
    VENTA_ID               numeric(10, 0)    NOT NULL,
    COMISION               numeric(10, 2)    NOT NULL,
    ID_ENCARGADO_TIENDA    numeric(10, 0)    NOT NULL,
    CONSTRAINT PK35 PRIMARY KEY NONCLUSTERED (VENTA_ID), 
    CONSTRAINT RefVENTA22 FOREIGN KEY (VENTA_ID)
    REFERENCES VENTA(VENTA_ID),
    CONSTRAINT RefENCARGADOR_TIENDA32 FOREIGN KEY (ID_ENCARGADO_TIENDA)
    REFERENCES ENCARGADOR_TIENDA(EMPLEADO_ID)
)
go



IF OBJECT_ID('FISICA') IS NOT NULL
    PRINT '<<< CREATED TABLE FISICA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE FISICA >>>'
go

/* 
 * TABLE: CATEGORIA 
 */

CREATE TABLE CATEGORIA(
    CATEGORIA_ID    numeric(10, 0)    NOT NULL,
    NOMBRE          varchar(40)       NOT NULL,
    DESCRIPCION     varchar(400)      NOT NULL,
    EMPLEADO_ID     numeric(10, 0)    NOT NULL,
    CONSTRAINT PK28 PRIMARY KEY NONCLUSTERED (CATEGORIA_ID), 
    CONSTRAINT RefADMINISTRATIVO14 FOREIGN KEY (EMPLEADO_ID)
    REFERENCES ADMINISTRATIVO(EMPLEADO_ID),
	CONSTRAINT uk_nombre_categoria UNIQUE(nombre)
)
go



IF OBJECT_ID('CATEGORIA') IS NOT NULL
    PRINT '<<< CREATED TABLE CATEGORIA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CATEGORIA >>>'
go

/* 
 * TABLE: OFERTA 
 */

CREATE TABLE OFERTA(
    OFERTA_ID       numeric(10, 0)    NOT NULL,
    FECHA_FIN       datetime          NOT NULL,
    DESCRIPCION     varchar(400)      NOT NULL,
    TIPO            varchar(10)       NOT NULL,
    FECHA_INICIO    datetime          NOT NULL,
    EMPLEADO_ID     numeric(10, 0)    NOT NULL,
    CONSTRAINT PK29 PRIMARY KEY NONCLUSTERED (OFERTA_ID), 
    CONSTRAINT RefADMINISTRATIVO15 FOREIGN KEY (EMPLEADO_ID)
    REFERENCES ADMINISTRATIVO(EMPLEADO_ID),
	CONSTRAINT ck_tipo_oferta CHECK(tipo in ('NORMAL', 'LIMITADA'))
)
go



IF OBJECT_ID('OFERTA') IS NOT NULL
    PRINT '<<< CREATED TABLE OFERTA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE OFERTA >>>'
go

/* 
 * TABLE: PRODUCTO 
 */

CREATE TABLE PRODUCTO(
    PRODUCTO_ID     numeric(10, 0)    NOT NULL,
    NOMBRE          varchar(40)       NOT NULL,
    FOTO            image             NOT NULL,
    COSTO           numeric(10, 2)    NOT NULL,
    DESCRIPCION     varchar(400)      NOT NULL,
    CATEGORIA_ID    numeric(10, 0)    NOT NULL,
    OFERTA_ID       numeric(10, 0)    NOT NULL,
    EMPLEADO_ID     numeric(10, 0)    NOT NULL,
    CONSTRAINT PK27 PRIMARY KEY NONCLUSTERED (PRODUCTO_ID), 
    CONSTRAINT RefCATEGORIA16 FOREIGN KEY (CATEGORIA_ID)
    REFERENCES CATEGORIA(CATEGORIA_ID),
    CONSTRAINT RefOFERTA17 FOREIGN KEY (OFERTA_ID)
    REFERENCES OFERTA(OFERTA_ID),
    CONSTRAINT RefADMINISTRATIVO18 FOREIGN KEY (EMPLEADO_ID)
    REFERENCES ADMINISTRATIVO(EMPLEADO_ID),
	CONSTRAINT uk_nombre_producto UNIQUE(nombre)
)
go



IF OBJECT_ID('PRODUCTO') IS NOT NULL
    PRINT '<<< CREATED TABLE PRODUCTO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE PRODUCTO >>>'
go

/* 
 * TABLE: INV_CENTRO_NORMAL 
 */

CREATE TABLE INV_CENTRO_NORMAL(
    INV_CRETRO_NORMAL_ID    numeric(10, 0)    NOT NULL,
    EXISTENCIAS             numeric(5, 0)     NOT NULL,
    PRODUCTO_ID             numeric(10, 0)    NOT NULL,
    CENTRO_ID               numeric(5, 0)     NOT NULL,
    CONSTRAINT PK30_1 PRIMARY KEY NONCLUSTERED (INV_CRETRO_NORMAL_ID), 
    CONSTRAINT RefCENTRO39 FOREIGN KEY (CENTRO_ID)
    REFERENCES CENTRO(CENTRO_ID),
    CONSTRAINT RefPRODUCTO20 FOREIGN KEY (PRODUCTO_ID)
    REFERENCES PRODUCTO(PRODUCTO_ID),
	CONSTRAINT uk_producto_id_centro_id_inv_centro_normal
	  UNIQUE(producto_id, centro_id)
)
go



IF OBJECT_ID('INV_CENTRO_NORMAL') IS NOT NULL
    PRINT '<<< CREATED TABLE INV_CENTRO_NORMAL >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE INV_CENTRO_NORMAL >>>'
go

/* 
 * TABLE: CARRITO_FISICO 
 */

CREATE TABLE CARRITO_FISICO(
    VENTA_ID                numeric(10, 0)    NOT NULL,
    INV_CRETRO_NORMAL_ID    numeric(10, 0)    NOT NULL,
    CANTIDAD                numeric(5, 0)     NOT NULL,
    COSTO_TOTAL             numeric(10, 2)    NOT NULL,
    CONSTRAINT PK37 PRIMARY KEY NONCLUSTERED (VENTA_ID, INV_CRETRO_NORMAL_ID), 
    CONSTRAINT RefFISICA25 FOREIGN KEY (VENTA_ID)
    REFERENCES FISICA(VENTA_ID),
    CONSTRAINT RefINV_CENTRO_NORMAL26 FOREIGN KEY (INV_CRETRO_NORMAL_ID)
    REFERENCES INV_CENTRO_NORMAL(INV_CRETRO_NORMAL_ID)
)
go



IF OBJECT_ID('CARRITO_FISICO') IS NOT NULL
    PRINT '<<< CREATED TABLE CARRITO_FISICO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CARRITO_FISICO >>>'
go

/* 
 * TABLE: ESTADO_VENTA 
 */

CREATE TABLE ESTADO_VENTA(
    ESTADO_ID      numeric(3, 0)    NOT NULL,
    NOMBRE         varchar(40)      NOT NULL,
    DESCRIPCION    varchar(400)     NOT NULL,
    CONSTRAINT PK39 PRIMARY KEY NONCLUSTERED (ESTADO_ID),
	CONSTRAINT uk_nombre_estado_venta UNIQUE(nombre)
)
go



IF OBJECT_ID('ESTADO_VENTA') IS NOT NULL
    PRINT '<<< CREATED TABLE ESTADO_VENTA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ESTADO_VENTA >>>'
go

/* 
 * TABLE: LINEA 
 */

CREATE TABLE LINEA(
    VENTA_ID              numeric(10, 0)    NOT NULL,
    TARIFA_CANCELACION    numeric(10, 2)    NULL,
    ESTADO_ID             numeric(3, 0)     NOT NULL,
    CONSTRAINT PK34 PRIMARY KEY NONCLUSTERED (VENTA_ID), 
    CONSTRAINT RefVENTA21 FOREIGN KEY (VENTA_ID)
    REFERENCES VENTA(VENTA_ID),
    CONSTRAINT RefESTADO_VENTA27 FOREIGN KEY (ESTADO_ID)
    REFERENCES ESTADO_VENTA(ESTADO_ID)
)
go



IF OBJECT_ID('LINEA') IS NOT NULL
    PRINT '<<< CREATED TABLE LINEA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE LINEA >>>'
go

/* 
 * TABLE: INV_CENTRO_REGIONAL 
 */

CREATE TABLE INV_CENTRO_REGIONAL(
    INV_CRETRO_REGIONAL_ID    numeric(10, 0)    NOT NULL,
    EXISTENCIAS               numeric(5, 0)     NOT NULL,
    PRODUCTO_ID               numeric(10, 0)    NOT NULL,
    CENTRO_ID                 numeric(5, 0)     NOT NULL,
    CONSTRAINT PK30 PRIMARY KEY NONCLUSTERED (INV_CRETRO_REGIONAL_ID), 
    CONSTRAINT RefCENTRO40 FOREIGN KEY (CENTRO_ID)
    REFERENCES CENTRO(CENTRO_ID),
    CONSTRAINT RefPRODUCTO19 FOREIGN KEY (PRODUCTO_ID)
    REFERENCES PRODUCTO(PRODUCTO_ID),
	CONSTRAINT uk_producto_id_centro_id_inv_centro_regional
	  UNIQUE(producto_id, centro_id)
)
go



IF OBJECT_ID('INV_CENTRO_REGIONAL') IS NOT NULL
    PRINT '<<< CREATED TABLE INV_CENTRO_REGIONAL >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE INV_CENTRO_REGIONAL >>>'
go

/* 
 * TABLE: CARRITO_LINEA 
 */

CREATE TABLE CARRITO_LINEA(
    VENTA_ID                  numeric(10, 0)    NOT NULL,
    INV_CRETRO_REGIONAL_ID    numeric(10, 0)    NOT NULL,
    CANTIDAD                  numeric(5, 0)     NOT NULL,
    COSTO_TOTAL               numeric(10, 2)    NOT NULL,
    CONSTRAINT PK36 PRIMARY KEY NONCLUSTERED (VENTA_ID, INV_CRETRO_REGIONAL_ID), 
    CONSTRAINT RefLINEA23 FOREIGN KEY (VENTA_ID)
    REFERENCES LINEA(VENTA_ID),
    CONSTRAINT RefINV_CENTRO_REGIONAL24 FOREIGN KEY (INV_CRETRO_REGIONAL_ID)
    REFERENCES INV_CENTRO_REGIONAL(INV_CRETRO_REGIONAL_ID)
)
go



IF OBJECT_ID('CARRITO_LINEA') IS NOT NULL
    PRINT '<<< CREATED TABLE CARRITO_LINEA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CARRITO_LINEA >>>'
go

/* 
 * TABLE: VETERINARIO 
 */

CREATE TABLE VETERINARIO(
    EMPLEADO_ID     numeric(10, 0)    NOT NULL,
    CEDULA          varchar(40)       NOT NULL,
    ESPECIALIDAD    varchar(40)       NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (EMPLEADO_ID), 
    CONSTRAINT RefEMPLEADO48 FOREIGN KEY (EMPLEADO_ID)
    REFERENCES EMPLEADO(EMPLEADO_ID)
)
go



IF OBJECT_ID('VETERINARIO') IS NOT NULL
    PRINT '<<< CREATED TABLE VETERINARIO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE VETERINARIO >>>'
go


/* 
 * TABLE: RAZA 
 */

CREATE TABLE ESPECIE(
    ESPECIE_ID       numeric(10, 0)    NOT NULL,
    NOMBRE           varchar(5)        NOT NULL,
    CONSTRAINT PK14 PRIMARY KEY NONCLUSTERED (ESPECIE_ID), 
	CONSTRAINT uk_nombre_especie UNIQUE(nombre),
	CONSTRAINT ck_nombre_especie CHECK(nombre in ('gato', 'perro'))
)
go

IF OBJECT_ID('ESPECIE') IS NOT NULL
    PRINT '<<< CREATED TABLE ESPECIE >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ESPECIE >>>'
go

/* 
 * TABLE: ESPECIE 
 */

CREATE TABLE RAZA(
    RAZA_ID    numeric(10, 0)    NOT NULL,
    NOMBRE        varchar(40)       NOT NULL,
	ESPECIE_ID       numeric(10, 0)    NOT NULL,
    CONSTRAINT PK15 PRIMARY KEY NONCLUSTERED (RAZA_ID),
	CONSTRAINT RAZA_ESPECIE_ID_FK FOREIGN KEY (ESPECIE_ID)
	REFERENCES ESPECIE(ESPECIE_ID),
	CONSTRAINT uk_nombre_raza UNIQUE(nombre)
)
go



IF OBJECT_ID('RAZA') IS NOT NULL
    PRINT '<<< CREATED TABLE RAZA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE RAZA >>>'
go


/* 
 * TABLE: MASCOTA 
 */

CREATE TABLE MASCOTA(
    MASCOTA_ID      numeric(10, 0)    NOT NULL,
    GENERO          char(1)           NOT NULL,
    RASGO           varchar(400)      NOT NULL,
    NOMBRE          varchar(40)       NOT NULL,
    CLIENTE_ID      numeric(10, 0)    NOT NULL,
    RAZA_ID         numeric(10, 0)    NOT NULL,
    CONSTRAINT PK13 PRIMARY KEY NONCLUSTERED (MASCOTA_ID), 
    CONSTRAINT RefCLIENTE3 FOREIGN KEY (CLIENTE_ID)
    REFERENCES CLIENTE(CLIENTE_ID),
    CONSTRAINT RefRAZA5 FOREIGN KEY (RAZA_ID)
    REFERENCES RAZA(RAZA_ID),
	CONSTRAINT ck_genero_mascota CHECK(genero in ('M','H'))
)
go



IF OBJECT_ID('MASCOTA') IS NOT NULL
    PRINT '<<< CREATED TABLE MASCOTA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE MASCOTA >>>'
go

/* 
 * TABLE: BRAZALETE 
 */

CREATE TABLE BRAZALETE(
    BRAZALETE_ID         numeric(10, 0)    NOT NULL,
    MEDICAMENTO          varchar(50)       NOT NULL,
    CUIDADOS             varchar(400)      NOT NULL,
    TIPO_ALIMENTACION    varchar(40)       NOT NULL,
    CANTIDAD_COMIDA      numeric(3, 0)     NOT NULL,
    ESTADO               varchar(40)       NOT NULL,
	MASCOTA_ID      numeric(10, 0)         NOT NULL,
    CONSTRAINT PK16 PRIMARY KEY NONCLUSTERED (BRAZALETE_ID),
	CONSTRAINT BRAZALETE_MASCOTA_ID FOREIGN KEY(MASCOTA_ID)
	REFERENCES MASCOTA(MASCOTA_ID)
)
go

CREATE TABLE SIGNOS_VITALES(
	SIGNOS_VITALES_ID    numeric(10, 0)    NOT NULL,
	RITMO_CARDIACO       numeric(3, 0)     NOT NULL,
	TEMPERATURA          numeric(2, 0)     NOT NULL,
    NIVEL_OXIGENACION    numeric(3, 0)     NOT NULL,
	BRAZALETE_ID         numeric(10, 0)    NOT NULL,
	CONSTRAINT SIGNOS_VITALES_PK PRIMARY KEY(SIGNOS_VITALES_ID),
	CONSTRAINT SIGNOS_VITALES_BRAZALETE_ID_FK 
	FOREIGN KEY (BRAZALETE_ID) REFERENCES BRAZALETE(BRAZALETE_ID)
)
GO


IF OBJECT_ID('BRAZALETE') IS NOT NULL
    PRINT '<<< CREATED TABLE BRAZALETE >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE BRAZALETE >>>'
go

/* 
 * TABLE: CONSULTA 
 */

CREATE TABLE CONSULTA(
    CONSULTA_ID    numeric(10, 0)     NOT NULL,
    DIAGNOSTICO    varchar(400)       NOT NULL,
    FECHA          datetime           NOT NULL,
    DETALLES       varchar(400)       NOT NULL,
    COSTO          numeric(10, 2)     default 350,
    EMPLEADO_ID    numeric(10, 0)     NOT NULL,
    MASCOTA_ID     numeric(10, 0)     NOT NULL,
    CONSTRAINT PK20 PRIMARY KEY NONCLUSTERED (CONSULTA_ID), 
    CONSTRAINT RefVETERINARIO8 FOREIGN KEY (EMPLEADO_ID)
    REFERENCES VETERINARIO(EMPLEADO_ID),
    CONSTRAINT RefMASCOTA9 FOREIGN KEY (MASCOTA_ID)
    REFERENCES MASCOTA(MASCOTA_ID)
)
go



IF OBJECT_ID('CONSULTA') IS NOT NULL
    PRINT '<<< CREATED TABLE CONSULTA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CONSULTA >>>'
go

/* 
 * TABLE: CUIDADOR 
 */

CREATE TABLE CUIDADOR(
    EMPLEADO_ID            numeric(10, 0)    NOT NULL,
    CUIDADOR_LIDER         numeric(10, 0)    NULL,
    EDAD                   numeric(2, 0)     NOT NULL,
    ESPECIE_ASIGNADA_ID    numeric(10, 0)    NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY NONCLUSTERED (EMPLEADO_ID), 
    CONSTRAINT RefESPECIE41 FOREIGN KEY (ESPECIE_ASIGNADA_ID)
    REFERENCES ESPECIE(ESPECIE_ID),
    CONSTRAINT RefEMPLEADO46 FOREIGN KEY (EMPLEADO_ID)
    REFERENCES EMPLEADO(EMPLEADO_ID),
    CONSTRAINT RefCUIDADOR49 FOREIGN KEY (CUIDADOR_LIDER)
    REFERENCES CUIDADOR(EMPLEADO_ID)
)
go



IF OBJECT_ID('CUIDADOR') IS NOT NULL
    PRINT '<<< CREATED TABLE CUIDADOR >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CUIDADOR >>>'
go

/* 
 * TABLE: ENFERMEDAD 
 */

CREATE TABLE ENFERMEDAD(
    ENFERMEDAD_ID    numeric(10, 0)    NOT NULL,
    NOMBRE           varchar(40)       NOT NULL,
    DESCRIPCION      varchar(400)      NOT NULL,
    CONSTRAINT PK17 PRIMARY KEY NONCLUSTERED (ENFERMEDAD_ID),
	CONSTRAINT uk_nombre_enfermeadad UNIQUE(nombre)
)
go



IF OBJECT_ID('ENFERMEDAD') IS NOT NULL
    PRINT '<<< CREATED TABLE ENFERMEDAD >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ENFERMEDAD >>>'
go

/* 
 * TABLE: ENVIO 
 */

CREATE TABLE ENVIO(
    ENVIO_ID     numeric(10, 0)    NOT NULL,
    VENTA_ID     numeric(10, 0)    NOT NULL,
    DISTANCIA    numeric(4, 0)     NOT NULL,
    TARIFA       as 40*distancia persisted,
    CONSTRAINT PK40 PRIMARY KEY NONCLUSTERED (ENVIO_ID), 
    CONSTRAINT RefLINEA30 FOREIGN KEY (VENTA_ID)
    REFERENCES LINEA(VENTA_ID)
)
go



IF OBJECT_ID('ENVIO') IS NOT NULL
    PRINT '<<< CREATED TABLE ENVIO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ENVIO >>>'
go

/* 
 * TABLE: ESTACION_AÑO 
 */

CREATE TABLE ESTACION_AÑO(
    ESTACION_ID    numeric(1, 0)    NOT NULL,
    NOMBRE         varchar(40)      NOT NULL,
    CONSTRAINT PK26 PRIMARY KEY NONCLUSTERED (ESTACION_ID),
	CONSTRAINT uk_nombre_estacion_año UNIQUE(nombre)
)
go



IF OBJECT_ID('ESTACION_AÑO') IS NOT NULL
    PRINT '<<< CREATED TABLE ESTACION_AÑO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ESTACION_AÑO >>>'
go

/* 
 * TABLE: ESTANCIA 
 */

CREATE TABLE ESTANCIA(
    ID_ESTANCIA      numeric(10, 0)    NOT NULL,
	--Permite poner la fecha actual por defecto si es que no se especifica
    FECHA_INICIO     datetime          default getdate(), 
	--Calculo de atributo derivado
    FECHA_FIN        as (DATEADD(day,dias_estancia,fecha_inicio)) PERSISTED,
    DIAS_ESTANCIA    numeric(3, 0)     NOT NULL,
    COSTO            as 500*dias_estancia PERSISTED,
    CENTRO_ID        numeric(5, 0)     NOT NULL,
    MASCOTA_ID       numeric(10, 0)    NOT NULL,
    ID_CUIDADOR      numeric(10, 0)    NOT NULL,
    ESTACION_ID      numeric(1, 0)     NOT NULL,
    CONSTRAINT PK24 PRIMARY KEY NONCLUSTERED (ID_ESTANCIA), 
    CONSTRAINT RefMASCOTA35 FOREIGN KEY (MASCOTA_ID)
    REFERENCES MASCOTA(MASCOTA_ID),
    CONSTRAINT RefCUIDADOR36 FOREIGN KEY (ID_CUIDADOR)
    REFERENCES CUIDADOR(EMPLEADO_ID),
    CONSTRAINT RefESTACION_AÑO37 FOREIGN KEY (ESTACION_ID)
    REFERENCES ESTACION_AÑO(ESTACION_ID),
    CONSTRAINT RefCENTRO13 FOREIGN KEY (CENTRO_ID)
    REFERENCES CENTRO(CENTRO_ID)
)
go



IF OBJECT_ID('ESTANCIA') IS NOT NULL
    PRINT '<<< CREATED TABLE ESTANCIA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ESTANCIA >>>'
go

/* 
 * TABLE: HISTORICO_ESTANCIA 
 */

CREATE TABLE HISTORICO_ESTANCIA(
    HISTRICIO_ESTANCIA_ID    numeric(10, 0)    NOT NULL,
    COSTO                    numeric(10, 2)    NOT NULL,
    CENTRO_ID                numeric(5, 0)     NOT NULL,
    MASCOTA_ID               numeric(10, 0)    NOT NULL,
    ID_CUIDADOR              numeric(10, 0)    NOT NULL,
    ESTACION_ID              numeric(1, 0)     NOT NULL,
    FECHA_INICIO             date              NOT NULL,
    FECHA_FIN                date              NOT NULL,
    DIAS_ESTANCIA            numeric(3, 0)     NOT NULL,
    ID_ESTANCIA              numeric(10, 0)    NOT NULL,
    CONSTRAINT PK25 PRIMARY KEY NONCLUSTERED (HISTRICIO_ESTANCIA_ID), 
    CONSTRAINT RefESTANCIA38 FOREIGN KEY (ID_ESTANCIA)
    REFERENCES ESTANCIA(ID_ESTANCIA)
)
go



IF OBJECT_ID('HISTORICO_ESTANCIA') IS NOT NULL
    PRINT '<<< CREATED TABLE HISTORICO_ESTANCIA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HISTORICO_ESTANCIA >>>'
go

/* 
 * TABLE: MEDICAMENTO 
 */

CREATE TABLE MEDICAMENTO(
    MEDICAMENTO_ID    numeric(10, 0)    NOT NULL,
    NOMBRE            varchar(40)       NOT NULL,
    COSTO             numeric(10,2)             NOT NULL,
    CONSTRAINT PK22 PRIMARY KEY NONCLUSTERED (MEDICAMENTO_ID),
	CONSTRAINT uk_nombre_medicamento UNIQUE(nombre)
)
go



IF OBJECT_ID('MEDICAMENTO') IS NOT NULL
    PRINT '<<< CREATED TABLE MEDICAMENTO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE MEDICAMENTO >>>'
go

/* 
 * TABLE: INVENTARIO_MEDICO 
 */

CREATE TABLE INVENTARIO_MEDICO(
    INV_MED_ID        numeric(10, 0)    NOT NULL,
    MEDICAMENTO_ID    numeric(10, 0)    NOT NULL,
    CANTIDAD          numeric(5, 0)     NOT NULL,
    CENTRO_ID         numeric(5, 0)     NOT NULL,
    CONSTRAINT PK21 PRIMARY KEY NONCLUSTERED (INV_MED_ID), 
    CONSTRAINT RefMEDICAMENTO11 FOREIGN KEY (MEDICAMENTO_ID)
    REFERENCES MEDICAMENTO(MEDICAMENTO_ID),
    CONSTRAINT RefCENTRO29 FOREIGN KEY (CENTRO_ID)
    REFERENCES CENTRO(CENTRO_ID),
	CONSTRAINT uk_centro_id_medicamento_id UNIQUE(medicamento_id,centro_id)
)
go



IF OBJECT_ID('INVENTARIO_MEDICO') IS NOT NULL
    PRINT '<<< CREATED TABLE INVENTARIO_MEDICO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE INVENTARIO_MEDICO >>>'
go

/* 
 * TABLE: INV_MED_CONSULTA 
 */

CREATE TABLE INV_MED_CONSULTA(
    INV_MED_ID     numeric(10, 0)    NOT NULL,
    CONSULTA_ID    numeric(10, 0)    NOT NULL,
    CANTIDAD       numeric(3, 0)     NOT NULL,
    COSTO_TOTAL    numeric(10, 2)    NOT NULL,
    CONSTRAINT PK23 PRIMARY KEY NONCLUSTERED (INV_MED_ID, CONSULTA_ID), 
    CONSTRAINT RefCONSULTA34 FOREIGN KEY (CONSULTA_ID)
    REFERENCES CONSULTA(CONSULTA_ID),
    CONSTRAINT RefINVENTARIO_MEDICO12 FOREIGN KEY (INV_MED_ID)
    REFERENCES INVENTARIO_MEDICO(INV_MED_ID)
)
go



IF OBJECT_ID('INV_MED_CONSULTA') IS NOT NULL
    PRINT '<<< CREATED TABLE INV_MED_CONSULTA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE INV_MED_CONSULTA >>>'
go

/* 
 * TABLE: MASCOTA_ENFERMEDAD 
 */

CREATE TABLE MASCOTA_ENFERMEDAD(
    MASCOTA_ID       numeric(10, 0)    NOT NULL,
    ENFERMEDAD_ID    numeric(10, 0)    NOT NULL,
    CONSTRAINT PK18 PRIMARY KEY NONCLUSTERED (MASCOTA_ID, ENFERMEDAD_ID), 
    CONSTRAINT RefMASCOTA6 FOREIGN KEY (MASCOTA_ID)
    REFERENCES MASCOTA(MASCOTA_ID),
    CONSTRAINT RefENFERMEDAD7 FOREIGN KEY (ENFERMEDAD_ID)
    REFERENCES ENFERMEDAD(ENFERMEDAD_ID)
)
go



IF OBJECT_ID('MASCOTA_ENFERMEDAD') IS NOT NULL
    PRINT '<<< CREATED TABLE MASCOTA_ENFERMEDAD >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE MASCOTA_ENFERMEDAD >>>'
go

/* 
 * TABLE: RECEPCION 
 */

CREATE TABLE RECEPCION(
    RECEPCION_ID     numeric(10, 0)    NOT NULL,
    ENVIO_ID         numeric(10, 0)    NOT NULL,
    NOMBRE           varchar(100)      NOT NULL,
    FECHA_ENTREGA    datetime          NOT NULL,
    FOTO             image             NOT NULL,
    CONSTRAINT PK41 PRIMARY KEY NONCLUSTERED (RECEPCION_ID), 
    CONSTRAINT RefENVIO31 FOREIGN KEY (ENVIO_ID)
    REFERENCES ENVIO(ENVIO_ID)
)
go



IF OBJECT_ID('RECEPCION') IS NOT NULL
    PRINT '<<< CREATED TABLE RECEPCION >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE RECEPCION >>>'
go

/* 
 * TABLE: TARJETA 
 */

CREATE TABLE TARJETA(
    TARJETA_ID    numeric(10, 0)    NOT NULL,
    MES_EXPIRA    numeric(2, 0)     NOT NULL,
    AÑO_EXPIRA    numeric(4, 0)     NOT NULL,
    NUMERO        varchar(20)       NOT NULL,
    TIPO          varchar(10)           NOT NULL,
    CLIENTE_ID    numeric(10, 0)    NOT NULL,
    BANCO_ID      numeric(10, 0)    NOT NULL,
    CONSTRAINT PK11 PRIMARY KEY NONCLUSTERED (TARJETA_ID), 
    CONSTRAINT RefCLIENTE1 FOREIGN KEY (CLIENTE_ID)
    REFERENCES CLIENTE(CLIENTE_ID),
    CONSTRAINT RefBANCO2 FOREIGN KEY (BANCO_ID)
    REFERENCES BANCO(BANCO_ID),
	CONSTRAINT ck_tipo_tarjeta CHECK(tipo in ('CREDITO', 'DEBITO')),
	CONSTRAINT uk_numero_tarjeta UNIQUE(numero)
)
go



IF OBJECT_ID('TARJETA') IS NOT NULL
    PRINT '<<< CREATED TABLE TARJETA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TARJETA >>>'
go

/* 
 * TABLE: TELEFONO_EMPLEADO 
 */

CREATE TABLE TELEFONO_EMPLEADO(
    EMPLEADO_ID    numeric(10, 0)    NOT NULL,
    TELEFONO       varchar(40)       NOT NULL,
    CONSTRAINT PK42 PRIMARY KEY NONCLUSTERED (EMPLEADO_ID, TELEFONO), 
    CONSTRAINT RefEMPLEADO43 FOREIGN KEY (EMPLEADO_ID)
    REFERENCES EMPLEADO(EMPLEADO_ID)
)
go



IF OBJECT_ID('TELEFONO_EMPLEADO') IS NOT NULL
    PRINT '<<< CREATED TABLE TELEFONO_EMPLEADO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TELEFONO_EMPLEADO >>>'
go

--Creación de secuencias

CREATE SEQUENCE seq_consulta
AS numeric(10,0)
START WITH 25
INCREMENT BY 1;
GO

create sequence seq_historico_estancia
as numeric(10,0)
start with 46
increment by 1;
go

------------------------
--CREACIÓN DE ESQUEMAS
------------------------

create schema ventas;
go

create schema operacion;
go

------------------------
--MOVER TABLAS A ESQUEMAS CREADOS
------------------------

--Esquema ventas
alter schema ventas transfer dbo.VENTA;
alter schema ventas transfer dbo.FISICA;
alter schema ventas transfer dbo.LINEA;
alter schema ventas transfer dbo.CARRITO_FISICO;
alter schema ventas transfer dbo.CARRITO_LINEA;
alter schema ventas transfer dbo.PRODUCTO;
alter schema ventas transfer dbo.INV_CENTRO_NORMAL;
alter schema ventas transfer dbo.INV_CENTRO_REGIONAL;
alter schema ventas transfer dbo.MEDICAMENTO;
alter schema ventas transfer dbo.INVENTARIO_MEDICO;
alter schema ventas transfer dbo.INV_MED_CONSULTA;
go


--Esquema operacion
alter schema operacion transfer dbo.ADMINISTRATIVO;
alter schema operacion transfer dbo.BANCO;
alter schema operacion transfer dbo.BRAZALETE;
alter schema operacion transfer dbo.CATEGORIA;
alter schema operacion transfer dbo.CUIDADOR;
alter schema operacion transfer dbo.ENVIO;
alter schema operacion transfer dbo.ESPECIE;
alter schema operacion transfer dbo.ESTACION_AÑO;
alter schema operacion transfer dbo.ESTADO;
alter schema operacion transfer dbo.GERENTE;
alter schema operacion transfer dbo.OFERTA;
alter schema operacion transfer dbo.RECEPCION;
alter schema operacion transfer dbo.SIGNOS_VITALES;
alter schema operacion transfer dbo.TARJETA;
alter schema operacion transfer dbo.TELEFONO_EMPLEADO;
alter schema operacion transfer dbo.CENTRO;
alter schema operacion transfer dbo.CLIENTE;
alter schema operacion transfer dbo.CONSULTA;
alter schema operacion transfer dbo.EMPLEADO;
alter schema operacion transfer dbo.ENCARGADOR_TIENDA;
alter schema operacion transfer dbo.ENFERMEDAD;
alter schema operacion transfer dbo.ESTADO_VENTA;
alter schema operacion transfer dbo.ESTANCIA;
alter schema operacion transfer dbo.HISTORICO_ESTANCIA;
alter schema operacion transfer dbo.MASCOTA;
alter schema operacion transfer dbo.MASCOTA_ENFERMEDAD;
alter schema operacion transfer dbo.RAZA;
alter schema operacion transfer dbo.VETERINARIO;
go
------------------------
--SINÓNIMOS PARA EVITAR ESCRIBIR EL ESQUEMA
------------------------

create synonym dbo.VENTA for ventas.VENTA;
create synonym dbo.FISICA for ventas.FISICA;
create synonym dbo.LINEA for ventas.LINEA;
create synonym dbo.CARRITO_FISICO for ventas.CARRITO_FISICO;
create synonym dbo.CARRITO_LINEA for ventas.CARRITO_LINEA;
create synonym dbo.PRODUCTO for ventas.PRODUCTO;
create synonym dbo.INV_CENTRO_NORMAL for ventas.INV_CENTRO_NORMAL;
create synonym dbo.INV_CENTRO_REGIONAL for ventas.INV_CENTRO_REGIONAL;
create synonym dbo.MEDICAMENTO for ventas.MEDICAMENTO;
create synonym dbo.INVENTARIO_MEDICO for ventas.INVENTARIO_MEDICO;
create synonym dbo.INV_MED_CONSULTA for ventas.INV_MED_CONSULTA;
go

create synonym dbo.ADMINISTRATIVO for operacion.ADMINISTRATIVO;
create synonym dbo.BANCO for operacion.BANCO;
create synonym dbo.BRAZALETE for operacion.BRAZALETE;
create synonym dbo.CATEGORIA for operacion.CATEGORIA;
create synonym dbo.CUIDADOR for operacion.CUIDADOR;
create synonym dbo.ENVIO for operacion.ENVIO;
create synonym dbo.ESPECIE for operacion.ESPECIE;
create synonym dbo.[ESTACION_AÑO] for operacion.[ESTACION_AÑO];
create synonym dbo.ESTADO for operacion.ESTADO;
create synonym dbo.GERENTE for operacion.GERENTE;
create synonym dbo.OFERTA for operacion.OFERTA;
create synonym dbo.RECEPCION for operacion.RECEPCION;
create synonym dbo.SIGNOS_VITALES for operacion.SIGNOS_VITALES;
create synonym dbo.TARJETA for operacion.TARJETA;
create synonym dbo.TELEFONO_EMPLEADO for operacion.TELEFONO_EMPLEADO;

create synonym dbo.CENTRO for operacion.CENTRO;
create synonym dbo.CLIENTE for operacion.CLIENTE;
create synonym dbo.CONSULTA for operacion.CONSULTA;
create synonym dbo.EMPLEADO for operacion.EMPLEADO;
create synonym dbo.ENCARGADOR_TIENDA for operacion.ENCARGADOR_TIENDA;
create synonym dbo.ENFERMEDAD for operacion.ENFERMEDAD;
create synonym dbo.ESTADO_VENTA for operacion.ESTADO_VENTA;
create synonym dbo.ESTANCIA for operacion.ESTANCIA;
create synonym dbo.HISTORICO_ESTANCIA for operacion.HISTORICO_ESTANCIA;
create synonym dbo.MASCOTA for operacion.MASCOTA;
create synonym dbo.MASCOTA_ENFERMEDAD for operacion.MASCOTA_ENFERMEDAD;
create synonym dbo.RAZA for operacion.RAZA;
create synonym dbo.VETERINARIO for operacion.VETERINARIO;
go