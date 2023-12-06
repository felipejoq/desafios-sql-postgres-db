
-- Crea la base de datos "name_database"
CREATE DATABASE name_database;

-- selecciona la base de datos: \c name_database

-- crea la tabla "clientes"
CREATE TABLE clientes (
    email varchar(50),
    nombre varchar,
    telefono varchar(16),
    empresa varchar(50),
    prioridad smallint --CHECK (prioridad >= 1 AND prioridad <= 10)
    -- Podríamos agregar un check para solo permitir valores del 1 al 10.
);

-- Inserta registros en la tabla anterior.
INSERT INTO clientes (email, nombre, telefono, empresa, prioridad) VALUES
('juan@test.test', 'Juan Pérez', '+56912345678', 'Empresa A', 5),
('mariag@test.test', 'María González', '+56923456789', 'Empresa B', 3),
('pedro@test.test', 'Pedro López', '+56934567890', 'Empresa C', 1),
('ana@test.test', 'Ana Sánchez', '+56945678901', 'Empresa D', 9),
('luis@test.test', 'Luis García', '+56956789012', 'Empresa E', 7);

-- Selecciona los registros y los ordena por prioridad de mayor a menor y solo retorna 3.
SELECT *
FROM clientes
ORDER BY prioridad DESC
LIMIT 3;

-- Selecciona todos los clientes con prioridad mayor a 5.
SELECT *
FROM clientes
WHERE prioridad > 5;
