-- SQL completo para MySQL 8+
-- Sesión 17y 18: DCL (usuarios, roles y permisos)
-- Base de datos de práctica: clinica_seguridad
-- Incluye: esquema, datos, usuarios, roles, privilegios y pruebas



-- CREACIÓN DE LA BASE DE DATOS Y TABLAS

CREATE DATABASE clinica_seguridad;


CREATE TABLE pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    fecha_nacimiento DATE,
    dni VARCHAR(15) UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(80),
    direccion VARCHAR(120)
);

CREATE TABLE medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    especialidad VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(80)
);

CREATE TABLE recepcionistas (
    id_recepcionista INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    turno VARCHAR(20)
);

CREATE TABLE citas (
    id_cita INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    fecha_cita DATETIME NOT NULL,
    motivo VARCHAR(150),
    estado ENUM('Programada','Confirmada','Cancelada','Realizada') DEFAULT 'Programada',
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

CREATE TABLE diagnosticos (
    id_diagnostico INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    fecha_diagnostico DATETIME NOT NULL,
    descripcion TEXT NOT NULL,
    tratamiento TEXT,
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

CREATE TABLE facturacion (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    fecha_factura DATE NOT NULL,
    concepto VARCHAR(120) NOT NULL,
    importe DECIMAL(10,2) NOT NULL,
    pagada BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente)
);

CREATE TABLE auditoria_accesos (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    usuario_bd VARCHAR(100) NOT NULL,
    accion_realizada VARCHAR(150) NOT NULL,
    fecha_evento DATETIME NOT NULL,
    detalle TEXT
);


-- DATOS DE EJEMPLO

INSERT INTO pacientes (nombre, apellidos, fecha_nacimiento, dni, telefono, email, direccion) VALUES
('Laura', 'Martinez Gomez', '1990-05-10', '11111111A', '600111222', 'laura@email.com', 'Calle Sol 12'),
('Carlos', 'Ruiz Perez', '1985-09-20', '22222222B', '600333444', 'carlos@email.com', 'Avenida Norte 8'),
('Ana', 'Lopez Diaz', '2000-01-15', '33333333C', '600555666', 'ana@email.com', 'Plaza Mayor 3'),
('Miguel', 'Santos Gil', '1978-12-01', '44444444D', '600777888', 'miguel@email.com', 'Calle Luna 20');

INSERT INTO medicos (nombre, apellidos, especialidad, telefono, email) VALUES
('Javier', 'Sanchez Romero', 'Cardiologia', '611111111', 'jsanchez@clinica.com'),
('Elena', 'Ruiz Torres', 'Dermatologia', '622222222', 'eruiz@clinica.com'),
('Pablo', 'Navarro Cruz', 'Medicina General', '633333333', 'pnavarro@clinica.com');

INSERT INTO recepcionistas (nombre, apellidos, turno) VALUES
('Marta', 'Lozano Perez', 'Manana'),
('Sergio', 'Diaz Martin', 'Tarde');

INSERT INTO citas (id_paciente, id_medico, fecha_cita, motivo, estado) VALUES
(1, 1, '2025-03-10 09:00:00', 'Revision cardiologica', 'Confirmada'),
(2, 2, '2025-03-10 10:30:00', 'Consulta dermatologica', 'Programada'),
(3, 3, '2025-03-11 12:00:00', 'Dolor de garganta', 'Programada'),
(4, 1, '2025-03-12 08:45:00', 'Control tension', 'Realizada');

INSERT INTO diagnosticos (id_paciente, id_medico, fecha_diagnostico, descripcion, tratamiento) VALUES
(4, 1, '2025-03-12 09:15:00', 'Hipertension arterial leve', 'Dieta baja en sal y control en 30 dias'),
(2, 2, '2025-03-10 11:00:00', 'Dermatitis atopica', 'Crema topica durante 14 dias');

INSERT INTO facturacion (id_paciente, fecha_factura, concepto, importe, pagada) VALUES
(1, '2025-03-10', 'Consulta cardiologia', 95.00, TRUE),
(2, '2025-03-10', 'Consulta dermatologia', 80.00, FALSE),
(3, '2025-03-11', 'Consulta medicina general', 60.00, TRUE),
(4, '2025-03-12', 'Revision cardiologia', 70.00, FALSE);

INSERT INTO auditoria_accesos (usuario_bd, accion_realizada, fecha_evento, detalle) VALUES
('admin_clinica', 'CREACION INICIAL', NOW(), 'Carga inicial de estructura y datos'),
('sistema', 'REVISION', NOW(), 'Base lista para prácticas de DCL');


-- CONSULTAS BÁSICAS DE COMPROBACIÓN DE DATOS

SELECT * FROM pacientes;
SELECT * FROM medicos;
SELECT * FROM citas;
SELECT * FROM diagnosticos;
SELECT * FROM facturacion;


-- CREACIÓN DE USUARIOS
-- Nota: ejecutar con una cuenta con privilegios de administración, vosotros sois root

CREATE USER 'admin_clinica'@'localhost' IDENTIFIED BY 'Admin123!';
CREATE USER 'medico1'@'%' IDENTIFIED BY 'Medico123!';
CREATE USER 'medico2'@'%' IDENTIFIED BY 'Medico456!';
CREATE USER 'recepcion1'@'%' IDENTIFIED BY 'Recep123!';
CREATE USER 'secretaria2'@'%' IDENTIFIED BY 'Secre123!';
CREATE USER 'enfermeria1'@'%' IDENTIFIED BY 'Enfer123!';
CREATE USER 'auditor1'@'%' IDENTIFIED BY 'Audit123!';


-- CREACIÓN DE ROLES

CREATE ROLE 'rol_admin';
CREATE ROLE 'rol_medico';
CREATE ROLE 'rol_recepcion';
CREATE ROLE 'rol_enfermeria';
CREATE ROLE 'rol_auditor';


-- ASIGNACIÓN DE PERMISOS A LOS ROLES
-- Rol administrador: acceso total
GRANT ALL PRIVILEGES ON clinica_seguridad.* TO 'rol_admin';

-- Rol médico
GRANT SELECT ON clinica_seguridad.pacientes TO 'rol_medico';
GRANT SELECT ON clinica_seguridad.citas TO 'rol_medico';
GRANT SELECT ON clinica_seguridad.medicos TO 'rol_medico';
GRANT SELECT, INSERT ON clinica_seguridad.diagnosticos TO 'rol_medico';

-- Rol recepción
GRANT SELECT ON clinica_seguridad.pacientes TO 'rol_recepcion';
GRANT SELECT, INSERT, UPDATE ON clinica_seguridad.citas TO 'rol_recepcion';
GRANT SELECT ON clinica_seguridad.facturacion TO 'rol_recepcion';

-- Rol enfermería
GRANT SELECT ON clinica_seguridad.pacientes TO 'rol_enfermeria';
GRANT SELECT, UPDATE ON clinica_seguridad.citas TO 'rol_enfermeria';
GRANT SELECT ON clinica_seguridad.diagnosticos TO 'rol_enfermeria';

-- Rol auditor: solo lectura global
GRANT SELECT ON clinica_seguridad.* TO 'rol_auditor';


-- ASIGNAR ROLES A USUARIOS

GRANT 'rol_admin' TO 'admin_clinica'@'localhost';
GRANT 'rol_medico' TO 'medico1'@'%';
GRANT 'rol_medico' TO 'medico2'@'%';
GRANT 'rol_recepcion' TO 'recepcion1'@'%';
GRANT 'rol_recepcion' TO 'secretaria2'@'%';
GRANT 'rol_enfermeria' TO 'enfermeria1'@'%';
GRANT 'rol_auditor' TO 'auditor1'@'%';



-- COMPROBACIÓN DE PRIVILEGIOS

SHOW GRANTS FOR 'rol_admin';
SHOW GRANTS FOR 'rol_medico';
SHOW GRANTS FOR 'rol_recepcion';
SHOW GRANTS FOR 'rol_enfermeria';
SHOW GRANTS FOR 'rol_auditor';

SHOW GRANTS FOR 'admin_clinica'@'localhost';
SHOW GRANTS FOR 'medico1'@'%';
SHOW GRANTS FOR 'recepcion1'@'%';
SHOW GRANTS FOR 'enfermeria1'@'%';
SHOW GRANTS FOR 'auditor1'@'%';


-- EJERCICIOS RESUELTOS

-- Ejercicio 1:
-- Crear un usuario de apoyo administrativo y darle permisos directos.
DROP USER IF EXISTS 'apoyo_admin'@'%';
CREATE USER 'apoyo_admin'@'%' IDENTIFIED BY 'Apoyo123!';

-- Para comprobar
SELECT User, Host
FROM mysql.user
WHERE User = 'apoyo_admin';

--User: apoyo_admin → el usuario existe
--Host: % → puede conectarse desde cualquier máquina


GRANT SELECT ON clinica_seguridad.pacientes TO 'apoyo_admin'@'%';
GRANT SELECT, INSERT ON clinica_seguridad.citas TO 'apoyo_admin'@'%';
SHOW GRANTS FOR 'apoyo_admin'@'%';

-- Ejercicio 2:
-- Quitar UPDATE al rol de recepción.
REVOKE UPDATE ON clinica_seguridad.citas FROM 'rol_recepcion';
SHOW GRANTS FOR 'rol_recepcion';

-- Para comprobar
SELECT User, Host
FROM mysql.user
WHERE User = 'rol_recepcion';

-- host vacío en roles
-- Esto ocurre porque:
-- los usuarios necesitan un Host (desde dónde se conectan)
-- los roles no necesitan host, porque no se conectan

-- Volver a restaurarlo para continuar con la práctica.
GRANT UPDATE ON clinica_seguridad.citas TO 'rol_recepcion';

-- Ejercicio 3:
-- Quitar el rol médico al usuario medico2.
REVOKE 'rol_medico' FROM 'medico2'@'%';
SHOW GRANTS FOR 'medico2'@'%';

-- Volver a asignarlo.
GRANT 'rol_medico' TO 'medico2'@'%';
SET DEFAULT ROLE 'rol_medico' TO 'medico2'@'%';

-- Resumiendo permisos
-- USAGE	usuario sin permisos
-- GRANT rol_x	el usuario tiene ese rol
-- GRANT SELECT ...	permiso directo


-- EJERCICIOS PROPUESTOS

-- 1) Crear usuario 'enfermero2'@'%' con contraseña 'Enfer456!'.
-- 2) Crear un rol llamado 'rol_secretaria_consulta'.
-- 3) Dar a ese rol SELECT sobre pacientes y citas.
-- 4) Asignar ese rol a 'secretaria2'@'%'.
-- 5) Quitar a 'auditor1' el acceso global y dejarle solo SELECT sobre facturacion.
-- 6) Revocar a 'rol_medico' el permiso INSERT sobre diagnosticos.
-- 7) Comprobar con SHOW GRANTS los cambios realizados.


