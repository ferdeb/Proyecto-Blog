-- Asumiendo que ya has creado la base de datos y las tablas, este script inserta datos de ejemplo.

-- 1. Insertar tipos de usuario
INSERT INTO tipousuario (tipu_rol, tipu_descripcion) VALUES
  ('Admin', 'Administrador del sistema'),
  ('Editor', 'Editor de contenido'),
  ('Usuario', 'Usuario registrado');

-- 2. Insertar imágenes
INSERT INTO imagen (img_url, img_descripcion) VALUES
  ('https://example.com/images/1.jpg', 'Imagen de portada del blog'),
  ('https://example.com/images/2.jpg', 'Foto de perfil por defecto'),
  ('https://example.com/images/3.jpg', 'Banner principal'),
  ('https://example.com/images/4.jpg', 'Icono de categoría tecnología'),
  ('https://example.com/images/5.jpg', 'Icono de categoría deportes');

-- 3. Insertar usuarios
INSERT INTO usuario (usu_username, usu_password, usu_nombre, usu_paterno, usu_materno, usu_mail, usu_biografia, usu_estado, usu_foto_perfil, tipo_usuario_id)
VALUES
  ('admin', 'adminpass', 'Carlos', 'Gonzalez', 'Martinez', 'admin@example.com', 'Administrador del sistema', 'Activo', 2, 1),
  ('editor', 'editorpass', 'Laura', 'Rodriguez', 'Lopez', 'editor@example.com', 'Editora de contenido', 'Activo', 3, 2),
  ('user1', 'user1pass', 'Pedro', 'Sanchez', 'Ramirez', 'pedro@example.com', 'Usuario regular', 'Activo', 1, 3);

-- 4. Insertar contenidos
INSERT INTO contenido (cont_titulo, cont_resumen, cont_texto, cont_estado, cont_visitas, usuario_id)
VALUES
  ('Bienvenidos al blog', 'Resumen del post de bienvenida', 'Contenido completo del post de bienvenida. Lorem ipsum dolor sit amet...', 'Publicado', 150, 1),
  ('Tecnología en 2025', 'Resumen de avances tecnológicos', 'Análisis de las últimas tendencias tecnológicas...', 'Publicado', 230, 2),
  ('Deportes en vivo', 'Resumen de eventos deportivos', 'Cobertura en tiempo real de eventos deportivos...', 'Publicado', 120, 3);

-- 5. Relacionar contenido con imágenes (tabla intermedia contenido_imagen)
INSERT INTO contenido_imagen (contenido_id, imagen_id) VALUES
  (1, 1),
  (1, 2),
  (2, 3),
  (2, 4),
  (3, 5);

-- 6. Insertar calificaciones
INSERT INTO calificacion (contenido_id, usuario_id, calificacioncol) VALUES
  (1, 2, 5),
  (1, 3, 4),
  (2, 1, 3),
  (2, 3, 5),
  (3, 1, 4),
  (3, 2, 3);

-- 7. Insertar categorías
INSERT INTO categoria (cat_nombre, cat_descripcion, cat_icono) VALUES
  ('Tecnología', 'Artículos sobre tecnología', 4),
  ('Deportes', 'Actualidad y noticias deportivas', 5),
  ('Bienestar', 'Salud y estilo de vida', NULL);

-- 8. Insertar comentarios
-- Comentario principal en el contenido 1
INSERT INTO comentario (cmt_texto, cmt_ip_usuario, contenido_id, usuario_id) VALUES
  ('Excelente artículo, bienvenido al blog!', '192.168.1.1', 1, 2);

-- Respuesta al comentario anterior (se referencia al id 1)
INSERT INTO comentario (cmt_texto, cmt_responde_a, cmt_ip_usuario, contenido_id, usuario_id) VALUES
  ('Gracias por el comentario!', 1, '192.168.1.2', 1, 1);

-- Comentario en el contenido 2
INSERT INTO comentario (cmt_texto, cmt_ip_usuario, contenido_id, usuario_id) VALUES
  ('Muy interesante análisis sobre tecnología.', '192.168.1.3', 2, 3);

-- Comentario en el contenido 3
INSERT INTO comentario (cmt_texto, cmt_ip_usuario, contenido_id, usuario_id) VALUES
  ('Esperando más cobertura deportiva en vivo.', '192.168.1.4', 3, 1);

-- 9. Relacionar contenido con categorías (tabla intermedia contenido_categoria)
INSERT INTO contenido_categoria (contenido_id, categoria_id) VALUES
  (1, 3),  -- Contenido 1 asignado a 'Bienestar'
  (2, 1),  -- Contenido 2 asignado a 'Tecnología'
  (3, 2);  -- Contenido 3 asignado a 'Deportes'

-- 10. Insertar etiquetas
INSERT INTO etiqueta (etiq_nombre) VALUES
  ('Blog'),
  ('Tech'),
  ('Sports'),
  ('News'),
  ('Lifestyle');

-- 11. Relacionar contenido con etiquetas (tabla intermedia contenido_etiqueta)
INSERT INTO contenido_etiqueta (contenido_id, etiqueta_id) VALUES
  (1, 1),  -- 'Blog'
  (1, 4),  -- 'News'
  (2, 2),  -- 'Tech'
  (2, 4),  -- 'News'
  (3, 3),  -- 'Sports'
  (3, 5);  -- 'Lifestyle'
