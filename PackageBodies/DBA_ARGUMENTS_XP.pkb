CREATE OR REPLACE PACKAGE BODY GAT.dba_arguments_xp
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     DBA_ARGUMENTS_XP
Proposito:  eXtensiones para dba_arguments

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
02-Mar-2012 mherrera Creación
*******************************************************************************/
AS
   --* Variables, constantes, tipos y subtipos locales

   --* Procedimientos y funciones
   FUNCTION has_a_paramter (p_arguments IN dba_arguments_tp.dba_arguments_ct)
      RETURN BOOLEAN
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'has_a_paramter';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   BEGIN
      IF p_arguments.COUNT = 0
      THEN
         RETURN FALSE;
      END IF;

      IF (p_arguments (p_arguments.FIRST).position = 0.0 AND p_arguments.COUNT > 1.0)
         OR (p_arguments (p_arguments.FIRST).position != 0.0 AND p_arguments.COUNT > 0.0)
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => k_modulo,
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END has_a_paramter;

   FUNCTION is_fnc (p_arguments IN dba_arguments_tp.dba_arguments_ct)
      RETURN BOOLEAN
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'is_fnc';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   BEGIN
      IF p_arguments.COUNT = 0
      THEN
         RETURN FALSE;
      END IF;

      --DBMS_OUTPUT.put_line (k_programa || ':p_arguments (1).data_type' || p_arguments (1).data_type);

      IF p_arguments.EXISTS (1) AND p_arguments (1).position = 0
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => k_modulo,
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END is_fnc;

   --*
   FUNCTION is_fnc_with_ref_cursor (p_arguments IN dba_arguments_tp.dba_arguments_ct)
      RETURN BOOLEAN
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'is_fnc_with_ref_cursor';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   BEGIN
      IF p_arguments.COUNT = 0
      THEN
         RETURN FALSE;
      END IF;

      --DBMS_OUTPUT.put_line (k_programa || ':p_arguments (1).data_type' || p_arguments (1).data_type);

      IF     p_arguments.EXISTS (1)
         AND p_arguments (1).position = 0
         AND p_arguments (1).data_type = 'REF CURSOR'
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => k_modulo,
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END is_fnc_with_ref_cursor;
END dba_arguments_xp;
/
SHOW ERRORS;


