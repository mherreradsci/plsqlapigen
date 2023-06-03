CREATE OR REPLACE PACKAGE GAT.dba_col_comments_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     DBA_COL_COMMENTS_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               DBA_COL_COMMENTS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   22-mar-2012 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de DBA_COL_COMMENTS basado en la PK
   FUNCTION existe (p_owner         IN dba_col_comments_tp.owner_t,
                    p_table_name    IN dba_col_comments_tp.table_name_t,
                    p_column_name   IN dba_col_comments_tp.column_name_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla DBA_COL_COMMENTS a partir de la pk
   FUNCTION cuenta_por_pk (p_owner         IN dba_col_comments_tp.owner_t,
                           p_table_name    IN dba_col_comments_tp.table_name_t,
                           p_column_name   IN dba_col_comments_tp.column_name_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de DBA_COL_COMMENTS basado en la constraint COCM_PK
   PROCEDURE sel_cocm_pk (
      p_owner              IN            dba_col_comments_tp.owner_t,
      p_table_name         IN            dba_col_comments_tp.table_name_t,
      p_column_name        IN            dba_col_comments_tp.column_name_t,
      p_dba_col_comments      OUT NOCOPY dba_col_comments_tp.dba_col_comments_rt);

   -- Consulta el registro de DBA_COL_COMMENTS basado en la PK
   FUNCTION sel_pk (p_owner         IN dba_col_comments_tp.owner_t,
                    p_table_name    IN dba_col_comments_tp.table_name_t,
                    p_column_name   IN dba_col_comments_tp.column_name_t)
      RETURN dba_col_comments_tp.dba_col_comments_rt;

   -- Obtiene un cursor via una consulta sobre la constraint COCM_PK de la tabla DBA_COL_COMMENTS
   FUNCTION sel_cocm_pk (p_owner         IN dba_col_comments_tp.owner_t,
                         p_table_name    IN dba_col_comments_tp.table_name_t,
                         p_column_name   IN dba_col_comments_tp.column_name_t)
      RETURN dba_col_comments_tp.dba_col_comments_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla DBA_COL_COMMENTS
   PROCEDURE sel_where (
      p_where                            VARCHAR2,
      p_dba_col_comments   IN OUT NOCOPY dba_col_comments_tp.dba_col_comments_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla DBA_COL_COMMENTS
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN dba_col_comments_tp.dba_col_comments_rc;
END dba_col_comments_qp;
/
SHOW ERRORS;


