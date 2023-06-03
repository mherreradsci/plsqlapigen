CREATE OR REPLACE PACKAGE GAT.gat_genera_api_tablas
   AUTHID CURRENT_USER
IS
   /*
   Empresa:    Explora IT
   Proyecto:   Utiles
   Objetivo:   GENERA API TABLAS para un esquema determinado, la tabla debe estar
               en el esquema donde se ejecuta esta utilidad

   Historia    Quien    Descripción
   ----------- -------- -----------------------------------------------------------
   21-Jul-2004 mherrera Creación
   10-Nov-2004 mherrera Agrega p_owner y p_solo_spec, deja pendiente el manejo de
                        los parámetros.
   18-Nov-2009 mherrera Agrega p_expand_cols para que el generador de queries
                        construya los SELECT con * o con la lista de columnas.
                        Esto es porque entre un entorno y otro puede haber
                        diferencias en el orden de columnas y el
                        select c1, c2,c3 puede no estar acorde a la definición
                        del registro obtenido por table%rowtype
   */
   k_package   CONSTANT fdc_defs.package_name_t := UPPER ('GAT_GENERA_API_TABLAS');

   PROCEDURE gencod (p_prod_id         IN gat_productos.prod_id%TYPE,
                     --p_sistema         IN VARCHAR2,
                     p_autor           IN all_users.username%TYPE,
                     p_table_owner     IN all_objects.owner%TYPE,
                     p_table_name      IN all_tables.table_name%TYPE,
                     p_package_owner   IN all_users.username%TYPE,
                     p_genera_body     IN BOOLEAN DEFAULT TRUE,
                     p_expand_cols     IN BOOLEAN DEFAULT TRUE,
                     p_spool_out       IN BOOLEAN DEFAULT FALSE,
                     p_write_files     IN BOOLEAN DEFAULT TRUE,
                     p_compile         IN BOOLEAN DEFAULT FALSE);
END gat_genera_api_tablas;
/
SHOW ERRORS;


