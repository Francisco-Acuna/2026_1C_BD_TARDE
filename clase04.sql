-- ---------------------------------------
-- Curso de Base de Datos con MySQL
-- ---------------------------------------

-- comentarios en línea
-- siempre debe haber un espacio luego de los dos guiones

/*
comentario
en 
bloque
varias
líneas
*/

-- SQL: Structure Query Languaje (lenguaje de consulta estructurada)

/*
DDL: Data Definition Language (lenguaje de definición de datos)
Creamos y modificamos estructuras
CREATE
ALTER
DROP
*/

/*
DML: Data Manipulation Languaje (lenguaje de manipulación de datos)
Insertamos, actualizamos o eliminamos registros/datos
INSERT
DELETE
UPDATE
*/

/*
DQL: Data Query Languaje (Lenguaje de consulta de datos)
SELECT
*/

/*
Con SQL podemos consultar datos, modificar información, borrar datos, crear tablas y bases de datos, cambiar
estructuras existentes.
ANSI SQL o SQL ESTANDAR
SQL tiene un estándar, esto es una base común de reglas y comandos que muchos motores de datos intentan respetar.
Cada motor implementa el estándar a su manera y además agrega sus propias funciones y particularidades. 
El SQL estándar ayuda a que haya compatibilidad, pero no garantiza portabilidad total. 
*/

-- -------------------------
-- Tipos de datos en MySQL
-- -------------------------

/*
Tipos de datos de texto más usados.

char -> este tipo de dato lo utilizamos cuando sabemos cuántos caracteres se guardarán.
Si declaramos un tipo de dato char de 20 posiciones
nombre char(20)
siempre vamos a estar utilizando 20 bytes para guardar el dato.
|--------------------| -> 20 bytes
|maximiliano---------| -> 20 bytes
|carlos--------------| -> 20 bytes
|ana-----------------| -> 20 bytes

varchar -> este tipo de datos lo utilizamos cuando no sabemos la longitud del dato que se ingresará
nombre varchar(20)
|--------------------| -> 20 bytes
|maximiliano| -> 11 bytes + 1 byte de aviso de longitud
|carlos| -> 6 bytes + 1 byte de aviso de longitud
|ana| -> 3 bytes + 1 byte de aviso de longitud
*/

/*
Tipos de datos numéricos

BIT o BOOL representa un entero que representa un valor de verdad.
Sirve para guardar valores lógicos. El 0 representa el valor falso y cualquier otro número distinto a 0 representa el valor
de verdad.

TINYINT almacena un entero de 1 byte
|--------|--------|
-128     0        127

TINYINT unsigned
|-----------------|
0                 255

SMALLINT
|--------|--------|
-32.768  0        32.767

SMALLINT unsigned
|-----------------|
0                65.535

INT
|--------|--------|
-2.147.483.648   2.147.483.647   

INT unsigned
|-----------------|
0            4.294.967.295

BIGINT es el valor más grande

FLOAT decimales de 32 bits
almacena hasta 8 dígitos
por ejemplo si quisiera hacer
10/3, el resultado sería
3.333333 (el . cuenta como un dígito más)

si hiciera 100/3, el resultado sería
33.33333 (se desplazó el punto, por eso se le dice que es de punto flotante, pero se achica la precisión decimal)

DOUBLE (son decimales de 64 bits)
almacena 17 dígitos (puede variar) 
por ejemplo si quisiera hacer
10/3
3.333333333333333
ó
100/3
33.33333333333333
float y double no tienen precisión fija o exacta.

DECIMAL
Representa números decimales de precisión fija, es una precisión exacta.
La estructura es:
DECIMAL(n,m)
donde n es la cantidad de dígitos que tendrá el número en total y m es la cantidad de dígitos que se utilizarán para
representar los decimales.
por ejemplo 
DECIMAL(10,2)
xxxxxxxx,xx (en este caso el punto no se cuenta como un dígito más)
el mayor número que podría represetar sería
99999999,99
*/

