
-- PRÁCTICA Sesión 23 - OPTIMIZACIÓN DE CONSULTAS SQL


CREATE DATABASE biblioteca_optimizada;


CREATE TABLE socios (
    id_socio    INT AUTO_INCREMENT PRIMARY KEY,
    nombre      VARCHAR(50)  NOT NULL,
    apellidos   VARCHAR(80)  NOT NULL,
    email       VARCHAR(100) NOT NULL,
    ciudad      VARCHAR(50)  NOT NULL,
    fecha_alta  DATE NOT NULL
);


CREATE TABLE prestamos (
    id_prestamo      INT AUTO_INCREMENT PRIMARY KEY,
    id_socio         INT NOT NULL,
    libro            VARCHAR(120) NOT NULL,
    categoria        VARCHAR(50) NOT NULL,
    fecha_prestamo   DATE NOT NULL,
    fecha_devolucion DATE,
    estado           VARCHAR(20) NOT NULL,
    CONSTRAINT fk_prestamos_socios
        FOREIGN KEY (id_socio) REFERENCES socios(id_socio)
);



-- CARGA DE DATOS

INSERT INTO socios (nombre, apellidos, email, ciudad, fecha_alta) VALUES
('Ana',    'Gómez López',      'ana.gomez@example.com',      'Madrid',    '2024-01-10'),
('Luis',   'Pérez Martín',     'luis.perez@example.com',     'Sevilla',   '2024-02-15'),
('María',  'López García',     'maria.lopez@example.com',    'Valencia',  '2024-03-20'),
('Javier', 'Sánchez Ruiz',     'javier.sanchez@example.com', 'Madrid',    '2024-04-08'),
('Lucía',  'Torres Díaz',      'lucia.torres@example.com',   'Barcelona', '2024-05-11'),
('Pedro',  'Ramírez Ortiz',    'pedro.ramirez@example.com',  'Madrid',    '2024-06-01'),
('Elena',  'Castro Romero',    'elena.castro@example.com',   'Bilbao',    '2024-06-17'),
('Carlos', 'Núñez Herrera',    'carlos.nunez@example.com',   'Sevilla',   '2024-07-09'),
('Sara',   'Jiménez Flores',   'sara.jimenez@example.com',   'Valencia',  '2024-08-03'),
('Diego',  'Moreno Santos',    'diego.moreno@example.com',   'Madrid',    '2024-08-25'),
('Paula',  'Ibáñez Gil',       'paula.ibanez@example.com',   'Granada',   '2024-09-12'),
('Hugo',   'Vidal Vega',       'hugo.vidal@example.com',     'Madrid',    '2024-10-05');


INSERT INTO prestamos (id_socio, libro, categoria, fecha_prestamo, fecha_devolucion, estado) VALUES
(1,  'Cien años de soledad',      'Novela',     '2025-01-10', '2025-01-20', 'DEVUELTO'),
(1,  'El Quijote',                'Clásico',    '2025-02-01', NULL,         'PENDIENTE'),
(2,  '1984',                      'Distopía',   '2025-01-12', '2025-01-22', 'DEVUELTO'),
(3,  'La sombra del viento',      'Novela',     '2025-02-03', NULL,         'PENDIENTE'),
(4,  'Sapiens',                   'Historia',   '2025-01-15', '2025-01-30', 'DEVUELTO'),
(5,  'Clean Code',                'Tecnología', '2025-02-07', NULL,         'PENDIENTE'),
(6,  'El nombre del viento',      'Fantasía',   '2025-01-18', '2025-01-28', 'DEVUELTO'),
(7,  'Breves respuestas...',      'Ciencia',    '2025-02-10', NULL,         'PENDIENTE'),
(8,  'Hábitos atómicos',          'Autoayuda',  '2025-01-20', '2025-01-27', 'DEVUELTO'),
(9,  'Los pilares de la tierra',  'Histórica',  '2025-02-11', NULL,         'PENDIENTE'),
(10, 'Dune',                      'Ciencia F.', '2025-01-22', '2025-02-01', 'DEVUELTO'),
(11, 'Orgullo y prejuicio',       'Romántica',  '2025-02-13', NULL,         'PENDIENTE'),
(12, 'El principito',             'Infantil',   '2025-01-25', '2025-02-02', 'DEVUELTO'),
(4,  'Introducción a SQL',        'Tecnología', '2025-02-15', NULL,         'PENDIENTE'),
(6,  'Python para todos',         'Tecnología', '2025-02-16', NULL,         'PENDIENTE');



