----------------
-- 	EJERCICIOS
--  ----------------

-- +++++++++++++++++++++
--   PRIMERA PARTE   --
-- +++++++++++++++++++++

-- Basándose en la tabla articulos, realizar los siguientes puntos:

-- 1) Agregar a la tabla articulos, los campos stockMinimo y stockMaximo.
ALTER TABLE articulos ADD stockMinimo INT UNSIGNED;
ALTER TABLE articulos ADD stockMaximo INT UNSIGNED;

-- 2) Completar en los registros los valores de los campos stockMinimo y stockMaximo teniendo en cuenta que el stock mínimo debe ser menor 
-- que el stock máximo.
select * from articulos;
UPDATE articulos
SET
    stock = CASE codigo
        WHEN 1 THEN 45
        WHEN 2 THEN 12
        WHEN 3 THEN 38
        WHEN 4 THEN 30
        WHEN 5 THEN 20
        WHEN 6 THEN 120
        WHEN 7 THEN 110
        WHEN 8 THEN 150
        WHEN 9 THEN 25
        WHEN 10 THEN 18
        WHEN 11 THEN 60
        WHEN 12 THEN 22
        WHEN 13 THEN 40
        WHEN 14 THEN 90
        WHEN 15 THEN 55
        WHEN 16 THEN 28
        WHEN 17 THEN 24
        WHEN 18 THEN 15
        WHEN 19 THEN 26
        WHEN 20 THEN 35
        WHEN 21 THEN 42
        WHEN 22 THEN 14
        WHEN 23 THEN 32
        WHEN 24 THEN 36
        WHEN 25 THEN 18
        WHEN 26 THEN 12
        WHEN 27 THEN 20
        WHEN 28 THEN 16
        WHEN 29 THEN 14
        WHEN 30 THEN 8
        WHEN 31 THEN 10
        WHEN 32 THEN 50
    END,

    stockMinimo = CASE codigo
        WHEN 1 THEN 10
        WHEN 2 THEN 3
        WHEN 3 THEN 10
        WHEN 4 THEN 8
        WHEN 5 THEN 5
        WHEN 6 THEN 30
        WHEN 7 THEN 30
        WHEN 8 THEN 40
        WHEN 9 THEN 5
        WHEN 10 THEN 5
        WHEN 11 THEN 15
        WHEN 12 THEN 5
        WHEN 13 THEN 10
        WHEN 14 THEN 20
        WHEN 15 THEN 15
        WHEN 16 THEN 8
        WHEN 17 THEN 6
        WHEN 18 THEN 4
        WHEN 19 THEN 6
        WHEN 20 THEN 8
        WHEN 21 THEN 10
        WHEN 22 THEN 4
        WHEN 23 THEN 8
        WHEN 24 THEN 10
        WHEN 25 THEN 5
        WHEN 26 THEN 3
        WHEN 27 THEN 5
        WHEN 28 THEN 4
        WHEN 29 THEN 4
        WHEN 30 THEN 2
        WHEN 31 THEN 2
        WHEN 32 THEN 10
    END,

    stockMaximo = CASE codigo
        WHEN 1 THEN 100
        WHEN 2 THEN 25
        WHEN 3 THEN 80
        WHEN 4 THEN 70
        WHEN 5 THEN 40
        WHEN 6 THEN 300
        WHEN 7 THEN 300
        WHEN 8 THEN 400
        WHEN 9 THEN 60
        WHEN 10 THEN 50
        WHEN 11 THEN 120
        WHEN 12 THEN 50
        WHEN 13 THEN 90
        WHEN 14 THEN 200
        WHEN 15 THEN 120
        WHEN 16 THEN 60
        WHEN 17 THEN 50
        WHEN 18 THEN 35
        WHEN 19 THEN 60
        WHEN 20 THEN 70
        WHEN 21 THEN 80
        WHEN 22 THEN 30
        WHEN 23 THEN 70
        WHEN 24 THEN 80
        WHEN 25 THEN 40
        WHEN 26 THEN 25
        WHEN 27 THEN 45
        WHEN 28 THEN 35
        WHEN 29 THEN 30
        WHEN 30 THEN 15
        WHEN 31 THEN 20
        WHEN 32 THEN 100
    END
WHERE codigo BETWEEN 1 AND 32;

select * from articulos;
select * from articulos where stock < stockMinimo;
update articulos set stock=2 where codigo in (5,7,9);
-- 3) Listar los articulos que se deben reponer y qué cantidad se debe  reponer de cada artículo.
-- Tener en cuenta que se debe reponer cuando el stock es menor al stockMinimo y la cantidad de articulos a reponer es stockMaximo - stock.
SELECT nombre, (stockMaximo - stock) 'cantidad a reponer' FROM articulos where stock < stockMinimo;

