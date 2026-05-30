--Carga inicial: 

use [guarderia_mascotas]
go

--CARGA EN TABLA ESTADO
INSERT INTO ESTADO (ESTADO_ID, NOMBRE) VALUES (1, 'Ciudad de México');
INSERT INTO ESTADO (ESTADO_ID, NOMBRE) VALUES (2, 'Jalisco');
INSERT INTO ESTADO (ESTADO_ID, NOMBRE) VALUES (3, 'Nuevo León');
INSERT INTO ESTADO (ESTADO_ID, NOMBRE) VALUES (4, 'Puebla');
INSERT INTO ESTADO (ESTADO_ID, NOMBRE) VALUES (5, 'Yucatán');
INSERT INTO ESTADO (ESTADO_ID, NOMBRE) VALUES (6, 'Querétaro');
INSERT INTO ESTADO (ESTADO_ID, NOMBRE) VALUES (7, 'Guanajuato');
INSERT INTO ESTADO (ESTADO_ID, NOMBRE) VALUES (8, 'Veracruz');
INSERT INTO ESTADO (ESTADO_ID, NOMBRE) VALUES (9, 'Oaxaca');
INSERT INTO ESTADO (ESTADO_ID, NOMBRE) VALUES (10, 'Chihuahua');
GO
----------------------------------------------------

--CARGA DE CENTROS REGIONALES
INSERT INTO CENTRO 
(CENTRO_ID, NOMBRE, DIRECCION, TIPO, GERENTE_ENCARGADO_ID, ESTADO_ID)
VALUES
(1, 'Centro Regional CDMX',
 'Av. Paseo de la Reforma 222, Cuauhtémoc, Ciudad de México',
 'R', NULL, 1);

INSERT INTO CENTRO 
(CENTRO_ID, NOMBRE, DIRECCION, TIPO, GERENTE_ENCARGADO_ID, ESTADO_ID)
VALUES
(2, 'Centro Regional Jalisco',
 'Av. Vallarta 6503, Zapopan, Jalisco',
 'R', NULL, 2);

INSERT INTO CENTRO 
(CENTRO_ID, NOMBRE, DIRECCION, TIPO, GERENTE_ENCARGADO_ID, ESTADO_ID)
VALUES
(3, 'Centro Regional Nuevo León',
 'Av. Constitución 4100, Monterrey, Nuevo León',
 'R', NULL, 3);


--CARGA DE CENTROS NORMALES
INSERT INTO CENTRO 
(CENTRO_ID, NOMBRE, DIRECCION, TIPO, GERENTE_ENCARGADO_ID, ESTADO_ID)
VALUES
(4, 'Centro Operativo Coyoacán',
 'Av. Universidad 1200, Coyoacán, Ciudad de México',
 'N', NULL, 1);

INSERT INTO CENTRO 
(CENTRO_ID, NOMBRE, DIRECCION, TIPO, GERENTE_ENCARGADO_ID, ESTADO_ID)
VALUES
(5, 'Centro Operativo Polanco',
 'Ejército Nacional 980, Miguel Hidalgo, Ciudad de México',
 'N', NULL, 1);

INSERT INTO CENTRO 
(CENTRO_ID, NOMBRE, DIRECCION, TIPO, GERENTE_ENCARGADO_ID, ESTADO_ID)
VALUES
(6, 'Centro Operativo Guadalajara Norte',
 'Calzada Independencia 3400, Guadalajara, Jalisco',
 'N', NULL, 2);

INSERT INTO CENTRO 
(CENTRO_ID, NOMBRE, DIRECCION, TIPO, GERENTE_ENCARGADO_ID, ESTADO_ID)
VALUES
(7, 'Centro Operativo Tlaquepaque',
 'Av. Revolución 150, Tlaquepaque, Jalisco',
 'N', NULL, 2);

INSERT INTO CENTRO 
(CENTRO_ID, NOMBRE, DIRECCION, TIPO, GERENTE_ENCARGADO_ID, ESTADO_ID)
VALUES
(8, 'Centro Operativo San Pedro',
 'Av. Gómez Morín 955, San Pedro Garza García, Nuevo León',
 'N', NULL, 3);

INSERT INTO CENTRO 
(CENTRO_ID, NOMBRE, DIRECCION, TIPO, GERENTE_ENCARGADO_ID, ESTADO_ID)
VALUES
(9, 'Centro Operativo Apodaca',
 'Carretera Miguel Alemán 120, Apodaca, Nuevo León',
 'N', NULL, 3);
GO

---EMPLEADOS
--EMPLEADOS CENTROS DE ESTADO 1
INSERT INTO EMPLEADO VALUES
(1001,'G','Ricardo','Mendoza','Salas','MESR800315HDFNLR01',1,
'Col. Del Valle, Ciudad de México',
'rmendoza','Gerente123',42000.00);

INSERT INTO EMPLEADO VALUES
(1002,'A','Fernanda','López','Ruiz','LORF850411MDFPRN02',1,
'Col. Roma Norte, Ciudad de México',
'flopez','Admin123',18000.00);

INSERT INTO EMPLEADO VALUES
(1003,'A','Mauricio','Castro','Luna','CALM900718HDFSTC03',1,
'Col. Narvarte, Ciudad de México',
'mcastro','Admin456',19000.00);

INSERT INTO EMPLEADO VALUES
(1004,'V','Daniel','Herrera','Campos','HECD880101HDFRMD04',1,
'Col. Portales, Ciudad de México',
'dherrera','Vet123',28000.00);

INSERT INTO EMPLEADO VALUES
(1005,'V','Paola','Jiménez','Reyes','JIRP920224MDFMYS05',1,
'Col. Escandón, Ciudad de México',
'pjimenez','Vet456',29500.00);

INSERT INTO EMPLEADO VALUES
(1006,'E','Jorge','Navarro','Gil','NAGJ930330HDFVLR06',1,
'Col. San Rafael, Ciudad de México',
'jnavarro','Enc123',17000.00);

INSERT INTO EMPLEADO VALUES
(1007,'C','Alma','Vega','Morales','VEMA960812MDFGRL07',1,
'Col. Doctores, Ciudad de México',
'avega','Cuida123',14500.00);



INSERT INTO EMPLEADO VALUES
(1008,'V','Sofía','Paredes','León','PALS910617MDFRNS08',4,
'Col. Coyoacán, Ciudad de México',
'sparedes','Vet789',27000.00);

INSERT INTO EMPLEADO VALUES
(1009,'E','Luis','Ortega','Soto','OESL940922HDFTRS09',4,
'Col. Copilco, Ciudad de México',
'lortega','Enc456',16800.00);

INSERT INTO EMPLEADO VALUES
(1010,'C','Marina','Flores','Ríos','FORM970503MDFLRS10',4,
'Col. Taxqueña, Ciudad de México',
'mflores','Cuida456',14200.00);



INSERT INTO EMPLEADO VALUES
(1011,'V','Arturo','Sánchez','Peña','SAPA890210HDFNXR11',5,
'Col. Anzures, Ciudad de México',
'asanchez','VetPolanco',30000.00);

INSERT INTO EMPLEADO VALUES
(1012,'E','Karla','Torres','Mejía','TOMK950721MDFQRL12',5,
'Col. Granada, Ciudad de México',
'ktorres','EncPolanco',17200.00);



INSERT INTO EMPLEADO VALUES
(1013,'G','Alejandro','Ramírez','Cano','RACA810914HJCLNL13',2,
'Col. Americana, Guadalajara',
'aramirez','GerJal123',41000.00);

INSERT INTO EMPLEADO VALUES
(1014,'A','Patricia','Mora','Delgado','MODP870406MJCLPT14',2,
'Col. Providencia, Guadalajara',
'pmora','AdminJal1',18500.00);

INSERT INTO EMPLEADO VALUES
(1015,'V','Valeria','Núñez','Campos','NUCV930801MJCLMR15',2,
'Col. Chapalita, Guadalajara',
'vnunez','VetJal1',28500.00);

INSERT INTO EMPLEADO VALUES
(1016,'V','Emilio','Rojas','Silva','ROSE900125HJCLML16',2,
'Col. Centro, Guadalajara',
'erojas','VetJal2',27600.00);

INSERT INTO EMPLEADO VALUES
(1017,'E','Gabriela','Cortés','Ibarra','COIG940918MJCLBR17',2,
'Col. Oblatos, Guadalajara',
'gcortes','EncJal1',16900.00);

INSERT INTO EMPLEADO VALUES
(1018,'C','Hugo','Méndez','Pérez','MEPH950602HJCLRG18',2,
'Col. Miravalle, Guadalajara',
'hmendez','CuidaJal1',14300.00);



INSERT INTO EMPLEADO VALUES
(1019,'V','Natalia','Fuentes','Ruvalcaba','FURN920410MJCLVT19',6,
'Col. Independencia, Guadalajara',
'nfuentes','VetGDLN',28100.00);

INSERT INTO EMPLEADO VALUES
(1020,'E','Raúl','Esquivel','Moreno','ESMR910709HJCLRN20',6,
'Col. Huentitán, Guadalajara',
'resquivel','EncGDLN',17100.00);



INSERT INTO EMPLEADO VALUES
(1021,'V','Diana','Campos','Lara','CALD960115MJCLRS21',7,
'Col. Centro, Tlaquepaque',
'dcampos','VetTlaq',26800.00);

INSERT INTO EMPLEADO VALUES
(1022,'E','Iván','Beltrán','Ortega','BEOI940511HJCLRV22',7,
'Col. Artesanos, Tlaquepaque',
'ibeltran','EncTlaq',16600.00);

INSERT INTO EMPLEADO VALUES
(1023,'C','Rocío','Salinas','Vega','SAVR980323MJCLGC23',7,
'Col. Cerro del Cuatro, Tlaquepaque',
'rsalinas','CuidaTlaq',14100.00);
GO

---INSERCION RAZA 
INSERT INTO ESPECIE (ESPECIE_ID, NOMBRE)
VALUES (1, 'Perro');

INSERT INTO ESPECIE (ESPECIE_ID, NOMBRE)
VALUES (2, 'Gato');
GO



INSERT INTO RAZA (RAZA_ID, NOMBRE, ESPECIE_ID)
VALUES (1, 'Labrador Retriever', 1);

INSERT INTO RAZA (RAZA_ID, NOMBRE, ESPECIE_ID)
VALUES (2, 'Pastor Alemán', 1);

INSERT INTO RAZA (RAZA_ID, NOMBRE, ESPECIE_ID)
VALUES (3, 'Golden Retriever', 1);

INSERT INTO RAZA (RAZA_ID, NOMBRE, ESPECIE_ID)
VALUES (4, 'Husky Siberiano', 1);

INSERT INTO RAZA (RAZA_ID, NOMBRE, ESPECIE_ID)
VALUES (5, 'Bulldog Francés', 1);

