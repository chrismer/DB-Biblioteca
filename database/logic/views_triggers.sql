-- Archivo de Lógica de Base de Datos
-- Contiene las Vistas y Triggers.

-- =============================================================================
-- TRIGGERS
-- =============================================================================

-- Trigger que se dispara después de insertar un nuevo préstamo.
-- Actualiza el estado del ejemplar a "no disponible" (0).
CREATE TRIGGER IF NOT EXISTS trg_prestamo_insert
AFTER INSERT ON prestamos
FOR EACH ROW
BEGIN
    UPDATE ejemplares
    SET disponible = 0
    WHERE id_ejemplar = NEW.id_ejemplar;
END;

-- Trigger que se dispara después de actualizar un préstamo para registrar una devolución.
-- Se activa solo cuando fecha_devolucion cambia de NULL a un valor no nulo.
-- Actualiza el estado del ejemplar a "disponible" (1).
CREATE TRIGGER IF NOT EXISTS trg_devolucion_update
AFTER UPDATE OF fecha_devolucion ON prestamos
FOR EACH ROW
WHEN OLD.fecha_devolucion IS NULL AND NEW.fecha_devolucion IS NOT NULL
BEGIN
    UPDATE ejemplares
    SET disponible = 1
    WHERE id_ejemplar = NEW.id_ejemplar;
END;

-- =============================================================================
-- VISTAS
-- =============================================================================

-- Vista que muestra los libros con ejemplares disponibles para prestar.
CREATE VIEW IF NOT EXISTS vista_libros_disponibles AS
SELECT
    l.titulo,
    a.nombre AS autor,
    g.descripcion AS genero,
    COUNT(e.id_ejemplar) AS copias_disponibles
FROM libros l
JOIN autores a ON l.id_autor = a.id_autor
JOIN genero g ON l.id_genero = g.id_genero
JOIN ejemplares e ON l.isbn = e.isbn
WHERE e.disponible = 1
GROUP BY l.isbn, a.nombre, g.descripcion;

-- Vista que muestra los préstamos activos (pendientes de devolución).
CREATE VIEW IF NOT EXISTS vista_prestamos_pendientes AS
SELECT
    p.id_prestamo,
    u.nombre || ' ' || u.apellido AS usuario,
    l.titulo AS libro,
    p.fecha_prestamo,
    CAST(julianday('now') - julianday(p.fecha_prestamo) AS INTEGER) AS dias_prestado
FROM prestamos p
JOIN usuarios u ON p.id_usuario = u.id_usuario
JOIN ejemplares e ON p.id_ejemplar = e.id_ejemplar
JOIN libros l ON e.isbn = l.isbn
WHERE p.fecha_devolucion IS NULL;