-- 1.	Obtener los datos completos de los empleados.
SELECT nombre FROM empleados;

-- 2.	Obtener los datos completos de los departamentos. 
SELECT * FROM departamentos;

-- 3.	Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’. 
SELECT * FROM empleados WHERE cargoE = 'Secretaria';

-- 4.	Obtener el nombre y salario de todos los empleados. 
SELECT nombre, salEmp FROM empleados;

-- 5.	Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente. 
SELECT * FROM empleados WHERE cargoE = 'Vendedor' ORDER BY nombre;

-- 6.	Listar el nombre de los departamentos. 
SELECT DISTINCT nombreDepto FROM departamentos;

-- 7.	Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor. 
SELECT nombre, cargoE, salEmp FROM empleados ORDER BY salEmp;

-- 8.	Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
SELECT DISTINCT salEmp, comisionE FROM empleados WHERE idDepto = '2000' ORDER BY comisionE;

-- 9.	Listar todas las comisiones. 
SELECT DISTINCT comisionE FROM empleados;

-- 10.	Obtener el valor total a pagar que resulta de sumar a los empleados del departamento 3000 una bonificación de 500,
-- en orden alfabético del empleado. 
SELECT nombre, salEmp, comisionE FROM empleados WHERE idDepto = '3000' ORDER BY comisionE;

-- 11.	Obtener la lista de los empleados que ganan una comisión superior a su sueldo. 
SELECT nombre, salEmp, comisionE FROM empleados WHERE salEmp < comisionE;

-- 12.	Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
SELECT nombre, salEmp, comisionE FROM empleados WHERE comisionE <= ((30*salEmp)/100);

-- 13.	Elabore un listado donde para cada fila, figure ‘Nombre’ y ‘Cargo’ antes del valor respectivo para cada empleado. 

-- 14.	Muestra los empleados cuyo nombre empiece entre las letras J y Z (rango).
-- Liste estos empleados y su cargo por orden alfabético. 
SELECT nombre, cargoE FROM empleados WHERE nombre BETWEEN 'J' And 'Z'  ORDER BY nombre;

-- 15.	Listar el salario, la comisión, el salario total (salario + comisión) y nombre,
-- de aquellos empleados que tienen comisión superior a 1000.
SELECT nombre, salEmp, comisionE, salEmp + comisionE FROM empleados WHERE comisionE > 1000;

-- 16.	Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión 
SELECT nombre, salEmp, comisionE, salEmp + comisionE FROM empleados WHERE comisionE = 0;

-- 17.	Hallar los empleados cuyo nombre no contiene la cadena “MA” 
SELECT * FROM empleados WHERE nombre NOT LIKE '%ma%';

-- 18.	Obtener los nombres de los departamentos que no sean “Ventas” ni “Investigación” ni ‘Mantenimiento. 
SELECT * FROM departamentos WHERE nombreDepto NOT LIKE 'VENTAS' AND nombreDepto NOT LIKE 'INVESTIGACION' and nombreDepto NOT LIKE 'MANTENIMIENTO';

-- 19.	Obtener el nombre y el departamento de los empleados con cargo ‘Secretaria’ o ‘Vendedor’,
-- que no trabajan en el departamento de “PRODUCCION”, cuyo salario es superior a $1000, ordenados por fecha de incorporación. 
SELECT nombre, idDepto FROM empleados
WHERE cargoE LIKE 'Secretaria' or cargoE LIKE 'Vendedor' and idDepto NOT LIKE '1500' and salEmp > 1000
ORDER BY fecIncorporacion; 

-- 20.	Obtener información de los empleados cuyo nombre tiene exactamente 11 caracteres 
SELECT * FROM empleados WHERE nombre LIKE '___________';

-- 21.	Obtener información de los empleados cuyo nombre tiene al menos 11 caracteres 
SELECT * FROM empleados WHERE nombre LIKE '___________%';

-- 22.	Listar los datos de los empleados cuyo nombre inicia por la letra ‘M’,
-- su salario es mayor a $800 o reciben comisión y trabajan para el departamento de ‘VENTAS’ 
SELECT * FROM empleados WHERE nombre LIKE 'M%' AND salEmp > 800 OR comisionE <> 0 AND idDepto LIKE '2%';

-- 23.	Mostrar el salario más alto de la empresa. 
SELECT nombre, MAX(salEmp) from empleados;

-- 24.	Mostrar el nombre del último empleado de la lista por orden alfabético. 
SELECT MAX(nombre) FROM empleados;

-- 25.	Hallar el salario más alto, el más bajo y la diferencia entre ellos. 

-- 27.	Hallar el salario promedio por departamento.

-- 28.	Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa.
-- Ordenarlo por departamento.
SELECT * FROM empleados WHERE salEmp >= '10000' GROUP BY idDepto;

-- 29.	Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos. 

-- 30.	Mostrar el código y nombre de cada jefe, junto al número de empleados que dirige.
-- Solo los que tengan más de dos empleados (2 incluido). 

-- 31.	Hallar los departamentos que no tienen empleados 
-- SELECT nombreDepto FROM departamentos WHERE idDepto 

-- 32.	Mostrar el nombre del departamento cuya suma de salarios sea la más alta, indicando el valor de la suma de los salarios. 