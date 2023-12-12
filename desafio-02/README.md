# 👨‍💻 SQL: Consultas Agrupadas

En este desafío se ponen a prueba algunos conocimientos SQL para hacer consultas con funciones de agrupación como SUM, COUNT, AVG y además las cláusulas ORDER BY o GRUP BY, etc. Todo el desafío queda explicado en [este archivo](https://drive.google.com/file/d/1qNBZfw5aputTqmOiy7EyQViPtp2uG5FK/view?usp=sharing) PDF

## Desarrollo del desafío

1. ¿Cuántos registros hay?

```sql
SELECT COUNT(*)
FROM inscritos;
```

##### Resultado:
![01-resultado](https://gist.github.com/assets/35277450/a249922f-2249-4904-8eac-21f6d273bfb0)

___

2. ¿Cuántos inscritos hay en total?

```sql
SELECT SUM(cantidad) AS total_inscritos
FROM inscritos;
```

##### Resultado:
![02-resultado](https://gist.github.com/assets/35277450/86c48844-4ed2-45cd-9fbc-9f543cb7a359)

___

3. ¿Cuál o cuáles son los registros de mayor antigüedad?

```sql
SELECT *
FROM inscritos
ORDER BY fecha ASC;
```

##### Resultado:
![03-resultado](https://gist.github.com/assets/35277450/c730f970-cbdc-4a4c-8fd2-ceeef8aeb847)

___

4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante)

```sql
SELECT fecha, SUM(cantidad) AS total_inscritos
FROM inscritos
GROUP BY fecha
ORDER BY fecha;
```

##### Resultado:
![04-resultado](https://gist.github.com/assets/35277450/d0f529c9-7f77-4e62-8fb0-ce4e32d42ee7)

___

5. ¿Cuántos inscritos hay por fuente?

```sql
SELECT fuente, SUM(cantidad)
FROM inscritos
GROUP BY fuente;
```

##### Resultado:
![05-resultado](https://gist.github.com/assets/35277450/edc5de87-2059-4470-8eac-430cc4b79391)

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
![06-resultado](https://gist.github.com/assets/35277450/f411bdc9-9cbf-4c56-99c4-026bad3a42df)

___

7. ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas personas fueron?

```sql
SELECT fecha, fuente, SUM(cantidad) AS total_inscritos
FROM inscritos
GROUP BY fecha, fuente
HAVING fuente = 'Blog'
ORDER BY total_inscritos ASC;
```

##### Resultado:
![07-resultado](https://gist.github.com/assets/35277450/125645ed-96f9-4722-aa54-c489e3673452)

___

8. ¿Cuál es el promedio de personas inscritas por día?

```sql
SELECT fecha, ROUND(AVG(cantidad), 2)
FROM inscritos
GROUP BY fecha;
```

##### Resultado:
![08-resultado](https://gist.github.com/assets/35277450/432a9e65-ce9a-4edd-bf29-767eae8d2fe4)

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
![09-resultado](https://gist.github.com/assets/35277450/13eed52b-b273-403e-be5c-a137d420abdb)

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
![10-resultado](https://gist.github.com/assets/35277450/8cf11fae-1bc6-4f47-ac49-f3878b4b56a2)

___

Desafío desarrollado con PortgreSQL versión 14.9