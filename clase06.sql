-- -----------
-- Ejercicios
-- -----------

use cursomysql;
-- Llenar las tablas artículos, clientes y facturas con 10 registros cada una,
insert into clientes (nombre, apellido, dni, direccion) values
('Gabriel', 'Mendez', '34111222', 'Av. Directorio 145'),
('Patricia', 'Sosa', '28444777', 'Yerbal 963'),
('Leonardo', 'Ruiz', '32666555', 'Av. Nazca 741'),
('Mariana', 'Peralta', '29123498', 'Camacuá 852'),
('Facundo', 'Luna', '33888741', 'Av. Eva Perón 369'),
('Cecilia', 'Morales', '27333111', 'Alberdi 951'),
('Iván', 'Riquelme', '31777444', 'Av. Riestra 753'),
('Noelia', 'Godoy', '28666888', 'Fonrouge 159'),
('Cristian', 'Villalba', '32999111', 'Av. Escalada 456'),
('Tamara', 'Ojeda', '29555777', 'Murguiondo 888');

insert into articulos (nombre, precio, stock) values
('Tijera escolar', 2800, 25),
('Plasticola 250ml', 1900, 40),
('Cartuchera simple', 5200, 18),
('Cartuchera doble cierre', 7800, 12),
('Block de dibujo A4', 3400, 22),
('Tempera x6 colores', 4600, 16),
('Compás metálico', 3100, 14),
('Mochila escolar', 25000, 8),
('Calculadora científica', 18500, 10),
('Papel glacé x10', 1200, 50);

insert into facturas (letra, numero, fecha, monto) values
('A', 1008, '2025-04-10', 28700),
('A', 1009, '2025-04-15', 46500),
('B', 2008, '2025-04-12', 19800),
('B', 2009, '2025-04-18', 35200),
('B', 2010, '2025-04-22', 41000),
('C', 3007, '2025-04-08', 9400),
('C', 3008, '2025-04-14', 17600),
('C', 3009, '2025-04-20', 22100),
('A', 1010, '2025-04-25', 38900),
('C', 3010, '2025-04-28', 14300);

-- 1 - Basándose en la tabla artículos obtener los siguientes listados.
-- a-	artículos con precio mayor a 4000
select * from articulos where precio > 4000;

-- b-	artículos con precio entre 2000 y 4000 (usar < y >)
select * from articulos where precio > 2000 and precio < 4000;

-- c-	artículos con precio entre 4000 y 60000 (usar BETWEEN)
select * from articulos where precio between 4000 and 600000;

-- d-	artículos con precio = 2000 y stock mayor a 30
select * from articulos where precio=2000 and stock>30;

-- e-	artículos con precio (1200,2000,3000) no usar IN
select * from articulos where precio=1200 or precio=2000 or precio=3000;

-- f-	artículos con precio (1200,2000,3000) usar el IN
select * from articulos where precio in (1200, 2000, 3000);

-- g-	artículos que su precio no sea (1200,2000,3000)
select * from articulos where precio not in (1200, 2000, 3000);

-- h- 	Listar los artículos ordenados por precio de mayor a menor, y si hubiera precio iguales deben quedar ordenados por nombre.
select * from articulos order by precio desc, nombre;

-- i-	Listar todos los artículos incluyendo una columna denominada precio con IVA, la cual deberá tener el monto con el iva del producto.
select nombre as name, precio, precio * 1.21 as precio_con_iva from articulos;

-- j- 	Listar todos los artículos incluyendo una columna denominada “cantidad de cuotas” y otra “valor de cuota”, la cantidad es fija y 
-- es 3, el valor de cuota corresponde a 1/3 del monto con un 5% de interés.
select nombre, precio, 3 'cantidad de cuotas', round(((precio / 3) * 1.05),2) 'valor de cuota' from articulos;
select nombre, precio, 3 'cantidad de cuotas', (precio / 3) * 1.05 'valor de cuota' from articulos;

-- listar todos los artículos cuyo nombre termine con 'a' y tenga 6 caracteres
select * from articulos where nombre like '_____a';

-- listar todos los artículos cuyo nombre contenga al menos dos 'm'
select * from articulos where nombre like '%m%m%';

-- listar todos los articulos cuyo nombre esté compuesto de al menos, 2 palabras
select * from articulos where nombre like '%_ _%';

-- listar los primeros 6 articulos ordenados por precio en forma descendente
select * from articulos order by precio desc limit 6;

-- listar los 2 primeros articulos, luego del segundo registro, ordenados por stock
select * from articulos order by stock limit 2,2;

-- ============================================================================================================================

-- creamos una tabla con 2 campos
create table personas(
	nombre varchar(50),
    apellido varchar(50)
);

-- la tabla es nueva, no tiene registros
select * from personas;

-- cargamos la tabla con datos de otra tabla
insert into personas (nombre, apellido) select  nombre, apellido from clientes;

-- chequeamos el contenido
select * from personas;

