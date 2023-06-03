CREATE OR REPLACE PACKAGE GAT.gat_gen_names
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
   -- Constantes para identificar el package
   k_package   CONSTANT fdc_defs.package_name_t := 'GAT_GEN_NAMES';

   --* Subtipos, Tipos, Constantes del package

   --* Procedimientos y funciones
   FUNCTION pk_sequence_column_name (p_table_owner    dba_constraints.owner%TYPE,
                                     p_table_name     dba_constraints.table_name%TYPE)
      RETURN dba_tab_columns.column_name%TYPE;

   FUNCTION is_update_by_columns (p_object_name IN VARCHAR2)
      RETURN BOOLEAN;

   FUNCTION is_update_by_one_column (p_object_name IN VARCHAR2)
      RETURN BOOLEAN;

   FUNCTION is_delete_by_pk (p_object_name IN VARCHAR2)
      RETURN BOOLEAN;

   FUNCTION is_delete_by_uk (p_object_name IN VARCHAR2)
      RETURN BOOLEAN;

   FUNCTION is_delete_by_fk (p_object_name IN VARCHAR2)
      RETURN BOOLEAN;

   FUNCTION is_delete_by_one_column (p_object_name IN VARCHAR2)
      RETURN BOOLEAN;
END gat_gen_names;
/
SHOW ERRORS;