-- CONSULTAS DE PRUEBA PARA COMPROBAR PERMISOS

-- Ejecuta las siguientes consultas iniciando sesión con cada usuario.

-- ===== COMO medico1 =====
-- Debe funcionar:
-- SELECT * FROM clinica_seguridad.pacientes;
-- SELECT * FROM clinica_seguridad.citas;
-- INSERT INTO clinica_seguridad.diagnosticos
-- (id_paciente, id_medico, fecha_diagnostico, descripcion, tratamiento)
-- VALUES (1, 1, NOW(), 'Arritmia leve', 'Control en 15 dias');

-- Debe fallar:
-- DELETE FROM clinica_seguridad.diagnosticos WHERE id_diagnostico = 1;
-- UPDATE clinica_seguridad.facturacion SET pagada = TRUE WHERE id_factura = 2;

-- ===== COMO recepcion1 =====
-- Debe funcionar:
-- SELECT * FROM clinica_seguridad.pacientes;
-- SELECT * FROM clinica_seguridad.citas;
-- INSERT INTO clinica_seguridad.citas
-- (id_paciente, id_medico, fecha_cita, motivo, estado)
-- VALUES (1, 2, '2025-03-20 10:00:00', 'Nueva revision', 'Programada');
-- UPDATE clinica_seguridad.citas SET estado = 'Confirmada' WHERE id_cita = 2;

