-- JOINS Y FOREIGN KEYS

-- creamos una nueva base de datos
DROP DATABASE IF EXISTS negocio;
CREATE DATABASE negocio;
-- cambiamos de base de datos, nos posicionamos dentro de la BD negocio
USE negocio;

CREATE TABLE clientes(
	codigo INT auto_increment,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni char(8) NOT NULL,
    direccion VARCHAR(100),
    PRIMARY KEY (codigo)
);

CREATE TABLE facturas(
	letra CHAR(1),
    numero INT,
    codigoCliente INT NOT NULL,
    fecha DATE NOT NULL,
    monto DOUBLE NOT NULL,
    CHECK(letra in ('A','B','C')),
    PRIMARY KEY(letra, numero)
);

INSERT INTO clientes (nombre, apellido, dni, direccion) values
('Juan', 'Perez', 32456789, 'Lope de Vega 243'),
('Marcelo', 'Cándido', 85462135, 'Medrano 162'),
('Mirna', 'Freire', 98657421, 'Julián Álvarez 1300'),
('Florencia', 'Flores', 32365987, 'Lavalle 50'),
('Jana', 'Furtado', 36985632, 'Av. Corrientes 12.325'),
('Melisa', 'Pico', 31265498, 'Callao 3568'),
('Roberto', 'Fernandez', 87465532, 'Casullo 102'),
('Julián', 'Spataro', 32326598, 'Juan B. Justo 987'),
('Marcos', 'Perez', 39564125, 'Zeballos 98'),
('Diego', 'Gonzalez', 32652222, 'Azul 2032'),
('Juan', 'Perez', '22222222', 'La Paz 2042'),
('Marcelo', 'Lopez', '33333333', 'Independencia 124'),
('Julia', 'Gonzalez', '44444444', 'Larrea 2587'),
('Violeta', 'Gutierrez', '55555555', 'Belgrano 89'),
('Victor', 'Espíndola', '66666666', 'Soler 5341'),
('Mario', 'Ramos', '77777777', 'Independencia 683'),
('Troy', 'McKlure', '88888888', 'Salta 54'),
('Cosme', 'Fulanito', '99999999', 'Navarra 44'),
('Mariana', 'Flores', '10101010', 'Italia 354'),
('Carlos', 'Ríos', '11111111', 'Medrano 162');


INSERT INTO facturas values 
('A', 1, 1, curdate(), 125000),
('A', 2, 2, '2023-10-31', 250000),
('B', 1, 1, '2023-10-30', 25000),
('C', 1, 3, '2023-10-06', 2000),
('A', 3, 6, '2023-10-03', 125000),
('C', 2, 10, '2023-02-01', 248000),
('C', 3, 7, curdate(), 100000),
('C', 4, 9, curdate(), 12000),
('B', 2, 2, '2024-01-17', 70000),
('B', 3, 5, '2024-05-22', 5000),
('A', 4, 9, '2023-11-07', 777000),
('A', 5, 7, '2023-10-12', 125000),
('B', 4, 12, '2023-11-08', 550000),
('C', 5, 15, curdate(), 25000),
('C', 6, 20, curdate(), 258000),
('A', 6, 14, '2024-01-12', 548000),
('A', 7, 10, '2022-10-25', 98000),
('B', 5, 18, curdate(), 987000),
('C', 7, 14, '2024-06-12', 12000),
('C', 8, 8, curdate(), 78000);

-- El producto cartesiano es la unión de todos los registros, por lo que va a traer las relaciones de todos con todos.
SELECT * FROM clientes; -- 20
SELECT * FROM facturas; -- 20
SELECT * FROM clientes, facturas; -- 400
-- acá el producto cartesiano es la multiplicación de todos los registros de ambas tablas.

-- Producto relacionado
-- El producto relacionado es la representación de las relaciones reales entre las tablas.
SELECT * FROM clientes, facturas WHERE clientes.codigo=facturas.codigoCliente;
-- Para obtener el producto relacionado, primero tiene que hacerse el cruce interno de los registos.
-- Ya que para obtener el producto relacionado, primero tenemos que obtener el producto cartesiano y luego
-- filtrar por la relación.

-- uso de alias para tablas
SELECT	c.nombre, c.apellido, f.fecha, f.monto
FROM	clientes c, facturas f
WHERE 	c.codigo = f.codigoCliente;
-- los alias sirven para identificar a las tablas y que sea más cómodo poder nombrarlas. Por lo general, el alias
-- es la primera letra del nombre de la misma tabla. Si hubiesen otras tablas que comiencen con la misma letra, se
-- agrega la segunda.
-- El alias nos sirve para identificar la tabla a la que pertenece el campo al cual se está haciendo referencia,
-- no es obligatorio poner el nombre de la tabla ni el alias antes del nombre del campo, si el nombre del campo
-- no se repite en las tablas.

SELECT * FROM clientes, facturas where clientes.codigo=facturas.codigoCliente;
SELECT * FROM clientes c, facturas f where c.codigo=f.codigoCliente;

-- /// INNER JOIN ///
-- Un JOIN es una operación que permite combinar filas de dos o más tablas, basándose en una condición de relación
-- El JOIN que solemos utilizar se lo conoce como INNER JOIN
-- Une las dos tablas por medio de una columna en común.
-- Compara los valores y si encuentra coincidencia, los selecciona.
SELECT 		*	 
FROM 		clientes c 
INNER JOIN 	facturas f 
on 			c.codigo=f.codigoCliente;