INSERT INTO RAZA (RAZA_ID, NOMBRE, ESPECIE_ID)
VALUES (6, 'Chihuahua', 1);



INSERT INTO RAZA (RAZA_ID, NOMBRE, ESPECIE_ID)
VALUES (7, 'Persa', 2);

INSERT INTO RAZA (RAZA_ID, NOMBRE, ESPECIE_ID)
VALUES (8, 'Siamés', 2);

INSERT INTO RAZA (RAZA_ID, NOMBRE, ESPECIE_ID)
VALUES (9, 'Maine Coon', 2);

INSERT INTO RAZA (RAZA_ID, NOMBRE, ESPECIE_ID)
VALUES (10, 'Bengalí', 2);

INSERT INTO RAZA (RAZA_ID, NOMBRE, ESPECIE_ID)
VALUES (11, 'Azul Ruso', 2);

INSERT INTO RAZA (RAZA_ID, NOMBRE, ESPECIE_ID)
VALUES (12, 'British Shorthair', 2);
GO

---INSERCION DE EMPLEADOS EN SUBENTIDADES
INSERT INTO GERENTE (EMPLEADO_ID) VALUES (1001);
INSERT INTO GERENTE (EMPLEADO_ID) VALUES (1013);
GO


INSERT INTO ADMINISTRATIVO (EMPLEADO_ID) VALUES (1002);
INSERT INTO ADMINISTRATIVO (EMPLEADO_ID) VALUES (1003);
INSERT INTO ADMINISTRATIVO (EMPLEADO_ID) VALUES (1014);
GO


INSERT INTO ENCARGADOR_TIENDA (EMPLEADO_ID) VALUES (1006);
INSERT INTO ENCARGADOR_TIENDA (EMPLEADO_ID) VALUES (1009);
INSERT INTO ENCARGADOR_TIENDA (EMPLEADO_ID) VALUES (1012);
INSERT INTO ENCARGADOR_TIENDA (EMPLEADO_ID) VALUES (1017);
INSERT INTO ENCARGADOR_TIENDA (EMPLEADO_ID) VALUES (1020);
INSERT INTO ENCARGADOR_TIENDA (EMPLEADO_ID) VALUES (1022);
GO


INSERT INTO VETERINARIO
(EMPLEADO_ID, CEDULA, ESPECIALIDAD)
VALUES
(1004, 'CED-PMV-458721', 'Medicina felina');

INSERT INTO VETERINARIO
(EMPLEADO_ID, CEDULA, ESPECIALIDAD)
VALUES
(1005, 'CED-PMV-458722', 'Cirugía veterinaria');

INSERT INTO VETERINARIO
(EMPLEADO_ID, CEDULA, ESPECIALIDAD)
VALUES
(1008, 'CED-PMV-458723', 'Animales exóticos');

INSERT INTO VETERINARIO
(EMPLEADO_ID, CEDULA, ESPECIALIDAD)
VALUES
(1011, 'CED-PMV-458724', 'Traumatología animal');

INSERT INTO VETERINARIO
(EMPLEADO_ID, CEDULA, ESPECIALIDAD)
VALUES
(1015, 'CED-PMV-458725', 'Medicina preventiva');

INSERT INTO VETERINARIO
(EMPLEADO_ID, CEDULA, ESPECIALIDAD)
VALUES
(1016, 'CED-PMV-458726', 'Dermatología veterinaria');

INSERT INTO VETERINARIO
(EMPLEADO_ID, CEDULA, ESPECIALIDAD)
VALUES
(1019, 'CED-PMV-458727', 'Fauna silvestre');

INSERT INTO VETERINARIO
(EMPLEADO_ID, CEDULA, ESPECIALIDAD)
VALUES
(1021, 'CED-PMV-458728', 'Rehabilitación animal');
GO


INSERT INTO CUIDADOR
(EMPLEADO_ID, CUIDADOR_LIDER, EDAD, ESPECIE_ASIGNADA_ID)
VALUES
(1007, null, 34, 1);

INSERT INTO CUIDADOR
(EMPLEADO_ID, CUIDADOR_LIDER, EDAD, ESPECIE_ASIGNADA_ID)
VALUES
(1010, 1007, 29, 2);

INSERT INTO CUIDADOR
(EMPLEADO_ID, CUIDADOR_LIDER, EDAD, ESPECIE_ASIGNADA_ID)
VALUES
(1018, 1007, 31, 1);

INSERT INTO CUIDADOR
(EMPLEADO_ID, CUIDADOR_LIDER, EDAD, ESPECIE_ASIGNADA_ID)
VALUES
(1023, 1007, 27, 2);
GO

---TELEFONOS EMPLEADOS
INSERT INTO TELEFONO_EMPLEADO VALUES (1001, '5512341001');
INSERT INTO TELEFONO_EMPLEADO VALUES (1002, '5512341002');
INSERT INTO TELEFONO_EMPLEADO VALUES (1003, '5512341003');
INSERT INTO TELEFONO_EMPLEADO VALUES (1004, '5512341004');
INSERT INTO TELEFONO_EMPLEADO VALUES (1005, '5512341005');
INSERT INTO TELEFONO_EMPLEADO VALUES (1006, '5512341006');
INSERT INTO TELEFONO_EMPLEADO VALUES (1007, '5512341007');
INSERT INTO TELEFONO_EMPLEADO VALUES (1008, '5512341008');
INSERT INTO TELEFONO_EMPLEADO VALUES (1009, '5512341009');
INSERT INTO TELEFONO_EMPLEADO VALUES (1010, '5512341010');
INSERT INTO TELEFONO_EMPLEADO VALUES (1011, '5512341011');
INSERT INTO TELEFONO_EMPLEADO VALUES (1012, '5512341012');

INSERT INTO TELEFONO_EMPLEADO VALUES (1013, '3312341013');
INSERT INTO TELEFONO_EMPLEADO VALUES (1014, '3312341014');
INSERT INTO TELEFONO_EMPLEADO VALUES (1015, '3312341015');
INSERT INTO TELEFONO_EMPLEADO VALUES (1016, '3312341016');
INSERT INTO TELEFONO_EMPLEADO VALUES (1017, '3312341017');
INSERT INTO TELEFONO_EMPLEADO VALUES (1018, '3312341018');
INSERT INTO TELEFONO_EMPLEADO VALUES (1019, '3312341019');
INSERT INTO TELEFONO_EMPLEADO VALUES (1020, '3312341020');
INSERT INTO TELEFONO_EMPLEADO VALUES (1021, '3312341021');
INSERT INTO TELEFONO_EMPLEADO VALUES (1022, '3312341022');
INSERT INTO TELEFONO_EMPLEADO VALUES (1023, '3312341023');



INSERT INTO TELEFONO_EMPLEADO VALUES (1001, '5587654321');
INSERT INTO TELEFONO_EMPLEADO VALUES (1004, '5567891200');
INSERT INTO TELEFONO_EMPLEADO VALUES (1008, '5534567812');
INSERT INTO TELEFONO_EMPLEADO VALUES (1013, '3387654321');
INSERT INTO TELEFONO_EMPLEADO VALUES (1015, '3345678910');
INSERT INTO TELEFONO_EMPLEADO VALUES (1021, '3321987654');
GO

----INSERCION DE CLIENTES
INSERT INTO CLIENTE
(NOMBRE, AP_PAT, AP_MAT, DOMICILIO, CURP, GENERO, CORREO, USUARIO, EMPLEADO_ID)
VALUES
('Andrea','Martínez','Luna',
'Col. Del Valle, Ciudad de México',
'MALA950214MDFRNN01','M',
'andrea.martinez@gmail.com',
'amartinez',1002);

INSERT INTO CLIENTE VALUES
('Carlos','Hernández','Ruiz',
'Col. Roma Norte, Ciudad de México',
'HERC900315HDFLRS02','H',
'carlos.hr@gmail.com',
'chernandez',1002);

INSERT INTO CLIENTE VALUES
('Mariana','Pérez','Soto',
'Col. Narvarte, Ciudad de México',
'PESM970822MDFRTN03','M',
'mariana.perez@gmail.com',
'mperez',1003);

INSERT INTO CLIENTE VALUES
('Javier','Gómez','Castillo',
'Col. Coyoacán, Ciudad de México',
'GOCJ880712HDFMVR04','H',
'javier.gc@gmail.com',
'jgomez',1003);

INSERT INTO CLIENTE VALUES
('Fernanda','Ortega','Ríos',
'Col. Portales, Ciudad de México',
'OERF990203MDFPRS05','M',
'fernanda.ortega@gmail.com',
'fortega',1002);

INSERT INTO CLIENTE VALUES
('Luis','Ramírez','Navarro',
'Col. Escandón, Ciudad de México',
'RANL920505HDFMVS06','H',
'luis.ramirez@gmail.com',
'lramirez',1003);

INSERT INTO CLIENTE VALUES
('Valeria','Santos','Molina',
'Col. Polanco, Ciudad de México',
'SAMV960630MDFTRL07','M',
'valeria.santos@gmail.com',
'vsantos',1002);

INSERT INTO CLIENTE VALUES
('Miguel','Torres','León',
'Col. Anzures, Ciudad de México',
'TOLM910907HDFRNG08','H',
'miguel.torres@gmail.com',
'mtorres',1003);

INSERT INTO CLIENTE VALUES
('Daniela','Flores','Mejía',
'Col. Santa María la Ribera, Ciudad de México',
'FOMD940111MDFLJN09','M',
'daniela.flores@gmail.com',
'dflores',1002);

INSERT INTO CLIENTE VALUES
('Roberto','Castro','Vega',
'Col. San Rafael, Ciudad de México',
'CAVR870420HDFTGB10','H',
'roberto.castro@gmail.com',
'rcastro',1003);

INSERT INTO CLIENTE VALUES
('Paola','Mendoza','Silva',
'Col. Americana, Guadalajara',
'MESP950801MJCLRL11','M',
'paola.mendoza@gmail.com',
'pmendoza',1014);

INSERT INTO CLIENTE VALUES
('Alejandro','Ruiz','Campos',
'Col. Providencia, Guadalajara',
'RUCA890914HJCLMP12','H',
'alejandro.ruiz@gmail.com',
'aruiz',1014);

INSERT INTO CLIENTE VALUES
('Natalia','Vargas','Ortega',
'Col. Chapalita, Guadalajara',
'VAON980225MJCLRT13','M',
'natalia.vargas@gmail.com',
'nvargas',1014);

INSERT INTO CLIENTE VALUES
('Ricardo','Morales','Pineda',
'Col. Centro, Guadalajara',
'MOPR860716HJCLNS14','H',
'ricardo.morales@gmail.com',
'rmorales',1014);