-- 4) Calcular el valor de venta de toda la mercaderia que hay en stock.
SELECT SUM(precio * stock) sumaTotal FROM articulos;

-- 5) Calcular el valor de venta + IVA de toda la mercaderia que hay en stock.
SELECT SUM(precio * stock * 1.21) sumaTotal FROM articulos;


-- +++++++++++++++++++++
--   SEGUNDA PARTE   --
-- +++++++++++++++++++++

-- 1. Crear la tabla 'autos' dentro de la base de datos 'intro' con el siguiente detalle:

-- 	codigo	INT y PK
-- 	marca	VARCHAR(255)
-- 	modelo	VARCHAR(255)
-- 	color	VARCHAR(255)
-- 	anio	INT
-- 	precio	DOUBLE

CREATE DATABASE intro;
USE intro;
CREATE TABLE autos(
	codigo int,
	marca varchar(255),
    modelo varchar(255),
    color varchar(255),
    anio int,
	precio double, 
    primary key(codigo)
);

-- 2. Cargar la tabla con 15 autos
INSERT INTO autos (codigo, marca, modelo, color, anio, precio) VALUES
(1, 'Toyota', 'Corolla', 'Blanco', 2020, 24500000),
(2, 'Ford', 'Focus', 'Negro', 2018, 19800000),
(3, 'Chevrolet', 'Cruze', 'Gris', 2021, 28750000),
(4, 'Volkswagen', 'Golf', 'Azul', 2019, 25400000),
(5, 'Renault', 'Sandero', 'Rojo', 2017, 14300000),
(6, 'Peugeot', '208', 'Blanco', 2022, 23100000),
(7, 'Fiat', 'Cronos', 'Gris', 2023, 21950000),
(8, 'Honda', 'Civic', 'Negro', 2020, 31500000),
(9, 'Nissan', 'Versa', 'Plateado', 2021, 22600000),
(10, 'Citroën', 'C4 Lounge', 'Azul', 2018, 18750000),
(11, 'Jeep', 'Renegade', 'Verde', 2022, 38900000),
(12, 'BMW', '320i', 'Blanco', 2019, 54800000),
(13, 'Mercedes-Benz', 'Clase A', 'Negro', 2021, 61200000),
(14, 'Audi', 'A3', 'Rojo', 2020, 57500000),
(15, 'Kia', 'Rio', 'Gris', 2019, 20500000);

-- 3. Realizar las siguientes consultas:
-- 	a. obtener el precio máximo.
SELECT MAX(precio) precioMaximo FROM autos;

-- 	b. obtener el precio mínimo.
SELECT MIN(precio) precioMinimo FROM autos;

-- 	c. obtener el precio mínimo entre los años 2010 y 2020.
SELECT MIN(precio) FROM autos WHERE anio BETWEEN 2010 AND 2020;

-- 	d. obtener el precio promedio.
SELECT ROUND(AVG(precio),2) promedio FROM autos;

-- 	e. obtener el precio promedio del año 2023.
SELECT ROUND(AVG(precio),2) promedio FROM autos WHERE anio=2023;

-- 	f. obtener la cantidad de autos.
SELECT COUNT(*) cantidadTotalDeAutos from autos;

-- 	g. obtener la cantidad de autos que tienen un precio entre $3.500.000 y $4.000.000
SELECT COUNT(*) cantidadTotalDeAutos from autos WHERE precio BETWEEN 3500000 AND 4000000;

-- 	h. obtener la cantidad de autos que hay en cada año.
SELECT 		anio, 
			count(*) total
FROM 		autos
GROUP BY	anio;

-- 	i. obtener la cantidad de autos y el precio promedio en cada año.
SELECT 		anio, 
			COUNT(*) cantidadDeAutos, 
			ROUND(AVG(precio),2) precioPromedio
FROM		autos
GROUP BY 	anio;

-- 	j. obtener la suma de precios y el promedio de precios según marca.
SELECT 		marca, 
			SUM(precio) suma,
            AVG(precio) precioPromedio
FROM		autos
GROUP BY	marca;

--  k. informar los autos con el menor precio.
SELECT * FROM autos WHERE precio = (SELECT MIN(precio) FROM autos);

-- l. informar los autos con el menor precio entre los años 2014 y 2023
SELECT * FROM autos WHERE anio BETWEEN 2014 AND 2023 AND precio = (SELECT MIN(precio) FROM autos WHERE anio >= 2014 AND anio <= 2023);
insert into autos values (100, 'Renault', 'Kangoo Stepway', 'negro', 2026, 44000000);
update autos set precio=14300000 where codigo=100;