-- /// LEFT JOIN ///
-- Es otro JOIN que se utiliza para cruzar datos de tablas.
-- Es similar al INNER JOIN, solo que en este caso, además de las coincidencias, va a traer todos los valores
-- de la tabla de la IZQUIERDA. Por más que no se crucen con la tabla de la derecha.
-- Cuando hablamos de tablas de la derecha o de la izquierda, nos referimos a la posición en la que hayamos
-- escrito los nombres de las tablas con respecto al JOIN. 
SELECT 		c.nombre, c.apellido, f.*
FROM		clientes c
LEFT JOIN	facturas f 
ON			c.codigo=f.codigoCliente;

-- /// RIGTH JOIN ///
-- Es igual a LEFT JOIN, solo que en este caso trae todos los registros de la tabla de la derecha.
SELECT 		c.nombre, c.apellido, f.*
FROM		clientes c
RIGHT JOIN	facturas f
ON 			c.codigo=f.codigoCliente;

delete from clientes where codigo=15;

INSERT INTO facturas VALUES ('B', 6, 30, CURDATE(), 1000000);
INSERT INTO facturas VALUES ('B', 7, 25, current_timestamp(), 1000000);
-- current_timestamp es una función que inserta la fecha y la hora actual. En esta caso hace un truncate de los datos
-- porque el campo, no guarda la hora.


-- /// FULL OUTER JOIN ///
-- trae todas las relaciones posibles entre tablas, si la relación no existiera, completa con valores nulos.
-- No existe en MySQL la claúsula FULL JOIN o FULL OUTER JOIN como tal, pero podemos simular el mismo resultado
-- de la siguente manera:
SELECT		c.nombre, c.apellido, f.*
FROM 		clientes c
LEFT JOIN	facturas f 
ON			c.codigo=f.codigoCliente
UNION
SELECT		c.nombre, c.apellido, f.*
FROM		clientes c
RIGHT JOIN	facturas f
ON 			c.codigo=f.codigoCliente;

-- /// CROSS JOIN ///
-- trae el producto cartesiano, es decir, todas las combinaciones posibles
SELECT		c.nombre, c.apellido, f.*
FROM 		clientes c
CROSS JOIN	facturas f;


-- /// FOREIGN KEY ///
/* Al trabajar con bases de datos, debemos proteger los datos para que la base quede libre de inconsistencias.
Con los comandos SELECT, UPDATE y DELETE podemos perder esa integridad.
Tenemos distintas herramientas que nos permiten asegurar la integridad de los datos:
Tipos de datos, definiciones NOT NULL, definiciones DEFAULT, CHECK, PRIMARY KEY.
Las CONSTRAINT definen reglas en base a los valores permitidos en las columnas y son los mecanismos estándar
para asegurar la integridad.
La integridad referencial, preserva las relaciones definidas entre tablas. Cuando se ingresan, modifican o borran
registros se implementan con las CLAVES PRIMARIAS Y LAS CLAVES FORÁNEAS.
Esto nos permite evitar que se agreguen registros a una tabla relacionada con otra si no hay registros asociados 
en la tabla correspondiente.
Y también evita que se borren registros desde una tabla si existen registros relacionados en la otra tabla de relación.
Una clave foránea (FOREIGN KEY) es una restricción que cuida la integridad referencial de los datos entre dos tablas.
La FOREIGN KEY establece la relación entre un campo o un conjunto de campos con otro campo o conjunto de campos de
otra tabla.
Garantiza que los datos de una tabla estén correctamente relacionados con los datos de la otra tabla.
*/
ALTER TABLE 	facturas 
ADD CONSTRAINT 	FK_facturas_codigo_cliente 
FOREIGN KEY 	(codigoCliente) 
REFERENCES 		clientes(codigo);
-- se suele usar este tipo de nombres para las restricciones para luego poder identificarlas

-- el alter no funciona, porque actualmente estamos violando la restricción al tener facturas con códigoCliente que
-- no existen como clientes
-- Eliminamos esos dos registros y volvemos a intentar correr la query
DELETE FROM facturas where codigoCliente in (25, 30);
SET sql_safe_updates=0;

-- qué pasaría si quisiera ingresar una factura que apunte a un cliente que no existe:
INSERT INTO facturas VALUES ('A', 8, 40, curdate(), 100000);
-- no podemos insertar un registro que esté relacionado con otro registro que no exista.


-- Ejemplos de consultas con JOINS

-- quiénes compraron hoy? (nombre, apellido)
SELECT 	nombre, apellido
FROM 	clientes
JOIN	facturas 
ON		codigo=codigoCliente
WHERE	fecha = curdate();

-- qué compras (facturas) realizó Juan Perez?
SELECT		f.*
FROM		facturas f
JOIN		clientes c
ON 			codigo=codigoCliente
WHERE		nombre='Juan'
AND			apellido='Perez';

-- cuánto se le facturó a cada cliente?
SELECT		codigo, nombre, apellido, sum(monto) total_facturado
FROM		clientes
JOIN		facturas
ON			codigo=codigoCliente
GROUP BY 	codigo;




