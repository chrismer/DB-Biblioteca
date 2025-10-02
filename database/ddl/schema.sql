-- Archivo de Definición de Datos (DDL)
-- Define la estructura de la base de datos de la biblioteca.

-- Eliminar tablas si ya existen para permitir una recreación limpia del esquema.
DROP TABLE IF EXISTS prestamos;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS ejemplares;
DROP TABLE IF EXISTS estanterias;
DROP TABLE IF EXISTS libros_autores;
DROP TABLE IF EXISTS libros;
DROP TABLE IF EXISTS genero;
DROP TABLE IF EXISTS autores;

-- Tabla para almacenar información de los autores.
CREATE TABLE autores (
    id_autor INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(60) NOT NULL
);

-- Tabla para clasificar los libros por género.
CREATE TABLE genero (
    id_genero INTEGER PRIMARY KEY AUTOINCREMENT,
    descripcion VARCHAR(200) NOT NULL
);

-- Tabla que contiene la información principal de cada libro.
CREATE TABLE libros (
    isbn VARCHAR(13) PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    id_genero INTEGER NOT NULL,
    anio_publicacion INTEGER NOT NULL,
    edicion INTEGER NOT NULL,
    FOREIGN KEY (id_genero) REFERENCES genero(id_genero)
);

-- Tabla intermedia para manejar la relación muchos a muchos entre libros y autores.
CREATE TABLE libros_autores (
    isbn VARCHAR(13) NOT NULL,
    id_autor INTEGER NOT NULL,
    PRIMARY KEY (isbn, id_autor),
    FOREIGN KEY (isbn) REFERENCES libros(isbn),
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
);

-- Tabla para organizar físicamente los ejemplares.
CREATE TABLE estanterias (
    id_estanteria INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(50) NOT NULL,
    capacidad INTEGER NOT NULL
);

-- Tabla para cada copia física de un libro.
CREATE TABLE ejemplares (
    id_ejemplar INTEGER PRIMARY KEY AUTOINCREMENT,
    isbn VARCHAR(13) NOT NULL,
    -- 1 para disponible, 0 para no disponible/prestado.
    disponible INTEGER NOT NULL CHECK(disponible IN (0, 1)) DEFAULT 1,
    id_estanteria INTEGER NOT NULL,
    FOREIGN KEY (isbn) REFERENCES libros(isbn),
    FOREIGN KEY (id_estanteria) REFERENCES estanterias(id_estanteria)
);

-- Tabla para los usuarios registrados en la biblioteca.
CREATE TABLE usuarios (
    id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(60) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(15) NOT NULL UNIQUE
);

-- Tabla para registrar los préstamos de ejemplares a usuarios.
CREATE TABLE prestamos (
    id_prestamo INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER NOT NULL,
    id_ejemplar INTEGER NOT NULL,
    fecha_prestamo DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_devolucion DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_ejemplar) REFERENCES ejemplares(id_ejemplar)
);