INSERT INTO CLIENTE VALUES
('Gabriela','Jiménez','Salas',
'Col. Oblatos, Guadalajara',
'JISG970410MJCLLR15','M',
'gabriela.jimenez@gmail.com',
'gjimenez',1014);

INSERT INTO CLIENTE VALUES
('Héctor','Navarro','Delgado',
'Col. Miravalle, Guadalajara',
'NADH900228HJCLRC16','H',
'hector.navarro@gmail.com',
'hnavarro',1014);

INSERT INTO CLIENTE VALUES
('Sofía','Cruz','Reyes',
'Col. Independencia, Guadalajara',
'CUSR990612MJCLYR17','M',
'sofia.cruz@gmail.com',
'scruz',1014);

INSERT INTO CLIENTE VALUES
('Emilio','Salinas','Torres',
'Col. Huentitán, Guadalajara',
'SATE930109HJCLRM18','H',
'emilio.salinas@gmail.com',
'esalinas',1014);

INSERT INTO CLIENTE VALUES
('Camila','Herrera','Núñez',
'Col. Centro, Tlaquepaque',
'HENC960718MJCLMR19','M',
'camila.herrera@gmail.com',
'cherrera',1014);

INSERT INTO CLIENTE VALUES
('Diego','Fuentes','Rojas',
'Col. Artesanos, Tlaquepaque',
'FURD920331HJCLGS20','H',
'diego.fuentes@gmail.com',
'dfuentes',1014);
GO

--BANCOS
INSERT INTO BANCO (BANCO_ID, NOMBRE)
VALUES (1, 'BBVA México');

INSERT INTO BANCO (BANCO_ID, NOMBRE)
VALUES (2, 'Banorte');

INSERT INTO BANCO (BANCO_ID, NOMBRE)
VALUES (3, 'Santander México');

INSERT INTO BANCO (BANCO_ID, NOMBRE)
VALUES (4, 'HSBC México');

INSERT INTO BANCO (BANCO_ID, NOMBRE)
VALUES (5, 'Citibanamex');

INSERT INTO BANCO (BANCO_ID, NOMBRE)
VALUES (6, 'Scotiabank');

INSERT INTO BANCO (BANCO_ID, NOMBRE)
VALUES (7, 'Inbursa');

INSERT INTO BANCO (BANCO_ID, NOMBRE)
VALUES (8, 'Banco Azteca');
GO

--tarjetas
INSERT INTO TARJETA
(TARJETA_ID, MES_EXPIRA, AÑO_EXPIRA, NUMERO, TIPO, CLIENTE_ID, BANCO_ID)
VALUES
(1, 5, 2028, '4556123412341001', 'CREDITO', 1, 1);

INSERT INTO TARJETA VALUES
(2, 11, 2027, '4556123412341002', 'DEBITO', 1, 2);

INSERT INTO TARJETA VALUES
(3, 8, 2029, '4556123412341003', 'DEBITO', 2, 1);

INSERT INTO TARJETA VALUES
(4, 3, 2027, '4556123412341004', 'CREDITO', 3, 3);

INSERT INTO TARJETA VALUES
(5, 9, 2028, '4556123412341005', 'DEBITO', 4, 2);

INSERT INTO TARJETA VALUES
(6, 1, 2030, '4556123412341006', 'CREDITO', 5, 4);

INSERT INTO TARJETA VALUES
(7, 12, 2027, '4556123412341007', 'DEBITO', 5, 1);

INSERT INTO TARJETA VALUES
(8, 6, 2028, '4556123412341008', 'DEBITO', 7, 3);

INSERT INTO TARJETA VALUES
(9, 10, 2029, '4556123412341009', 'CREDITO', 8, 2);

INSERT INTO TARJETA VALUES
(10, 4, 2027, '4556123412341010', 'DEBITO', 9, 1);

INSERT INTO TARJETA VALUES
(11, 7, 2028, '4556123412341011', 'CREDITO', 10, 4);

INSERT INTO TARJETA VALUES
(12, 2, 2030, '4556123412341012', 'DEBITO', 11, 2);

INSERT INTO TARJETA VALUES
(13, 8, 2029, '4556123412341013', 'CREDITO', 12, 3);

INSERT INTO TARJETA VALUES
(14, 5, 2028, '4556123412341014', 'DEBITO', 12, 1);

INSERT INTO TARJETA VALUES
(15, 11, 2027, '4556123412341015', 'DEBITO', 14, 4);

INSERT INTO TARJETA VALUES
(16, 9, 2029, '4556123412341016', 'CREDITO', 15, 2);

INSERT INTO TARJETA VALUES
(17, 1, 2031, '4556123412341017', 'DEBITO', 16, 3);

INSERT INTO TARJETA VALUES
(18, 3, 2028, '4556123412341018', 'CREDITO', 18, 1);

INSERT INTO TARJETA VALUES
(19, 10, 2030, '4556123412341019', 'DEBITO', 19, 2);

INSERT INTO TARJETA VALUES
(20, 6, 2029, '4556123412341020', 'CREDITO', 20, 4);
GO

---MASCOTAS

INSERT INTO MASCOTA
(MASCOTA_ID, GENERO, RASGO, NOMBRE, CLIENTE_ID, RAZA_ID)
VALUES
(1,'H','Pelaje dorado y muy juguetón','Max',1,3);

INSERT INTO MASCOTA VALUES
(2,'M','Ojos azules y muy tranquila','Luna',1,8);

INSERT INTO MASCOTA VALUES
(3,'H','Muy energético y obediente','Rocky',2,2);

INSERT INTO MASCOTA VALUES
(4,'M','Pelaje negro brillante','Nala',2,11);

INSERT INTO MASCOTA VALUES
(5,'H','Pequeño y muy sociable','Toby',3,6);

INSERT INTO MASCOTA VALUES
(6,'H','Gran tamaño y muy protector','Thor',3,4);

INSERT INTO MASCOTA VALUES
(7,'M','Muy cariñosa con los niños','Kiara',4,3);

INSERT INTO MASCOTA VALUES
(8,'H','Pelaje café claro y activo','Bruno',5,1);

INSERT INTO MASCOTA VALUES
(9,'M','Le gusta dormir todo el día','Canela',5,12);

INSERT INTO MASCOTA VALUES
(10,'H','Muy inteligente y rápido','Simba',6,2);

INSERT INTO MASCOTA VALUES
(11,'M','Pelaje atigrado y ojos verdes','Mila',7,10);

INSERT INTO MASCOTA VALUES
(12,'H','Muy protector y amistoso','Zeus',7,1);

INSERT INTO MASCOTA VALUES
(13,'M','Le gusta trepar muebles','Pelusa',8,9);

INSERT INTO MASCOTA VALUES
(14,'H','Extremadamente juguetón','Firulais',8,5);

INSERT INTO MASCOTA VALUES
(15,'M','Muy tranquila y elegante','Olivia',9,7);

INSERT INTO MASCOTA VALUES
(16,'H','Gran fuerza y obediencia','Apolo',9,2);

INSERT INTO MASCOTA VALUES
(17,'H','Pelaje blanco y muy activo','Copito',10,4);

INSERT INTO MASCOTA VALUES
(18,'M','Cariñosa y de ojos azules','Kira',10,8);

INSERT INTO MASCOTA VALUES
(19,'M','Pelaje suave color crema y muy tranquila','Maya',11,7);

INSERT INTO MASCOTA VALUES
(20,'H','Muy juguetón y protector','Rex',12,2);

INSERT INTO MASCOTA VALUES
(21,'H','Pequeño y muy activo','Bolt',13,6);

INSERT INTO MASCOTA VALUES
(22,'M','Muy elegante y cariñosa','Greta',14,12);

INSERT INTO MASCOTA VALUES
(23,'H','Muy protector con la familia','Balto',15,4);

INSERT INTO MASCOTA VALUES
(24,'H','Extremadamente sociable','Leo',16,3);

INSERT INTO MASCOTA VALUES
(25,'H','Muy rápido y obediente','Jack',17,2);

INSERT INTO MASCOTA VALUES
(26,'H','Gran fuerza física y obediencia','Kaiser',18,1);

INSERT INTO MASCOTA VALUES
(27,'H','Muy energético y sociable','Benji',19,3);

INSERT INTO MASCOTA VALUES
(28,'M','Pelaje oscuro y ojos amarillos','Salem',20,11);
GO

---BRAZALETE
INSERT INTO BRAZALETE
(BRAZALETE_ID, MEDICAMENTO, CUIDADOS, TIPO_ALIMENTACION,
 CANTIDAD_COMIDA, ESTADO, MASCOTA_ID)
VALUES
(1,'Ninguno',
'Sacar a pasear dos veces al día',
'Croquetas premium',
350,'Estable',1);

INSERT INTO BRAZALETE VALUES
(2,'Antihistamínico',
'Evitar polvo y cambios bruscos de temperatura',
'Alimento hipoalergénico',
180,'En observación',2);

INSERT INTO BRAZALETE VALUES
(3,'Vitaminas',
'Actividad física diaria',
'Croquetas alta proteína',
400,'Estable',3);

INSERT INTO BRAZALETE VALUES
(4,'Ninguno',
'Cepillado diario',
'Alimento húmedo',
150,'Estable',4);

INSERT INTO BRAZALETE VALUES
(5,'Desparasitante',
'Supervisar durante paseos',
'Croquetas razas pequeñas',
120,'Recuperación',5);

INSERT INTO BRAZALETE VALUES
(6,'Antibiótico',
'No realizar actividad intensa',
'Croquetas premium',
420,'En tratamiento',6);

INSERT INTO BRAZALETE VALUES
(7,'Ninguno',
'Proporcionar agua constantemente',
'Alimento balanceado',
300,'Estable',7);

INSERT INTO BRAZALETE VALUES
(8,'Protector articular',
'Evitar subir escaleras',
'Croquetas senior',
340,'En observación',8);

INSERT INTO BRAZALETE VALUES
(9,'Ninguno',
'Cepillado dos veces por semana',
'Alimento húmedo premium',
140,'Estable',9);

INSERT INTO BRAZALETE VALUES
(10,'Vitaminas',
'Realizar caminatas largas',
'Croquetas premium',
360,'Estable',10);

INSERT INTO BRAZALETE VALUES
(11,'Antipulgas',
'Aplicar tratamiento mensual',
'Alimento seco premium',
120,'En tratamiento',11);

INSERT INTO BRAZALETE VALUES
(12,'Ninguno',
'Sacar a pasear diariamente',
'Croquetas premium',
320,'Estable',12);

INSERT INTO BRAZALETE VALUES
(13,'Suplemento vitamínico',
'Proporcionar juguetes interactivos',
'Alimento húmedo',
160,'Estable',13);

INSERT INTO BRAZALETE VALUES
(14,'Ninguno',
'Supervisar convivencia con otros perros',
'Croquetas premium',
280,'Estable',14);

