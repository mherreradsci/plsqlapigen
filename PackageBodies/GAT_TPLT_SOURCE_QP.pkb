CREATE OR REPLACE PACKAGE BODY GAT.gat_tplt_source_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TPLT_SOURCE_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_TPLT_SOURCE
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_TPLT_SOURCE basado en la PK
   FUNCTION existe (p_perf_id       IN gat_tplt_source_tp.perf_id_t,
                    p_ttem_codigo   IN gat_tplt_source_tp.ttem_codigo_t,
                    p_tpso_id       IN gat_tplt_source_tp.tpso_id_t)
      RETURN BOOLEAN
   IS
      CURSOR un_registro
      IS
         SELECT NULL
         FROM gat_tplt_source
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND tpso_id = p_tpso_id;

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
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_QP.existe',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END existe;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_TPLT_SOURCE a partir de la pk
   FUNCTION cuenta_por_pk (p_perf_id       IN gat_tplt_source_tp.perf_id_t,
                           p_ttem_codigo   IN gat_tplt_source_tp.ttem_codigo_t,
                           p_tpso_id       IN gat_tplt_source_tp.tpso_id_t)
      RETURN PLS_INTEGER
   IS
      v_cantidad   PLS_INTEGER;
   BEGIN
      SELECT COUNT (*)
      INTO v_cantidad
      FROM gat_tplt_source
      WHERE perf_id = p_perf_id AND ttem_codigo = p_ttem_codigo AND tpso_id = p_tpso_id;

      RETURN v_cantidad;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_QP.cuenta_por_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END cuenta_por_pk;

   -- Consulta un registro de GAT_TPLT_SOURCE basado en la constraint TPSO_PK
   PROCEDURE sel_tpso_pk (
      p_perf_id           IN            gat_tplt_source_tp.perf_id_t,
      p_ttem_codigo       IN            gat_tplt_source_tp.ttem_codigo_t,
      p_tpso_id           IN            gat_tplt_source_tp.tpso_id_t,
      p_gat_tplt_source      OUT NOCOPY gat_tplt_source_tp.gat_tplt_source_rt)
   IS
      CURSOR c_gat_tplt_source
      IS
         SELECT perf_id,
                ttem_codigo,
                tpso_id,
                linea,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_tplt_source
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND tpso_id = p_tpso_id;

      v_found   BOOLEAN;
   BEGIN
      OPEN c_gat_tplt_source;

      FETCH c_gat_tplt_source
      INTO p_gat_tplt_source;

      v_found := c_gat_tplt_source%FOUND;

      CLOSE c_gat_tplt_source;

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
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_QP.sel_TPSO_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tpso_pk;

   -- Consulta el registro de GAT_TPLT_SOURCE basado en la PK
   FUNCTION sel_pk (p_perf_id       IN gat_tplt_source_tp.perf_id_t,
                    p_ttem_codigo   IN gat_tplt_source_tp.ttem_codigo_t,
                    p_tpso_id       IN gat_tplt_source_tp.tpso_id_t)
      RETURN gat_tplt_source_tp.gat_tplt_source_rt
   IS
      v_gat_tplt_source   gat_tplt_source_tp.gat_tplt_source_rt;

      CURSOR c_gat_tplt_source
      IS
         SELECT perf_id,
                ttem_codigo,
                tpso_id,
                linea,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_tplt_source
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND tpso_id = p_tpso_id;
   BEGIN
      OPEN c_gat_tplt_source;

      FETCH c_gat_tplt_source
      INTO v_gat_tplt_source;

      CLOSE c_gat_tplt_source;

      RETURN v_gat_tplt_source;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_QP.sel_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_pk;

   -- Obtiene un cursor via una consulta sobre la constraint TPSO_PK de la tabla GAT_TPLT_SOURCE
   FUNCTION sel_tpso_pk (p_perf_id       IN gat_tplt_source_tp.perf_id_t,
                         p_ttem_codigo   IN gat_tplt_source_tp.ttem_codigo_t,
                         p_tpso_id       IN gat_tplt_source_tp.tpso_id_t)
      RETURN gat_tplt_source_tp.gat_tplt_source_rc
   IS
      cu_gat_tplt_source   gat_tplt_source_tp.gat_tplt_source_rc;
   BEGIN
      OPEN cu_gat_tplt_source FOR
         SELECT perf_id,
                ttem_codigo,
                tpso_id,
                linea,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_tplt_source
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND tpso_id = p_tpso_id;

      RETURN cu_gat_tplt_source;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_QP.sel_TPSO_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tpso_pk;

   -- Obtiene un cursor via una consulta sobre la constraint TPSO_TPLT_FK1 de la tabla GAT_TPLT_SOURCE
   FUNCTION sel_tpso_tplt_fk1 (p_perf_id       IN gat_tplt_source_tp.perf_id_t,
                               p_ttem_codigo   IN gat_tplt_source_tp.ttem_codigo_t)
      RETURN gat_tplt_source_tp.gat_tplt_source_rc
   IS
      cu_gat_tplt_source   gat_tplt_source_tp.gat_tplt_source_rc;
   BEGIN
      OPEN cu_gat_tplt_source FOR
         SELECT perf_id,
                ttem_codigo,
                tpso_id,
                linea,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_tplt_source
         WHERE perf_id = p_perf_id AND ttem_codigo = p_ttem_codigo;

      RETURN cu_gat_tplt_source;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_QP.sel_TPSO_TPLT_FK1',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tpso_tplt_fk1;

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_TPLT_SOURCE
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_tplt_source_tp.gat_tplt_source_rc
   IS
      c_gat_tplt_source   gat_tplt_source_tp.gat_tplt_source_rc;
   BEGIN
      OPEN c_gat_tplt_source FOR '
      select
      PERF_ID
      ,TTEM_CODIGO
      ,TPSO_ID
      ,LINEA
      ,AUD_CREADO_EN
      ,AUD_CREADO_POR
      ,AUD_MODIFICADO_EN
      ,AUD_MODIFICADO_POR
      from GAT_TPLT_SOURCE
      WHERE ' || p_where;

      RETURN c_gat_tplt_source;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_TPLT_SOURCE
   PROCEDURE sel_where (
      p_where                           VARCHAR2,
      p_gat_tplt_source   IN OUT NOCOPY gat_tplt_source_tp.gat_tplt_source_ct)
   IS
      TYPE cursor_rc IS REF CURSOR;

      v_cursor   cursor_rc;
   BEGIN
      OPEN v_cursor FOR '
         select
         PERF_ID
         ,TTEM_CODIGO
         ,TPSO_ID
         ,LINEA
         ,AUD_CREADO_EN
         ,AUD_CREADO_POR
         ,AUD_MODIFICADO_EN
         ,AUD_MODIFICADO_POR
         from GAT_TPLT_SOURCE
         WHERE ' || p_where;

      LOOP
         FETCH v_cursor
         INTO p_gat_tplt_source (p_gat_tplt_source.COUNT + 1);

         EXIT WHEN v_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cursor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;
END gat_tplt_source_qp;
/
SHOW ERRORS;


