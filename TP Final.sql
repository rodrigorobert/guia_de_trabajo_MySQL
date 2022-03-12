-- 1. Dada la siguiente relación PRESTAMO_LIBROS (Colegio, profesor, asignatura/ habilidad, aula, curso, libro, editorial, fecha_prestamo) que contiene información relativa a los préstamos que realizan las editoriales a los profesores de primaria de los colegios para su evaluación en alguna de las asignaturas/habilidades que imparten. Se pide aplicar las reglas de normalización y obtener su modelo relacional, indicar sus claves, atributos principales.
-- VER .pptx ADJUNTO

-- 2. Escriba los comandos necesarios para crear esta BBDD (Tenga en cuenta las respectivas Foreign keys que no se muestran en el diagrama)

CREATE TABLE IF NOT EXISTS Libro (
  IdLibro int(11),
  Codigo int(35),
  Titulo varchar(100),
  ISBN varchar(30),
  Editorial varchar(60),
  NumPags tinyint,
  IdAutor int,
  PRIMARY KEY (`IdLibro`),
  FOREIGN KEY (`IdAutor`) REFERENCES Autor (IDAutor)
);

CREATE TABLE IF NOT EXISTS Autor (
  IdAutor int,
  Nombre varchar(100),
  Nacionalidad varchar(50),
  PRIMARY KEY (IdAutor)
  );
  
-- 3. Mencione al menos 2 ventajas y 2 desventajas del modelo relacional.
/*
· ventajas: a) se ahorra espacio , b) se asegura la integridad de los datos
· desventajas: a) consultas son más complejas, b) es un sistema rígido para algunos tipos de trabajo
*/
  
-- 4. A partir de la BBDD de jardineria:
-- a. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe = 7;

-- b. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
SELECT codigo_pedido
FROM pedido
WHERE estado = 'rechazado'
AND fecha_entrega BETWEEN '2009-01-01' AND '2010-01-01';

SELECT * 
FROM pedido
WHERE estado = "Rechazado"
AND YEAR(fecha_pedido) = 2009;


-- c. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
SELECT COUNT(ciudad), ciudad
FROM cliente
GROUP BY ciudad LIKE 'M%';

SELECT ciudad, COUNT(*) AS Cantidad_clientes_por_ciudad
FROM cliente
GROUP BY ciudad
HAVING ciudad LIKE “M%”;


-- d. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT DISTINCT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2
FROM cliente
JOIN empleado
WHERE cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

-- e. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado.
-- La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido.
-- El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.

SELECT SUM(cantidad * precio_unidad) AS IMPONIBLE,
SUM(cantidad * precio_unidad)*0.21 AS IVA,
SUM(cantidad * precio_unidad) *1.21 AS TOTAL
FROM detalle_pedido;

-- ·agrupada por código de producto.
SELECT codigo_producto, SUM(cantidad * precio_unidad) AS IMPONIBLE,
SUM(cantidad * precio_unidad)*0.21 AS IVA,
SUM(cantidad * precio_unidad) *1.21 AS TOTAL
FROM detalle_pedido
GROUP BY codigo_producto;

-- ·filtrada por los códigos que empiecen por OR.
SELECT codigo_producto, SUM(cantidad * precio_unidad) AS IMPONIBLE,
SUM(cantidad * precio_unidad)*0.21 AS IVA,
SUM(cantidad * precio_unidad) *1.21 AS TOTAL
FROM detalle_pedido
GROUP BY codigo_producto
HAVING codigo_producto LIKE 'OR%';

-- f. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2, oficina.ciudad 
FROM cliente
JOIN empleado
JOIN oficina
WHERE cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
AND empleado.codigo_oficina = oficina.codigo_oficina;

SELECT DISTINCT cliente.nombre_cliente AS Cliente, empleado.nombre AS RepVentas, empleado.apellido1 AS ApRepVentas, empleado.apellido2 AS Ap2RepVentas, oficina.ciudad AS Ciudad_Oficina
FROM cliente
JOIN pago
ON cliente.codigo_cliente = pago.codigo_cliente
JOIN empleado
ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
JOIN oficina
ON oficina.codigo_oficina = empleado.codigo_oficina;


-- g. Devuelve el nombre del cliente con mayor límite de crédito.
SELECT cliente.nombre_cliente, limite_credito
FROM cliente
WHERE limite_credito = (
SELECT MAX(limite_credito)
FROM cliente);