INSERT INTO BRAZALETE VALUES
(15,'Antibiótico',
'Reposo por una semana',
'Alimento gastrointestinal',
140,'Recuperación',15);

INSERT INTO BRAZALETE VALUES
(16,'Protector hepático',
'Evitar estrés',
'Croquetas premium',
390,'En observación',16);

INSERT INTO BRAZALETE VALUES
(17,'Ninguno',
'Permitir actividad física diaria',
'Alimento balanceado',
370,'Estable',17);

INSERT INTO BRAZALETE VALUES
(18,'Antihistamínico',
'Evitar ciertos alimentos',
'Alimento especial felino',
150,'En tratamiento',18);

INSERT INTO BRAZALETE VALUES
(19,'Ninguno',
'Cepillado frecuente',
'Alimento húmedo premium',
130,'Estable',19);

INSERT INTO BRAZALETE VALUES
(20,'Desparasitante',
'Supervisar apetito',
'Croquetas premium',
360,'Recuperación',20);

INSERT INTO BRAZALETE VALUES
(21,'Ninguno',
'Evitar estrés',
'Alimento razas pequeñas',
110,'Estable',21);

INSERT INTO BRAZALETE VALUES
(22,'Ninguno',
'Cepillado diario',
'Alimento húmedo',
150,'Estable',22);

INSERT INTO BRAZALETE VALUES
(23,'Antibiótico',
'Reposo absoluto por cinco días',
'Croquetas alta proteína',
410,'En tratamiento',23);

INSERT INTO BRAZALETE VALUES
(24,'Suplemento vitamínico',
'Sacar a pasear diariamente',
'Croquetas premium',
300,'Estable',24);

INSERT INTO BRAZALETE VALUES
(25,'Ninguno',
'Actividad física diaria',
'Croquetas premium',
350,'Estable',25);

INSERT INTO BRAZALETE VALUES
(26,'Protector articular',
'No realizar saltos altos',
'Croquetas senior',
420,'En observación',26);

INSERT INTO BRAZALETE VALUES
(27,'Vitaminas',
'Sacar a correr diariamente',
'Croquetas alta proteína',
360,'Estable',27);

INSERT INTO BRAZALETE VALUES
(28,'Antihistamínico',
'Evitar perfumes fuertes',
'Alimento especial felino',
140,'En observación',28);
GO

--SIGNOS VITALES
INSERT INTO SIGNOS_VITALES
(SIGNOS_VITALES_ID, RITMO_CARDIACO, TEMPERATURA,
 NIVEL_OXIGENACION, BRAZALETE_ID)
VALUES
(1, 88, 38, 98, 1);

INSERT INTO SIGNOS_VITALES VALUES
(2, 92, 39, 97, 1);

INSERT INTO SIGNOS_VITALES VALUES
(3, 85, 38, 99, 1);



INSERT INTO SIGNOS_VITALES VALUES
(4, 78, 37, 96, 2);

INSERT INTO SIGNOS_VITALES VALUES
(5, 95, 39, 95, 2);

INSERT INTO SIGNOS_VITALES VALUES
(6, 81, 38, 97, 2);



INSERT INTO SIGNOS_VITALES VALUES
(7, 102, 39, 98, 3);

INSERT INTO SIGNOS_VITALES VALUES
(8, 98, 38, 97, 3);

INSERT INTO SIGNOS_VITALES VALUES
(9, 100, 39, 96, 3);



INSERT INTO SIGNOS_VITALES VALUES
(10, 76, 37, 99, 4);

INSERT INTO SIGNOS_VITALES VALUES
(11, 82, 38, 98, 4);

INSERT INTO SIGNOS_VITALES VALUES
(12, 79, 37, 97, 4);



INSERT INTO SIGNOS_VITALES VALUES
(13, 110, 40, 94, 5);

INSERT INTO SIGNOS_VITALES VALUES
(14, 104, 39, 95, 5);

INSERT INTO SIGNOS_VITALES VALUES
(15, 108, 40, 93, 5);



INSERT INTO SIGNOS_VITALES VALUES
(16, 90, 38, 98, 6);

INSERT INTO SIGNOS_VITALES VALUES
(17, 84, 37, 99, 7);

INSERT INTO SIGNOS_VITALES VALUES
(18, 88, 38, 97, 8);

INSERT INTO SIGNOS_VITALES VALUES
(19, 80, 37, 98, 9);

INSERT INTO SIGNOS_VITALES VALUES
(20, 93, 39, 96, 10);

INSERT INTO SIGNOS_VITALES VALUES
(21, 86, 38, 99, 11);

INSERT INTO SIGNOS_VITALES VALUES
(22, 91, 39, 97, 12);

INSERT INTO SIGNOS_VITALES VALUES
(23, 77, 37, 98, 13);

INSERT INTO SIGNOS_VITALES VALUES
(24, 95, 39, 96, 14);

INSERT INTO SIGNOS_VITALES VALUES
(25, 83, 38, 99, 15);

INSERT INTO SIGNOS_VITALES VALUES
(26, 89, 38, 97, 16);

INSERT INTO SIGNOS_VITALES VALUES
(27, 96, 39, 95, 17);

INSERT INTO SIGNOS_VITALES VALUES
(28, 79, 37, 98, 18);

INSERT INTO SIGNOS_VITALES VALUES
(29, 87, 38, 97, 19);

INSERT INTO SIGNOS_VITALES VALUES
(30, 101, 39, 96, 20);

INSERT INTO SIGNOS_VITALES VALUES
(31, 82, 37, 99, 21);

INSERT INTO SIGNOS_VITALES VALUES
(32, 78, 37, 98, 22);

INSERT INTO SIGNOS_VITALES VALUES
(33, 105, 40, 94, 23);

INSERT INTO SIGNOS_VITALES VALUES
(34, 90, 38, 97, 24);

INSERT INTO SIGNOS_VITALES VALUES
(35, 88, 38, 98, 25);

INSERT INTO SIGNOS_VITALES VALUES
(36, 97, 39, 95, 26);

INSERT INTO SIGNOS_VITALES VALUES
(37, 92, 38, 97, 27);

INSERT INTO SIGNOS_VITALES VALUES
(38, 80, 37, 98, 28);
GO

---ENFERMEDADES
INSERT INTO ENFERMEDAD
(ENFERMEDAD_ID, NOMBRE, DESCRIPCION)
VALUES
(1, 'Parvovirus Canino',
'Enfermedad viral altamente contagiosa que afecta principalmente a perros jóvenes y provoca vómito, diarrea y deshidratación severa.');

INSERT INTO ENFERMEDAD VALUES
(2, 'Moquillo',
'Enfermedad viral que afecta el sistema respiratorio, digestivo y nervioso de los perros.');

INSERT INTO ENFERMEDAD VALUES
(3, 'Dermatitis',
'Inflamación de la piel causada por alergias, parásitos o infecciones.');

INSERT INTO ENFERMEDAD VALUES
(4, 'Otitis',
'Infección o inflamación del oído frecuente en perros y gatos.');

INSERT INTO ENFERMEDAD VALUES
(5, 'Insuficiencia Renal',
'Pérdida progresiva de la función renal, común en mascotas de edad avanzada.');

INSERT INTO ENFERMEDAD VALUES
(6, 'Obesidad',
'Acumulación excesiva de grasa corporal debido a mala alimentación y poca actividad física.');

INSERT INTO ENFERMEDAD VALUES
(7, 'Gingivitis',
'Inflamación de las encías causada por acumulación de sarro y bacterias.');

INSERT INTO ENFERMEDAD VALUES
(8, 'Conjuntivitis',
'Inflamación ocular que provoca enrojecimiento, irritación y secreciones.');

INSERT INTO ENFERMEDAD VALUES
(9, 'Gastroenteritis',
'Inflamación del sistema digestivo que causa diarrea, vómito y pérdida de apetito.');

INSERT INTO ENFERMEDAD VALUES
(10, 'Artritis',
'Enfermedad degenerativa de las articulaciones que provoca dolor y dificultad de movimiento.');

INSERT INTO ENFERMEDAD VALUES
(11, 'Diabetes Mellitus',
'Trastorno metabólico relacionado con niveles elevados de glucosa en sangre.');

INSERT INTO ENFERMEDAD VALUES
(12, 'Alergia Alimentaria',
'Reacción adversa a ciertos ingredientes presentes en la alimentación de la mascota.');
GO

--MASCOTA_ENFERMEDAD
INSERT INTO MASCOTA_ENFERMEDAD
(MASCOTA_ID, ENFERMEDAD_ID)
VALUES
(2, 12);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(4, 4);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(5, 9);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(6, 10);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(8, 6);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(9, 7);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(10, 3);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(11, 8);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(12, 10);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(14, 3);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(15, 5);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(16, 11);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(18, 12);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(19, 7);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(20, 2);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(21, 9);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(22, 6);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(23, 10);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(24, 1);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(25, 4);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(26, 10);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(27, 6);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(28, 3);



INSERT INTO MASCOTA_ENFERMEDAD VALUES
(6, 3);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(10, 12);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(15, 10);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(20, 9);

INSERT INTO MASCOTA_ENFERMEDAD VALUES
(24, 7);
GO


--MEDICAMENTOS
INSERT INTO MEDICAMENTO
(MEDICAMENTO_ID, NOMBRE, COSTO)
VALUES
(1, 'Amoxicilina Veterinaria', 280.00);

INSERT INTO MEDICAMENTO VALUES
(2, 'Antipulgas NexGard', 450.00);

INSERT INTO MEDICAMENTO VALUES
(3, 'Vacuna Triple Felina', 520.00);

INSERT INTO MEDICAMENTO VALUES
(4, 'Desparasitante Drontal', 190.00);

INSERT INTO MEDICAMENTO VALUES
(5, 'Meloxicam', 240.00);

INSERT INTO MEDICAMENTO VALUES
(6, 'Suero Oral Veterinario', 85.00);

INSERT INTO MEDICAMENTO VALUES
(7, 'Gasas Estériles', 60.00);

INSERT INTO MEDICAMENTO VALUES
(8, 'Venda Elástica', 75.00);

INSERT INTO MEDICAMENTO VALUES
(9, 'Jeringa Desechable 5ml', 18.00);

INSERT INTO MEDICAMENTO VALUES
(10, 'Vitamina B12', 160.00);

INSERT INTO MEDICAMENTO VALUES
(11, 'Antibiótico Cefalexina', 310.00);

INSERT INTO MEDICAMENTO VALUES
(12, 'Shampoo Medicado', 220.00);

INSERT INTO MEDICAMENTO VALUES
(13, 'Collar Isabelino', 140.00);

INSERT INTO MEDICAMENTO VALUES
(14, 'Termómetro Veterinario', 125.00);

