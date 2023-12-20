-- 1. Crea y agrega al entregable las consultas para completar
-- el setup de acuerdo a lo pedido.

-- ##### DESARROLLO DEL SETUP
CREATE DATABASE desafio3_felipe_jofre_000;
-- Para usar la base de datos utilizar comando:
--    \c desafio3_felipe_jofre_000

CREATE TABLE IF NOT EXISTS
  usuarios (
    id SERIAL PRIMARY KEY,
    rol VARCHAR DEFAULT 'usuario' CHECK (rol IN ('administrador', 'usuario')) NOT NULL,
    email VARCHAR NOT NULL,
    nombre VARCHAR NOT NULL,
    apellido VARCHAR NOT NULL
  );
  
INSERT INTO
  usuarios (rol, email, nombre, apellido)
VALUES
  ('administrador', 'felipe@test.test', 'Felipe', 'Jofré'),
  ('usuario', 'antonio@test.test', 'Antonio', 'Rivera'),
  ('usuario', 'jane@test.test', 'Jane', 'Loto'),
  ('usuario', 'maria@test.test', 'María', 'López'),
  ('usuario', 'roberto@test.test', 'Roberto', 'Troncoso');

CREATE TABLE IF NOT EXISTS
  posts (
    id SERIAL PRIMARY KEY,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT NOW (),
    fecha_actualizacion TIMESTAMP,
    destacado BOOLEAN DEFAULT false NOT NULL,
    titulo VARCHAR,
    contenido TEXT,
    usuario_id BIGINT,
    CONSTRAINT fk_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
  );

INSERT INTO
  posts (fecha_creacion, fecha_actualizacion, destacado, titulo, contenido, usuario_id)
VALUES
  ('2023-12-01', NULL, true, '01 Lorem ipsum dolor sit amet', '01 Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...', 1),
  ('2023-12-05', NULL, false, '02 Lorem ipsum dolor sit amet', '02 Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...', 1),
  ('2023-12-11', NULL, false, '03 Lorem ipsum dolor sit amet', '03 Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...', 2),
  ('2023-12-15', NULL, false, '04 Lorem ipsum dolor sit amet', '04 Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...', 3),
  ('2023-12-19', NULL, false, '05 Lorem ipsum dolor sit amet', '05 Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...', NULL);

CREATE TABLE IF NOT EXISTS
  comentarios (
    id SERIAL PRIMARY KEY,
    fecha_creacion TIMESTAMP DEFAULT NOW(),
    usuario_id BIGINT,
    post_id BIGINT,
    contenido TEXT NOT NULL,
    CONSTRAINT fk_usuario 
      FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id),
    CONSTRAINT fk_post
      FOREIGN KEY (post_id)
      	REFERENCES posts(id)
  );

INSERT INTO
	comentarios (fecha_creacion, usuario_id, post_id, contenido)
VALUES
	('2023-12-01', 1, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
 	('2023-12-05', 2, 1, 'consectetur adipiscing elit, sed do'),
 	('2023-12-11', 3, 1, 'sit amet, consectetur adipisci'),
 	('2023-12-15', 1, 2, 'consectetur adipiscing elit'),
 	('2023-12-19', 2, 2, 'psum dolor sit amet, consectetur adipiscing elit, sed d');

-- DESARROLLO

-- 2. Cruza los datos de la tabla usuarios y posts, mostrando las siguientes columnas:
-- nombre y email del usuario junto al título y contenido del post.
SELECT u.nombre, u.email, p.titulo, p.contenido
FROM usuarios AS u
INNER JOIN posts AS p
ON u.id = p.usuario_id;

-- 3. Muestra el id, título y contenido de los posts de los administradores.
-- a). El administrador puede ser cualquier id.
SELECT p.id, p.titulo, p.contenido, u.nombre AS autor, u.rol
FROM usuarios AS u
INNER JOIN posts AS p
ON u.id = p.usuario_id
WHERE u.id = (SELECT id FROM usuarios WHERE rol = 'administrador');

-- 4. Cuenta la cantidad de posts de cada usuario.
-- a). La tabla resultante debe mostrar el id e email del usuario junto con la
--     cantidad de posts de cada usuario.
SELECT u.id, u.email, COUNT(p.id) as cantidad_posts
FROM usuarios AS u
INNER JOIN posts AS p
ON u.id = p.usuario_id
GROUP BY u.id, u.email
ORDER BY cantidad_posts DESC;

-- 5. Muestra el email del usuario que ha creado más posts.
-- a). Aquí la tabla resultante tiene un único registro y muestra solo el email.
SELECT u.id, u.email, COUNT(p.id) as cantidad_posts
FROM usuarios AS u
INNER JOIN posts AS p
ON u.id = p.usuario_id
GROUP BY u.id, u.email
ORDER BY cantidad_posts DESC
LIMIT 1;

-- 6. Muestra la fecha del último post de cada usuario.
SELECT u.nombre AS autor, p.titulo, p.fecha_creacion
FROM usuarios AS u
INNER JOIN posts AS p
ON u.id = p.usuario_id;

-- 7. Muestra el título y contenido del post (artículo) con más comentarios
SELECT p.titulo, p.contenido, count(c.id) AS cantidad_comentarios
FROM posts AS p
INNER JOIN comentarios AS c
ON p.id = c.post_id
GROUP BY p.id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 8. Muestra en una tabla el título de cada post, el contenido de cada
-- post y el contenido de cada comentario asociado a los posts mostrados,
-- junto con el email delusuario queloescribió.
SELECT p.titulo, p.contenido, c.contenido, u.email
FROM posts AS p
INNER JOIN comentarios AS c
ON p.id = c.post_id
INNER JOIN usuarios AS u
ON c.usuario_id = u.id;

-- 9. Muestra el contenido del último comentario de cada usuario.
SELECT DISTINCT ON (u.email)
  u.email,
  c.fecha_creacion,
  c.contenido
FROM usuarios u
INNER JOIN comentarios c
ON u.id = c.usuario_id
ORDER BY u.email, c.fecha_creacion DESC;

-- 10. Muestra los emails de los usuarios que no han escrito ningún comentario
SELECT u.email
FROM usuarios u
LEFT JOIN comentarios c
ON u.id = c.usuario_id
WHERE c.id IS NULL;