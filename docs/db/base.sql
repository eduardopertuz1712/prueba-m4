-- Creación de la base de datos
CREATE DATABASE sistema_pagos;
USE sistema_pagos;

-- Tabla de Clientes con validación de email
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    numero_identificacion VARCHAR(20) NOT NULL UNIQUE,
    nombre_cliente VARCHAR(100) NOT NULL,
    direccion TEXT NOT NULL,
    telefono VARCHAR(30) NOT NULL,
    email VARCHAR(100) NOT NULL,
    CONSTRAINT chk_email_format CHECK (email LIKE '%_@__%.__%' AND email NOT LIKE '% %')
);