INSERT INTO MEDICAMENTO VALUES
(15, 'Pomada Antibiótica', 135.00);

INSERT INTO MEDICAMENTO VALUES
(16, 'Guantes Quirúrgicos', 95.00);

INSERT INTO MEDICAMENTO VALUES
(17, 'Alcohol Antiséptico', 70.00);

INSERT INTO MEDICAMENTO VALUES
(18, 'Algodón Absorbente', 55.00);

INSERT INTO MEDICAMENTO VALUES
(19, 'Vacuna Antirrábica', 480.00);

INSERT INTO MEDICAMENTO VALUES
(20, 'Protector Hepático Veterinario', 350.00);
GO

--INVENTARIO MEDICO

INSERT INTO INVENTARIO_MEDICO
(INV_MED_ID, MEDICAMENTO_ID, CANTIDAD, CENTRO_ID)
VALUES
(1,1,80,1),
(2,2,60,1),
(3,3,45,1),
(4,4,70,1),
(5,5,55,1),
(6,6,90,1),
(7,7,150,1),
(8,8,120,1),
(9,9,200,1),
(10,10,75,1);

INSERT INTO INVENTARIO_MEDICO VALUES
(11,11,65,1),
(12,12,40,1),
(13,13,30,1),
(14,14,25,1),
(15,15,50,1);

INSERT INTO INVENTARIO_MEDICO VALUES
(16,1,75,2),
(17,2,55,2),
(18,3,50,2),
(19,4,68,2),
(20,5,52,2),
(21,6,85,2),
(22,7,140,2),
(23,8,115,2),
(24,9,180,2),
(25,10,70,2);

INSERT INTO INVENTARIO_MEDICO VALUES
(26,11,60,2),
(27,12,35,2),
(28,13,28,2),
(29,14,22,2),
(30,15,48,2);

INSERT INTO INVENTARIO_MEDICO VALUES
(31,1,30,4),
(32,4,35,4),
(33,6,40,4),
(34,7,70,4),
(35,9,90,4),
(36,12,20,4);

INSERT INTO INVENTARIO_MEDICO VALUES
(37,2,28,5),
(38,5,22,5),
(39,8,35,5),
(40,10,18,5),
(41,13,15,5),
(42,15,20,5);

INSERT INTO INVENTARIO_MEDICO VALUES
(43,1,32,6),
(44,3,25,6),
(45,6,38,6),
(46,7,65,6),
(47,9,88,6),
(48,11,20,6);

INSERT INTO INVENTARIO_MEDICO VALUES
(49,2,26,7),
(50,4,30,7),
(51,8,28,7),
(52,10,20,7),
(53,14,12,7),
(54,15,18,7);
GO

--CONSULTAS MEDICAS
INSERT INTO CONSULTA
(CONSULTA_ID, DIAGNOSTICO, FECHA, DETALLES,
 COSTO, EMPLEADO_ID, MASCOTA_ID)
VALUES
(1,
'Revisión general saludable',
'2026-01-10 10:30:00',
'Se realizó revisión física completa y esquema de vacunación.',
450.00,1004,1);

INSERT INTO CONSULTA VALUES
(2,
'Alergia alimentaria leve',
'2026-01-12 12:00:00',
'Se detectó irritación cutánea relacionada con alimento.',
650.00,1005,2);

INSERT INTO CONSULTA VALUES
(3,
'Otitis moderada',
'2026-01-15 09:15:00',
'Limpieza auditiva y tratamiento antibiótico.',
780.00,1015,4);

INSERT INTO CONSULTA VALUES
(4,
'Gastroenteritis leve',
'2026-01-16 11:45:00',
'Dieta blanda y medicamento por tres días.',
720.00,1016,5);

INSERT INTO CONSULTA VALUES
(5,
'Revisión preventiva',
'2026-01-18 16:20:00',
'Sin anomalías detectadas.',
400.00,1008,3);

INSERT INTO CONSULTA VALUES
(6,
'Problemas articulares',
'2026-01-20 13:10:00',
'Se recomienda control de peso y suplemento.',
950.00,1011,6);

INSERT INTO CONSULTA VALUES
(7,
'Control de obesidad',
'2026-01-22 10:40:00',
'Ajuste de dieta y rutina de ejercicio.',
600.00,1021,8);

INSERT INTO CONSULTA VALUES
(8,
'Infección dental',
'2026-01-23 15:00:00',
'Limpieza dental y antibiótico.',
890.00,1004,9);

INSERT INTO CONSULTA VALUES
(9,
'Dermatitis alérgica',
'2026-01-24 09:00:00',
'Aplicación de tratamiento tópico.',
760.00,1005,10);

INSERT INTO CONSULTA VALUES
(10,
'Conjuntivitis',
'2026-01-25 14:35:00',
'Gotas oftálmicas durante siete días.',
550.00,1015,11);

INSERT INTO CONSULTA VALUES
(11,
'Artritis temprana',
'2026-01-27 12:50:00',
'Se indicó suplemento articular.',
980.00,1011,12);

INSERT INTO CONSULTA VALUES
(12,
'Revisión general felina',
'2026-01-28 11:00:00',
'Estado general estable.',
420.00,1019,13);

INSERT INTO CONSULTA VALUES
(13,
'Insuficiencia renal inicial',
'2026-01-30 17:10:00',
'Se prescribe dieta renal especializada.',
1200.00,1016,15);

INSERT INTO CONSULTA VALUES
(14,
'Diabetes mellitus',
'2026-02-02 10:25:00',
'Control de glucosa y tratamiento continuo.',
1400.00,1021,16);

INSERT INTO CONSULTA VALUES
(15,
'Revisión postoperatoria',
'2026-02-03 13:30:00',
'Buena evolución y cicatrización adecuada.',
700.00,1008,17);

INSERT INTO CONSULTA VALUES
(16,
'Moquillo canino',
'2026-02-05 09:40:00',
'Tratamiento intensivo y monitoreo constante.',
1800.00,1015,20);

INSERT INTO CONSULTA VALUES
(17,
'Parvovirus canino',
'2026-02-06 08:20:00',
'Hospitalización y terapia de hidratación.',
2500.00,1016,24);

INSERT INTO CONSULTA VALUES
(18,
'Control dermatológico',
'2026-02-07 16:15:00',
'Mejoría visible después del tratamiento.',
650.00,1005,14);

INSERT INTO CONSULTA VALUES
(19,
'Chequeo general',
'2026-02-08 11:45:00',
'Sin síntomas de enfermedad.',
390.00,1004,18);

INSERT INTO CONSULTA VALUES
(20,
'Control de peso',
'2026-02-10 15:50:00',
'Reducción de peso satisfactoria.',
580.00,1019,22);

INSERT INTO CONSULTA VALUES
(21,
'Infección respiratoria leve',
'2026-02-12 10:10:00',
'Antibiótico y reposo durante una semana.',
810.00,1011,19);

INSERT INTO CONSULTA VALUES
(22,
'Revisión de seguimiento',
'2026-02-14 12:20:00',
'Recuperación favorable.',
500.00,1008,5);

INSERT INTO CONSULTA VALUES
(23,
'Problema digestivo',
'2026-02-15 09:30:00',
'Dieta especial y medicamento gastrointestinal.',
730.00,1015,21);

INSERT INTO CONSULTA VALUES
(24,
'Chequeo geriátrico',
'2026-02-16 14:00:00',
'Monitoreo preventivo por edad avanzada.',
990.00,1021,26);
GO

---INV_MED_CONSUTLA
INSERT INTO INV_MED_CONSULTA
(INV_MED_ID, CONSULTA_ID, CANTIDAD, COSTO_TOTAL)
VALUES
(1,2,1,280.00);



INSERT INTO INV_MED_CONSULTA VALUES
(4,3,2,380.00);



INSERT INTO INV_MED_CONSULTA VALUES
(20,4,1,240.00);



INSERT INTO INV_MED_CONSULTA VALUES
(39,6,1,220.00);

INSERT INTO INV_MED_CONSULTA VALUES
(41,6,1,140.00);



INSERT INTO INV_MED_CONSULTA VALUES
(54,7,1,135.00);



INSERT INTO INV_MED_CONSULTA VALUES
(11,8,1,310.00);

INSERT INTO INV_MED_CONSULTA VALUES
(15,8,1,135.00);



INSERT INTO INV_MED_CONSULTA VALUES
(12,9,1,220.00);



INSERT INTO INV_MED_CONSULTA VALUES
(15,10,1,135.00);



INSERT INTO INV_MED_CONSULTA VALUES
(38,11,2,480.00);



INSERT INTO INV_MED_CONSULTA VALUES
(43,13,2,560.00);

INSERT INTO INV_MED_CONSULTA VALUES
(48,13,1,310.00);



INSERT INTO INV_MED_CONSULTA VALUES
(54,14,2,240.00);



INSERT INTO INV_MED_CONSULTA VALUES
(27,16,2,620.00);

INSERT INTO INV_MED_CONSULTA VALUES
(21,16,3,255.00);



INSERT INTO INV_MED_CONSULTA VALUES
(16,17,3,840.00);

INSERT INTO INV_MED_CONSULTA VALUES
(21,17,4,340.00);



INSERT INTO INV_MED_CONSULTA VALUES
(12,18,1,220.00);



INSERT INTO INV_MED_CONSULTA VALUES
(44,20,1,520.00);



INSERT INTO INV_MED_CONSULTA VALUES
(48,21,1,310.00);



INSERT INTO INV_MED_CONSULTA VALUES
(18,23,1,520.00);

INSERT INTO INV_MED_CONSULTA VALUES
(21,23,2,170.00);



INSERT INTO INV_MED_CONSULTA VALUES
(50,24,1,190.00);

INSERT INTO INV_MED_CONSULTA VALUES
(52,24,1,75.00);
GO

---Empleados adicionesles
INSERT INTO EMPLEADO
(EMPLEADO_ID, TIPO_EMPLEADO, NOMBRE, AP_PAT, AP_MAT,
 CURP, CENTRO_ID, DOMICILIO, USUARIO, CONTRASEÑA, SUELDO)
VALUES
(1024,'C','Miguel','Hernández','López',
'HELM950315HDFRRG01',1,
'Av. Reforma 120, Toluca, Estado de México',
'mhernandez','Mascotas123',9200.00);

INSERT INTO EMPLEADO VALUES
(1025,'C','Fernanda','Ruiz','Mendoza',
'RUMF970821MDFZRN02',2,
'Calle Juárez 45, Guadalajara, Jalisco',
'fruiz','Mascotas123',9100.00);

INSERT INTO EMPLEADO VALUES
(1026,'C','Diego','Navarro','Silva',
'NASD980412HDFVLG03',4,
'Av. Central 88, Toluca, Estado de México',
'dnavarro','Mascotas123',8900.00);

