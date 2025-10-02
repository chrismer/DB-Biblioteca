-- Archivo de Ejemplo de Transacción
--
-- IMPORTANTE: SQLite no tiene un bloque TRY/CATCH en su SQL estándar.
-- La lógica de "verificar y luego actuar" dentro de una única transacción
-- generalmente se maneja en el código de la aplicación (ej. Python, Java, Node.js)
-- que se conecta a la base de datos.
--
-- Este script demuestra los comandos SQL que se ejecutarían dentro de esa lógica.

-- Escenario: El usuario con id_usuario = 1 quiere tomar prestado el ejemplar con id_ejemplar = 3.

-- Paso 1: Iniciar la transacción.
-- Esto asegura que todas las operaciones siguientes sean atómicas (o todo o nada).
BEGIN TRANSACTION;

-- Paso 2 (Lógica en la aplicación): Verificar si el ejemplar está disponible.
-- En una aplicación real, ejecutarías esta consulta y verificarías el resultado.
-- SELECT disponible FROM ejemplares WHERE id_ejemplar = 3;
-- Si el resultado es 0, la aplicación haría un ROLLBACK y notificaría al usuario.
-- Si es 1, procedería al siguiente paso.

-- Asumimos que el ejemplar está disponible.

-- Paso 3: Insertar el registro del préstamo.
-- La fecha se establece por defecto a la actual gracias al DEFAULT en el DDL.
-- El trigger `trg_prestamo_insert` se disparará automáticamente aquí
-- y pondrá `ejemplares.disponible` en 0.
INSERT INTO prestamos (id_usuario, id_ejemplar) VALUES (1, 3);

-- Paso 4: Si todo ha ido bien, confirmar la transacción.
-- Los cambios se guardan permanentemente en la base de datos.
COMMIT;

-- Si en algún punto hubiera ocurrido un error, se ejecutaría:
-- ROLLBACK;