-- CONSULTAS ANTES DE OPTIMIZAR


-- 3.1 Buscar un socio por email
-- Esta consulta es muy típica en aplicaciones reales.
-- Sin índice sobre email, MariaDB puede revisar fila por fila.
SELECT *
FROM socios
WHERE email = 'ana.gomez@example.com';

-- 3.2 Buscar socios por ciudad
-- También es una consulta habitual.
-- Si no hay índice en ciudad, el motor puede hacer un escaneo completo.
SELECT *
FROM socios
WHERE ciudad = 'Madrid';

-- 3.3 JOIN entre prestamos y socios filtrando por ciudad
-- Aquí intervienen:
-- - la relación entre tablas por id_socio
-- - el filtro por ciudad
-- - la ordenación por fecha_prestamo
-- Este tipo de consulta suele mejorar bastante con buenos índices.
SELECT p.id_prestamo, s.nombre, s.apellidos, p.libro, p.fecha_prestamo, p.estado
FROM prestamos p
JOIN socios s ON p.id_socio = s.id_socio
WHERE s.ciudad = 'Madrid'
ORDER BY p.fecha_prestamo DESC;

-- 3.4 Buscar préstamos pendientes
-- Esta consulta puede beneficiarse de un índice sobre estado.
SELECT *
FROM prestamos
WHERE estado = 'PENDIENTE';

-- 3.5 Consulta poco recomendable
-- YEAR(fecha_prestamo) aplica una función sobre la columna.
-- Eso suele impedir que un índice en fecha_prestamo se aproveche bien.
SELECT *
FROM prestamos
WHERE YEAR(fecha_prestamo) = 2025;



-- ANALIZAR CON EXPLAIN


-- EXPLAIN muestra cómo piensa ejecutar MariaDB la consulta.
-- Las columnas más importantes para esta práctica son:
-- - type: forma de acceso a la tabla
-- - possible_keys: índices posibles
-- - key: índice realmente usado
-- - rows: filas estimadas a examinar
-- - Extra: información adicional


-- type = ALL,    recorre toda la tabla
-- type = range, usa un rango del índice
-- type = ref,   usa un índice no único
-- type = const, acceso muy eficiente a una fila concreta

EXPLAIN
SELECT *
FROM socios
WHERE email = 'ana.gomez@example.com';

EXPLAIN
SELECT *
FROM socios
WHERE ciudad = 'Madrid';

EXPLAIN
SELECT p.id_prestamo, s.nombre, s.apellidos, p.libro, p.fecha_prestamo, p.estado
FROM prestamos p
JOIN socios s ON p.id_socio = s.id_socio
WHERE s.ciudad = 'Madrid'
ORDER BY p.fecha_prestamo DESC;

EXPLAIN
SELECT *
FROM prestamos
WHERE estado = 'PENDIENTE';

EXPLAIN
SELECT *
FROM prestamos
WHERE YEAR(fecha_prestamo) = 2025;


--  VER ÍNDICES ACTUALES


-- Antes de crear índices adicionales, revisamos cuáles existen.
-- En este punto normalmente solo veremos los de PRIMARY KEY.
SHOW INDEX FROM socios;
SHOW INDEX FROM prestamos;


-- CREAR ÍNDICES PARA OPTIMIZAR


-- Índice para búsquedas exactas por email.
-- Es muy útil para consultas tipo:
-- WHERE email = '...'
CREATE INDEX idx_socios_email ON socios(email);

-- Índice para filtros por ciudad.
-- Útil cuando se consulta mucho por ciudad.
CREATE INDEX idx_socios_ciudad ON socios(ciudad);

-- Índice para la clave foránea en prestamos.
-- Ayuda en JOIN y en búsquedas de préstamos por socio.
CREATE INDEX idx_prestamos_id_socio ON prestamos(id_socio);

-- Índice para búsquedas por estado.
-- Útil en consultas como WHERE estado = 'PENDIENTE'
CREATE INDEX idx_prestamos_estado ON prestamos(estado);

-- Índice para filtros por fecha.
-- Ayuda especialmente en consultas con BETWEEN o >= <=
CREATE INDEX idx_prestamos_fecha_prestamo ON prestamos(fecha_prestamo);

-- Índice compuesto.
-- Este índice está pensado para consultas donde primero se filtra
-- por id_socio y después por fecha_prestamo.
-- El orden de las columnas dentro del índice importa.
CREATE INDEX idx_prestamos_socio_fecha ON prestamos(id_socio, fecha_prestamo);



-- COMPROBAR ÍNDICES CREADOS


-- Revisamos que los índices se hayan creado correctamente.
SHOW INDEX FROM socios;
SHOW INDEX FROM prestamos;



-- REPETIR EXPLAIN DESPUÉS DE OPTIMIZAR


-- Ahora repetimos los EXPLAIN.
-- La idea es comparar:
-- - si aparece un índice en possible_keys
-- - si el optimizador realmente lo usa en key
-- - si baja el número de filas estimadas en rows
-- - si cambia type de ALL a ref/range/const

EXPLAIN
SELECT *
FROM socios
WHERE email = 'ana.gomez@example.com';

EXPLAIN
SELECT *
FROM socios
WHERE ciudad = 'Madrid';

EXPLAIN
SELECT p.id_prestamo, s.nombre, s.apellidos, p.libro, p.fecha_prestamo, p.estado
FROM prestamos p
JOIN socios s ON p.id_socio = s.id_socio
WHERE s.ciudad = 'Madrid'
ORDER BY p.fecha_prestamo DESC;

EXPLAIN
SELECT *
FROM prestamos
WHERE estado = 'PENDIENTE';

-- Aquí ya no usamos YEAR(fecha_prestamo).
-- Reescribimos la condición como rango para que el índice pueda ayudar.
EXPLAIN
SELECT *
FROM prestamos
WHERE fecha_prestamo BETWEEN '2025-01-01' AND '2025-12-31';


-- REESCRITURA DE CONSULTAS


-- 9.1 MAL: SELECT *
-- Trae todas las columnas, aunque no hagan falta.
-- Eso aumenta lectura, transferencia y uso de memoria.
SELECT *
FROM socios
WHERE ciudad = 'Madrid';

-- 9.2 BIEN: solo columnas necesarias
-- Mejor práctica: pedir solo los datos que realmente se necesitan.
SELECT nombre, apellidos, email
FROM socios
WHERE ciudad = 'Madrid';

-- 9.3 MAL: función sobre la columna
-- Aunque exista un índice en fecha_prestamo, esta forma suele impedir
-- su aprovechamiento eficiente.
SELECT *
FROM prestamos
WHERE YEAR(fecha_prestamo) = 2025;

-- 9.4 BIEN: rango sobre la columna
-- Esta versión permite que MariaDB use mejor el índice de fecha.
SELECT id_prestamo, id_socio, libro, fecha_prestamo, estado
FROM prestamos
WHERE fecha_prestamo BETWEEN '2025-01-01' AND '2025-12-31';

-- 9.5 JOIN mejor escrito
-- Igual que antes, pero seleccionando solo columnas necesarias.
-- Esto es preferible a SELECT * en joins.
SELECT p.id_prestamo, p.libro, p.fecha_prestamo, s.nombre, s.ciudad
FROM prestamos p
JOIN socios s ON p.id_socio = s.id_socio
WHERE s.ciudad = 'Madrid'
ORDER BY p.fecha_prestamo DESC;



-- EJERCICIOS RESUELTOS


-- EJERCICIO 1
-- Consulta por categoría.
-- Sin índice, MariaDB puede revisar todos los préstamos.
SELECT *
FROM prestamos
WHERE categoria = 'Tecnología';

-- Creamos índice para mejorar ese filtro.
CREATE INDEX idx_prestamos_categoria ON prestamos(categoria);

-- Comprobamos el plan con EXPLAIN.
EXPLAIN
SELECT *
FROM prestamos
WHERE categoria = 'Tecnología';


-- EJERCICIO 2
-- MAL: pedir todas las columnas
SELECT *
FROM socios
WHERE ciudad = 'Madrid';

-- BIEN: pedir solo lo necesario
SELECT nombre, apellidos, email
FROM socios
WHERE ciudad = 'Madrid';


-- EJERCICIO 3
-- Consulta menos recomendable por usar SELECT * en un JOIN.
SELECT *
FROM prestamos p
JOIN socios s ON p.id_socio = s.id_socio;

-- Mejor reescrita: solo columnas necesarias.
SELECT p.id_prestamo, p.libro, p.fecha_prestamo, s.nombre, s.apellidos
FROM prestamos p
JOIN socios s ON p.id_socio = s.id_socio;


-- EJERCICIO 4
-- Analizamos si el índice sobre estado se usa realmente.
EXPLAIN
SELECT *
FROM prestamos
WHERE estado = 'PENDIENTE';



-- EJERCICIOS PROPUESTOS


-- EJERCICIO A
-- Buscar un socio concreto por email.
-- Pregunta para analizar:
-- ¿usa idx_socios_email?
SELECT *
FROM socios
WHERE email = 'maria.lopez@example.com';

-- EJERCICIO B
-- Buscar préstamos en un rango de fechas.
-- Pregunta para analizar:
-- ¿aparece type = range?
SELECT *
FROM prestamos
WHERE fecha_prestamo BETWEEN '2025-02-01' AND '2025-02-28';

-- EJERCICIO C
-- JOIN filtrando por ciudad Sevilla.
-- Pregunta para analizar:
-- ¿usa el índice de ciudad?
-- ¿usa el índice de id_socio?
EXPLAIN
SELECT p.id_prestamo, p.libro, p.fecha_prestamo, s.nombre, s.ciudad
FROM prestamos p
JOIN socios s ON p.id_socio = s.id_socio
WHERE s.ciudad = 'Sevilla';

-- EJERCICIO D
-- Comparar consulta mala frente a consulta buena.
-- La primera usa función sobre la columna.
-- La segunda usa un rango y debería optimizar mejor.
SELECT *
FROM prestamos
WHERE YEAR(fecha_prestamo) = 2025;

SELECT *
FROM prestamos
WHERE fecha_prestamo BETWEEN '2025-01-01' AND '2025-12-31';

-- EJERCICIO E
-- Esta consulta es ideal para el índice compuesto
-- idx_prestamos_socio_fecha (id_socio, fecha_prestamo)
-- porque:
-- 1. filtra primero por id_socio
-- 2. luego por fecha
-- 3. y además ordena por fecha
SELECT id_prestamo, id_socio, libro, fecha_prestamo, estado
FROM prestamos
WHERE id_socio = 4
  AND fecha_prestamo >= '2025-01-01'
ORDER BY fecha_prestamo DESC;


-- EJEMPLOS DE VISTAS

-- Una vista es una consulta guardada con nombre.
-- Sirve para reutilizar consultas frecuentes y hacer más cómodo el trabajo.
-- Importante:
-- una vista NO guarda los datos físicamente;
-- lo que guarda es la definición de la consulta.



-- 1: socios de Madrid

-- Esta vista muestra solo los socios cuya ciudad es Madrid.
-- Es útil cuando una consulta se repite muchas veces.
CREATE OR REPLACE VIEW vw_socios_madrid AS
SELECT id_socio, nombre, apellidos, email, ciudad, fecha_alta
FROM socios
WHERE ciudad = 'Madrid';

-- Consultar la vista:
SELECT *
FROM vw_socios_madrid;

-- 2: préstamos pendientes
-- ---------------------------------------------------------

-- Esta vista muestra solo los préstamos que todavía no han sido devueltos.
-- Muy útil para consultas de seguimiento.
CREATE OR REPLACE VIEW vw_prestamos_pendientes AS
SELECT id_prestamo, id_socio, libro, categoria, fecha_prestamo, estado
FROM prestamos
WHERE estado = 'PENDIENTE';

-- Consultar la vista:
SELECT *
FROM vw_prestamos_pendientes;


-- 3: préstamos con datos del socio

-- Esta vista combina las dos tablas.
-- Así no tienes que escribir el JOIN cada vez.
CREATE OR REPLACE VIEW vw_prestamos_socios AS
SELECT 
    p.id_prestamo,
    p.libro,
    p.categoria,
    p.fecha_prestamo,
    p.fecha_devolucion,
    p.estado,
    s.id_socio,
    s.nombre,
    s.apellidos,
    s.email,
    s.ciudad
FROM prestamos p
JOIN socios s ON p.id_socio = s.id_socio;

-- Consultar la vista:
SELECT *
FROM vw_prestamos_socios;


-- 4: préstamos pendientes con nombre del socio


-- Esta vista es más específica:
-- muestra solo préstamos pendientes junto con el nombre del socio.
-- Es útil para listados o informes.
CREATE OR REPLACE VIEW vw_prestamos_pendientes_detalle AS
SELECT
    p.id_prestamo,
    p.libro,
    p.categoria,
    p.fecha_prestamo,
    p.estado,
    s.nombre,
    s.apellidos,
    s.ciudad
FROM prestamos p
JOIN socios s ON p.id_socio = s.id_socio
WHERE p.estado = 'PENDIENTE';

-- Consultar la vista:
SELECT *
FROM vw_prestamos_pendientes_detalle;


-- 5: resumen de préstamos por socio


-- Esta vista agrupa los préstamos por socio.
-- Permite ver cuántos préstamos tiene cada uno.
CREATE OR REPLACE VIEW vw_resumen_prestamos_por_socio AS
SELECT
    s.id_socio,
    s.nombre,
    s.apellidos,
    COUNT(p.id_prestamo) AS total_prestamos
FROM socios s
LEFT JOIN prestamos p ON s.id_socio = p.id_socio
GROUP BY s.id_socio, s.nombre, s.apellidos;

-- Consultar la vista:
SELECT *
FROM vw_resumen_prestamos_por_socio;


-- 6: resumen de préstamos pendientes por ciudad


-- Esta vista sirve para análisis.
-- Muestra cuántos préstamos pendientes hay en cada ciudad.
CREATE OR REPLACE VIEW vw_pendientes_por_ciudad AS
SELECT
    s.ciudad,
    COUNT(p.id_prestamo) AS total_pendientes
FROM prestamos p
JOIN socios s ON p.id_socio = s.id_socio
WHERE p.estado = 'PENDIENTE'
GROUP BY s.ciudad;

-- Consultar la vista:
SELECT *
FROM vw_pendientes_por_ciudad;



-- CONSULTAS SOBRE VISTAS


-- Las vistas se consultan como si fueran tablas.

-- 1: ver socios de Madrid
SELECT *
FROM vw_socios_madrid;

-- 2: ver solo los libros pendientes
SELECT libro, nombre, apellidos
FROM vw_prestamos_pendientes_detalle;

-- 3: filtrar sobre una vista
SELECT *
FROM vw_prestamos_socios
WHERE ciudad = 'Sevilla';

-- 4: ordenar datos obtenidos desde una vista
SELECT *
FROM vw_resumen_prestamos_por_socio
ORDER BY total_prestamos DESC;



-- EXPLICACIÓN  DE VISTAS

-- 1. Una vista es una consulta guardada con un nombre.
--
-- 2. Sirve para:
--    - simplificar consultas complejas
--    - reutilizar joins frecuentes
--    - mostrar solo ciertos datos
--    - mejorar la organización del trabajo
--
-- 3. Una vista NO sustituye a los índices.
--    Si la consulta de la vista necesita rendimiento,
--    los índices siguen siendo importantes en las tablas base.
--
-- 4. Una vista puede consultar una tabla o varias tablas.
--
-- 5. Una vista puede incluir:
--    - filtros (WHERE)
--    - joins
--    - agrupaciones (GROUP BY)
--    - funciones de agregado como COUNT()
--
-- 6. Consultar una vista es parecido a consultar una tabla:
--    SELECT * FROM nombre_vista;
--
-- 7. Si cambian los datos de las tablas base,
--    al consultar la vista se verán esos cambios.

