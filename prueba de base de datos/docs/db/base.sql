-- Creación de la base de datos
CREATE DATABASE sistema_pagos;
USE sistema_pagos;

-- Tabla de Plataformas (usando ENUM)
CREATE TABLE plataformas (
    id_plataforma INT AUTO_INCREMENT PRIMARY KEY,
    nombre_plataforma ENUM('Nequi', 'Daviplata') NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Clientes con validación de email
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    numero_identificacion VARCHAR(20) NOT NULL UNIQUE,
    nombre_cliente VARCHAR(100) NOT NULL,
    direccion TEXT NOT NULL,
    telefono VARCHAR(30) NOT NULL,
    email VARCHAR(100) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_email_format CHECK (email LIKE '%_@__%.__%' AND email NOT LIKE '% %')
);

-- Tabla de Facturas
CREATE TABLE facturas (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    numero_factura VARCHAR(20) NOT NULL UNIQUE,
    periodo_facturacion VARCHAR(10) NOT NULL,
    monto_facturado DECIMAL(12, 2) NOT NULL,
    id_cliente INT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabla de Estados de Transacción
CREATE TABLE estados_transaccion (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    nombre_estado ENUM('Pendiente', 'Completada', 'Fallida') NOT NULL,
    descripcion VARCHAR(100)
);

-- Tabla de Tipos de Transacción
CREATE TABLE tipos_transaccion (
    id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tipo ENUM('Pago de Factura') NOT NULL,
    descripcion VARCHAR(100)
);

-- Tabla de Transacciones
CREATE TABLE transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    codigo_transaccion VARCHAR(20) NOT NULL UNIQUE,
    fecha_hora_transaccion DATETIME NOT NULL,
    monto_transaccion DECIMAL(12, 2) NOT NULL,
    monto_pagado DECIMAL(12, 2) NOT NULL,
    id_factura INT NOT NULL,
    id_plataforma INT NOT NULL,
    id_estado INT NOT NULL,
    id_tipo INT NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_factura) REFERENCES facturas(id_factura),
    FOREIGN KEY (id_plataforma) REFERENCES plataformas(id_plataforma),
    FOREIGN KEY (id_estado) REFERENCES estados_transaccion(id_estado),
    FOREIGN KEY (id_tipo) REFERENCES tipos_transaccion(id_tipo)
);

-- Creación de índices para mejorar el rendimiento
CREATE INDEX idx_cliente_identificacion ON clientes(numero_identificacion);
CREATE INDEX idx_factura_numero ON facturas(numero_factura);
CREATE INDEX idx_transaccion_codigo ON transacciones(codigo_transaccion);
CREATE INDEX idx_transaccion_fecha ON transacciones(fecha_hora_transaccion);
CREATE INDEX idx_transaccion_estado ON transacciones(id_estado);

-- Función para validación robusta de email (MySQL 5.7+)
DELIMITER //
CREATE FUNCTION fn_validate_email(email VARCHAR(100))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE pattern VARCHAR(255);
    SET pattern = '^[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9._-]@[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9]\\.[a-zA-Z]{2,63}$';
    
    IF email REGEXP pattern THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END //
DELIMITER ;

-- Trigger para validación antes de insertar
DELIMITER //
CREATE TRIGGER trg_check_email_before_insert
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    IF NOT fn_validate_email(NEW.email) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Formato de email inválido';
    END IF;
END //
DELIMITER ;

-- Trigger para validación antes de actualizar
DELIMITER //
CREATE TRIGGER trg_check_email_before_update
BEFORE UPDATE ON clientes
FOR EACH ROW
BEGIN
    IF NOT fn_validate_email(NEW.email) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Formato de email inválido';
    END IF;
END //
DELIMITER ;