--  m. listar los autos ordenados ascendentemente por marca, modelo, y el año en forma descendente.
SELECT	* FROM autos ORDER BY marca asc, modelo asc, anio desc;
SELECT	* FROM autos ORDER BY marca, modelo, anio desc;

-- n. contar cuantos autos hay de cada marca.
SELECT 		marca,
			COUNT(*) cantidadDeAutosPorMarca
FROM		autos
GROUP BY	marca;

-- o. borrar los autos del siglo pasado.
DELETE FROM autos where anio <= 2000;

-- ejemplo de un total facturado por mes
USE cursomysql;
SELECT		fecha, 
			SUM(monto) total,
            COUNT(*) cantidad
FROM 		facturas
GROUP BY	fecha;

-- lo mismo pero agrupado por mes
SELECT		CONCAT(YEAR(fecha), '/', MONTH(fecha)) mes,
			SUM(monto) total,
            COUNT(*) cantidad
FROM		facturas
GROUP BY	mes;

-- ===============================================================================================

-- -------------------------------------------------------------
-- COMBINACIÓN DE CONSULTAS
-- -------------------------------------------------------------
/*
Para comparar los resultados de varias consultas y combinarlas en un único resultado, existe el operador UNION.
Para que funcione correctamente, tenemos que tener en cuenta:
- en cada resultado, tiene que haber la misma cantidad de campos
- los campos tienen que tener el mismo tipo de dato
- las primeras consultas se escriben sin el punto y coma final
- los registros duplicados se eliminan
- si queremos conservar los registros duplicados, se utiliza el operador UNION ALL
*/

-- supongamos que tenemos 2 tablas que representan a hombres y mujeres
-- una tabla para hombres y otra para mujeres
-- en cada tabla guardamos el nombre, la provincia y la edad.

CREATE TABLE hombres(
	nombre VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    edad INT NOT NULL
);

CREATE TABLE mujeres(
	nombre VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    edad INT NOT NULL
);

INSERT INTO hombres VALUES
('Juan', 'Buenos Aires', 32),
('Mariano', 'Córdoba', 24),
('Luis', 'Mendoza', 40),
('Cris', 'Mendoza', 20),
('Raul', 'San Juan', 35);

INSERT INTO mujeres VALUES
('Malena', 'Catamarca', 22),
('Luisa', 'Formosa', 30),
('Cris', 'Buenos Aires', 61),
('Alejandra', 'Córdoba', 19),
('Mariela', 'Misiones', 50);

-- obtener el listado de todos (hombres y mujeres)
SELECT * FROM hombres
UNION
SELECT * FROM mujeres;

-- obtener todos los nombres
SELECT nombre FROM hombres
UNION
SELECT nombre FROM mujeres;

-- obtener todos los nombres, con los duplicados
SELECT nombre FROM hombres
UNION ALL
SELECT nombre FROM mujeres;

-- obtener los nombres de quienes sean de la provincia de Córdoba
SELECT nombre FROM hombres WHERE provincia='Córdoba'
UNION
SELECT nombre FROM mujeres WHERE provincia='Córdoba';

-- obtener los nombres de los hombres que sean de Córdoba y las mujeres de Misiones
SELECT nombre FROM hombres WHERE provincia='Córdoba'
UNION
SELECT nombre FROM mujeres WHERE provincia='Misiones';

/*
Workbench permite armar gráficas sobre las bases de datos. Trae incorporado un graficador. Que nos permite realizar la gráfica de la base.
Mediante un proceso que se conoce como Ingenieria Reversa, se analiza una base de datos existente y se arma una representación visual de la
 estructura.
Esto es muy útil al momento de tener una documentación de base de datos, un análisis de funcionamiento, para ver posibles fallas o errores, 
para generar una optimización de rendimiento, incluso para realizar mejoras, modificaciones o una nueva base que suplante la actual.

A este diagrama se lo conoce como DER (Diagrama de Entidad Relacional o Entidad-Relación), en inglés sería ERD (Entity Relationship Diagram).
Es la representación gráfica de la estructura de la base de datos que muestra las entidades, atributos y relaciones.

Hay 3 conceptos claves que figuran en un DER:
1- entidades -> son las representaciones de los objetos o conceptos del mundo real.
			Ej. clientes, facturas, articulos. Es decir, las tablas.
2- atributos -> son las características o propiedades de las entidades.
			Ej. nombre, apellido, monto, stock, etc. Es decir, los campos de la tabla
3- relaciones -> son las relaciones entre las tablas, es decir, cómo se relacionan entre sí.
            Ej. una factura pertenece a un cliente.
*/

