# Proyecto de Base de Datos: Sistema de Biblioteca

## Diagramas

### Diagrama de Entidad-Relación (DER)
![Diagrama de Entidad-Relación](https://res.cloudinary.com/dmt7nidfb/image/upload/v1759444893/biblioteca_db_der_gp5n6d.jpg)

### Diagrama de Tablas de la Base de Datos
![Diagrama de Tablas de la DB](https://res.cloudinary.com/dmt7nidfb/image/upload/v1759444892/DiagramaDeTablas_u8y3jx.jpg)


Este proyecto implementa una base de datos para la gestión de una biblioteca, como parte del Trabajo Práctico Integrador.

## Estructura del Proyecto

- `database/ddl/schema.sql`: Script con las sentencias `CREATE TABLE` para definir la estructura de la base de datos.
- `database/dml/data_load.sql`: Script con sentencias `INSERT` para poblar la base de datos con datos de ejemplo.
- `database/logic/views_triggers.sql`: Script que crea las vistas y los triggers para la lógica de negocio.
- `database/logic/transaction_example.sql`: Script de ejemplo que muestra cómo se realizaría una transacción para un préstamo.
- `database/biblioteca.db`: El archivo de la base de datos SQLite. Se genera al ejecutar los scripts.

## Cómo Construir la Base de Datos

Para crear y poblar la base de datos desde cero, puedes usar la interfaz de línea de comandos de SQLite.

1.  Abre una terminal en el directorio raíz del proyecto.
2.  Ejecuta el siguiente comando para crear la base de datos y aplicar el esquema:
    ```bash
    sqlite3 database/biblioteca.db < database/ddl/schema.sql
    ```
3.  Ejecuta los siguientes comandos para cargar los datos de ejemplo y crear la lógica:
    ```bash
    sqlite3 database/biblioteca.db < database/dml/data_load.sql
    sqlite3 database/biblioteca.db < database/logic/views_triggers.sql
    ```

## Autores:
### <a href="https://github.com/socarros02">Amadeo Socarros</a>
### <a href="https://github.com/chrismer">Christian Mereles</a>