# 👨‍💻 SQL: Consultas Agrupadas

En este desafío se ponen a prueba algunos conocimientos SQL para hacer consultas con funciones de agrupación como SUM, COUNT, AVG y además las cláusulas ORDER BY o GRUP BY, etc. Todo el desafío queda explicado en [este archivo](https://drive.google.com/file/d/1qNBZfw5aputTqmOiy7EyQViPtp2uG5FK/view?usp=sharing) PDF

## Desarrollo del desafío

1. ¿Cuántos registros hay?

```sql
SELECT COUNT(*)
FROM inscritos;
```

##### Resultado:
![01-resultado](https://github.com/felipejoq/desafios-sql-postgres-db/assets/35277450/da3e7ae0-f1e0-4051-a65f-c9a8504f7aef)

___

2. ¿Cuántos inscritos hay en total?

```sql
SELECT SUM(cantidad) AS total_inscritos
FROM inscritos;
```

##### Resultado:
![02-resultado](https://github.com/felipejoq/desafios-sql-postgres-db/assets/35277450/347aac58-a6e1-43b5-931c-d8b9309ee32c)

___

3. ¿Cuál o cuáles son los registros de mayor antigüedad?

```sql
SELECT * 
FROM inscritos
WHERE fecha = (SELECT MIN(fecha) FROM inscritos);
```

##### Resultado:
![03-resultado](https://github.com/felipejoq/desafios-sql-postgres-db/assets/35277450/fd71edd7-f828-4928-85db-330d6eea34ff)

___

4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante)

```sql
SELECT fecha, SUM(cantidad) AS total_inscritos
FROM inscritos
GROUP BY fecha
ORDER BY fecha;
```

##### Resultado:
![04-resultado](https://github.com/felipejoq/desafios-sql-postgres-db/assets/35277450/96f46320-0d32-443b-b795-14a3c0a9658d)

___

5. ¿Cuántos inscritos hay por fuente?

```sql
SELECT fuente, SUM(cantidad)
FROM inscritos
GROUP BY fuente;
```

##### Resultado:
![05-resultado](https://github.com/felipejoq/desafios-sql-postgres-db/assets/35277450/d01dec4d-ae78-4182-8bd0-566f4f17b34c)

___

6. ¿Qué día se inscribió la mayor cantidad de personas? ¿Cuántas personas se inscribieron en ese día?

```sql
SELECT fecha, SUM(cantidad) AS total_inscritos
FROM inscritos
GROUP BY fecha
ORDER BY total_inscritos DESC
LIMIT 1;
```

##### Resultado:
![06-resultado](https://github.com/felipejoq/desafios-sql-postgres-db/assets/35277450/11104f6f-63ea-4e11-8509-8e7ddb41a30c)

___

7. ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas personas fueron?

```sql
SELECT fecha, fuente, SUM(cantidad) AS total_inscritos
FROM inscritos
GROUP BY fecha, fuente
HAVING fuente = 'Blog'
ORDER BY total_inscritos DESC
LIMIT 1;
```

##### Resultado:
![07-resultado](https://github.com/felipejoq/desafios-sql-postgres-db/assets/35277450/a43f5662-bb74-48e9-b03e-bc3fc8011319)

___

8. ¿Cuál es el promedio de personas inscritas por día?

```sql
SELECT fecha, ROUND(AVG(cantidad), 2)
FROM inscritos
GROUP BY fecha;
```

##### Resultado:
![08-resultado](https://github.com/felipejoq/desafios-sql-postgres-db/assets/35277450/c68f074b-e60f-4e8b-9f37-3e5b1acdd3e1)

___

9. ¿Qué días se inscribieron más de 50 personas?

```sql
SELECT fecha, SUM(cantidad) AS total_inscritos
FROM inscritos
GROUP BY fecha
HAVING SUM(cantidad) > 50
ORDER BY SUM(cantidad) DESC;
```

##### Resultado:
![09-resultado](https://github.com/felipejoq/desafios-sql-postgres-db/assets/35277450/8590513e-c5a7-4333-9cbd-9f95665f4259)

___

10. ¿Cuál es el promedio diario de personas inscritas a partir del tercer día en adelante, considerando únicamente las fechas posteriores o iguales a la indicada?

```sql
SELECT fecha, ROUND(AVG(cantidad), 2) AS promedio
FROM inscritos
GROUP BY fecha
ORDER BY fecha ASC
OFFSET 2;
```

##### Resultado:
![10-resultado](https://github.com/felipejoq/desafios-sql-postgres-db/assets/35277450/879888f2-8e5a-418e-a510-f17bb7f65561)

___

Desafío desarrollado con PortgreSQL versión 14.9
