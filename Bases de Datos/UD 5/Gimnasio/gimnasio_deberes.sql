/* =========================================================
   GIMNASIO - ARCHIVO ÚNICO .SQL (PK/UNIQUE INLINE)
   MariaDB / XAMPP / phpMyAdmin

   CONTENIDO:
   1) DDL: BD + tablas + claves + vistas
   2) DML: datos de ejemplo
   3) DML de PRÁCTICA con ENUNCIADOS
   ========================================================= */

-- =========================================================
-- 1) CREACIÓN DE LA BASE DE DATOS
-- =========================================================

CREATE DATABASE gimnasio;


-- =========================================================
-- 2) DDL - TABLAS
-- =========================================================

-- Tabla SOCIO
CREATE TABLE socio (
  id_socio INT AUTO_INCREMENT PRIMARY KEY,
  nombre   VARCHAR(80) NOT NULL,
  telefono VARCHAR(20) UNIQUE
);

-- Tabla INSTRUCTOR
CREATE TABLE instructor (
  id_instructor INT AUTO_INCREMENT PRIMARY KEY,
  nombre        VARCHAR(80) NOT NULL,
  especialidad  VARCHAR(80) NOT NULL
);

-- Tabla SALA
CREATE TABLE sala (
  id_sala   INT AUTO_INCREMENT PRIMARY KEY,
  nombre    VARCHAR(80) NOT NULL,
  capacidad INT NOT NULL,
  CHECK (capacidad > 0)
);

CREATE TABLE sala2 (
    id_sala int AUTO_INCREMENT PRIMARY KEY,
    nombre_sala varchar(20) NOT null UNIQUE,
    capacidad int not null check(capacidad > 0) 
);

-- Tabla CLASE
CREATE TABLE clase (
  id_clase INT AUTO_INCREMENT PRIMARY KEY,
  nombre   VARCHAR(120) NOT NULL,

  -- Socio que reserva la clase
  id_socio INT NOT NULL,
    FOREIGN KEY (id_socio) REFERENCES socio (id_socio),


  -- Instructor que imparte la clase
  id_instructor INT NOT NULL,
  FOREIGN KEY (id_instructor) REFERENCES instructor (id_instructor),

  -- Sala donde se imparte la clase
  id_sala INT NOT NULL,
  FOREIGN KEY (id_sala) REFERENCES sala (id_sala)

);



CREATE TABLE clase2 (
  id_clase INT AUTO_INCREMENT PRIMARY KEY,
  nombre_clase VARCHAR(20) NOT NULL,

  id_socio INT,
  id_sala INT,
  id_instructor INT,

  FOREIGN KEY (id_socio) REFERENCES socio(id_socio),
  FOREIGN KEY (id_sala) REFERENCES sala(id_sala),
  FOREIGN KEY (id_instructor) REFERENCES instructor(id_instructor)
);


-- =========================================================
-- 3) DML - DATOS DE EJEMPLO
-- =========================================================

INSERT INTO socio (nombre, telefono) VALUES
('Luis Gómez', '600111222'),
('Claudia Pérez', '600333444'),
('Nora Sánchez', '600555666'),
('Hugo Romero', '600777888');

INSERT INTO instructor (nombre, especialidad) VALUES
('María López', 'Spinning'),
('Carlos Vega', 'Crossfit'),
('Irene Navarro', 'Yoga'),
('Sergio Molina', 'Pilates');

INSERT INTO sala (nombre, capacidad) VALUES
('Sala A', 20),
('Sala B', 15),
('Sala Yoga', 25),
('Sala Funcional', 18);

INSERT INTO clase (nombre, id_socio, id_instructor, id_sala) VALUES
('Spinning - mañana',  1, 1, 1),
('Crossfit - tarde',   2, 2, 4),
('Yoga - iniciación',  3, 3, 3),
('Pilates - avanzado', 1, 4, 2),
('Yoga - intermedio',  4, 3, 3),
('Spinning - tarde',   2, 1, 1);






-- =========================================================
-- 5) CONSULTAS DML PARA PRACTICAR 
-- =========================================================

-- =========================================================
-- A) INSERT
-- ========================================================= 

-- 1) Añade un nuevo socio llamado “María García” con teléfono 600999000
INSERT INTO socio (nombre, telefono)
VALUES ('María García', '600999000');

-- 2) Añade un nuevo instructor especializado en BodyPump
INSERT INTO instructor (nombre, especialidad)
VALUES ('Raúl Peña', 'BodyPump');

-- 3) Añade una nueva sala llamada “Sala C” con capacidad para 12 personas
INSERT INTO sala (nombre, capacidad)
VALUES ('Sala C', 12);

-- 4) Inserta una nueva clase de Spinning por la noche
--    (usa un socio, instructor y sala que ya existan)
INSERT INTO clase (nombre, id_socio, id_instructor, id_sala)
VALUES ('Spinning - noche', 1, 1, 1);


/* =========================================================
   B) SELECT
========================================================= */

-- 5) Muestra todos los socios del gimnasio
SELECT * FROM socio;

-- 6) Muestra todas las clases con su información completa
SELECT * FROM vista_clases_detalle ORDER BY id_clase;

-- 7) Muestra cuántas clases tiene reservadas cada socio
SELECT * FROM vista_reservas_por_socio
ORDER BY num_clases_reservadas DESC;

-- 8) Muestra las clases reservadas por el socio con id 1
SELECT * FROM vista_clases_detalle
WHERE id_socio = 1;

-- 9) Muestra todas las clases de Yoga

-- 10) Muestra las clases que se imparten en la Sala Yoga


-- 11) Muestra los socios que no tienen ninguna clase reservada



-- =========================================================
  -- C) UPDATE
-- ========================================================= 

-- 12) Cambia el teléfono del socio con id 1


-- 13) Cambia la capacidad de la Sala Yoga a 30 personas


-- 14) Cambia el instructor de la clase con id 3


-- 15) Cambia la sala de todas las clases de Spinning a la Sala B


/* =========================================================
   D) DELETE
========================================================= */

-- 16) Borra la clase con id 6


-- 17) Intenta borrar un socio que tenga clases (observa el error)


-- 18) Borra correctamente un socio:
--     primero sus clases y después el socio


-- 19) Borra todas las clases impartidas por instructores de Crossfit



/* =========================================================
   FIN DEL SCRIPT
========================================================= */
