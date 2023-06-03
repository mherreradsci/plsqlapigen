CREATE OR REPLACE PACKAGE BODY GAT.gat_gen_names
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     GAT_GEN_NAMES
Proposito:  Genera los nombres a partir de los templates de nombre (por ahora
            solo genera los nombres "en duro"

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
19-03-2012 mherrera Creación
*******************************************************************************/
AS
   --* Variables, constantes, tipos y subtipos locales

   --* Procedimientos y funciones

   FUNCTION pk_sequence_column_name (p_table_owner    dba_constraints.owner%TYPE,
                                     p_table_name     dba_constraints.table_name%TYPE)
      RETURN dba_tab_columns.column_name%TYPE
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'pk_sequence_column_name';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
      -- Variables, constantes, tipos y subtipos locales
      v_column_name         dba_tab_columns.column_name%TYPE;
   BEGIN
      --*
      --* Implementación.
      v_column_name := SYS_CONTEXT ('TABLE_CTX', 'table_short_name') || gat_defs.k_sufijo_secuencia_id;
      --DBMS_OUTPUT.put_line (k_modulo || ':v_column_name:' || v_column_name);
      --* Fin Implementación
      --*
      RETURN v_column_name;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END pk_sequence_column_name;

   FUNCTION is_update_by_columns (p_object_name IN VARCHAR2)
      RETURN BOOLEAN
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'is_update_by_columns';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   BEGIN
      IF (p_object_name LIKE 'UPD\_____\_PK' ESCAPE '\'
          OR p_object_name LIKE 'UPD\_____\_UK%' ESCAPE '\')
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END is_update_by_columns;

   FUNCTION is_update_by_one_column (p_object_name IN VARCHAR2)
      RETURN BOOLEAN
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'is_update_by_one_column';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   BEGIN
      IF (p_object_name = 'UPD_POR_UNA_COLUMNA')
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END is_update_by_one_column;

   FUNCTION is_delete_by_pk (p_object_name IN VARCHAR2)
      RETURN BOOLEAN
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'is_delete_by_pk';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   BEGIN
      IF p_object_name LIKE 'DEL\_____\_PK' ESCAPE '\'
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END is_delete_by_pk;

   FUNCTION is_delete_by_uk (p_object_name IN VARCHAR2)
      RETURN BOOLEAN
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'is_delete_by_pk';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   BEGIN
      IF p_object_name LIKE 'DEL\_____\_UK%' ESCAPE '\'
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END is_delete_by_uk;

   FUNCTION is_delete_by_fk (p_object_name IN VARCHAR2)
      RETURN BOOLEAN
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'is_delete_by_fk';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   BEGIN
      IF p_object_name LIKE 'DEL\_____\_____\_FK%' ESCAPE '\'
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END is_delete_by_fk;

   FUNCTION is_delete_by_one_column (p_object_name IN VARCHAR2)
      RETURN BOOLEAN
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'is_delete_by_one_column';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   BEGIN
      IF (p_object_name = 'DEL_POR_UNA_COLUMNA')
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END is_delete_by_one_column;
END gat_gen_names;
/
SHOW ERRORS;


