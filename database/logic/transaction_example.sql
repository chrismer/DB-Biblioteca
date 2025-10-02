-- Iniciamos una transacción. 
-- Esto garantiza que todos los pasos (autor, género y libro) 
-- se ejecuten como una sola unidad: o se hacen todos, o ninguno.
BEGIN TRANSACTION;

-- Insertamos al autor "Isabel Allende" solo si no existe todavía.
-- Usamos WHERE NOT EXISTS para evitar duplicados en la tabla de autores.
INSERT INTO autores (nombre)
SELECT 'Isabel Allende'
WHERE NOT EXISTS (
    SELECT 1 FROM autores WHERE nombre = 'Isabel Allende'
);

-- Insertar el género "Literatura contemporánea" solo si no existe.
INSERT INTO genero (descripcion)
SELECT 'Literatura contemporánea'
WHERE NOT EXISTS (
    SELECT 1 FROM genero WHERE descripcion = 'Literatura contemporánea'
);

-- Finalmente, insertamos el libro "La casa de los espíritus"
INSERT INTO libros (isbn, titulo, id_autor, id_genero, anio_publicacion, edicion)
VALUES (
    '9788408172177',
    'La casa de los espíritus',
    (SELECT id_autor FROM autores WHERE nombre = 'Isabel Allende'),
    (SELECT id_genero FROM genero WHERE descripcion = 'Literatura contemporánea'),
    1982,
    1
);


COMMIT;
-- Si alguna de las operaciones falla, se puede hacer un ROLLBACK para deshacer todos los cambios.
-- ROLLBACK;