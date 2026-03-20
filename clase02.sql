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
CREATE
ALTER
DROP
*/

/*
DML: Data Manipulation Languaje (lenguaje de manipulación de datos)
SELECT
INSERT
DELETE
UPDATE
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
insert into clientes (nombre, apellido, dni, direccion) values ('Aquiles', 'Bailo', '23234545', 'Puan 2014');
insert into clientes (nombre, apellido, dni, direccion) values ('Armando', 'Paredes', '78788989', 'Rivadavia 2');
insert into clientes (nombre, apellido, dni, direccion) values ('Lola', 'Mento', '12356868', null);
insert into clientes (nombre, apellido, dni) values ('Aitor', 'Tilla', '74741236');

select * from clientes;