/*
Tipos de datos de fecha y hora

DATE
ocupa 3 bytes y almacena una fecha (por defecto es YYYY-MM-DD)
por ejemplo '2026-03-13'

DATETIME
ocupa 8 bytes y guarda la fecha y la hora. El formato es (YYYY-MM-DD HH:MM:SS)

TIME
ocupa 3 bytes y guarda la hora (HH:MM:SS)

YEAR
No es un standard, ocupa solo 1 byte y almacena valores en años. Puede ser con 2 o 4 dígitos.
*/

-- -----------------------------
-- COMANDO SELECT
-- -----------------------------

-- el comando SELECT nos sirve para traer registros de una tabla, pero también lo podemos utilizar para imprimir mensajes
-- en la consola, como por ejemplo
SELECT 'Hola Mundo!'; --  la salida es el mensaje por consola.
-- también puedo pedirle cálculos matemáticos, como por ejemplo:
SELECT 2 + 2; -- imprime el resultado de la suma (4)
-- podemos agregar alias a las consultas de select
SELECT 2 * 2 AS 'Multiplicación';  
-- el uso del AS no es obligatorio:
SELECT 2 * 2 'Multiplicación';
-- tampoco es obligatorio el uso de las comillas si el texto no tiene espacio
SELECT 2 * 2 Multiplicación;
-- el alias no puede llevar espacio, se deben utilizar las comillas simples.
select 2 * 2 'resultado de la multiplicacion';

-- función que devuelve la fecha actual
select curdate() hoy;

-- función que devuelve la hora actual 
select curtime();

-- función que devuelve fecha y hora
select sysdate();

-- ------------------------------
-- CÓMO CREAR UNA BASE DE DATOS
-- ------------------------------

show databases; -- muestra las bases de datos del sistema
SHOW DATABASES; -- el lenguaje es NO CASE SENSITIVE
-- el ; es el terminador de sentencias o instrucciones

-- drop se utiliza para eliminar estructuras -> DDL
drop database if exists cursomysql;
-- borra la base de datos, si es que existe

-- creamos la base de datos
create database cursomysql;

-- crea la base de datos si no existe
create database if not exists cursomysql;

/*
Los objetos creados en Windows, no diferencian mayúsculas de minúsculas. 
Pero los objetos creados en Linux o Unix sí son CASE SENSITIVE.
Por ejemplo 
prueba | Prueba
en Windows serían lo mismo, pero en Linux serían diferentes.
Los objetos son las bases de datos, las tablas y las vistas.
*/

-- entramos dentro de la base con el comando USE
use cursomysql;
-- para poder ejecutar código en una base de dato, tengo que estar parado dentro de la base

-- listar las tablas
show tables;

-- --------------------------------
-- CÓMO CREAR UNA TABLA EN MYSQL
-- --------------------------------

-- creamos la tabla clientes
create table clientes(
	id int auto_increment,
    nombre varchar(100) not null,
    apellido varchar(100) not null,
    dni char(8) not null,
    direccion varchar(100),
    primary key (id)
);
-- la anterior es una única instrucción, por eso finaliza con un ;
-- tiene varias líneas, se escribe así para facilitar la lectura del código
-- la cláusula auto_increment permite que ese campo sea registrado automáticamente de forma incremental
-- eso solo sirve para campos de clave primaria.
-- La clave primaria (primary key) indentifica a ese registro y no puede tener valores repetidos
-- not null signfica que no admite nulos, esto quiere decir que es obligatorio guardar un dato allí.

-- comprobamos la existencia de la tabla
show tables;

-- mostramos la descripción de la tabla
describe clientes;

-- mostramos todos los registros de la tabla
select * from clientes;

-- borramos la tabla clientes
drop table clientes;

-- para correr el comando de borrado seguro (que no arroje error)
drop table if exists clientes;

-- creamos la tabla con la cláusula if not exists
create table if not exists clientes(
	id int auto_increment,
    nombre varchar(100) not null,
    apellido varchar(100) not null,
    dni char(8) not null,
    direccion varchar(100),
    primary key (id)
);
-- en caso de no existir, se crea. Si no, omite la creación.

show tables;