INSERT INTO EMPLEADO VALUES
(1027,'C','Paola','Martínez','Castro',
'MACP990223MDFTRL04',5,
'Calle Hidalgo 150, Metepec, Estado de México',
'pmartinez','Mascotas123',9000.00);

INSERT INTO EMPLEADO VALUES
(1028,'C','Ricardo','Santos','Flores',
'SAFR960614HJCLLR05',6,
'Av. Vallarta 310, Zapopan, Jalisco',
'rsantos','Mascotas123',9300.00);

INSERT INTO EMPLEADO VALUES
(1029,'C','Valeria','Ortega','Pineda',
'ORPV000105MJCLNL06',7,
'Calle Morelos 73, Tlaquepaque, Jalisco',
'vortega','Mascotas123',9050.00);
GO



INSERT INTO CUIDADOR
(EMPLEADO_ID, CUIDADOR_LIDER, EDAD, ESPECIE_ASIGNADA_ID)
VALUES
(1024,null,28,1);

INSERT INTO CUIDADOR VALUES
(1025,1018,31,2);

INSERT INTO CUIDADOR VALUES
(1026,1007,26,1);

INSERT INTO CUIDADOR VALUES
(1027,1010,29,2);

INSERT INTO CUIDADOR VALUES
(1028,1018,33,1);

INSERT INTO CUIDADOR VALUES
(1029,1023,27,2);
GO

INSERT INTO TELEFONO_EMPLEADO
(EMPLEADO_ID, TELEFONO)
VALUES
(1024,'7223457810');

INSERT INTO TELEFONO_EMPLEADO VALUES
(1025,'3314567821');

INSERT INTO TELEFONO_EMPLEADO VALUES
(1026,'7225678932');

INSERT INTO TELEFONO_EMPLEADO VALUES
(1027,'7226789043');

INSERT INTO TELEFONO_EMPLEADO VALUES
(1028,'3317890154');

INSERT INTO TELEFONO_EMPLEADO VALUES
(1029,'3338901265');
GO
---------------------------------
--ESTACIONES DEL AÑO

INSERT INTO ESTACION_AÑO
(ESTACION_ID, NOMBRE)
VALUES
(1, 'Primavera');

INSERT INTO ESTACION_AÑO VALUES
(2, 'Verano');

INSERT INTO ESTACION_AÑO VALUES
(3, 'Otoño');

INSERT INTO ESTACION_AÑO VALUES
(4, 'Invierno');
GO

--ESTANCIAS ACTUALES
INSERT INTO ESTANCIA
(ID_ESTANCIA, FECHA_INICIO, DIAS_ESTANCIA,
 CENTRO_ID, MASCOTA_ID, ID_CUIDADOR, ESTACION_ID)
VALUES
-- CENTRO 1 | SOLO PERROS
(1,'2026-05-01',7,1,1,1007,1);

INSERT INTO ESTANCIA VALUES
(2,'2026-05-01',5,1,3,1024,1);

INSERT INTO ESTANCIA VALUES
(3,'2026-05-02',6,1,5,1007,2);

INSERT INTO ESTANCIA VALUES
(4,'2026-05-02',8,1,7,1024,2);

INSERT INTO ESTANCIA VALUES
(5,'2026-05-03',4,1,8,1007,2);



-- CENTRO 2 | PERROS Y GATOS
INSERT INTO ESTANCIA VALUES
(6,'2026-05-03',5,2,2,1025,1);

INSERT INTO ESTANCIA VALUES
(7,'2026-05-04',9,2,4,1025,1);

INSERT INTO ESTANCIA VALUES
(8,'2026-05-04',6,2,10,1018,2);

INSERT INTO ESTANCIA VALUES
(9,'2026-05-05',7,2,11,1025,2);

INSERT INTO ESTANCIA VALUES
(10,'2026-05-05',5,2,12,1018,2);



-- CENTRO 4 | PERROS Y GATOS
INSERT INTO ESTANCIA VALUES
(11,'2026-05-06',8,4,6,1026,2);

INSERT INTO ESTANCIA VALUES
(12,'2026-05-06',4,4,9,1010,2);

INSERT INTO ESTANCIA VALUES
(13,'2026-05-07',7,4,14,1026,3);

INSERT INTO ESTANCIA VALUES
(14,'2026-05-07',6,4,15,1010,3);

INSERT INTO ESTANCIA VALUES
(15,'2026-05-08',5,4,16,1026,3);



-- CENTRO 5 | SOLO GATOS
INSERT INTO ESTANCIA VALUES
(16,'2026-05-08',9,5,13,1027,2);

INSERT INTO ESTANCIA VALUES
(17,'2026-05-09',6,5,18,1027,3);

INSERT INTO ESTANCIA VALUES
(18,'2026-05-09',5,5,19,1027,3);

INSERT INTO ESTANCIA VALUES
(19,'2026-05-10',7,5,22,1027,1);



-- CENTRO 6 | SOLO PERROS
INSERT INTO ESTANCIA VALUES
(20,'2026-05-10',8,6,17,1028,1);

INSERT INTO ESTANCIA VALUES
(21,'2026-05-11',10,6,20,1028,2);

INSERT INTO ESTANCIA VALUES
(22,'2026-05-11',5,6,21,1028,2);

INSERT INTO ESTANCIA VALUES
(23,'2026-05-12',9,6,23,1028,2);

INSERT INTO ESTANCIA VALUES
(24,'2026-05-12',6,6,24,1028,3);

INSERT INTO ESTANCIA VALUES
(25,'2026-05-13',4,6,25,1028,3);

INSERT INTO ESTANCIA VALUES
(26,'2026-05-13',7,6,26,1028,1);

INSERT INTO ESTANCIA VALUES
(27,'2026-05-14',5,6,27,1028,1);



-- CENTRO 7 | SOLO GATOS
INSERT INTO ESTANCIA VALUES
(28,'2026-05-14',6,7,28,1029,2);
GO

----Registros históricos

INSERT INTO HISTORICO_ESTANCIA
(HISTRICIO_ESTANCIA_ID, COSTO, CENTRO_ID, MASCOTA_ID,
 ID_CUIDADOR, ESTACION_ID, FECHA_INICIO,
 FECHA_FIN, DIAS_ESTANCIA, ID_ESTANCIA)
VALUES
(1,2500,1,1,1007,4,
'2025-12-10','2025-12-15',5,1);

INSERT INTO HISTORICO_ESTANCIA VALUES
(2,3000,1,1,1024,3,
'2025-09-01','2025-09-07',6,1);



INSERT INTO HISTORICO_ESTANCIA VALUES
(3,2000,1,3,1024,4,
'2025-11-05','2025-11-09',4,2);

INSERT INTO HISTORICO_ESTANCIA VALUES
(4,3500,1,5,1007,1,
'2026-03-02','2026-03-09',7,3);

INSERT INTO HISTORICO_ESTANCIA VALUES
(5,2500,1,7,1024,2,
'2026-04-10','2026-04-15',5,4);

INSERT INTO HISTORICO_ESTANCIA VALUES
(6,1500,1,8,1007,4,
'2025-12-20','2025-12-23',3,5);



INSERT INTO HISTORICO_ESTANCIA VALUES
(7,3000,2,2,1025,3,
'2025-10-01','2025-10-07',6,6);

INSERT INTO HISTORICO_ESTANCIA VALUES
(8,2000,2,4,1025,4,
'2025-12-01','2025-12-05',4,7);

INSERT INTO HISTORICO_ESTANCIA VALUES
(9,3500,2,10,1018,1,
'2026-02-11','2026-02-18',7,8);

INSERT INTO HISTORICO_ESTANCIA VALUES
(10,2500,2,11,1025,2,
'2026-04-01','2026-04-06',5,9);

INSERT INTO HISTORICO_ESTANCIA VALUES
(11,3000,2,12,1018,3,
'2025-09-15','2025-09-21',6,10);



INSERT INTO HISTORICO_ESTANCIA VALUES
(12,4000,4,6,1026,4,
'2025-12-02','2025-12-10',8,11);

INSERT INTO HISTORICO_ESTANCIA VALUES
(13,2000,4,9,1010,1,
'2026-03-01','2026-03-05',4,12);

INSERT INTO HISTORICO_ESTANCIA VALUES
(14,3000,4,14,1026,2,
'2026-04-12','2026-04-18',6,13);

INSERT INTO HISTORICO_ESTANCIA VALUES
(15,2500,4,15,1010,3,
'2025-10-20','2025-10-25',5,14);

INSERT INTO HISTORICO_ESTANCIA VALUES
(16,3500,4,16,1026,4,
'2025-11-11','2025-11-18',7,15);



INSERT INTO HISTORICO_ESTANCIA VALUES
(17,4500,5,13,1027,1,
'2026-01-05','2026-01-14',9,16);

INSERT INTO HISTORICO_ESTANCIA VALUES
(18,3000,5,18,1027,2,
'2026-04-03','2026-04-09',6,17);

INSERT INTO HISTORICO_ESTANCIA VALUES
(19,2500,5,19,1027,3,
'2025-09-02','2025-09-07',5,18);

INSERT INTO HISTORICO_ESTANCIA VALUES
(20,3500,5,22,1027,4,
'2025-12-08','2025-12-15',7,19);



INSERT INTO HISTORICO_ESTANCIA VALUES
(21,4000,6,17,1028,1,
'2026-03-01','2026-03-09',8,20);

INSERT INTO HISTORICO_ESTANCIA VALUES
(22,5000,6,20,1028,2,
'2026-04-01','2026-04-11',10,21);

INSERT INTO HISTORICO_ESTANCIA VALUES
(23,2500,6,21,1028,3,
'2025-11-10','2025-11-15',5,22);

INSERT INTO HISTORICO_ESTANCIA VALUES
(24,4500,6,23,1028,4,
'2025-12-01','2025-12-10',9,23);

INSERT INTO HISTORICO_ESTANCIA VALUES
(25,3000,6,24,1028,1,
'2026-02-01','2026-02-07',6,24);

INSERT INTO HISTORICO_ESTANCIA VALUES
(26,2000,6,25,1028,2,
'2026-04-15','2026-04-19',4,25);

INSERT INTO HISTORICO_ESTANCIA VALUES
(27,3500,6,26,1028,3,
'2025-10-01','2025-10-08',7,26);

INSERT INTO HISTORICO_ESTANCIA VALUES
(28,2500,6,27,1028,4,
'2025-12-12','2025-12-17',5,27);



INSERT INTO HISTORICO_ESTANCIA VALUES
(29,3000,7,28,1029,1,
'2026-03-10','2026-03-16',6,28);

INSERT INTO HISTORICO_ESTANCIA VALUES
(30,2000,7,28,1023,4,
'2025-11-01','2025-11-05',4,28);
GO

