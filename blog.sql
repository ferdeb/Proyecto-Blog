CREATE DATABASE blog;
USE blog;

-- Tabla Usuarios
-- VARCHAR de 50 para soportar apellidos largos, segun ChatGPT
CREATE TABLE usuario (
    usu_id INT AUTO_INCREMENT PRIMARY KEY,
    usu_nombre VARCHAR(50) NOT NULL,
    usu_paterno VARCHAR(50) NOT NULL,         
    usu_materno VARCHAR(50) NOT NULL,
    usu_mail VARCHAR(50) UNIQUE NOT NULL,
    tipo_usuario_id INT,
    FOREIGN KEY (tipo_usuario_id) REFERENCES TiposUsuario(id)
);

-- Tabla TiposUsuario
CREATE TABLE tipoUsuario (
    --tipou_id?
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(30) NOT NULL
);

-- Tabla Categorias
CREATE TABLE categoria (
    cat_id INT AUTO_INCREMENT PRIMARY KEY,
    cat_nombre VARCHAR(30) NOT NULL
);

-- Tabla Contenido
CREATE TABLE contenido (
    cont_id INT AUTO_INCREMENT PRIMARY KEY,
    cont_titulo VARCHAR(100) NOT NULL,
    cont_texto TEXT NOT NULL,
    usuario_id INT,
    categoria_id INT,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (categoria_id) REFERENCES Categorias(id)
);


-- Tabla Imagenes
CREATE TABLE imagen (
    img_id INT AUTO_INCREMENT PRIMARY KEY,
    img_url VARCHAR(100) NOT NULL,
    contenido_id INT,
    FOREIGN KEY (contenido_id) REFERENCES Contenido(id)
);

-- Tabla Comentarios
-- TIMESTAMP es mejor, guarda los datos en UTC y los convierte en tiempo real
CREATE TABLE comentario (
    cmt_id INT AUTO_INCREMENT PRIMARY KEY,
    cmt_texto TEXT NOT NULL,
    cmt_fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    contenido_id INT,
    usuario_id INT,
    FOREIGN KEY (contenido_id) REFERENCES Contenido(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

-- Tabla Calificaciones
CREATE TABLE calificacion (
    cal_id INT AUTO_INCREMENT PRIMARY KEY,
    calificacion INT,
    usuario_id INT,
    FOREIGN KEY (contenido_id) REFERENCES Contenido(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

-- Tabla Notificaciones
CREATE TABLE notificacion (
    noti_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    mensaje TEXT NOT NULL,
    leida BOOLEAN DEFAULT FALSE,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

-- Tabla Etiquetas
CREATE TABLE etiqueta (
    etiq_id INT AUTO_INCREMENT PRIMARY KEY,
    etiq_nombre VARCHAR(50) NOT NULL
);

-- Relación muchos a muchos entre Contenido y Etiquetas
CREATE TABLE contenido_etiqueta (
    contenido_id INT,
    etiqueta_id INT,
    PRIMARY KEY (contenido_id, etiqueta_id),
    FOREIGN KEY (contenido_id) REFERENCES Contenido(id),
    FOREIGN KEY (etiqueta_id) REFERENCES Etiquetas(id)
);

-- Relación muchos a muchos entre Contenido y Categorias
CREATE TABLE contenido_categoria (
    contenido_id INT,
    categoria_id INT,
    PRIMARY KEY (contenido_id, categoria_id),
    FOREIGN KEY (contenido_id) REFERENCES Contenido(id),
    FOREIGN KEY (categoria_id) REFERENCES Categorias(id)
);

-- Relación muchos a muchos entre Imagenes y Categorias
CREATE TABLE imagen_categoria (
    imagen_id INT,
    categoria_id INT,
    PRIMARY KEY (imagen_id, categoria_id),
    FOREIGN KEY (imagen_id) REFERENCES Imagenes(id),
    FOREIGN KEY (categoria_id) REFERENCES Categorias(id)
);

-- Relación muchos a muchos entre Notificaciones y Usuarios
CREATE TABLE Notificaciones_Usuarios (
    notificacion_id INT,
    usuario_id INT,
    PRIMARY KEY (notificacion_id, usuario_id),
    FOREIGN KEY (notificacion_id) REFERENCES Notificaciones(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);


-- SHOW TABLES;


-- SHOW DATABASES;


-- USE Blog;