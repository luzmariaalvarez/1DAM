
-- Base de datos para ejercicios GROUP BY y HAVING

CREATE DATABASE gestion_incidencias;


-- Tabla usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    rol VARCHAR(20)
);

INSERT INTO usuarios (nombre, rol) VALUES
('Ana', 'admin'),
('Luis', 'admin'),
('Carlos', 'tecnico'),
('Marta', 'tecnico'),
('Sonia', 'usuario'),
('Pedro', 'usuario'),
('Lucia', 'usuario');

-- Tabla incidencias
CREATE TABLE incidencias (
    id_incidencia INT AUTO_INCREMENT PRIMARY KEY,
    estado VARCHAR(20),
    prioridad VARCHAR(20)
);

INSERT INTO incidencias (estado, prioridad) VALUES
('abierta', 'alta'),
('abierta', 'alta'),
('abierta', 'alta'),
('abierta', 'alta'),
('abierta', 'alta'),
('abierta', 'alta'),
('abierta', 'media'),
('abierta', 'media'),
('abierta', 'media'),
('abierta', 'baja'),
('en_proceso', 'alta'),
('en_proceso', 'media'),
('en_proceso', 'media'),
('resuelta', 'alta'),
('resuelta', 'media'),
('resuelta', 'baja'),
('resuelta', 'baja'),
('resuelta', 'baja'),
('resuelta', 'baja'),
('resuelta', 'baja'),
('resuelta', 'baja');

-- Tabla reparaciones
CREATE TABLE reparaciones (
    id_reparacion INT AUTO_INCREMENT PRIMARY KEY,
    vehiculo_id INT,
    precio DECIMAL(8,2)
);

INSERT INTO reparaciones (vehiculo_id, precio) VALUES
(1, 120.50),
(1, 80.00),
(1, 200.00),
(2, 300.00),
(2, 150.00),
(3, 90.00),
(3, 110.00),
(3, 60.00);

-- Usuarios por rol


-- Incidencias por prioridad




-- Estados con más de 10 incidencias




-- Precio medio de reparaciones por vehículo




-- Incidencias por estado excluyendo resueltas



-- Prioridades con más de 5 incidencias abiertas



-- Roles que tengan más de 1 usuario



-- Número total de usuarios (sin agrupar)


-- Número total de incidencias



-- Incidencias por estado y prioridad




-- Estados que tengan incidencias de prioridad alta




-- Estados con más de 2 incidencias no resueltas




-- Prioridad con más incidencias en estado abierto




-- Número de incidencias por estado (ordenadas de mayor a menor)



-- Precio máximo de reparación por vehículo




-- Vehículos con un precio medio de reparación superior a 100 €



