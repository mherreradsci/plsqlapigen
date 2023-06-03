CREATE OR REPLACE PACKAGE GAT.gat_tab_gen_cp
IS
   /*
   Empresa:    Explora IT
   Proyecto:   Utilidades para desarrolladores
   Objetivo:   Procedimientos para generar packages APIs de change de tablas

   Historia:
   Cuando      Quien    Comantario
   ----------- -------- -----------------------------------------------------------
   04-Dic-2004 mherrera Separa los programas que generan los %CP del package
                        UTL_TAB_API
   */

   -- Constantes para identificar el package
   k_package   CONSTANT fdc_defs.package_name_t := 'GAT_TAB_GEN_CP';

   -- Procedimientos y funciones
   PROCEDURE gen_pkg_change_spec (
      p_table_owner          IN            dba_objects.owner%TYPE,
      p_table_name           IN            dba_tables.table_name%TYPE,
      p_types_package_name   IN            all_objects.object_name%TYPE,
      p_lineas               IN OUT NOCOPY utl_line.lines_t);

   PROCEDURE gen_pkg_change_body (
      p_package_name         IN            dba_objects.object_name%TYPE,
      p_table_owner          IN            dba_objects.owner%TYPE,
      p_table_name           IN            dba_tables.table_name%TYPE,
      p_types_package_name   IN            all_objects.object_name%TYPE,
      p_lineas               IN OUT NOCOPY utl_line.lines_t);
END gat_tab_gen_cp;
/
SHOW ERRORS;


