CREATE OR REPLACE PACKAGE BODY GAT.app_nulls_params_context
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Fundaciones

Nombre:     APP_NULLS_PARAMS_CONTEXT
Proposito:  Para implementar manejo de parametros y valores por omisión a nivel
            de contexto Oracle

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
25-04-2012  mherrera Creación
*******************************************************************************/
AS
   PROCEDURE set_client_info (p_info IN VARCHAR2)
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'set_client_info';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   -- Variables, constantes, tipos y subtipos locales

   BEGIN
      --*
      --* Implementación.
      DBMS_SESSION.set_context ('FDC_NULL_CTX', 'param_info', p_info);
   --* Fin Implementación
   --*

   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END set_client_info;

   PROCEDURE read_client_info (p_info OUT VARCHAR2)
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'read_client_info';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   -- Variables, constantes, tipos y subtipos locales

   BEGIN
      --*
      --* Implementación.
      p_info := SYS_CONTEXT ('FDC_NULL_CTX', 'param_info');
   --* Fin Implementación
   --*

   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END read_client_info;
END app_nulls_params_context;
/
SHOW ERRORS;


