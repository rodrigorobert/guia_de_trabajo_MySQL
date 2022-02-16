
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- TAREA

-- 1.	Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
-- Ordene el resultado por el nombre del fabricante, por orden alfabético. 
SELECT * FROM producto ORDER BY codigo_fabricante; 

-- 2.	Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante,
-- de todos los productos de la base de datos. 

SELECT producto.codigo, producto.nombre, codigo_fabricante, fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo;

-- 3.	Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato. 
SELECT producto.nombre, MIN(producto.precio), fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo;

-- 4.	Devuelve una lista de todos los productos del fabricante Lenovo. 
SELECT producto.nombre, fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';

-- 5.	Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT producto.nombre, fabricante.nombre, producto.precio
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Crucial' AND producto.precio > '200';

-- 6.	Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN. 
SELECT producto.nombre, fabricante.nombre, producto.precio
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard' OR fabricante.nombre = 'Seagate';

-- 7.	Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
SELECT producto.nombre, fabricante.nombre, producto.precio
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- 8.	Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a $180.
-- Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio >= '180'
ORDER BY producto.precio DESC, producto.nombre ASC;

-- 9.	Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos.
-- El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados. 
SELECT fabricante.nombre, producto.nombre
FROM fabricante
LEFT JOIN producto
ON fabricante.codigo = producto.codigo_fabricante;

-- 10.	Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT fabricante.nombre
FROM fabricante
JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.nombre = null;

-- 11.	Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT producto.nombre
FROM producto
JOIN fabricante
ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre = 'Lenovo';

-- 12.	Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN). 
SELECT *
FROM producto
JOIN fabricante
ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.precio = (
SELECT MAX(producto.precio)
FROM producto
JOIN fabricante
ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre = 'Lenovo');

-- 13.	Lista el nombre del producto más caro del fabricante Lenovo. 
SELECT producto.nombre, MAX(producto.precio)
FROM producto
INNER JOIN fabricante
ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre = 'Lenovo';

-- 14.	Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT *
FROM producto
JOIN fabricante
ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.precio > (
SELECT avg(producto.precio)
FROM producto
JOIN fabricante
ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre = 'Asus');

-- 15.	Devuelve los nombres de los fabricantes que tienen productos asociados (Utilizando ALL o ANY). 
-- Devuelve los nombres de los fabricantes que no tienen productos asociados (Utilizando ALL o ANY).
SELECT fabricante.nombre
FROM fabricante
LEFT JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre = ANY
(SELECT fabricante.nombre
FROM fabricante
WHERE producto.nombre is not null);

SELECT fabricante.nombre
FROM fabricante
LEFT JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre = ANY
(SELECT fabricante.nombre
FROM fabricante
WHERE producto.nombre is null);

-- 16.	Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT fabricante.nombre
FROM fabricante
LEFT JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre IN
(SELECT fabricante.nombre
FROM fabricante
WHERE producto.nombre is not null);

-- 17.	Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).


-- 18.	Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS). 
SELECT fabricante.nombre
FROM fabricante
LEFT JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
WHERE EXISTS
(SELECT fabricante.nombre
FROM fabricante
WHERE producto.nombre is not null);

-- 19.	Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
SELECT fabricante.nombre
FROM fabricante
LEFT JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
WHERE NOT EXISTS
(SELECT fabricante.nombre
FROM fabricante
WHERE producto.nombre is not null);

-- 20.	Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo