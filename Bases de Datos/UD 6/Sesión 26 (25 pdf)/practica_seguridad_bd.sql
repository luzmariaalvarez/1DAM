-- PRACTICA MYSQL: SEGURIDAD DE DATOS

-- 1. Crear base de datos
CREATE DATABASE seguridad_bd;
USE seguridad_bd;

-- 2. Crear tabla
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    dni VARCHAR(20),
    email VARCHAR(100),
    edad INT
);

-- 3. Insertar datos
INSERT INTO clientes (nombre, dni, email, edad) VALUES
('Juan Perez', '12345678A', 'juan@gmail.com', 30),
('Maria Lopez', '87654321B', 'maria@gmail.com', 25),
('Carlos Ruiz', '11223344C', 'carlos@gmail.com', 40);

-- 4. Ver datos originales
SELECT * FROM clientes;

-- 5. ANONIMIZACION (IRREVERSIBLE)
UPDATE clientes
SET nombre = NULL,
    dni = NULL,
    email = NULL;

-- 6. Ver resultado anonimizado
SELECT * FROM clientes;

-- 7. PSEUDONIMIZACION
CREATE TABLE clientes_pseudo (
    id INT PRIMARY KEY,
    codigo VARCHAR(10)
);



CREATE TABLE clientes2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    dni VARCHAR(20),
    email VARCHAR(100),
    edad INT
);

-- 3. Insertar datos
INSERT INTO cliente2 (nombre, dni, email, edad) VALUES
('Juan Perez', '12345678A', 'juan@gmail.com', 30),
('Maria Lopez', '87654321B', 'maria@gmail.com', 25),
('Carlos Ruiz', '11223344C', 'carlos@gmail.com', 40);

INSERT INTO clientes_pseudo VALUES
(4, 'ID004'),
(5, 'ID005'),
(6, 'ID006');

SELECT p.codigo, c.edad
FROM clientes2 c
JOIN clientes_pseudo p ON c.id = p.id;

SELECT p.codigo, c.edad, c.nombre FROM clientes2 c JOIN clientes_pseudo p ON c.id = p.id;


-- 8. Craer tabla e Insertar datos

CREATE TABLE clientesMask (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    dni VARCHAR(20),
    email VARCHAR(100),
    edad INT
);

INSERT INTO clientesMask (nombre, dni, email, edad) VALUES
('Ana ALonso', '44445678A', 'ana@gmail.com', 34),
('Pedro Perez', '6664321B', 'pedro@gmail.com', 23),
('Marta Ruiz', '13333344C', 'carlos@gmail.com', 56);

-- 9. DATA MASKING (ejemplo con DNI)
SELECT 
    nombre,
    CONCAT('****', RIGHT(dni, 2)) AS dni_oculto,
    email
FROM clientesMask;

-- 10. DATA MASKING (email)
SELECT 
    nombre,
    CONCAT(LEFT(email, 2), '****@gmail.com') AS email_oculto
FROM clientesMask;


-- CIFRADO 


--Crear tabla
-- Usamos TEXT porque vamos a guardar el cifrado en Base64 (texto)
CREATE TABLE clientesCifrados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre TEXT,
    dni TEXT,
    email TEXT,
    edad INT
);


-- INSERTAR DATOS CIFRADOS

-- AES_ENCRYPT(): cifra el dato
-- TO_BASE64(): convierte el resultado binario a texto legible

INSERT INTO clientesCifrados (nombre, dni, email, edad)
VALUES
(
    TO_BASE64(AES_ENCRYPT('Juan Perez', 'Clave123')),   -- nombre cifrado
    TO_BASE64(AES_ENCRYPT('12345678A', 'Clave123')),    -- dni cifrado
    TO_BASE64(AES_ENCRYPT('juan@gmail.com', 'Clave123')), -- email cifrado
    30
),
(
    TO_BASE64(AES_ENCRYPT('Maria Lopez', 'Clave123')),
    TO_BASE64(AES_ENCRYPT('87654321B', 'Clave123')),
    TO_BASE64(AES_ENCRYPT('maria@gmail.com', 'Clave123')),
    25
),
(
    TO_BASE64(AES_ENCRYPT('Carlos Ruiz', 'Clave123')),
    TO_BASE64(AES_ENCRYPT('11223344C', 'Clave123')),
    TO_BASE64(AES_ENCRYPT('carlos@gmail.com', 'Clave123')),
    40
);


-- VER DATOS GUARDADOS


-- veremos cadenas en Base64 (no legibles directamente)
SELECT * FROM clientesCifrados;


-- DESCIFRAR DATOS


-- FROM_BASE64(): vuelve a convertir el texto a binario
-- AES_DECRYPT(): descifra usando la misma clave
-- CAST(... AS CHAR): convierte el resultado a texto legible

SELECT
    id,
    CAST(AES_DECRYPT(FROM_BASE64(nombre), 'Clave123') AS CHAR) AS nombre,
    CAST(AES_DECRYPT(FROM_BASE64(dni), 'Clave123') AS CHAR) AS dni,
    CAST(AES_DECRYPT(FROM_BASE64(email), 'Clave123') AS CHAR) AS email,
    edad
FROM clientesCifrados;

