-- ######### PARTE 1 ######### --
DROP TABLE IF EXISTS peliculas, tags, peliculas_tags;

-- Se crea la tabla películas
CREATE TABLE peliculas (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255),
  anno INTEGER
);

-- Se crea la tabla tags
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  tag VARCHAR(32)
);

-- Se crea la tabla peliculas_tags que une las dos anteriores.
CREATE TABLE peliculas_tags (
  id SERIAL PRIMARY KEY,
  pelicula_id INTEGER,
  tag_id INTEGER,
  CONSTRAINT fk_pelicula_id
    FOREIGN KEY (pelicula_id)
      REFERENCES peliculas (id)
        ON DELETE CASCADE,
  CONSTRAINT fk_tag_id
    FOREIGN KEY (tag_id)
      REFERENCES tags (id)
        ON DELETE CASCADE
);

-- Se pobla de datos la DB.
INSERT INTO peliculas (nombre, anno)
VALUES
('Titanic', 1997),
('Toy Story 3', 2010),
('El Padrino', 1983),
('Vengadores Endgame', 2019),
('Coco', 2017);

INSERT INTO tags (tag)
VALUES
('SCI-FI'),
('Drama'),
('Romance'),
('Infantil'),
('General');

INSERT INTO peliculas_tags (pelicula_id, tag_id)
VALUES
(1, 2),
(1, 3),
(1, 5),
(2, 4),
(2, 5);

-- Obtiene la cantidad de tags por película
SELECT p.id, p.nombre, COUNT(pt.tag_id) AS cantidad_tags
FROM peliculas p
LEFT JOIN peliculas_tags pt ON p.id = pt.pelicula_id
GROUP BY p.id, p.nombre
ORDER BY cantidad_tags DESC;