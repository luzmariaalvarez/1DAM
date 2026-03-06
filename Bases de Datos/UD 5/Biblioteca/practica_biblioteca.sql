-- ============================================
-- PRÁCTICA COMPLETA DE MYSQL
-- BIBLIOTECA MUNICIPAL
-- Incluye:
-- SELECT, INSERT, UPDATE, DELETE, ALTER,
-- JOIN, INNER JOIN, LEFT JOIN, RIGHT JOIN,
-- WHERE, ORDER BY, HAVING, COUNT, AVG, MIN, MAX,
-- SUBCONSULTAS
-- Entorno: XAMPP / phpMyAdmin
-- ============================================

CREATE DATABASE Biblioteca;


CREATE TABLE libros (
    id_libro INT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    anio INT,
    disponible BOOLEAN DEFAULT TRUE
);

CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(100),
    edad INT
);


CREATE TABLE prestamos (
    id_prestamo INT PRIMARY KEY,
    id_libro INT,
    id_usuario INT,
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);



-- Añadir nuevas columnas para practicar ALTER

ALTER TABLE usuarios
ADD telefono VARCHAR(20);

ALTER TABLE libros
ADD genero VARCHAR(50);

-- INSERTAR DATOS


INSERT INTO libros (id_libro, titulo, autor, anio, disponible, genero) VALUES
(1, 'Don Quijote', 'Miguel de Cervantes', 1605, TRUE, 'Novela'),
(2, '1984', 'George Orwell', 1949, FALSE, 'Distopía'),
(3, 'El Principito', 'Antoine de Saint-Exupéry', 1943, FALSE, 'Fábula'),
(4, 'Cien años de soledad', 'Gabriel García Márquez', 1967, TRUE, 'Realismo mágico'),
(5, 'La sombra del viento', 'Carlos Ruiz Zafón', 2001, TRUE, 'Misterio'),
(6, 'Rayuela', 'Julio Cortázar', 1963, FALSE, 'Novela');

INSERT INTO usuarios (id_usuario, nombre, correo, edad, telefono) VALUES
(1, 'Ana', 'ana@email.com', 22, '600111111'),
(2, 'Luis', 'luis@email.com', 25, '600222222'),
(3, 'Marta', 'marta@email.com', 18, '600333333'),
(4, 'Carlos', 'carlos@email.com', 30, '600444444'),
(5, 'Sonia', 'sonia@email.com', 27, '600555555');

INSERT INTO prestamos (id_prestamo, id_libro, id_usuario, fecha_prestamo, fecha_devolucion) VALUES
(1, 2, 1, '2026-02-01', NULL),
(2, 3, 2, '2026-02-10', NULL),
(3, 6, 4, '2026-02-15', '2026-02-28');


-- SELECT BÁSICOS


-- 1. Mostrar todos los libros


-- 2. Mostrar todos los usuarios

-- 3. Mostrar solo título y autor


-- 4. WHERE: libros publicados después de 1950


-- 5. WHERE: usuarios mayores de 21 años


-- 6. ORDER BY: libros ordenados por año ascendente


-- 7. ORDER BY descendente: usuarios por edad


-- 8. WHERE + ORDER BY



-- UPDATE


--9. SELECT previo al libro id= 5
SELECT *
FROM libros
WHERE id_libro = 5;

-- el libro 5 deja de estar disponible
UPDATE libros
SET disponible = FALSE
WHERE id_libro = 5;

-- Comprobación
SELECT *
FROM libros
WHERE id_libro = 5;

-- 10. SELECT previo al id_usuario = 1


-- Cambiar correo de Ana por ana.nuevo@email.com


-- Comprobación del cambio


-- 11. Usuarios mayores de 25 años y sumarles 1 año mas 



-- DELETE


-- SELECT previo a usuarios mayores de edad


-- ¿Puedes borrar alguno de estos usuarios?


-- Comprobación


-- 12. SELECT previo al libro id_libro = 1


-- borralo


-- Comprobación



-- JOIN, INNER JOIN, LEFT JOIN, RIGHT JOIN



-- 13. Mostrar préstamos con nombre de usuario y título del libro

-- 14. LEFT JOIN
-- Mostrar todos los usuarios, tengan o no préstamos

-- 15. RIGHT JOIN
-- Mostrar todos los préstamos y los datos del usuario asociado



-- FUNCIONES DE AGREGACIÓN


-- 16.COUNT: número total de libros

-- 17. COUNT: número de usuarios


-- 18. AVG: edad media de los usuarios


-- 19. MIN: edad mínima


-- 20. MAX: edad máxima


-- 21. COUNT de libros disponibles


-- GROUP BY Y HAVING


-- 22. Contar cuántos libros hay por género


-- 23. Mostrar géneros con más de 1 libro


-- 24. Contar préstamos por usuario


-- 25. Mostrar solo usuarios con al menos 1 préstamo



-- SUBCONSULTAS


-- 26. Mostrar usuarios que tienen préstamos


-- 27. Mostrar libros que han sido prestados IN

-- 28. Mostrar usuarios con edad superior a la edad media AVG


-- 29. Mostrar el libro más antiguo

