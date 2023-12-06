# 🚀 Desafío 1 - Introducción a Bases de Datos

Desafío para validar conocimientos básicos de SQL y Base de Datos usando PostgreSQL. El desafío queda explicado en [este archivo PDF](https://github.com/felipejoq/desafios-sql-postgres-db/blob/main/desafio-01/01-intro-base-de-datos.pdf) y a continuación tenemos el desarrollo.

## 📹 Video explicativo del desafío en práctica

El desafío queda desarrollado de forma práctica en este video ✅ [Desafío 1 - Introducción a Bases de Datos](https://youtu.be/fQsNY8sUD6M)

<a href="https://youtu.be/fQsNY8sUD6M" target="_blank">
<image
    src="https://github.com/felipejoq/desafios-sql-postgres-db/assets/35277450/eb8455b6-8e85-46a3-8db9-c24c7b364006"
    alt="Primer desafío SQL y Postgres"
/>
</a>

## 👨‍💻 Desarrollo del desafío

A. Conectarse a una DB de postgres por consola

```bash
psql -U [user] -W [database]
## Luego pregunta el password
```

1. Crear una base de datos llamada ```desafio-tuNombre-tuApellido-3digitos```

```sql
CREATE DATABASE desafio_felipe_jofre_123;
```

2. Ingresar a la base de datos creada por consola:

```bash
\c [database]
## En la consola debería decir: [database]=#
```

3. Crear una tabla llamada clientes:
   
* Con una columna llamada email de tipo varchar(50).
* Una columna llamada nombre de tipo varchar sin limitación.
* Una columna llamada teléfono de tipo varchar(16).
* Un campo llamado empresa de tipo varchar(50).
* Una columna de tipo smallint, para indicar la prioridad del cliente.
    * Ahí se debe ingresar un valor entre 1 y 10, donde 10 es más prioritario.

```sql
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    email VARCHAR(50),
    nombre VARCHAR,
    telefono VARCHAR(16),
    empresa VARCHAR(50),
    prioridad SMALLINT --CHECK (prioridad >= 1 AND prioridad <= 10)
    -- Podríamos agregar un check para solo permitir valores del 1 al 10.
);
```

4. Ingresar 5 clientes distintos con distintas prioridades, el resto de los valores lospuedes inventar.

```sql
INSERT INTO clientes (email, nombre, telefono, empresa, prioridad) VALUES
('juan@test.test', 'Juan Pérez', '+56912345678', 'Empresa A', 5),
('mariag@test.test', 'María González', '+56923456789', 'Empresa B', 3),
('pedro@test.test', 'Pedro López', '+56934567890', 'Empresa C', 1),
('ana@test.test', 'Ana Sánchez', '+56945678901', 'Empresa D', 9),
('luis@test.test', 'Luis García', '+56956789012', 'Empresa E', 7);
```

5. Selecciona los tres clientes de mayor prioridad

```sql
SELECT *
FROM clientes
ORDER BY prioridad DESC
LIMIT 3;
```

6. Selecciona, de la tabla clientes, una prioridad o una empresa, de forma que el resultado devuelva 2 registros

```sql
SELECT *
FROM clientes
WHERE prioridad > 5;
```

Esos serían los requisitos o solicitudes del desafío.
