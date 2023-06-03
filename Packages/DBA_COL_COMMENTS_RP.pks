CREATE OR REPLACE PACKAGE GAT.dba_col_comments_rp
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     DBA_COL_COMMENTS_RP
Proposito:  Reglas de negocio adicionales para tabla DBA_COL_COMMENTS

Observaciones:
            SQL> create table dba_col_comments as 
                  select * from dba_col_comments where 1=0;
            SQL> alter table dba_col_comments 
                  add constraint cocm_pk 
                     primary key( OWNER, TABLE_NAME, COLUMN_NAME);
            SQL> drop table dba_col_comments purge;

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
24-Feb-2012 mherrera Creación
*******************************************************************************/
AS
   -- Constantes para identificar el package
   k_package   CONSTANT fdc_defs.package_name_t := 'DBA_COL_COMMENTS_RP';

   --* Subtipos, Tipos, Constantes del package

   --* Procedimientos y funciones
   FUNCTION get_comment (p_owner         IN dba_col_comments_tp.owner_t,
                         p_table_name    IN dba_col_comments_tp.table_name_t,
                         p_column_name   IN dba_col_comments_tp.column_name_t)
      RETURN dba_col_comments_tp.comments_t;
END dba_col_comments_rp;
/
SHOW ERRORS;


