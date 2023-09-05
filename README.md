# PL/SQL API Generator
## Generador de código PL/SQL que construye código base (Select+DML) en función del modelo de base de datos y un catálogo de configuración
### Por cada tabla del modelo de base de datos que se integra al catálogo, se generan tres packages separados por función
- \<Prefix>_<Table_Name>_TP: Type Package
- \<Prefix>_<Table_Name>_QP: Query Package
- \<Prefix>_<Table_Name>_CP: Change Package (Insert/Update/Delete)

## El código generado adhiere a estándares que se declaran en el catálogo de generación
- Con el fin de estandarizar la documentación, nomenclatura de nombres y buenas prácticas.
- El catalogo se puede configurar para generar código PL/SQL que adhiera a los estándares del proyecto y  pasar validaciones __*Clean Code*__
- El catálogo se puede configurar para generar o dejar de generar procedimientos/funciones, dependiendo de la madurez y objetivos del proyecto, por ejemplo, se puede dejar de generar todas las operaciones Bulk o seleccionar que tipo de SQL dinámico se va a implementar
- Si se modifica el modelo de base de datos, se ejecuta el generador de APIs nuevamente para actualizar el catalogo y (opcionalmente) si se compilan las modificaciones en la base de datos

## Una vez generado el código de base, solo se debe construir packages de extension
- \<Prefix>_<Table_Name>_KP: Konstant Packages
- \<Prefix>_<Table_Name>_XP: user eXtentions

## TODO
* [-] 01: Incluir un generador de Packages para Konstantes en función de las tablas de tipos
* [-] 02: Interfaz de usuario para el generador
* [-] 03: Separar el TODO a un archivo TODO.md
