CREATE OR REPLACE PACKAGE BODY GAT.gat_table_ctx
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     GAT_TABLE_CTX
Proposito:  Manager del contexto TABLE_CTX

Cuando     Quien    Que
---------- -------- ------------------------------------------------------------
02/10/2012 mherrera Creación
*******************************************************************************/
AS
   PROCEDURE set_parameter (p_name IN VARCHAR2, p_value IN VARCHAR2)
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'set_parameter';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   -- Variables, constantes, tipos y subtipos locales

   BEGIN
      --*
      --* Implementación.

      DBMS_SESSION.set_context ('TABLE_CTX', p_name, p_value);
   --* Fin Implementación
   --*

   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => k_modulo,
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END set_parameter;

   PROCEDURE initialize
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'initialize';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
      -- Variables, constantes, tipos y subtipos locales


      v_app_name            VARCHAR2 (512);
      v_app_version         VARCHAR2 (512);
      v_app_author          VARCHAR2 (512);
   BEGIN
      v_app_name := uvg_valores_generales.nombre_proyecto (SYSDATE);
      v_app_version := uvg_valores_generales.version (SYSDATE);
      v_app_author := uvg_valores_generales.gat_author (SYSDATE);

      set_parameter ('app_name', v_app_name);
      set_parameter ('app_version', v_app_version);
      set_parameter ('app_author', v_app_author);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => k_modulo,
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
                            
   END initialize;

   PROCEDURE set_table_context (p_table_owner        IN all_tables.owner%TYPE,
                                p_table_name         IN all_tables.table_name%TYPE,
                                p_table_short_name   IN VARCHAR2)
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'set_table_context';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   -- Variables, constantes, tipos y subtipos locales


   BEGIN
      set_parameter ('table_owner', p_table_owner);
      set_parameter ('table_name', p_table_name);
      set_parameter ('table_short_name', p_table_short_name);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => k_modulo,
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END set_table_context;
END gat_table_ctx;
/
SHOW ERRORS;


