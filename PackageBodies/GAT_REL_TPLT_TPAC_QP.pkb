CREATE OR REPLACE PACKAGE BODY GAT.gat_rel_tplt_tpac_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_REL_TPLT_TPAC_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_REL_TPLT_TPAC
   Descipción de la tabla:
   Relación entre los Templates y Tipos de packages

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_REL_TPLT_TPAC basado en la PK
   FUNCTION existe (p_perf_id       IN gat_rel_tplt_tpac_tp.perf_id_t,
                    p_ttem_codigo   IN gat_rel_tplt_tpac_tp.ttem_codigo_t,
                    p_tpac_codigo   IN gat_rel_tplt_tpac_tp.tpac_codigo_t)
      RETURN BOOLEAN
   IS
      CURSOR un_registro
      IS
         SELECT NULL
         FROM gat_rel_tplt_tpac
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND tpac_codigo = p_tpac_codigo;

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
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_QP.existe',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END existe;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_REL_TPLT_TPAC a partir de la pk
   FUNCTION cuenta_por_pk (p_perf_id       IN gat_rel_tplt_tpac_tp.perf_id_t,
                           p_ttem_codigo   IN gat_rel_tplt_tpac_tp.ttem_codigo_t,
                           p_tpac_codigo   IN gat_rel_tplt_tpac_tp.tpac_codigo_t)
      RETURN PLS_INTEGER
   IS
      v_cantidad   PLS_INTEGER;
   BEGIN
      SELECT COUNT (*)
      INTO v_cantidad
      FROM gat_rel_tplt_tpac
      WHERE perf_id = p_perf_id
        AND ttem_codigo = p_ttem_codigo
        AND tpac_codigo = p_tpac_codigo;

      RETURN v_cantidad;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_QP.cuenta_por_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END cuenta_por_pk;

   -- Consulta un registro de GAT_REL_TPLT_TPAC basado en la constraint TPTP_PK
   PROCEDURE sel_tptp_pk (
      p_perf_id             IN            gat_rel_tplt_tpac_tp.perf_id_t,
      p_ttem_codigo         IN            gat_rel_tplt_tpac_tp.ttem_codigo_t,
      p_tpac_codigo         IN            gat_rel_tplt_tpac_tp.tpac_codigo_t,
      p_gat_rel_tplt_tpac      OUT NOCOPY gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rt)
   IS
      CURSOR c_gat_rel_tplt_tpac
      IS
         SELECT perf_id,
                ttem_codigo,
                tpac_codigo,
                descripcion,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_rel_tplt_tpac
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND tpac_codigo = p_tpac_codigo;

      v_found   BOOLEAN;
   BEGIN
      OPEN c_gat_rel_tplt_tpac;

      FETCH c_gat_rel_tplt_tpac
      INTO p_gat_rel_tplt_tpac;

      v_found := c_gat_rel_tplt_tpac%FOUND;

      CLOSE c_gat_rel_tplt_tpac;

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
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_QP.sel_TPTP_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tptp_pk;

   -- Consulta el registro de GAT_REL_TPLT_TPAC basado en la PK
   FUNCTION sel_pk (p_perf_id       IN gat_rel_tplt_tpac_tp.perf_id_t,
                    p_ttem_codigo   IN gat_rel_tplt_tpac_tp.ttem_codigo_t,
                    p_tpac_codigo   IN gat_rel_tplt_tpac_tp.tpac_codigo_t)
      RETURN gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rt
   IS
      v_gat_rel_tplt_tpac   gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rt;

      CURSOR c_gat_rel_tplt_tpac
      IS
         SELECT perf_id,
                ttem_codigo,
                tpac_codigo,
                descripcion,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_rel_tplt_tpac
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND tpac_codigo = p_tpac_codigo;
   BEGIN
      OPEN c_gat_rel_tplt_tpac;

      FETCH c_gat_rel_tplt_tpac
      INTO v_gat_rel_tplt_tpac;

      CLOSE c_gat_rel_tplt_tpac;

      RETURN v_gat_rel_tplt_tpac;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_QP.sel_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_pk;

   -- Obtiene un cursor via una consulta sobre la constraint TPTP_PK de la tabla GAT_REL_TPLT_TPAC
   FUNCTION sel_tptp_pk (p_perf_id       IN gat_rel_tplt_tpac_tp.perf_id_t,
                         p_ttem_codigo   IN gat_rel_tplt_tpac_tp.ttem_codigo_t,
                         p_tpac_codigo   IN gat_rel_tplt_tpac_tp.tpac_codigo_t)
      RETURN gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rc
   IS
      cu_gat_rel_tplt_tpac   gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rc;
   BEGIN
      OPEN cu_gat_rel_tplt_tpac FOR
         SELECT perf_id,
                ttem_codigo,
                tpac_codigo,
                descripcion,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_rel_tplt_tpac
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND tpac_codigo = p_tpac_codigo;

      RETURN cu_gat_rel_tplt_tpac;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_QP.sel_TPTP_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tptp_pk;

   -- Obtiene un cursor via una consulta sobre la constraint TPTP_TPLT_FK2 de la tabla GAT_REL_TPLT_TPAC
   FUNCTION sel_tptp_tplt_fk2 (p_perf_id       IN gat_rel_tplt_tpac_tp.perf_id_t,
                               p_ttem_codigo   IN gat_rel_tplt_tpac_tp.ttem_codigo_t)
      RETURN gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rc
   IS
      cu_gat_rel_tplt_tpac   gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rc;
   BEGIN
      OPEN cu_gat_rel_tplt_tpac FOR
         SELECT perf_id,
                ttem_codigo,
                tpac_codigo,
                descripcion,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_rel_tplt_tpac
         WHERE perf_id = p_perf_id AND ttem_codigo = p_ttem_codigo;

      RETURN cu_gat_rel_tplt_tpac;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_QP.sel_TPTP_TPLT_FK2',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tptp_tplt_fk2;

   -- Obtiene un cursor via una consulta sobre la constraint TPTP_TPAC_FK1 de la tabla GAT_REL_TPLT_TPAC
   FUNCTION sel_tptp_tpac_fk1 (p_tpac_codigo IN gat_rel_tplt_tpac_tp.tpac_codigo_t)
      RETURN gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rc
   IS
      cu_gat_rel_tplt_tpac   gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rc;
   BEGIN
      OPEN cu_gat_rel_tplt_tpac FOR
         SELECT perf_id,
                ttem_codigo,
                tpac_codigo,
                descripcion,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_rel_tplt_tpac
         WHERE tpac_codigo = p_tpac_codigo;

      RETURN cu_gat_rel_tplt_tpac;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_QP.sel_TPTP_TPAC_FK1',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tptp_tpac_fk1;

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_REL_TPLT_TPAC
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rc
   IS
      c_gat_rel_tplt_tpac   gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rc;
   BEGIN
      OPEN c_gat_rel_tplt_tpac FOR '
      select
      PERF_ID
      ,TTEM_CODIGO
      ,TPAC_CODIGO
      ,DESCRIPCION
      ,AUD_CREADO_EN
      ,AUD_CREADO_POR
      ,AUD_MODIFICADO_EN
      ,AUD_MODIFICADO_POR
      from GAT_REL_TPLT_TPAC
      WHERE ' || p_where;

      RETURN c_gat_rel_tplt_tpac;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_REL_TPLT_TPAC
   PROCEDURE sel_where (
      p_where                             VARCHAR2,
      p_gat_rel_tplt_tpac   IN OUT NOCOPY gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_ct)
   IS
      TYPE cursor_rc IS REF CURSOR;

      v_cursor   cursor_rc;
   BEGIN
      OPEN v_cursor FOR '
         select
         PERF_ID
         ,TTEM_CODIGO
         ,TPAC_CODIGO
         ,DESCRIPCION
         ,AUD_CREADO_EN
         ,AUD_CREADO_POR
         ,AUD_MODIFICADO_EN
         ,AUD_MODIFICADO_POR
         from GAT_REL_TPLT_TPAC
         WHERE ' || p_where;

      LOOP
         FETCH v_cursor
         INTO p_gat_rel_tplt_tpac (p_gat_rel_tplt_tpac.COUNT + 1);

         EXIT WHEN v_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cursor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;
END gat_rel_tplt_tpac_qp;
/
SHOW ERRORS;


