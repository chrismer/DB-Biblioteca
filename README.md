# Proyecto de Base de Datos: Sistema de Biblioteca

Este proyecto implementa una base de datos robusta y normalizada para la gestión de una biblioteca, utilizando SQLite.

## Diagramas del Diseño Final

### Diagrama de Entidad-Relación (DER)
![Diagrama de Entidad-Relación](https://res.cloudinary.com/dmt7nidfb/image/upload/v1760725646/Diagrama-DER_gmx8vx.jpg)

### Diagrama de Tablas de la Base de Datos
![Diagrama de Tablas de la DB](https://res.cloudinary.com/dmt7nidfb/image/upload/v1760725646/Diagrama-DB_yfot6v.jpg)

## Estructura del Proyecto

-   `database/ddl/schema.sql`: Script con las sentencias `CREATE TABLE` e `CREATE INDEX` para definir la estructura optimizada de la base de datos.
-   `database/dml/data_load.sql`: Script con sentencias `INSERT` para poblar la base de datos con datos de ejemplo.
-   `database/logic/views_triggers.sql`: Script que crea las vistas y los triggers para la lógica de negocio y la integridad de datos.
-   `database/logic/transaction_example.sql`: Script de ejemplo que muestra cómo se realizaría una transacción segura.
-   `database/biblioteca.db`: El archivo de la base de datos SQLite. Se genera al ejecutar los scripts.

## Cómo Construir la Base de Datos

Para crear y poblar la base de datos desde cero, sigue estos pasos desde la terminal en el directorio raíz del proyecto.

1.  **Asegúrate de no tener el archivo `biblioteca.db`** (bórralo si existe para empezar de cero).

2.  **Ejecuta los siguientes comandos en orden** para construir la base de datos:
    ```bash
    # 1. Crea el esquema, las tablas y los índices
    sqlite3 database/biblioteca.db < database/ddl/schema.sql

    # 2. Carga los datos de ejemplo
    sqlite3 database/biblioteca.db < database/dml/data_load.sql

    # 3. Crea las vistas y los triggers
    sqlite3 database/biblioteca.db < database/logic/views_triggers.sql
    ```

## Cómo Probar la Base de Datos

Una vez construida, puedes verificar que la lógica principal funciona correctamente.

1.  **Abre una sesión interactiva** con la base de datos:
    ```bash
    sqlite3 database/biblioteca.db
    ```

2.  **Verifica la vista de autores múltiples**:
    ```sql
    SELECT * FROM vista_libros_disponibles;
    ```
    * **Resultado esperado**: Una lista de libros donde los autores se muestran correctamente, sin duplicados.

3.  **Prueba el trigger de protección de préstamos**:
    ```sql
    -- Este primer préstamo sobre el ejemplar 1 debe FUNCIONAR.
    INSERT INTO prestamos (id_usuario, id_ejemplar) VALUES (1, 1);

    -- Este segundo préstamo sobre el MISMO ejemplar 1 debe FALLAR.
    INSERT INTO prestamos (id_usuario, id_ejemplar) VALUES (2, 1);
    ```
    * **Resultado esperado**: El segundo `INSERT` debe mostrar el error: `Error: El ejemplar ya se encuentra prestado.`

4.  Para salir de la sesión interactiva, escribe `.quit`.

## Autores:
### [Amadeo Socarros](https://github.com/socarros02)
### [Christian Mereles](https://github.com/chrismer)