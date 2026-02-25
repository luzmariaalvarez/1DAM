/* =========================================================
   BD de práctica JOINs (INNER / LEFT / RIGHT)
   ========================================================= */


CREATE DATABASE tienda_DAM;

-- =========================
-- 1) CLIENTES (1:N con pedidos)
-- =========================
CREATE TABLE clientes (
  id_cliente   INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(80) NOT NULL,
  email        VARCHAR(120) UNIQUE,
  provincia    VARCHAR(50) NOT NULL,
  fecha_alta   DATE NOT NULL
);

-- =========================
-- 2) PRODUCTOS (N:M con pedidos)
-- =========================
CREATE TABLE productos (
  id_producto      INT AUTO_INCREMENT PRIMARY KEY,
  nombre_producto  VARCHAR(120) NOT NULL,
  categoria        VARCHAR(60) NOT NULL,
  precio_base      DECIMAL(10,2) NOT NULL,
  activo           BOOLEAN NOT NULL DEFAULT TRUE
);

-- =========================
-- 3) PEDIDOS (cabecera)
-- =========================
CREATE TABLE pedidos (
  id_pedido     INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente    INT NULL,
  fecha_compra  DATE NOT NULL,
  estado        ENUM('creado','pagado','enviado','cancelado') NOT NULL,

  CONSTRAINT fk_pedidos_clientes
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

-- =========================
-- 4) PEDIDO_LINEAS (tabla puente N:M)
-- =========================
CREATE TABLE pedido_lineas (
  id_pedido      INT NOT NULL,
  id_producto    INT NOT NULL,
  cantidad       INT NOT NULL CHECK (cantidad > 0),
  precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario >= 0),

  PRIMARY KEY (id_pedido, id_producto),

  CONSTRAINT fk_lineas_pedido
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

  CONSTRAINT fk_lineas_producto
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

-- =========================
-- 5) PAGOS (1:N con pedidos)
-- =========================
CREATE TABLE pagos (
  id_pago     INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido   INT NOT NULL,
  metodo      ENUM('tarjeta','paypal','transferencia') NOT NULL,
  importe     DECIMAL(10,2) NOT NULL CHECK (importe >= 0),
  fecha_pago  DATE NOT NULL,
  estado      ENUM('ok','fallido','devuelto') NOT NULL,

  CONSTRAINT fk_pagos_pedidos
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- =========================================================
-- DATOS DE PRUEBA
-- =========================================================

INSERT INTO clientes (nombre, email, provincia, fecha_alta) VALUES
('Ana López','ana@correo.com','Madrid','2024-09-01'),
('Luis Pérez','luis@correo.com','Sevilla','2024-09-10'),
('Marta Gil','marta@correo.com','Valencia','2024-10-05'),
('Juan Ruiz','juan@correo.com','Madrid','2024-11-12'),
('Noelia Díaz','noelia@correo.com','Granada','2024-12-01'),
('Sergio Martín','sergio@correo.com','Barcelona','2025-01-15');

INSERT INTO productos (nombre_producto, categoria, precio_base, activo) VALUES
('Portátil 14"','Informática',799.00, TRUE),
('Ratón inalámbrico','Informática',19.99, TRUE),
('Teclado mecánico','Informática',59.90, TRUE),
('Auriculares BT','Audio',39.50, TRUE),
('Monitor 24"','Informática',129.00, TRUE),
('Mochila','Accesorios',24.95, TRUE),
('Altavoz','Audio',49.90, FALSE);

-- pedidos: dejamos algunos clientes sin pedidos a propósito
INSERT INTO pedidos (id_cliente, fecha_compra, estado) VALUES
(1,'2025-01-10','pagado'),
(1,'2025-01-14','enviado'),
(2,'2025-01-20','pagado'),
(3,'2025-02-02','cancelado'),
(6,'2025-02-15','pagado'),
(NULL,'2025-02-19','creado'); -- pedido sin cliente (para practicar RIGHT/LEFT)

-- líneas: (id_pedido, id_producto) es PK compuesta: un producto aparece 1 vez por pedido
INSERT INTO pedido_lineas (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 799.00),
(1, 2, 2, 19.99),
(2, 3, 1, 59.90),
(3, 5, 1, 129.00),
(4, 6, 1, 24.95),
(5, 1, 1, 799.00),
(5, 2, 1, 19.99),
(5, 4, 1, 39.50);

-- pagos: dejamos algún pedido sin pago para practicar LEFT JOIN
INSERT INTO pagos (id_pedido, metodo, importe, fecha_pago, estado) VALUES
(1,'tarjeta',838.98,'2025-01-10','ok'),
(2,'paypal',59.90,'2025-01-14','ok'),
(3,'tarjeta',129.00,'2025-01-20','ok'),
(4,'tarjeta',24.95,'2025-02-03','devuelto'),
(5,'transferencia',858.49,'2025-02-15','ok');


-- =========================================================
-- A) Básicos 
-- =========================================================

