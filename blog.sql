CREATE DATABASE `blog`;
USE `blog`;

-- Tabla de tipos de usuario
CREATE TABLE `tipousuario` (
  `tipu_id` INT NOT NULL AUTO_INCREMENT,
  `tipu_rol` VARCHAR(30) NOT NULL,
  `tipu_descripcion` TEXT NULL,
  PRIMARY KEY (`tipu_id`)
);
-- Tabla de usuarios
CREATE TABLE `usuario` (
  `usu_id` INT NOT NULL AUTO_INCREMENT,
  `usu_username` VARCHAR(30) NOT NULL UNIQUE,
  `usu_password` VARCHAR(20) NOT NULL,
  `usu_nombre` VARCHAR(50) NOT NULL,
  `usu_paterno` VARCHAR(50) NOT NULL,
  `usu_materno` VARCHAR(50) NOT NULL,
  `usu_mail` VARCHAR(50) NOT NULL UNIQUE,
  `usu_fecha_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `usu_biografia` TEXT NULL,
  `usu_estado` ENUM('Activo', 'Inactivo', 'Suspendido') NOT NULL DEFAULT 'Activo',
  `usu_foto_perfil` INT NULL,
  `tipo_usuario_id` INT NULL,
  PRIMARY KEY (`usu_id`),
  FOREIGN KEY (`tipo_usuario_id`) REFERENCES `tipousuario` (`tipu_id`),
  FOREIGN KEY (`usu_foto_perfil`) REFERENCES `imagen` (`img_id`)
);
-- Tabla de contenido
CREATE TABLE `contenido` (
  `cont_id` INT NOT NULL AUTO_INCREMENT,
  `cont_titulo` VARCHAR(100) NOT NULL,
  `cont_resumen` TEXT NULL,
  `cont_texto` TEXT NOT NULL,
  `cont_fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `cont_fecha_actualizacion` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `cont_estado` ENUM('Borrador', 'Publicado', 'Archivado') NOT NULL DEFAULT 'Borrador',
  `cont_visitas` INT DEFAULT 0,
  `usuario_id` INT NULL,
  PRIMARY KEY (`cont_id`),
  FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`usu_id`)
);

-- Tabla de calificación
CREATE TABLE `calificacion` (
  `cal_id` INT NOT NULL AUTO_INCREMENT,
  `contenido_id` INT NULL DEFAULT NULL,
  `usuario_id` INT NULL DEFAULT NULL,
  `calificacioncol` INT NOT NULL,
  PRIMARY KEY (`cal_id`),
  UNIQUE (`contenido_id`, `usuario_id`),
  FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`cont_id`),
  FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`usu_id`)
);

-- Tabla de categorías
CREATE TABLE `categoria` (
  `cat_id` INT NOT NULL AUTO_INCREMENT,
  `cat_nombre` VARCHAR(30) NOT NULL,
  `cat_descripcion` TEXT NULL,
  `cat_icono` INT NULL,
  PRIMARY KEY (`cat_id`),
  FOREIGN KEY (`cat_icono`) REFERENCES `imagen` (`img_id`)
);

-- Tabla de comentarios
-- Tabla de comentarios
CREATE TABLE `comentario` (
  `cmt_id` INT NOT NULL AUTO_INCREMENT,
  `cmt_texto` TEXT NOT NULL,
  `cmt_fecha` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `cmt_responde_a` INT NULL,
  `cmt_ip_usuario` VARCHAR(45) NULL,
  `contenido_id` INT NULL,
  `usuario_id` INT NULL,
  PRIMARY KEY (`cmt_id`),
  FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`cont_id`),
  FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`usu_id`),
  FOREIGN KEY (`cmt_responde_a`) REFERENCES `comentario` (`cmt_id`)
);

-- Tabla intermedia de contenido y categoría
CREATE TABLE `contenido_categoria` (
  `contenido_id` INT NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`contenido_id`, `categoria_id`),
  FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`cont_id`),
  FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`cat_id`)
);

-- Tabla de etiquetas
CREATE TABLE `etiqueta` (
  `etiq_id` INT NOT NULL AUTO_INCREMENT,
  `etiq_nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`etiq_id`)
);

-- Tabla intermedia de contenido y etiqueta
CREATE TABLE `contenido_etiqueta` (
  `contenido_id` INT NOT NULL,
  `etiqueta_id` INT NOT NULL,
  PRIMARY KEY (`contenido_id`, `etiqueta_id`),
  FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`cont_id`),
  FOREIGN KEY (`etiqueta_id`) REFERENCES `etiqueta` (`etiq_id`)
);

-- Tabla de imágenes
CREATE TABLE `imagen` (
  `img_id` INT NOT NULL AUTO_INCREMENT,
  `img_url` VARCHAR(255) NOT NULL,
  `img_descripcion` TEXT NULL,
  PRIMARY KEY (`img_id`)
);

-- Tabla intermedia de contenido e imágenes
CREATE TABLE `contenido_imagen` (
  `contenido_id` INT NOT NULL,
  `imagen_id` INT NOT NULL,
  PRIMARY KEY (`contenido_id`, `imagen_id`),
  FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`cont_id`),
  FOREIGN KEY (`imagen_id`) REFERENCES `imagen` (`img_id`)
);
