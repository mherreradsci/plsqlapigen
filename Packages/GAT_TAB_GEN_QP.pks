CREATE OR REPLACE PACKAGE GAT.gat_tab_gen_qp IS
/*------------------------------------------------------------------------------
Empresa:    Explora IT
Proyecto:   Utilidades para desarrolladores
Objetivo:   Procedimientos para generar un package de API de una tabla

Historia:
Cuando      Quien    Comantario
----------- -------- -----------------------------------------------------------
03-Dic-2004 mherrera Separa los programas que generan los %QP del package
                     UTL_TAB_API

*/
   k_package   CONSTANT fdc_defs.package_name_t := 'GAT_TAB_GEN_QP ';

   PROCEDURE gen_pkg_query_spec (
      p_table_owner          IN              dba_objects.owner%TYPE,
      p_table_name           IN              dba_tables.table_name%TYPE,
      p_types_package_name   IN              all_objects.object_name%TYPE,
      p_lineas               IN OUT NOCOPY   utl_line.lines_t
   );

   PROCEDURE gen_pkg_query_body (
      p_package_name         IN              dba_objects.object_name%TYPE,
      p_table_owner          IN              dba_objects.owner%TYPE,
      p_table_name           IN              dba_tables.table_name%TYPE,
      p_types_package_name   IN              all_objects.object_name%TYPE,
      p_expand_cols          IN              BOOLEAN DEFAULT TRUE,
      p_lineas               IN OUT NOCOPY   utl_line.lines_t
   );
END gat_tab_gen_qp;
/
SHOW ERRORS;


