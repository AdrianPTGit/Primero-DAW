
/*version: 0.8 09-03-2024 12:08 

FINAL*/
DROP DATABASE IF EXISTS peluqueria_canina;
CREATE DATABASE peluqueria_canina charset utf8mb4;
USE peluqueria_canina;

CREATE TABLE dueno_mascota (
    id_dueno INT AUTO_INCREMENT PRIMARY KEY,
    dni_dueno VARCHAR(9) NOT NULL UNIQUE,
    nombre_dueno VARCHAR(50) NOT NULL,
    apellido_dueno VARCHAR(100),
    calle VARCHAR(150),
    numero INT,
    codigo_postal INT,
    ciudad VARCHAR(50),
    telefono INT NOT NULL
);

CREATE TABLE perro_cliente (
    id_perro INT AUTO_INCREMENT PRIMARY KEY,
    nombre_perro VARCHAR(50) NOT NULL,
    raza VARCHAR(150) NOT NULL,
    tamano VARCHAR(25),
    id_cita INT,
    FOREIGN KEY (id_cita)
        REFERENCES cita_peluqueria (id_cita)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE perro_dueno (
    sexo VARCHAR(7),
    id_dueno INT,
    id_perro INT,
    PRIMARY KEY (id_dueno , id_perro),
    FOREIGN KEY (id_dueno)
        REFERENCES dueno_mascota (id_dueno),
    FOREIGN KEY (id_perro)
        REFERENCES perro_cliente (id_perro)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE cita_peluqueria (
    id_cita INT AUTO_INCREMENT PRIMARY KEY,
    fecha_cita DATE NOT NULL,
    hora_cita TIME NOT NULL
);
CREATE TABLE trabajo_realizar (
    id_trabajo INT AUTO_INCREMENT,
    cortar_unas VARCHAR(2) NOT NULL,
    cortar_pelo VARCHAR(2) NOT NULL,
    lavar VARCHAR(2) NOT NULL,
    peinar VARCHAR(2) NOT NULL,
    productos_utilizados TEXT,
    precio DECIMAL(7 , 2 ) NOT NULL,
    id_cita INT,
    id_empleado INT,
    PRIMARY KEY (id_trabajo , id_cita),
    FOREIGN KEY (id_cita)
        REFERENCES cita_peluqueria (id_cita),
    FOREIGN KEY (id_empleado)
        REFERENCES empleados (id_empleado)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE facturas (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    fecha_factura DATE NOT NULL,
    id_cita INT NOT NULL,
    FOREIGN KEY (id_cita)
        REFERENCES cita_peluqueria (id_cita)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empleado VARCHAR(50) NOT NULL,
    apellido1_empleado VARCHAR(25) NOT NULL,
    apellido2_empleado VARCHAR(25) NOT NULL,
    calle VARCHAR(150),
    numero INT,
    codigo_postal INT,
    ciudad VARCHAR(50),
    telefono_empleado INT UNIQUE NOT NULL,
    dni_empleado VARCHAR(9) UNIQUE NOT NULL,
    email_empleado VARCHAR(250) UNIQUE,
    puesto VARCHAR(200) NOT NULL
);

CREATE TABLE tienda (
    id_tienda INT AUTO_INCREMENT PRIMARY KEY,
    calle VARCHAR(150) NOT NULL,
    numero INT NOT NULL,
    codigo_postal INT NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    telefono_tienda INT UNIQUE
);


CREATE TABLE vender_producto (
    descripcion_producto TEXT,
    id_tienda INT,
    id_producto INT,
    PRIMARY KEY (id_tienda , id_producto),
    FOREIGN KEY (id_tienda)
        REFERENCES tienda (id_tienda),
    FOREIGN KEY (id_producto)
        REFERENCES productos (id_producto)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(250) NOT NULL,
    precio_producto DECIMAL(7 , 2 ) NOT NULL
);
CREATE TABLE proveedor_tienda (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    cif_proveedor VARCHAR(9) UNIQUE NOT NULL,
    nombre_proveedor VARCHAR(250),
    telefono_proveedor INT(9)
);
CREATE TABLE proveedor_productos (
    id_producto INT,
    id_proveedor INT,
    PRIMARY KEY (id_producto , id_proveedor),
    FOREIGN KEY (id_producto)
        REFERENCES productos (id_producto),
    FOREIGN KEY (id_proveedor)
        REFERENCES proveedor_tienda (id_proveedor)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE empleados_tienda (
    id_empleado INT,
    id_tienda INT,
    PRIMARY KEY (id_empleado , id_tienda),
    FOREIGN KEY (id_empleado)
        REFERENCES empleados (id_empleado),
    FOREIGN KEY (id_tienda)
        REFERENCES tienda (id_tienda)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ··················································································
-- :    _       _      _               ____                                _        :
-- :   / \   __| |_ __(_) __ _ _ __   |  _ \ ___  _ __ ___   __ _ _ __ ___| |_ __ _ :
-- :  / _ \ / _` | '__| |/ _` | '_ \  | |_) / _ \| '_ ` _ \ / _` | '__/ _ \ __/ _` |:
-- : / ___ \ (_| | |  | | (_| | | | | |  __/ (_) | | | | | | (_| | | |  __/ || (_| |:
-- :/_/   \_\__,_|_|  |_|\__,_|_| |_| |_|   \___/|_| |_| |_|\__,_|_|  \___|\__\__,_|:
-- ··················································································