-- Crea la Base de datos
CREATE DATABASE english_university;

-- \c english_university
-- Crea la tabla
CREATE TABLE inscritos (
    id SERIAL PRIMARY KEY, -- Añade clave primaria
    cantidad INT,
    fecha DATE,
    fuente VARCHAR
  );

-- Se insertan los registros en la tabla inscritos
INSERT INTO inscritos (cantidad, fecha, fuente)
VALUES (44, '01/01/2021', 'Blog'),
  (56, '01/01/2021', 'Página'),
  (39, '01/02/2021', 'Blog'),
  (81, '01/02/2021', 'Página'),
  (12, '01/03/2021', 'Blog'),
  (91, '01/03/2021', 'Página'),
  (48, '01/04/2021', 'Blog'),
  (45, '01/04/2021', 'Página'),
  (55, '01/05/2021', 'Blog'),
  (33, '01/05/2021', 'Página'),
  (18, '01/06/2021', 'Blog'),
  (12, '01/06/2021', 'Página'),
  (34, '01/07/2021', 'Blog'),
  (24, '01/07/2021', 'Página'),
  (83, '01/08/2021', 'Blog'),
  (99, '01/08/2021', 'Página');

-- 1. ¿Cuántos registros hay?
SELECT COUNT(*)
FROM inscritos;

-- 2. ¿Cuántos inscritos hay en total?
SELECT SUM(cantidad) AS total_inscritos
FROM inscritos;

-- 3. ¿Cuál o cuáles son los registros de mayor antigüedad?
SELECT *
FROM inscritos
ORDER BY fecha ASC;

-- 4. ¿Cuántos inscritos hay por día?
-- (entendiendo un día como una fecha distinta de ahora en adelante)
SELECT fecha, SUM(cantidad) AS total_inscritos
FROM inscritos
GROUP BY fecha
ORDER BY fecha;

-- 5. ¿Cuántos inscritos hay por fuente?
SELECT fuente, SUM(cantidad) AS total_por_fuente
FROM inscritos
GROUP BY fuente;

-- 6. ¿Qué día se inscribió la mayor cantidad de personas?
-- Y ¿Cuántas personas se inscribieron en ese día?
SELECT fecha, SUM(cantidad) AS total_inscritos
FROM inscritos
GROUP BY fecha
ORDER BY total_inscritos DESC
LIMIT 1;

-- 7. ¿Qué días se inscribieron la mayor cantidad de
-- personas utilizando el blog? ¿Cuántas personas fueron?
SELECT fecha, fuente, SUM(cantidad) AS total_inscritos
FROM inscritos
GROUP BY fecha, fuente
HAVING fuente = 'Blog'
ORDER BY total_inscritos ASC;

-- 8. ¿Cuál es el promedio de personas inscritas por día?
SELECT fecha, ROUND(AVG(cantidad), 2)
FROM inscritos
GROUP BY fecha;

-- 9. ¿Qué días se inscribieron más de 50 personas?
SELECT fecha, SUM(cantidad) AS total_inscritos
FROM inscritos
GROUP BY fecha
HAVING SUM(cantidad) > 50
ORDER BY SUM(cantidad) DESC;

-- 10. ¿Cuál es el promedio diario de personas inscritas
-- a partir del tercer día en adelante, considerando únicamente
-- las fechas posteriores o iguales a la indicada?
SELECT fecha, ROUND(AVG(cantidad), 2) AS promedio
FROM inscritos
GROUP BY fecha
ORDER BY fecha ASC
OFFSET 2;