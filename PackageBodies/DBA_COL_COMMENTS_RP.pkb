CREATE OR REPLACE PACKAGE BODY GAT.dba_col_comments_rp
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     DBA_COL_COMMENTS_RP
Proposito:  Reglas de negocio adicionales para tabla DBA_COL_COMMENTS

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
24-Feb-2012 mherrera Creación
*******************************************************************************/
AS
   --* Variables, constantes, tipos y subtipos locales

   --* Procedimientos y funciones

   FUNCTION get_comment (p_owner         IN dba_col_comments_tp.owner_t,
                         p_table_name    IN dba_col_comments_tp.table_name_t,
                         p_column_name   IN dba_col_comments_tp.column_name_t)
      RETURN dba_col_comments_tp.comments_t
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'get_comment';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
      -- Variables, constantes, tipos y subtipos locales
      v_comments            dba_col_comments_tp.comments_t;
   BEGIN
      --*
      --* Implementación.
      SELECT comments
      INTO v_comments
      FROM dba_col_comments cocm
      WHERE cocm.owner = p_owner
        AND cocm.table_name = p_table_name
        AND cocm.column_name = p_column_name;

      --* Fin Implementación
      --*
      RETURN v_comments;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         return null;
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => k_modulo,
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END get_comment;
END dba_col_comments_rp;
/
SHOW ERRORS;


