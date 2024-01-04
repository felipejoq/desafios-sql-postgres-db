-- ######### PARTE 2 ######### --
DROP TABLE IF EXISTS preguntas, usuarios, respuestas;

CREATE TABLE preguntas (
  id SERIAL PRIMARY KEY,
  pregunta VARCHAR(255),
  respuesta_correcta VARCHAR
);

CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255),
  edad INTEGER CHECK(edad >= 18)
);

CREATE TABLE respuestas (
  id SERIAL PRIMARY KEY,
  respuesta VARCHAR(255),
  usuario_id INTEGER,
  pregunta_id INTEGER,
  CONSTRAINT fk_usuario_id
    FOREIGN KEY (usuario_id)
      REFERENCES usuarios (id)
        ON DELETE CASCADE,
  CONSTRAINT fk_pregunta_id
    FOREIGN KEY (pregunta_id)
      REFERENCES preguntas (id)
        ON DELETE CASCADE
);

INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES
  ('¿Cuál es la capital de Francia?', 'París'),
  ('¿En qué año se fundó la ONU?', '1945'),
  ('¿Cuál es el símbolo químico del oro?', 'Au'),
  ('¿Quién escribió "Cien años de soledad"?', 'Gabriel García Márquez'),
  ('¿Cuántos lados tiene un triángulo?', '3');

INSERT INTO usuarios (nombre, edad) VALUES
  ('Juan', 25),
  ('María', 30),
  ('Carlos', 22),
  ('Laura', 28),
  ('Pedro', 35);

-- Respuestas correctas
INSERT INTO
  respuestas (respuesta, usuario_id, pregunta_id)
VALUES
  ('París', 1, 1), -- Usuario Juan responde correctamente la primera pregunta
  ('París', 2, 1), -- Usuario María responde correctamente la primera pregunta
  ('1945', 3, 2); -- Usuario Carlos responde correctamente la segunda pregunta

-- Respuestas incorrectas
INSERT INTO
  respuestas (respuesta, usuario_id, pregunta_id)
VALUES
  ('Berlín', 4, 1), -- Usuario Laura responde incorrectamente la primera pregunta
  ('Hiroshima', 5, 2), -- Usuario Pedro responde incorrectamente la segunda pregunta
  ('Ag', 1, 3), -- Usuario Juan responde incorrectamente la tercera pregunta
  ('Miguel de Cervantes', 2, 4), -- Usuario María responde incorrectamente la cuarta pregunta
  ('4', 3, 5); -- Usuario Carlos responde incorrectamente la quinta pregunta

-- Cantidad de respuestas correctas sin considerar la pregunta
SELECT u.id, u.nombre AS usuario, COUNT(r.id) AS respuestas_correctas
FROM usuarios u
LEFT JOIN respuestas r ON u.id = r.usuario_id
LEFT JOIN preguntas p ON r.pregunta_id = p.id
WHERE r.respuesta = p.respuesta_correcta
GROUP BY u.id, u.nombre;

-- Por cada pregunta, cuantos usuarios respondieron correctamente.
SELECT p.id, p.pregunta, COUNT(DISTINCT r.usuario_id) AS usuarios_correctos
FROM preguntas p
LEFT JOIN respuestas r ON p.id = r.pregunta_id AND r.respuesta = p.respuesta_correcta
GROUP BY p.id, p.pregunta;

-- Añade el campo email a la talba usuarios y lo restringe para que sea único.
ALTER TABLE usuarios
ADD COLUMN email VARCHAR(255) UNIQUE;
