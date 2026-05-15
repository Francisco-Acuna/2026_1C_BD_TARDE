-- Basándose en la tabla artículos, realizar los siguientes puntos.
-- 8- Aumentar un 20% los precios de los artículos con precio menor o igual a 50.
update articulos set precio = precio * 1.2 where precio <= 50;
set sql_safe_updates=0;

-- 9- Aumentar un 15% los precios de los artículos con precio mayor a 50.
update articulos set precio = precio * 1.15 where precio > 50;

-- 10- Bajar un 5% los precios de los artículos con precio mayor a 200.
update articulos set precio = precio * 0.95 where precio > 200;

-- 11- Bajar el %50 del precio a los artículos que estén entre 20000 y 40000
update articulos set precio = precio * 0.5 where precio between 20000 and 40000;

-- 12- Aumentar el stock a 200 a todos aquellos productos que tengan el stock mayor a 0 y hasta 150
update articulos set stock = 200 where stock > 0 and stock <= 150;

-- 13- Eliminar los artículos con stock menor a 0.
delete from articulos where stock < 0;

-- 14- Eliminar todos los artículos cuyo precio sea mayor a $50.000
delete from articulos where precio > 50000;

-- **********************************************************************************************************

-- ALTER TABLE
-- modifica la estructura de una tabla

describe clientes;

-- agregar campos
ALTER TABLE clientes ADD edad SMALLINT UNSIGNED NOT NULL;
-- agrega el campo "edad" a la tabla "clientes", el campo es de tipo SMALLINT sin signo (son solo positivos) y no admite valores nulos
describe clientes;
select * from clientes;

UPDATE clientes SET edad = 25 WHERE id=1;
UPDATE clientes SET edad = 35 WHERE id>1;

-- modificar campos
ALTER TABLE clientes MODIFY edad TINYINT UNSIGNED;
-- cambiamos el tipo de dato del campo edad
describe clientes;

-- cambiar nombre a un campo
ALTER TABLE clientes CHANGE edad antiguedad TINYINT UNSIGNED;
-- cambiamos el nombre del campo edad por antiguedad
describe clientes;

-- borrar campos
ALTER TABLE clientes DROP antiguedad;
-- eliminamos el campo "antiguedad"
describe clientes;

-- eliminar la primary key
ALTER TABLE clientes DROP PRIMARY KEY; -- error
-- para poder eliminar la PK, el campo no puede ser auto_increment
-- eliminamos la restricción de auto_increment
-- solo puede ser auto_increment el campo PRIMARY KEY
ALTER TABLE clientes MODIFY id int; -- con esto sacamos el auto_increment
-- al no ser más auto_increment, podemos eliminar la PK
ALTER TABLE clientes DROP PRIMARY KEY;
describe clientes;

-- agregar primary key
ALTER TABLE clientes ADD PRIMARY KEY (id);
describe clientes;

-- volvemos a agregarle el auto_increment
ALTER TABLE clientes MODIFY id int auto_increment;
describe clientes;

-- renombrar tablas
RENAME TABLE clientes TO auxiliar, facturas TO auxiliar2;
SHOW tables;
RENAME TABLE auxiliar TO clientes, auxiliar2 TO facturas;
SHOW tables;

-- agregar un campo en una posición específica
describe clientes;
ALTER TABLE clientes ADD COLUMN edad SMALLINT NOT NULL AFTER nombre;
describe clientes;
ALTER TABLE clientes drop edad;
describe clientes;

-- #############################################################################################################

-- ======================================
-- 		FUNCIONES DE AGRUPAMIENTO
-- ======================================

-- Las funciones de agrupamiento devuelven un solo registro como resultado
-- La función MAX trabaja con números, textos y fechas

-- MAX con números
SELECT MAX(monto) FROM facturas;
-- trae el monto máximo de la tabla facturas
SELECT * from facturas;
SELECT MAX(monto) monto_maximo FROM facturas; -- agregamos un alias
SELECT MAX(monto) monto_maximo FROM facturas WHERE letra='b';
-- trae el mayor monto de las facturas con la letra b

-- por convención las funciones se escriben sin espacio antes del paréntesis.
-- si se agrega espacio podría llegar a traer problemas según el motor de base de datos

-- MAX con texto
SELECT MAX(nombre) ultimo_nombre FROM clientes;
-- trae el último nombre, teniendo en cuenta el orden alfabético

-- MAX con fechas
SELECT MAX(fecha) ultima_fecha FROM facturas;
-- trae la fecha más reciente


-- la función MIN también trabaja con números, textos y fechas

-- MIN con números
SELECT MIN(monto) monto_menor FROM facturas;
-- trae el menor monto de facturas

-- MIN con textos
SELECT MIN(nombre) primer_nombre FROM clientes;
-- trae el primer nombre, teniendo en cuenta el orden alfabético

-- MIN con fechas
SELECT MIN(fecha) primera_fecha FROM facturas;
-- trae la fecha más antigua de facturas

-- AVG (average - promedio) 
-- trabaja con números
SELECT AVG(monto) monto_promedio FROM facturas;
-- trae el promedio de los montos de todas las facturas

SELECT AVG(monto) monto_promedio FROM facturas WHERE letra='a';
-- trae el monto promedio de las facturas cuya letra sea 'A'

SELECT ROUND(AVG(monto),2) monto_promedio FROM facturas;
-- devuelve el monto promedio ajustado a 2 decimales


-- SUM (suma)
-- la función SUM trabaja con números
SELECT SUM(monto) suma_total FROM facturas;
-- trae la suma total de los montos de la tabla facturas

SELECT SUM(monto) suma_total FROM facturas WHERE letra = 'c';
-- trae la suma total de los montos de la tabla facturas, cuya letra sea una c

-- COUNT
SELECT COUNT(*) FROM facturas;
-- trae la cantidad total de registros de la tabla facturas

SELECT COUNT(*) FROM clientes;
-- trae la cantidad de registros de la tabla clientes

SELECT COUNT(direccion) FROM clientes;
-- trae la cantidad de registros de la tabla clientes, cuya dirección no sea nula

SELECT COUNT(*) FROM facturas WHERE letra='A';
-- trae la cantidad de registros de la tabla facturas cuya letra sea una 'A'

-- ======================================
-- 		AGRUPAMIENTO EN MYSQL
-- ======================================

SELECT letra, COUNT(*) total, SUM(monto) suma FROM facturas where letra = 'A';
SELECT letra, COUNT(*) total, SUM(monto) suma FROM facturas where letra = 'B';
SELECT letra, COUNT(*) total, SUM(monto) suma FROM facturas where letra = 'C';

-- GROUP BY
-- Las funciones de agregación resumen varios registros en un resultado
-- Si no usamos GROUP BY, devuelven n único resultado general
-- Si usamos GROUP BY, devuelven un resultado por cada grupo
-- En el SELECT debemos incluir el campo por el cual agrupamos, y las funciones de agregación que queremos
-- calcular.
SELECT 		letra, 
			COUNT(*) total, 
            SUM(monto) suma 
FROM 		facturas 
GROUP BY 	letra;

-- uso de HAVING. Se utiliza para filtrar por campos agrupados.
SELECT 		letra, 
			COUNT(*) total, 
			SUM(monto) suma
FROM		facturas
GROUP BY	letra
HAVING		suma > 20000;
-- no se puede usar el WHERE para filtrar por campos agrupados