-- Debe fallar:
-- INSERT INTO clinica_seguridad.diagnosticos
-- (id_paciente, id_medico, fecha_diagnostico, descripcion, tratamiento)
-- VALUES (2, 2, NOW(), 'Prueba no permitida', 'Ninguno');
-- DELETE FROM clinica_seguridad.pacientes WHERE id_paciente = 1;

-- ===== COMO enfermeria1 =====
-- Debe funcionar:
-- SELECT * FROM clinica_seguridad.diagnosticos;
-- UPDATE clinica_seguridad.citas SET estado = 'Realizada' WHERE id_cita = 3;

-- Debe fallar:
-- INSERT INTO clinica_seguridad.diagnosticos
-- (id_paciente, id_medico, fecha_diagnostico, descripcion, tratamiento)
-- VALUES (3, 3, NOW(), 'Intento no permitido', 'Reposo');

-- ===== COMO auditor1 =====
-- Debe funcionar:
-- SELECT * FROM clinica_seguridad.facturacion;
-- SELECT * FROM clinica_seguridad.diagnosticos;

-- Debe fallar:
-- UPDATE clinica_seguridad.facturacion SET pagada = TRUE WHERE id_factura = 4;
-- DELETE FROM clinica_seguridad.citas WHERE id_cita = 1;



-- CONSULTAS ÚTILES PARA CLASE

-- Ver citas con paciente y médico
SELECT c.id_cita,
       p.nombre AS paciente,
       m.nombre AS medico,
       c.fecha_cita,
       c.motivo,
       c.estado
FROM citas c
JOIN pacientes p ON c.id_paciente = p.id_paciente
JOIN medicos m ON c.id_medico = m.id_medico;

-- Ver diagnósticos con nombre del paciente y médico
SELECT d.id_diagnostico,
       p.nombre AS paciente,
       m.nombre AS medico,
       d.fecha_diagnostico,
       d.descripcion,
       d.tratamiento
FROM diagnosticos d
JOIN pacientes p ON d.id_paciente = p.id_paciente
JOIN medicos m ON d.id_medico = m.id_medico;

-- Ver facturas pendientes
SELECT *
FROM facturacion
WHERE pagada = FALSE;


-- BAJA DE USUARIO (CASO REAL)

-- Un médico deja la clínica.
-- Opción 1: quitar rol
-- REVOKE 'rol_medico' FROM 'medico1'@'%';

-- Opción 2: eliminar usuario
-- DROP USER 'medico1'@'%';