INSERT INTO HISTORICO_ESTANCIA
(HISTRICIO_ESTANCIA_ID, COSTO, CENTRO_ID, MASCOTA_ID,
 ID_CUIDADOR, ESTACION_ID, FECHA_INICIO,
 FECHA_FIN, DIAS_ESTANCIA, ID_ESTANCIA)
VALUES
(31,4000,1,3,1007,2,
'2026-04-01','2026-04-09',8,2);

INSERT INTO HISTORICO_ESTANCIA VALUES
(32,3000,1,5,1024,3,
'2025-09-10','2025-09-16',6,3);

INSERT INTO HISTORICO_ESTANCIA VALUES
(33,2500,1,8,1007,1,
'2026-02-05','2026-02-10',5,5);



INSERT INTO HISTORICO_ESTANCIA VALUES
(34,3500,2,2,1025,1,
'2026-03-01','2026-03-08',7,6);

INSERT INTO HISTORICO_ESTANCIA VALUES
(35,3000,2,10,1018,2,
'2025-10-10','2025-10-16',6,8);

INSERT INTO HISTORICO_ESTANCIA VALUES
(36,2000,2,11,1025,4,
'2025-12-12','2025-12-16',4,9);



INSERT INTO HISTORICO_ESTANCIA VALUES
(37,4500,4,6,1026,1,
'2026-01-08','2026-01-17',9,11);

INSERT INTO HISTORICO_ESTANCIA VALUES
(38,2500,4,9,1010,2,
'2026-04-15','2026-04-20',5,12);

INSERT INTO HISTORICO_ESTANCIA VALUES
(39,3000,4,15,1010,3,
'2025-09-05','2025-09-11',6,14);



INSERT INTO HISTORICO_ESTANCIA VALUES
(40,5000,5,13,1027,4,
'2025-12-01','2025-12-11',10,16);

INSERT INTO HISTORICO_ESTANCIA VALUES
(41,3500,5,19,1027,1,
'2026-02-02','2026-02-09',7,18);



INSERT INTO HISTORICO_ESTANCIA VALUES
(42,4500,6,20,1028,1,
'2026-03-05','2026-03-14',9,21);

INSERT INTO HISTORICO_ESTANCIA VALUES
(43,3000,6,24,1028,2,
'2025-10-01','2025-10-07',6,24);

INSERT INTO HISTORICO_ESTANCIA VALUES
(44,2500,6,25,1028,3,
'2025-11-20','2025-11-25',5,25);



INSERT INTO HISTORICO_ESTANCIA VALUES
(45,3500,7,28,1023,2,
'2026-04-01','2026-04-08',7,28);
GO

--ASIGNAR GERENTES A CENTRO_REGIONAL

select * from CENTRO;

UPDATE CENTRO SET 
 GERENTE_ENCARGADO_ID = 1001 
 WHERE ESTADO_ID = 1;

UPDATE CENTRO SET 
 GERENTE_ENCARGADO_ID = 1013 
 WHERE ESTADO_ID = 2;

 -- ESTADOS DE VENTA
INSERT INTO ESTADO_VENTA
VALUES (1,'Pendiente','Esperando procesamiento');

INSERT INTO ESTADO_VENTA
VALUES (2,'Enviado','Pedido enviado');

INSERT INTO ESTADO_VENTA
VALUES (3,'Entregado','Pedido entregado');

INSERT INTO ESTADO_VENTA
VALUES (4,'Cancelado','Pedido cancelado');

INSERT INTO ESTADO_VENTA
VALUES (5,'Devuelto','Pedido devuelto');
GO

-- VENTAS

INSERT INTO VENTA
VALUES ('F',1200,'2026-05-01',1);

INSERT INTO VENTA
VALUES ('F',850,'2026-05-02',2);

INSERT INTO VENTA
VALUES ('F',600,'2026-05-03',3);

INSERT INTO VENTA
VALUES ('F',1450,'2026-05-04',4);

INSERT INTO VENTA
VALUES ('F',980,'2026-05-05',5);

INSERT INTO VENTA
VALUES ('L',2000,'2026-05-06',1);

INSERT INTO VENTA
VALUES ('L',1750,'2026-05-07',2);

INSERT INTO VENTA
VALUES ('L',2500,'2026-05-08',3);

INSERT INTO VENTA
VALUES ('L',900,'2026-05-09',4);

INSERT INTO VENTA
VALUES ('L',1300,'2026-05-10',5);
GO

----
INSERT INTO VENTA
VALUES ('F',1350,'2026-05-11',1);

INSERT INTO VENTA
VALUES ('F',720,'2026-05-12',2);

INSERT INTO VENTA
VALUES ('F',1890,'2026-05-13',3);

INSERT INTO VENTA
VALUES ('F',940,'2026-05-14',4);

INSERT INTO VENTA
VALUES ('F',1580,'2026-05-15',5);



INSERT INTO VENTA
VALUES ('L',2100,'2026-05-16',1);

INSERT INTO VENTA
VALUES ('L',1650,'2026-05-17',2);

INSERT INTO VENTA
VALUES ('L',980,'2026-05-18',3);

INSERT INTO VENTA
VALUES ('L',2750,'2026-05-19',4);

INSERT INTO VENTA
VALUES ('L',1420,'2026-05-20',5);
GO

----- CATEGORIAS
INSERT INTO CATEGORIA
(CATEGORIA_ID, NOMBRE, DESCRIPCION, EMPLEADO_ID)
VALUES
(1,'Alimento',
'Productos alimenticios para perros y gatos, incluyendo croquetas y alimento húmedo.',
1002);

INSERT INTO CATEGORIA VALUES
(2,'Higiene',
'Productos de limpieza, arena sanitaria, shampoo y cuidado general de mascotas.',
1003);

INSERT INTO CATEGORIA VALUES
(3,'Accesorios',
'Accesorios para paseo, transporte y uso diario de mascotas.',
1014);

INSERT INTO CATEGORIA VALUES
(4,'Juguetes',
'Juguetes interactivos y recreativos para perros y gatos.',
1002);

INSERT INTO CATEGORIA VALUES
(5,'Descanso',
'Camas, casas y productos diseñados para el descanso de mascotas.',
1003);

INSERT INTO CATEGORIA VALUES
(6,'Salud',
'Productos relacionados con el bienestar y cuidado médico veterinario.',
1014);

INSERT INTO CATEGORIA VALUES
(7,'Ropa',
'Prendas y accesorios textiles para mascotas.',
1002);

INSERT INTO CATEGORIA VALUES
(8,'Entrenamiento',
'Productos auxiliares para educación y entrenamiento de mascotas.',
1003);

INSERT INTO CATEGORIA VALUES
(9,'Comederos y Bebederos',
'Platos, fuentes y recipientes para alimento y agua.',
1014);

INSERT INTO CATEGORIA VALUES
(10,'Transportación',
'Mochilas, transportadoras y accesorios para traslado seguro de mascotas.',
1002);
GO

---OFERTAS
INSERT INTO OFERTA
(OFERTA_ID, FECHA_FIN, DESCRIPCION,
 TIPO, FECHA_INICIO, EMPLEADO_ID)
VALUES
(1,
'2026-06-30',
'Descuento del 10% en alimentos premium para perros.',
'NORMAL',
'2026-05-01',
1002);

INSERT INTO OFERTA VALUES
(2,
'2026-05-31',
'Promoción en productos de higiene para mascotas.',
'LIMITADA',
'2026-05-10',
1003);

INSERT INTO OFERTA VALUES
(3,
'2026-07-15',
'Oferta especial en transportadoras y accesorios de viaje.',
'NORMAL',
'2026-05-15',
1014);

INSERT INTO OFERTA VALUES
(4,
'2026-06-20',
'Descuento en camas y artículos de descanso.',
'NORMAL',
'2026-05-05',
1002);

INSERT INTO OFERTA VALUES
(5,
'2026-05-25',
'Promoción de temporada en juguetes para mascotas.',
'LIMITADA',
'2026-05-12',
1003);

INSERT INTO OFERTA VALUES
(6,
'2026-08-01',
'Oferta especial en productos veterinarios y de salud.',
'NORMAL',
'2026-05-20',
1014);

INSERT INTO OFERTA VALUES
(7,
'2026-06-10',
'Descuento en ropa y accesorios para invierno.',
'LIMITADA',
'2026-05-08',
1002);

INSERT INTO OFERTA VALUES
(8,
'2026-07-30',
'Promoción en comederos automáticos y bebederos.',
'NORMAL',
'2026-05-18',
1003);
GO

----PRODUCTOS
INSERT INTO PRODUCTO
(PRODUCTO_ID, NOMBRE, FOTO, COSTO, DESCRIPCION,
 CATEGORIA_ID, OFERTA_ID, EMPLEADO_ID)
VALUES
(1,'Croquetas Royal Canin Adulto',0x,980.00,
'Alimento premium para perros adultos de razas medianas.',
1,1,1002);

INSERT INTO PRODUCTO VALUES
(2,'Alimento Húmedo Fancy Feast',0x,65.00,
'Alimento húmedo gourmet para gatos adultos.',
1,1,1003);

INSERT INTO PRODUCTO VALUES
(3,'Arena Sanitaria FreshCat',0x,230.00,
'Arena aglomerante con control avanzado de olores.',
2,2,1003);

INSERT INTO PRODUCTO VALUES
(4,'Shampoo Antipulgas PetCare',0x,260.00,
'Shampoo especializado para eliminación de pulgas y garrapatas.',
2,6,1014);

INSERT INTO PRODUCTO VALUES
(5,'Correa Retráctil Deluxe',0x,340.00,
'Correa extensible para paseos cómodos y seguros.',
3,3,1014);

INSERT INTO PRODUCTO VALUES
(6,'Transportadora TravelPet',0x,890.00,
'Transportadora rígida con ventilación lateral.',
10,3,1002);

INSERT INTO PRODUCTO VALUES
(7,'Pelota Interactiva Canina',0x,180.00,
'Juguete resistente para perros activos.',
4,5,1003);

INSERT INTO PRODUCTO VALUES
(8,'Ratón con Catnip',0x,120.00,
'Juguete para gatos con hierba gatera incluida.',
4,5,1002);

INSERT INTO PRODUCTO VALUES
(9,'Cama Acolchonada Grande',0x,1250.00,
'Cama lavable y cómoda para perros grandes.',
5,4,1002);

INSERT INTO PRODUCTO VALUES
(10,'Casa Exterior DoggyHome',0x,2850.00,
'Casa resistente para exteriores fabricada en plástico durable.',
5,4,1003);

INSERT INTO PRODUCTO VALUES
(11,'Suplemento Articular VetFlex',0x,540.00,
'Suplemento para fortalecer articulaciones en mascotas adultas.',
6,6,1014);

