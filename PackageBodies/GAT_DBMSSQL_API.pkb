CREATE OR REPLACE PACKAGE BODY GAT.gat_dbmssql_api
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     GAT_DBMSSQL_API
Proposito:  API para DBMS_SQL

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
07-03-2012 mherrera Creación
*******************************************************************************/
AS
   --* Variables, constantes, tipos y subtipos locales

   --select * from dba_tables where owner = 'PYSNIP_OWN' and table_name like 'BAP_PROYECTOS';

   --select * from dba_tab_columns where owner = 'PYSNIP_OWN' and table_name like 'BAP_PROYECTOS';

   --* Procedimientos y funciones

   FUNCTION to_ora_type (p_data_type IN PLS_INTEGER)
      RETURN VARCHAR2
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'to_ora_type';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
      -- Variables, constantes, tipos y subtipos locales
      v_str_data_type       VARCHAR2 (32);
   BEGIN
      --*
      --* Implementación.
      v_str_data_type :=
         CASE p_data_type
            WHEN DBMS_SQL.varchar2_type THEN 'VARCHAR2'
            WHEN DBMS_SQL.number_type THEN 'NUMBER'
            WHEN DBMS_SQL.long_type THEN 'LONG'
            WHEN DBMS_SQL.rowid_type THEN 'ROWID'
            WHEN DBMS_SQL.date_type THEN 'DATE'
            WHEN DBMS_SQL.raw_type THEN 'RAW'
            WHEN DBMS_SQL.long_raw_type THEN 'LONG RAW'
            WHEN DBMS_SQL.char_type THEN 'CHAR'
            WHEN DBMS_SQL.binary_float_type THEN 'BINARY_FLOAT'
            WHEN DBMS_SQL.binary_bouble_type THEN 'BINARY_DOUBLE'
            --when dbms_sql.MLSLabel_Type                         then '
            --when dbms_sql.User_Defined_Type                     then '
            --when dbms_sql.Ref_Type                              then '
         WHEN DBMS_SQL.clob_type THEN 'CLOB'
            WHEN DBMS_SQL.blob_type THEN 'BLOB'
            WHEN DBMS_SQL.bfile_type THEN 'BFILE'
            WHEN DBMS_SQL.timestamp_type THEN 'TIMESTAMP'
            WHEN DBMS_SQL.timestamp_with_tz_type THEN 'TIMESTAMP WITH TIME ZONE'
            WHEN DBMS_SQL.interval_year_to_month_type THEN 'INTERVAL YEAR TO MONTH'
            WHEN DBMS_SQL.interval_day_to_second_type THEN 'INTERVAL DAY TO SECOND'
            WHEN DBMS_SQL.urowid_type THEN 'UROWID'
            WHEN DBMS_SQL.timestamp_with_local_tz_type THEN 'TIMESTAMP WITH LOCAL TIME ZONE'
         END;

      IF v_str_data_type IS NULL
      THEN
         raise_application_error (-20100, 'No se pudo mapear un tipo para(' || TO_CHAR (p_data_type) || ')');
      END IF;

      --* Fin Implementación
      --*
      RETURN v_str_data_type;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END to_ora_type;

   PROCEDURE desc_rec_to_desc_rec (p_desc_table_from   IN     DBMS_SQL.desc_tab,
                                   p_desc_table_to        OUT utl_desc.desc_table_ct)
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'desc_rec_to_desc_rec';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   -- Variables, constantes, tipos y subtipos locales
   BEGIN
      --*
      --* Implementación.
      IF p_desc_table_from.COUNT > 0
      THEN
         FOR i IN p_desc_table_from.FIRST .. p_desc_table_from.LAST LOOP
            p_desc_table_to (i).column_name := p_desc_table_from (i).col_name;
            p_desc_table_to (i).data_type := to_ora_type (p_desc_table_from (i).col_type);

            --p_desc_table_to (i).data_length
            p_desc_table_to (i).data_precision := p_desc_table_from (i).col_precision;
            p_desc_table_to (i).data_scale := p_desc_table_from (i).col_scale;
            p_desc_table_to (i).nullable :=
               CASE p_desc_table_from (i).col_null_ok WHEN TRUE THEN 'Y' WHEN FALSE THEN 'N' END;
         --p_desc_table_to (i).column_id       := v_pos;
         END LOOP;
      END IF;
   --* Fin Implementación
   --*
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END desc_rec_to_desc_rec;
END gat_dbmssql_api;
/
SHOW ERRORS;


