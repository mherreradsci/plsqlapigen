CREATE OR REPLACE PACKAGE BODY GAT.dba_col_comments_qp
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
      RETURN BOOLEAN
   IS
      CURSOR un_registro
      IS
         SELECT NULL
         FROM dba_col_comments
         WHERE owner = p_owner
           AND table_name = p_table_name
           AND column_name = p_column_name;

      v_valor    PLS_INTEGER;
      v_retval   BOOLEAN;
   BEGIN
      OPEN un_registro;

      FETCH un_registro
      INTO v_valor;

      v_retval := un_registro%FOUND;

      CLOSE un_registro;

      RETURN v_retval;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'DBA_COL_COMMENTS_QP.existe',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END existe;

   -- Funcion para obtener la cantidad de registros de la tabla DBA_COL_COMMENTS a partir de la pk
   FUNCTION cuenta_por_pk (p_owner         IN dba_col_comments_tp.owner_t,
                           p_table_name    IN dba_col_comments_tp.table_name_t,
                           p_column_name   IN dba_col_comments_tp.column_name_t)
      RETURN PLS_INTEGER
   IS
      v_cantidad   PLS_INTEGER;
   BEGIN
      SELECT COUNT (*)
      INTO v_cantidad
      FROM dba_col_comments
      WHERE owner = p_owner AND table_name = p_table_name AND column_name = p_column_name;

      RETURN v_cantidad;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'DBA_COL_COMMENTS_QP.cuenta_por_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END cuenta_por_pk;

   -- Consulta un registro de DBA_COL_COMMENTS basado en la constraint COCM_PK
   PROCEDURE sel_cocm_pk (
      p_owner              IN            dba_col_comments_tp.owner_t,
      p_table_name         IN            dba_col_comments_tp.table_name_t,
      p_column_name        IN            dba_col_comments_tp.column_name_t,
      p_dba_col_comments      OUT NOCOPY dba_col_comments_tp.dba_col_comments_rt)
   IS
      CURSOR c_dba_col_comments
      IS
         SELECT owner,
                table_name,
                column_name,
                comments
         FROM dba_col_comments
         WHERE owner = p_owner
           AND table_name = p_table_name
           AND column_name = p_column_name;

      v_found   BOOLEAN;
   BEGIN
      OPEN c_dba_col_comments;

      FETCH c_dba_col_comments
      INTO p_dba_col_comments;

      v_found := c_dba_col_comments%FOUND;

      CLOSE c_dba_col_comments;

      IF NOT v_found
      THEN
         RAISE NO_DATA_FOUND;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RAISE NO_DATA_FOUND;
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'DBA_COL_COMMENTS_QP.sel_COCM_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_cocm_pk;

   -- Consulta el registro de DBA_COL_COMMENTS basado en la PK
   FUNCTION sel_pk (p_owner         IN dba_col_comments_tp.owner_t,
                    p_table_name    IN dba_col_comments_tp.table_name_t,
                    p_column_name   IN dba_col_comments_tp.column_name_t)
      RETURN dba_col_comments_tp.dba_col_comments_rt
   IS
      v_dba_col_comments   dba_col_comments_tp.dba_col_comments_rt;

      CURSOR c_dba_col_comments
      IS
         SELECT owner,
                table_name,
                column_name,
                comments
         FROM dba_col_comments
         WHERE owner = p_owner
           AND table_name = p_table_name
           AND column_name = p_column_name;
   BEGIN
      OPEN c_dba_col_comments;

      FETCH c_dba_col_comments
      INTO v_dba_col_comments;

      CLOSE c_dba_col_comments;

      RETURN v_dba_col_comments;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'DBA_COL_COMMENTS_QP.sel_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_pk;

   -- Obtiene un cursor via una consulta sobre la constraint COCM_PK de la tabla DBA_COL_COMMENTS
   FUNCTION sel_cocm_pk (p_owner         IN dba_col_comments_tp.owner_t,
                         p_table_name    IN dba_col_comments_tp.table_name_t,
                         p_column_name   IN dba_col_comments_tp.column_name_t)
      RETURN dba_col_comments_tp.dba_col_comments_rc
   IS
      cu_dba_col_comments   dba_col_comments_tp.dba_col_comments_rc;
   BEGIN
      OPEN cu_dba_col_comments FOR
         SELECT owner,
                table_name,
                column_name,
                comments
         FROM dba_col_comments
         WHERE owner = p_owner
           AND table_name = p_table_name
           AND column_name = p_column_name;

      RETURN cu_dba_col_comments;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'DBA_COL_COMMENTS_QP.sel_COCM_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_cocm_pk;

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla DBA_COL_COMMENTS
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN dba_col_comments_tp.dba_col_comments_rc
   IS
      c_dba_col_comments   dba_col_comments_tp.dba_col_comments_rc;
   BEGIN
      OPEN c_dba_col_comments FOR '
      select
      OWNER
      ,TABLE_NAME
      ,COLUMN_NAME
      ,COMMENTS
      from DBA_COL_COMMENTS
      WHERE ' || p_where;

      RETURN c_dba_col_comments;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'DBA_COL_COMMENTS_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;

   -- Obtiene una tabla (index by) con los registros de la tabla DBA_COL_COMMENTS
   PROCEDURE sel_where (
      p_where                            VARCHAR2,
      p_dba_col_comments   IN OUT NOCOPY dba_col_comments_tp.dba_col_comments_ct)
   IS
      TYPE cursor_rc IS REF CURSOR;

      v_cursor   cursor_rc;
   BEGIN
      OPEN v_cursor FOR '
         select
         OWNER
         ,TABLE_NAME
         ,COLUMN_NAME
         ,COMMENTS
         from DBA_COL_COMMENTS
         WHERE ' || p_where;

      LOOP
         FETCH v_cursor
         INTO p_dba_col_comments (p_dba_col_comments.COUNT + 1);

         EXIT WHEN v_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cursor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'DBA_COL_COMMENTS_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;
END dba_col_comments_qp;
/
SHOW ERRORS;