-- -----------------------------------
-- INGRESAR REGISTROS EN UNA TABLA
-- -----------------------------------

-- ingresamos 5 registros en la tabla clientes
insert into clientes (nombre, apellido, dni, direccion) values ('Esteban', 'Quito', '12345678', 'Córdoba 2035');
insert into clientes (direccion, apellido, dni, nombre) values ('Puan 2014', 'Bailo', '23234545', 'Aquiles');
insert into clientes (nombre, apellido, dni, direccion) values ('Armando', 'Paredes', '78788989', 'Rivadavia 2');
insert into clientes (nombre, apellido, dni, direccion) values ('Lola', 'Mento', '12356868', null);
insert into clientes (nombre, apellido, dni) values ('Aitor', 'Tilla', '74741236');

select * from clientes;

-- Primer ejercicio
-- 1) Crear una tabla llamada facturas dentro de la base de datos con el siguiente detalle:
/*
letra -> char(1) y PK
numero -> int y PK
fecha -> date
monto -> double
*/
-- PK significa Primary Key
-- Solo puede haber una única PK por tabla, pero esta puede ser compuesta. Eso significa que está compuesta por 
-- más de un campo. 
-- Por ejemplo (letra, numero)
-- cada campo por si solo no es una clave ni tampoco identifica al registro, pero la suma de las dos, 
-- forman la clave.

-- 2) Crear una tabla llamada articulos dentro de la base cursomysql con el siguiente detalle:
/*
codigo -> int y PK
nombre -> varchar(50)
precio -> double
stock -> int
*/

-- cargar 5 registros en cada tabla.
-- '2026-03-27' así se ingresa una fecha

create table if not exists facturas(
	letra char(1),
    numero int, 
    fecha date,
    monto double,
    primary key(letra,numero)
);

show tables;

create table if not exists articulos(
	codigo int auto_increment primary key,
    nombre varchar(50) not null,
    precio double,
    stock int
);

insert into articulos (nombre, precio, stock) values ('cuaderno', 4500, 50);
insert into articulos (nombre, precio, stock) value ('sillas', 10000, 100);

INSERT INTO clientes (nombre, apellido, dni, direccion) VALUES
('Juan', 'Pérez', '30123456', 'Av. Rivadavia 1234'),
('Monica', 'Fernandez', '28987654', 'Calle San Martín 567'),
('Carlos', 'López', '31234567', 'Av. Corrientes 890'),
('Ana', 'Martínez', '27890123', 'Belgrano 456'),
('Luis', 'Rodríguez', '33456789', 'Av. Santa Fe 2222'),
('Sofía', 'Fernández', '29998877', 'Callao 123'),
('Diego', 'Sánchez', '31000111', 'Av. Córdoba 789'),
('Lucía', 'Romero', '27654321', 'Mitre 159'),
('Pedro', 'Torres', '32011223', 'Av. Independencia 654'),
('Valeria', 'Flores', '29555111', 'Lavalle 321'),
('Jorge', 'Díaz', '30000999', 'Av. Alem 777'),
('Camila', 'Vargas', '28999123', 'Salta 852'),
('Fernando', 'Castro', '31555666', 'Av. Belgrano 963'),
('Julieta', 'Ortiz', '27444999', 'Moreno 111'),
('Martín', 'Silva', '33000777', 'Av. Entre Ríos 456'),
('Daniela', 'Rojas', '29888765', 'Chile 222'),
('Gustavo', 'Molina', '30555999', 'Perú 654'),
('Paula', 'Suárez', '28777654', 'Av. Paseo Colón 888'),
('Ricardo', 'Herrera', '31999000', 'Defensa 123'),
('Carolina', 'Medina', '29666111', 'Av. Brasil 555'),
('Andrés', 'Aguilar', '31022334', 'Tacuarí 321'),
('Natalia', 'Vega', '27555123', 'Piedras 765'),
('Sebastián', 'Campos', '33555111', 'Av. Jujuy 999'),
('Florencia', 'Reyes', '29999222', 'Humberto 1º 456'),
('Pablo', 'Guerrero', '30222444', 'Estados Unidos 321'),
('Micaela', 'Cruz', '28888444', 'Av. San Juan 852'),
('Hernán', 'Peña', '31111888', 'Bolívar 147'),
('Romina', 'Navarro', '27777111', 'Av. Caseros 369'),
('Esteban', 'Ramos', '32222333', 'Catamarca 753'),
('Lorena', 'Acosta', '29444555', 'Av. Garay 951'),
('Bruno', 'Benítez', '30666777', 'México 654'),
('Verónica', 'Paredes', '28999333', 'Av. La Plata 741'),
('Emiliano', 'Ibarra', '31888999', '24 de Noviembre 852'),
('Agustina', 'Figueroa', '27666999', 'Av. Chiclana 963'),
('Tomás', 'Cabrera', '33111222', 'Av. Boedo 147');

