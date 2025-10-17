-- Archivo de Lógica de Base de Datos
-- Contiene las Vistas y Triggers.

-- =============================================================================
-- TRIGGERS
-- =============================================================================

-- Trigger que se dispara ANTES de insertar un nuevo préstamo.
-- MODIFICADO: Ahora valida si el ejemplar está disponible. Si no lo está, bloquea la inserción.
CREATE TRIGGER IF NOT EXISTS trg_prestamo_validacion_insert
BEFORE INSERT ON prestamos
FOR EACH ROW
WHEN (SELECT disponible FROM ejemplares WHERE id_ejemplar = NEW.id_ejemplar) = 0
BEGIN
    -- Lanza un error y aborta la transacción si el ejemplar no está disponible.
    SELECT RAISE(ABORT, 'Error: El ejemplar ya se encuentra prestado.');
END;

-- Trigger que se dispara DESPUÉS de un préstamo válido para actualizar el estado.
CREATE TRIGGER IF NOT EXISTS trg_prestamo_update_estado
AFTER INSERT ON prestamos
FOR EACH ROW
BEGIN
    UPDATE ejemplares
    SET disponible = 0
    WHERE id_ejemplar = NEW.id_ejemplar;
END;

-- Trigger que se dispara después de registrar una devolución.
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
    -- Usamos GROUP_CONCAT para listar todos los autores en una sola cadena.
    GROUP_CONCAT(DISTINCT a.nombre) AS autores,
    g.descripcion AS genero,
    COUNT(e.id_ejemplar) AS copias_disponibles
FROM libros l
JOIN libros_autores la ON l.isbn = la.isbn
JOIN autores a ON la.id_autor = a.id_autor
JOIN genero g ON l.id_genero = g.id_genero
JOIN ejemplares e ON l.isbn = e.isbn
WHERE e.disponible = 1
GROUP BY l.isbn, g.descripcion;

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