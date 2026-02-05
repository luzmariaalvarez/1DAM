/* =========================================================
   CLÍNICA - SCRIPT COMPLETO (MariaDB / XAMPP / phpMyAdmin)
   Incluye:
   - Creación de BD
   - Tablas + claves foráneas
 
   ========================================================= */

-- 1) CREAR BD
CREATE DATABASE clinica;


-- =========================================================
-- 1) TABLAS 
-- =========================================================

-- ---------------------------
-- paciente
-- ---------------------------
CREATE TABLE paciente (
  id_paciente INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(60) NOT NULL,
  apellidos   VARCHAR(90) NOT NULL,
  telefono    VARCHAR(20) UNIQUE
);

-- ---------------------------
-- medico
-- ---------------------------
CREATE TABLE medico (
  id_medico    INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(60) NOT NULL,
  apellidos    VARCHAR(90) NOT NULL,
  especialidad VARCHAR(80) NOT NULL
);

-- ---------------------------
-- tratamiento
-- ---------------------------
CREATE TABLE tratamiento (
  id_tratamiento INT AUTO_INCREMENT PRIMARY KEY,
  descripcion    VARCHAR(200) NOT NULL
);

-- ---------------------------
-- cita (paciente 1:N cita)
-- ---------------------------
CREATE TABLE cita (
  id_cita INT AUTO_INCREMENT PRIMARY KEY,
  fecha   DATETIME NOT NULL,

  id_paciente INT NOT NULL,
  FOREIGN KEY (id_paciente)
    REFERENCES paciente (id_paciente)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

-- ---------------------------
-- atiende (cita N:M medico)
--   - PK compuesta
-- ---------------------------
CREATE TABLE atiende (
  id_cita INT NOT NULL,
  FOREIGN KEY (id_cita)
    REFERENCES cita (id_cita),

  id_medico INT NOT NULL,
  FOREIGN KEY (id_medico)
    REFERENCES medico (id_medico),

  PRIMARY KEY (id_cita, id_medico)

);

-- ---------------------------
-- incluye (cita N:M tratamiento)
--   - PK compuesta
-- ---------------------------
CREATE TABLE incluye (
  id_cita INT NOT NULL,
  FOREIGN KEY (id_cita)
    REFERENCES cita (id_cita),

  id_tratamiento INT NOT NULL,
  FOREIGN KEY (id_tratamiento)
    REFERENCES tratamiento (id_tratamiento),

  PRIMARY KEY (id_cita, id_tratamiento)
);

-- =========================================================
-- 3) DATOS DE EJEMPLO
-- =========================================================

INSERT INTO paciente (nombre, apellidos, telefono) VALUES
('Lucía', 'Pérez Martín', '600111222'),
('Adrián', 'Gómez Ruiz', '600333444'),
('Nora', 'Sánchez Díaz', '600555666'),
('Hugo', 'Romero Paredes', '600777888'),
('Marta', 'Santos León', '600999000');

INSERT INTO medico (nombre, apellidos, especialidad) VALUES
('Marta',  'López Campos',     'Pediatría'),
('Carlos', 'Fernández Vega',   'Traumatología'),
('Irene',  'Navarro Gil',      'Dermatología'),
('Sergio', 'García Molina',    'Medicina general'),
('Laura',  'Ortega Prieto',    'Oftalmología');

INSERT INTO tratamiento (descripcion) VALUES
('Consulta general'),
('Radiografía'),
('Curación de herida'),
('Revisión dermatológica'),
('Infiltración'),
('Revisión pediátrica'),
('Revisión de vista'),
('Receta y medicación');

-- Citas (solo paciente + fecha)
INSERT INTO cita (fecha, id_paciente) VALUES
('2026-02-02 10:00:00', 1),
('2026-02-02 12:30:00', 2),
('2026-02-03 09:15:00', 1),
('2026-02-03 11:00:00', 3),
('2026-02-04 16:45:00', 4),
('2026-02-05 08:30:00', 5);

-- Médicos asignados a citas (N:M)
INSERT INTO atiende (id_cita, id_medico) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 2),
(4, 4),
(5, 4),
(6, 5);

-- Tratamientos por cita (N:M)
INSERT INTO incluye (id_cita, id_tratamiento) VALUES
(1, 6),
(1, 8),
(2, 2),
(2, 3),
(3, 4),
(4, 2),
(4, 5),
(5, 1),
(6, 7);



/* =========================================================
   CLÍNICA - QUERIES PRINCIPIANTES 
   ========================================================= */



-- 1) VER DATOS (básico)
SELECT * FROM paciente;
SELECT * FROM medico;
SELECT * FROM tratamiento;
SELECT * FROM cita;
SELECT * FROM atiende;
SELECT * FROM incluye;

-- 2) SELECCIONAR CAMPOS CONCRETOS
SELECT id_paciente, nombre, apellidos, telefono
FROM paciente;

SELECT id_medico, nombre, apellidos, especialidad
FROM medico;

SELECT id_tratamiento, descripcion
FROM tratamiento;

-- 3) WHERE (filtrar)
SELECT *
FROM paciente
WHERE nombre = 'Lucía';

SELECT *
FROM medico
WHERE especialidad = 'Traumatología';

SELECT *
FROM cita
WHERE fecha >= '2026-02-03 00:00:00';

-- 4) ORDER BY (ordenar)

-- ordenar citas por fecha
SELECT *
FROM cita
ORDER BY fecha;

-- odenar paciente por apellidos y nombre


-- 8) LIKE (buscar texto)
-- Tratamiento que contiene revisión


-- Medico que Contiene Vega en apellido
