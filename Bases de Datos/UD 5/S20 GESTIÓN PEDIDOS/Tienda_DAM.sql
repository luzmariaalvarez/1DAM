CREATE DATABASE Tienda_DAM;


-- Clientes
CREATE TABLE clientes (
  id_cliente INT AUTO_INCREMENT NOT NULL,
  nombre     VARCHAR(60)  NOT NULL,
  email      VARCHAR(100) NOT NULL UNIQUE,
  ciudad     VARCHAR(50)  NOT NULL,
  fecha_alta DATE         NOT NULL,
  
  PRIMARY KEY (id_cliente)
  
);

-- Categorías
CREATE TABLE categorias (
  id_categoria INT AUTO_INCREMENT NOT NULL,
  nombre       VARCHAR(60) NOT NULL UNIQUE,
  
  PRIMARY KEY (id_categoria)
  
);

-- Productos (1:N con categorías)

CREATE TABLE productos (
  id_producto  INT AUTO_INCREMENT NOT NULL,
  nombre       VARCHAR(80)  NOT NULL,
  precio       DECIMAL(10,2) NOT NULL,
  stock        INT NOT NULL,
  id_categoria INT NOT NULL,
 
  PRIMARY KEY (id_producto),
  
  CONSTRAINT fk_productos_categorias
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

-- Pedidos (1:N con clientes)

CREATE TABLE pedidos (
  id_pedido   INT AUTO_INCREMENT NOT NULL,
  id_cliente  INT NOT NULL,
  fecha       DATE NOT NULL,
  estado      ENUM('PENDIENTE','PAGADO','ENVIADO','CANCELADO') NOT NULL,
  total       DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  
  PRIMARY KEY (id_pedido),

  CONSTRAINT fk_pedidos_clientes
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

-- Líneas de pedido (N:M pedidos-productos) tabla intermedia

CREATE TABLE lineas_pedido (
  id_pedido       INT NOT NULL,
  id_producto     INT NOT NULL,
  cantidad        INT NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
 
  PRIMARY KEY (id_pedido, id_producto),

  CONSTRAINT fk_lineas_pedidos
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  
    CONSTRAINT fk_lineas_productos
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);


INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_alta) VALUES
(1,'Ana Ruiz','ana@correo.es','Sevilla','2024-01-10'),
(2,'Luis Pérez','luis@correo.es','Madrid','2024-02-05'),
(3,'Marta Gil','marta@correo.es','Valencia','2024-03-01');


INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_alta) VALUES 
(1000,'Maria Ruiz','maria@correo.es','Sevilla','2024-01-10');

select * from clientes;

INSERT INTO clientes (nombre, email, ciudad, fecha_alta) VALUES ('Pedro Ruiz','pr@correo.es','Madrid','2024-01-10');


INSERT INTO categorias (id_categoria, nombre) VALUES
(10,'Periféricos'),
(11,'Almacenamiento'),
(12,'Redes');



INSERT INTO productos (id_producto, nombre, precio, stock, id_categoria) VALUES
(100,'Teclado mecánico',79.90,15,10),
(101,'Ratón gaming',39.90,40,10),
(102,'SSD 1TB',89.00,20,11),
(103,'Router WiFi 6',129.00,8,12);

INSERT INTO pedidos (id_pedido, id_cliente, fecha, estado, total) VALUES
(500,1,'2024-05-03','PAGADO',119.80),
(501,1,'2024-05-10','PENDIENTE',89.00),
(502,2,'2024-05-12','ENVIADO',129.00),
(503,3,'2024-05-13','CANCELADO',39.90);

INSERT INTO lineas_pedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(500,100,1,79.90),
(500,101,1,39.90),
(501,102,1,89.00),
(502,103,1,129.00),
(503,101,1,39.90);



-- Consultas de práctica 



-- A) SELECT / WHERE / operadores


-- 1) Clientes de Sevilla

-- 2) Productos con stock bajo (<10)


-- 3) Pedidos entre dos fechas (incluye extremos)


-- 4) Pedidos con estado en lista


-- 5) Productos cuyo nombre empieza por 'R'


-- 6) Emails que contienen 'correo'

-- 7) Total >= 100 y NO cancelado


-- 8) Productos de categorías 10 o 12 (IN)


-- 9) Pedidos con total NO en {89,129} (NOT IN)


-- 10) Pedidos PAGADOS o ENVIADOS (OR)


-- 11) Pedidos NO (PAGADO) (NOT)

-- 12) Productos con precio entre 40 y 100




-- B) ORDER BY / LIMIT / DISTINCT


-- 13) Productos más caros primero


-- 14) Top 2 productos con menos stock


-- 15) Ciudades distintas de clientes


-- 16) Pedidos: primero los más recientes




-- C) Agregadas + GROUP BY + HAVING


-- 17) Número de pedidos por estado


-- 18) Facturación total por estado (solo estados con total > 100)


-- 19) Precio medio y stock total por categoría (en productos)


-- 20) Unidades vendidas por producto (en lineas_pedido)


-- 21) Pedido más caro y más barato (MAX/MIN)


-- 22) Precio máximo, mínimo y medio de productos


-- 23) Stock total en la tienda


-- 24) Estados con 2 o más pedidos (HAVING COUNT)




-- D) Subconsultas (SIN JOIN): IN / NOT IN / escalares


-- 25) Clientes que han hecho algún pedido (IN)


-- 26) Clientes SIN pedidos (NOT IN)


-- 27) Pedidos por encima de la media del total


-- 28) Productos que aparecen en alguna línea de pedido

-- 29) Productos que NO aparecen en líneas (nunca vendidos)

-- 30) Pedidos cuyo total es igual al máximo total


-- E) EXISTS / NOT EXISTS (correlacionadas)


-- 31) Clientes que tienen al menos 1 pedido (EXISTS)

-- 32) Clientes sin pedidos (NOT EXISTS)

-- 33) Pedidos que tienen líneas (EXISTS)


-- 34) Pedidos que NO tienen líneas (NOT EXISTS) (por si existieran)


-- 35) Para cada cliente, número de pedidos (columna calculada)


-- 36) Para cada pedido, número de líneas (columna calculada)



-- F) Funciones de fecha y texto


-- 37) Clientes dados de alta en 2024 (YEAR)


-- 38) Pedidos del mes de mayo (MONTH)


-- 39) Emails en mayúsculas (UPPER)


-- 40) Longitud del nombre del producto (CHAR_LENGTH)



-- F) INSERT / UPDATE / DELETE (PRUEBAS)
-- OJO: Estas sentencias CAMBIAN datos!!!!

-- 41) Insertar un cliente nuevo con todos los atributos


-- 42) Subir stock a 25 del producto 103


-- 43) Rebajar un 10% los productos de precio > 100


-- 44) Poner stock a 0 a productos sin ventas (NOT IN)


-- 45) Borrar pedidos cancelados


-- 46) Borrar líneas de un pedido concreto


-- 47) Borrar clientes sin pedidos (siempre que no estén referenciados)



-- G) ALTER TABLE (estructura) 
-- OJO: Esto MODIFICA la estructura de las tablas!!!!

-- 48) Añadir columna teléfono a clientes


-- 49) Cambiar longitud del nombre en productos


-- 50) Renombrar columna total -> total_eur 