select * from clientes;

INSERT INTO articulos (nombre, precio, stock) VALUES
('Cuaderno A4 rayado', 4500, 35),
('Cuaderno universitario', 6000, 25),
('Resma hojas A4', 9000, 20),
('Lapicera azul', 800, 100),
('Lapicera negra', 800, 100),
('Lápiz HB', 500, 120),
('Lápices de colores x12', 3500, 40),
('Marcadores x10', 4200, 30),
('Resaltador amarillo', 1200, 50),
('Resaltador surtido x4', 3800, 25),
('Regla 30cm', 1500, 45),
('Goma de borrar', 600, 80),
('Sacapuntas', 700, 70),
('Corrector líquido', 1800, 30),
('Corrector cinta', 2500, 25),
('Carpeta 3 anillos', 5500, 20),
('Carpeta con elástico', 3200, 30),
('Separadores x5', 2000, 35),
('Post-it', 2200, 40),
('Abrochadora', 4800, 15);

INSERT INTO facturas (letra, numero, fecha, monto) VALUES
('A', 1001, '2025-01-05', 15000),
('A', 1002, '2025-01-10', 32000),
('A', 1003, '2025-01-15', 27500),
('A', 1004, '2025-01-20', 41000),
('A', 1005, '2025-01-25', 9800),
('B', 2001, '2025-02-02', 12500),
('B', 2002, '2025-02-08', 22300),
('B', 2003, '2025-02-14', 30500),
('B', 2004, '2025-02-18', 18700),
('B', 2005, '2025-02-25', 45000),
('C', 3001, '2025-03-01', 8900),
('C', 3002, '2025-03-05', 13400),
('C', 3003, '2025-03-10', 7600),
('C', 3004, '2025-03-15', 15900),
('C', 3005, '2025-03-20', 21000),
('A', 1006, '2025-03-25', 33000),
('B', 2006, '2025-03-28', 27000),
('C', 3006, '2025-04-01', 11200),
('A', 1007, '2025-04-03', 54000),
('B', 2007, '2025-04-05', 36500);

insert into clientes (nombre, apellido, dni, direccion) values ('Diego', 'Te', '12345678', 'Lacarra 22');
insert into clientes (nombre, apellido, dni, direccion) values ('Esteban', 'Paredes', '22245678', 'Lacarra 22');
-- Comando re recuperación select con agregados
select * from clientes; -- trae todos los campos de todos los registros.
-- el * es un comodín, va a traer todo
select nombre, apellido from clientes;
select nombre from clientes;
select distinct(nombre) from clientes; -- no trae los duplicados

/*
Operadores relacionales
=  igual
<> distinto
!= no igual (es como el distinto, pero no es estándar)
>  mayor
<  menor
>= mayor o igual
<= menor o igual
*/

-- filtrado con where 
select * from clientes where nombre = 'juan'; -- trae a todos los que se llamen Juan
select * from clientes where nombre = 'JUAN'; -- no distingue entre mayúsculas y minúsculas para este caso
select * from clientes where id = 3; -- trae el registro de id 3 si es que existe
select * from clientes where id > 3; -- trae los registros que tengan id mayor a 3
select * from clientes where id < 3; -- trae los registros que sean menores a 3
select * from clientes where id <> 3; -- trae los registros que sean distintos a 3
 







