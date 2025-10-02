-- Archivo de Manipulación de Datos (DML)
-- Carga datos de ejemplo en la base de datos de la biblioteca.

-- Autores
INSERT INTO autores (nombre) VALUES
('Gabriel García Márquez'),
('J.K. Rowling'),
('George Orwell'),
('Isaac Asimov'),
('J.R.R. Tolkien');

-- Géneros
INSERT INTO genero (descripcion) VALUES
('Realismo Mágico'),
('Fantasía'),
('Ciencia Ficción'),
('Distopía');

-- Libros
INSERT INTO libros (isbn, titulo, id_genero, anio_publicacion, edicion) VALUES
('9788437604947', 'Cien años de soledad', 1, 1967, 1),
('9788478884452', 'Harry Potter y la piedra filosofal', 2, 1997, 1),
('9780451524935', '1984', 4, 1949, 1),
('9780553803709', 'Yo, Robot', 3, 1950, 1),
('9788445071762', 'El Señor de los Anillos: La Comunidad del Anillo', 2, 1954, 3);

-- Relación Libros-Autores
INSERT INTO libros_autores (isbn, id_autor) VALUES
('9788437604947', 1), -- Cien años de soledad -> Gabriel García Márquez
('9788478884452', 2), -- Harry Potter -> J.K. Rowling
('9780451524935', 3), -- 1984 -> George Orwell
('9780553803709', 4), -- Yo, Robot -> Isaac Asimov
('9788445071762', 5); -- El Señor de los Anillos -> J.R.R. Tolkien

-- Estanterías
INSERT INTO estanterias (nombre, capacidad) VALUES
('Ficción Clásica A1', 50),
('Fantasía y Sci-Fi B2', 75);

-- Ejemplares (copias de los libros)
INSERT INTO ejemplares (isbn, id_estanteria) VALUES
('9788437604947', 1), ('9788437604947', 1), -- 2 copias de Cien años de soledad
('9788478884452', 2), ('9788478884452', 2), ('9788478884452', 2), -- 3 copias de Harry Potter
('9780451524935', 1), -- 1 copia de 1984
('9780553803709', 2); -- 1 copia de Yo, Robot

-- Usuarios
INSERT INTO usuarios (nombre, apellido, email, telefono) VALUES
('Juan', 'Perez', 'juan.perez@email.com', '1122334455'),
('Ana', 'Gomez', 'ana.gomez@email.com', '5544332211');