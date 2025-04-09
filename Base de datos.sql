-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS tienda_ropa;
USE tienda_ropa;

-- Tabla de usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    ciudad VARCHAR(50),
    codigo_postal VARCHAR(10),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_login DATETIME,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de categorías de productos
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    imagen VARCHAR(255)
);

-- Tabla de productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    id_categoria INT,
    imagen_principal VARCHAR(255),
    stock INT DEFAULT 0,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    destacado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- Tabla de tallas disponibles por producto
CREATE TABLE producto_tallas (
    id_producto_talla INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    talla VARCHAR(10) NOT NULL,
    stock INT DEFAULT 0,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    UNIQUE KEY (id_producto, talla)
);

-- Tabla de imágenes adicionales de productos
CREATE TABLE producto_imagenes (
    id_imagen INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    imagen_url VARCHAR(255) NOT NULL,
    orden INT DEFAULT 0,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Tabla de pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('pendiente', 'procesando', 'enviado', 'entregado', 'cancelado') DEFAULT 'pendiente',
    total DECIMAL(10, 2) NOT NULL,
    direccion_envio TEXT NOT NULL,
    ciudad_envio VARCHAR(50) NOT NULL,
    codigo_postal_envio VARCHAR(10) NOT NULL,
    metodo_pago ENUM('tarjeta', 'paypal', 'transferencia') NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla de detalles del pedido
CREATE TABLE pedido_detalles (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    talla VARCHAR(10) NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Tabla de facturas
CREATE TABLE facturas (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    numero_factura VARCHAR(20) NOT NULL UNIQUE,
    fecha_emision DATETIME DEFAULT CURRENT_TIMESTAMP,
    subtotal DECIMAL(10, 2) NOT NULL,
    iva DECIMAL(10, 2) NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    datos_facturacion TEXT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

-- Tabla de carritos de compra
CREATE TABLE carritos (
    id_carrito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla de items del carrito
CREATE TABLE carrito_items (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_carrito INT NOT NULL,
    id_producto INT NOT NULL,
    talla VARCHAR(10) NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    fecha_agregado DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_carrito) REFERENCES carritos(id_carrito),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    UNIQUE KEY (id_carrito, id_producto, talla)
);

-- Insertar datos iniciales (ejemplo)
INSERT INTO categorias (nombre, descripcion) VALUES 
('Camisetas', 'Camisetas para hombre y mujer'),
('Pantalones', 'Pantalones de diferentes estilos'),
('Vestidos', 'Vestidos elegantes y casuales');

INSERT INTO productos (nombre, descripcion, precio, id_categoria) VALUES 
('Camiseta básica blanca', 'Camiseta de algodón 100% básica color blanco', 19.99, 1),
('Jeans slim fit', 'Pantalón jeans ajustado color azul', 49.99, 2),
('Vestido floral', 'Vestido veraniego con estampado floral', 39.99, 3);

INSERT INTO producto_tallas (id_producto, talla, stock) VALUES 
(1, 'S', 50), (1, 'M', 45), (1, 'L', 40), (1, 'XL', 30),
(2, '28', 25), (2, '30', 30), (2, '32', 35), (2, '34', 20),
(3, 'XS', 15), (3, 'S', 20), (3, 'M', 25), (3, 'L', 15);