-- A1) Lista todos los clientes (id, nombre, provincia).


-- A2) Lista todos los productos activos.


-- A3) Lista todos los pedidos y su estado.


-- A4) Lista todos los pagos con estado 'ok'.


-- A5) Lista los pedidos entre dos fechas (rango ejemplo).



-- =========================================================
-- B) INNER JOIN (coincidencias)
-- =========================================================

-- B1) Mostrar nombre_cliente, id_pedido, fecha_compra, estado (solo pedidos con cliente).


-- B2) Mostrar id_pedido, metodo, importe, fecha_pago (solo pedidos que tienen pago).


-- B3) Mostrar nombre_cliente, id_pedido, importe (clientes con pagos).


-- B4) Mostrar id_pedido, nombre_producto, cantidad, precio_unitario.


-- B5) Mostrar nombre_cliente, nombre_producto, cantidad


-- B6) Mostrar todos los pedidos que incluyen “Portátil 14"”.


-- B7) Mostrar pedidos con productos de categoría “Audio”.



-- =========================================================
-- C) LEFT JOIN (para ver “faltan datos” en la derecha)
-- =========================================================

-- C1) Listar todos los clientes y, si tienen, sus pedidos (clientes sin pedido deben aparecer).


-- C2) Encontrar clientes sin pedidos.


-- C3) Listar todos los pedidos y, si tienen, sus pagos (pedidos sin pago deben aparecer).


-- C4) Encontrar pedidos sin pagos.


-- C5) Listar todos los productos y, si se han vendido, cuántas unidades
--     (productos nunca vendidos deben aparecer).


-- C6) Encontrar productos nunca vendidos.



-- =========================================================
-- D) RIGHT JOIN (para conservar siempre la derecha)
-- =========================================================

-- D1) Mostrar todos los pedidos y el nombre del cliente (aunque sea NULL).

-- D2) Detectar pedidos sin cliente.


-- D3) Mostrar todos los productos que han sido vendidos y, aunque no haya cliente,
--     ver el pedido (RIGHT JOIN desde pedidos hacia líneas para conservar líneas/pedidos).


-- D4) Comparar RIGHT vs LEFT reescribiendo la misma consulta intercambiando el orden de tablas.

--     Versión RIGHT (conserva pedidos):


--     Versión equivalente LEFT (conserva pedidos poniendo pedidos a la izquierda):



-- =========================================================
-- E) ON vs WHERE 
-- =========================================================

-- E1) LEFT JOIN clientes–pedidos: filtra estado='pagado' en WHERE.
--     ¿Qué pasa? Los clientes sin pedido desaparecen (porque WHERE elimina NULL).


-- E2) Repite, pero mete estado='pagado' en el ON.
--     Aquí los clientes sin pedido siguen apareciendo con NULL.


-- E3) LEFT JOIN pedidos–pagos: filtra estado='ok' en WHERE y luego en ON. Compara.

--   E3a) Filtrado en WHERE: pedidos sin pago desaparecen.


--   E3b) Filtrado en ON: pedidos sin pago se mantienen con NULL.