-- creamos una tabla a partir de la información de otra tabla
create table nombres select distinct nombre from clientes;
select * from nombres;

-- creamos una tabla con los datos de otra tabla
create table clientes2 select * from clientes;
select * from clientes2;
select * from clientes;
-- IMPORTANTE: es una copia de la tabla, pero no copia las claves primarias ni los auto_increment ni los índices o restricciones
describe clientes;
describe clientes2;

-- crea una copia de la estructura (cantidad y nombres de campos, así como sus tipos de datos)
create table clientes3 select * from clientes limit 0;
select * from clientes3;

-- Tablas temporales
-- las tablas temporales existen solo durante la sesión/conexión actual
-- desaparecen automáticamente cuando se cierra la conexión
-- se la usa para obtener consultas muy veloces para datos temporarios
create temporary table clientes_temp select * from clientes;
select * from clientes_temp;

-- comando delete
select * from clientes where id=15;
delete from clientes where id=15; -- elimina el registro de id=15
select * from clientes; -- comprobamos que el registro de id 15 ya no existe

insert into clientes (nombre, apellido, dni) values ('Juan Pablo', 'González', '12456598');
insert into clientes (nombre, apellido, dni) values ('Juanpi', 'González', '12456599');
select * from clientes where nombre like '%juan%';
-- eliminar a todos los que se llamen Juan
delete from clientes where nombre='Juan'; -- elimina los registros cuyo nombre sea igual a 'Juan'
delete from clientes where nombre like '%juan%'; -- elimina los registros cuyo nombre contenga 'juan'

-- El editor de MySQL Workbench trae configurado por default una protección para evitar ejecutar comandos de borrado o de actualización
-- masiva. Hay que desactivarla desde el menú de edición -> preferencias-> editor de sql
-- Para mayor seguridad, luego reiniciar el Workbench
-- Otra manera simple de desactivarla es por medio de este código
set sql_safe_updates=0;  -- desactiva la protección
set sql_safe_updates=1;  -- activa la protección

use cursomysql;
delete from clientes; -- ojo con esto, elimina todos los registros de la tabla
insert into clientes select * from clientes2;

select * from clientes;
insert into clientes (nombre, apellido, dni) values ('Silvester', 'Estalone', '89896532');

-- el comando truncate también vacía la tabla, pero borrando todos los registros simultáneamente, no uno por uno como hace el comando
-- delete, por lo tanto es más veloz. Este comando también reinicia la secuencia de los autoincrementables a cero.
-- No admite where. 
truncate clientes;

-- comando update
-- actualiza valores de registros de una tabla
insert into clientes select * from clientes2; -- esto falla porque ya tengo un registro con el id=1
update clientes set id=1000 where id=1; -- actualicé el registro de id=1 y le puse el id=1000
-- este ejemplo es puramente pedagógico, no se debe cambiar un id ya asignado. 
insert into clientes (nombre, apellido, dni) values ('Bena', 'Flec', '45656554'); -- este registro se inserta con el id 1001
select * from clientes;
update clientes set nombre='Charles' where id=8; -- actualiza el nombre del id=8 a 'Charles'
update clientes set direccion='Medrano 162' where apellido like '%z';
-- actualiza la dirección de todos los que tengan un apellido que finalice con una 'z'


-- ===============================================================================================

-- Ejercicios

-- 1- Actualizar el nombre del cliente 1 a Jose
update clientes set nombre='Jose' where id=1;

-- 2- Actualizar el nombre, apellido y dni del cliente 3 a Pablo Fuentes 21053119
update clientes set nombre='Pablo', apellido='Fuentes', dni='21053119' where id=3;

-- 3- Actualizar la dirección del cliente de id 2 a vacío
update clientes set direccion='' where id=2; -- vacío no es lo mismo que null

-- 4- Actualizar las direcciones de los clientes de id 3, 5 y 7 a null
update clientes set direccion = null where id in (3, 5, 7);

-- 5- Eliminar los clientes con apellido Perez.
delete from clientes where apellido = 'Perez';

-- 6- Eliminar los clientes con dni que terminan en 0.
delete from clientes where dni like '%0';

-- 7- Eliminar los clientes cuyo nombre contenga una r y su apellido termine en z
delete from clientes where nombre like '%r%' and apellido like '%z';

-- Basándose en la tabla artículos, realizar los siguientes puntos.
-- 8- Aumentar un 20% los precios de los artículos con precio menor igual a 50.
-- 9- Aumentar un 15% los precios de los artículos con precio mayor a 50.
-- 10- Bajar un 5% los precios de los artículos con precio mayor a 200.
-- 11- Bajar el %50 del precio a los artículos que estén entre 20000 y 40000
-- 12- Aumentar el stock a 200 a todos aquellos productos que tengan el stock mayor a 0 y hasta 150
-- 13- Eliminar los artículos con stock menor a 0.
-- 14- Eliminar todos los artículos cuyo precio sea mayor a $50.000