INSERT INTO PRODUCTO VALUES
(12,'Termómetro Veterinario Digital',0x,190.00,
'Termómetro digital de uso veterinario.',
6,6,1002);

INSERT INTO PRODUCTO VALUES
(13,'Suéter Polar para Perro',0x,390.00,
'Prenda térmica ideal para clima frío.',
7,7,1003);

INSERT INTO PRODUCTO VALUES
(14,'Impermeable para Mascota',0x,420.00,
'Impermeable ligero para paseos bajo la lluvia.',
7,7,1014);

INSERT INTO PRODUCTO VALUES
(15,'Tapete Entrenador UltraAbsorb',0x,310.00,
'Tapete absorbente para entrenamiento de cachorros.',
8,2,1002);

INSERT INTO PRODUCTO VALUES
(16,'Clicker de Entrenamiento',0x,140.00,
'Herramienta de adiestramiento para perros y gatos.',
8,2,1003);

INSERT INTO PRODUCTO VALUES
(17,'Fuente Automática AquaPet',0x,980.00,
'Fuente de agua filtrada para mascotas.',
9,8,1014);

INSERT INTO PRODUCTO VALUES
(18,'Plato Antiderrapante Acero',0x,160.00,
'Plato metálico con base antiderrapante.',
9,8,1002);

INSERT INTO PRODUCTO VALUES
(19,'Mochila Transportadora Comfort',0x,1150.00,
'Mochila ergonómica para transportar mascotas pequeñas.',
10,3,1003);

INSERT INTO PRODUCTO VALUES
(20,'Cinturón de Seguridad Canino',0x,270.00,
'Accesorio de seguridad para viajes en automóvil.',
10,3,1014);
GO

---INVENTARIO_CENTRO_NORMAL
INSERT INTO INV_CENTRO_NORMAL
(INV_CRETRO_NORMAL_ID, EXISTENCIAS, PRODUCTO_ID, CENTRO_ID)
VALUES
(1,25,1,4),
(2,18,3,4),
(3,10,5,4),
(4,12,7,4),
(5,8,9,4),
(6,15,11,4),
(7,20,15,4),
(8,14,17,4);



INSERT INTO INV_CENTRO_NORMAL VALUES
(9,22,2,5),
(10,16,4,5),
(11,11,6,5),
(12,9,8,5),
(13,13,10,5),
(14,7,12,5),
(15,18,14,5),
(16,12,18,5);



INSERT INTO INV_CENTRO_NORMAL VALUES
(17,30,1,6),
(18,14,5,6),
(19,9,7,6),
(20,10,9,6),
(21,6,13,6),
(22,20,16,6),
(23,17,19,6),
(24,15,20,6);



INSERT INTO INV_CENTRO_NORMAL VALUES
(25,24,2,7),
(26,19,3,7),
(27,8,6,7),
(28,11,8,7),
(29,16,10,7),
(30,10,12,7),
(31,14,17,7),
(32,13,18,7);
GO

---INVENTARIO REGIONAL

INSERT INTO INV_CENTRO_REGIONAL
(INV_CRETRO_REGIONAL_ID, EXISTENCIAS, PRODUCTO_ID, CENTRO_ID)
VALUES
(1,45,1,1),
(2,40,2,1),
(3,35,3,1),
(4,28,4,1),
(5,22,5,1),
(6,18,6,1),
(7,30,7,1),
(8,26,8,1),
(9,32,9,1),
(10,20,10,1);

INSERT INTO INV_CENTRO_REGIONAL VALUES
(11,24,11,1),
(12,16,12,1),
(13,19,13,1),
(14,14,14,1),
(15,36,15,1),
(16,21,16,1),
(17,27,17,1),
(18,29,18,1),
(19,23,19,1),
(20,17,20,1);



INSERT INTO INV_CENTRO_REGIONAL VALUES
(21,42,1,2),
(22,38,2,2),
(23,31,3,2),
(24,25,4,2),
(25,20,5,2),
(26,15,6,2),
(27,28,7,2),
(28,24,8,2),
(29,30,9,2),
(30,18,10,2);

INSERT INTO INV_CENTRO_REGIONAL VALUES
(31,22,11,2),
(32,14,12,2),
(33,17,13,2),
(34,12,14,2),
(35,33,15,2),
(36,19,16,2),
(37,25,17,2),
(38,27,18,2),
(39,21,19,2),
(40,16,20,2);
GO

--VENTAS EN LINEA
INSERT INTO LINEA
(VENTA_ID, TARIFA_CANCELACION, ESTADO_ID)
VALUES
(6,NULL,3);

INSERT INTO LINEA VALUES
(7,NULL,2);

INSERT INTO LINEA VALUES
(8,180.00,4);

INSERT INTO LINEA VALUES
(9,NULL,1);

INSERT INTO LINEA VALUES
(10,NULL,3);

INSERT INTO LINEA VALUES
(16,NULL,2);

INSERT INTO LINEA VALUES
(17,150.00,4);

INSERT INTO LINEA VALUES
(18,NULL,5);

INSERT INTO LINEA VALUES
(19,NULL,3);

INSERT INTO LINEA VALUES
(20,NULL,1);
GO


---CARRITOS DE VENTA EN LINEA
INSERT INTO CARRITO_LINEA
(VENTA_ID, INV_CRETRO_REGIONAL_ID, CANTIDAD, COSTO_TOTAL)
VALUES
(6,1,1,980.00);

INSERT INTO CARRITO_LINEA VALUES
(6,7,1,1250.00);



INSERT INTO CARRITO_LINEA VALUES
(7,22,1,65.00);

INSERT INTO CARRITO_LINEA VALUES
(7,35,2,620.00);



INSERT INTO CARRITO_LINEA VALUES
(8,5,2,680.00);

INSERT INTO CARRITO_LINEA VALUES
(8,18,1,160.00);

INSERT INTO CARRITO_LINEA VALUES
(8,15,1,310.00);



INSERT INTO CARRITO_LINEA VALUES
(9,24,1,260.00);

INSERT INTO CARRITO_LINEA VALUES
(9,32,1,190.00);

INSERT INTO CARRITO_LINEA VALUES
(9,40,1,270.00);



INSERT INTO CARRITO_LINEA VALUES
(10,9,2,480.00);

INSERT INTO CARRITO_LINEA VALUES
(10,13,1,390.00);



INSERT INTO CARRITO_LINEA VALUES
(16,3,2,460.00);

INSERT INTO CARRITO_LINEA VALUES
(16,10,1,2850.00);



INSERT INTO CARRITO_LINEA VALUES
(17,27,1,1250.00);

INSERT INTO CARRITO_LINEA VALUES
(17,33,1,390.00);



INSERT INTO CARRITO_LINEA VALUES
(18,14,1,420.00);

INSERT INTO CARRITO_LINEA VALUES
(18,20,2,540.00);



INSERT INTO CARRITO_LINEA VALUES
(19,21,2,1960.00);

INSERT INTO CARRITO_LINEA VALUES
(19,38,1,160.00);

INSERT INTO CARRITO_LINEA VALUES
(19,36,1,120.00);



INSERT INTO CARRITO_LINEA VALUES
(20,8,1,120.00);

INSERT INTO CARRITO_LINEA VALUES
(20,17,1,980.00);

INSERT INTO CARRITO_LINEA VALUES
(20,19,1,350.00);
GO

--ENVIOS
INSERT INTO ENVIO
(ENVIO_ID, VENTA_ID, DISTANCIA)
VALUES
(1,6,18);

INSERT INTO ENVIO VALUES
(2,7,25);

INSERT INTO ENVIO VALUES
(3,10,12);

INSERT INTO ENVIO VALUES
(4,16,30);

INSERT INTO ENVIO VALUES
(5,19,22);
GO

---RECEPCION:
INSERT INTO RECEPCION
(RECEPCION_ID, ENVIO_ID, NOMBRE, FECHA_ENTREGA, FOTO)
VALUES
(1,1,
'María Fernanda López Hernández',
'2026-05-08 14:35:00',
0x);

INSERT INTO RECEPCION VALUES
(2,3,
'Carlos Eduardo Ramírez Silva',
'2026-05-12 11:20:00',
0x);

INSERT INTO RECEPCION VALUES
(3,5,
'Ana Sofía Martínez Cruz',
'2026-05-21 17:10:00',
0x);
GO

--VENTAS FISICA

INSERT INTO FISICA
(VENTA_ID, COMISION, ID_ENCARGADO_TIENDA)
VALUES
(11,135.00,1006);

INSERT INTO FISICA VALUES
(12,72.00,1009);

INSERT INTO FISICA VALUES
(13,189.00,1017);

INSERT INTO FISICA VALUES
(14,94.00,1020);
GO
INSERT INTO FISICA
(VENTA_ID, COMISION, ID_ENCARGADO_TIENDA)
VALUES
(1,120.00,1012);

INSERT INTO FISICA VALUES
(2,85.00,1022);

INSERT INTO FISICA VALUES
(3,60.00,1006);

INSERT INTO FISICA VALUES
(4,145.00,1017);

INSERT INTO FISICA VALUES
(5,98.00,1009);
GO

--CARRITO_FISICO

INSERT INTO CARRITO_FISICO
(VENTA_ID, INV_CRETRO_NORMAL_ID, CANTIDAD, COSTO_TOTAL)
VALUES
(1,1,1,980.00);

INSERT INTO CARRITO_FISICO VALUES
(1,3,1,340.00);



INSERT INTO CARRITO_FISICO VALUES
(2,9,2,130.00);

INSERT INTO CARRITO_FISICO VALUES
(2,16,1,1150.00);



INSERT INTO CARRITO_FISICO VALUES
(3,18,1,340.00);

INSERT INTO CARRITO_FISICO VALUES
(3,24,1,270.00);



INSERT INTO CARRITO_FISICO VALUES
(4,10,1,260.00);

INSERT INTO CARRITO_FISICO VALUES
(4,13,1,2850.00);



INSERT INTO CARRITO_FISICO VALUES
(5,5,1,1250.00);

INSERT INTO CARRITO_FISICO VALUES
(5,7,2,620.00);



INSERT INTO CARRITO_FISICO VALUES
(11,17,1,980.00);

INSERT INTO CARRITO_FISICO VALUES
(11,23,1,350.00);



INSERT INTO CARRITO_FISICO VALUES
(12,26,1,230.00);

INSERT INTO CARRITO_FISICO VALUES
(12,31,1,980.00);



INSERT INTO CARRITO_FISICO VALUES
(13,11,1,890.00);

INSERT INTO CARRITO_FISICO VALUES
(13,12,2,240.00);



INSERT INTO CARRITO_FISICO VALUES
(14,19,1,180.00);

INSERT INTO CARRITO_FISICO VALUES
(14,22,1,120.00);
GO

