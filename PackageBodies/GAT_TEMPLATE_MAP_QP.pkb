CREATE OR REPLACE PACKAGE BODY GAT.gat_template_map_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TEMPLATE_MAP_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_TEMPLATE_MAP
   Descipción de la tabla:
   Mapa de template

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_TEMPLATE_MAP basado en la PK
   FUNCTION existe (p_perf_id       IN gat_template_map_tp.perf_id_t,
                    p_ttem_codigo   IN gat_template_map_tp.ttem_codigo_t,
                    p_para_code     IN gat_template_map_tp.para_code_t)
      RETURN BOOLEAN
   IS
      CURSOR un_registro
      IS
         SELECT NULL
         FROM gat_template_map
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND para_code = p_para_code;

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
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_QP.existe',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END existe;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_TEMPLATE_MAP a partir de la pk
   FUNCTION cuenta_por_pk (p_perf_id       IN gat_template_map_tp.perf_id_t,
                           p_ttem_codigo   IN gat_template_map_tp.ttem_codigo_t,
                           p_para_code     IN gat_template_map_tp.para_code_t)
      RETURN PLS_INTEGER
   IS
      v_cantidad   PLS_INTEGER;
   BEGIN
      SELECT COUNT (*)
      INTO v_cantidad
      FROM gat_template_map
      WHERE perf_id = p_perf_id
        AND ttem_codigo = p_ttem_codigo
        AND para_code = p_para_code;

      RETURN v_cantidad;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_QP.cuenta_por_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END cuenta_por_pk;

   -- Consulta un registro de GAT_TEMPLATE_MAP basado en la constraint TEMA_PK
   PROCEDURE sel_tema_pk (
      p_perf_id            IN            gat_template_map_tp.perf_id_t,
      p_ttem_codigo        IN            gat_template_map_tp.ttem_codigo_t,
      p_para_code          IN            gat_template_map_tp.para_code_t,
      p_gat_template_map      OUT NOCOPY gat_template_map_tp.gat_template_map_rt)
   IS
      CURSOR c_gat_template_map
      IS
         SELECT perf_id,
                ttem_codigo,
                para_code,
                tipr_codigo,
                component,
                subcomponent,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_template_map
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND para_code = p_para_code;

      v_found   BOOLEAN;
   BEGIN
      OPEN c_gat_template_map;

      FETCH c_gat_template_map
      INTO p_gat_template_map;

      v_found := c_gat_template_map%FOUND;

      CLOSE c_gat_template_map;

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
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_QP.sel_TEMA_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tema_pk;

   -- Consulta el registro de GAT_TEMPLATE_MAP basado en la PK
   FUNCTION sel_pk (p_perf_id       IN gat_template_map_tp.perf_id_t,
                    p_ttem_codigo   IN gat_template_map_tp.ttem_codigo_t,
                    p_para_code     IN gat_template_map_tp.para_code_t)
      RETURN gat_template_map_tp.gat_template_map_rt
   IS
      v_gat_template_map   gat_template_map_tp.gat_template_map_rt;

      CURSOR c_gat_template_map
      IS
         SELECT perf_id,
                ttem_codigo,
                para_code,
                tipr_codigo,
                component,
                subcomponent,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_template_map
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND para_code = p_para_code;
   BEGIN
      OPEN c_gat_template_map;

      FETCH c_gat_template_map
      INTO v_gat_template_map;

      CLOSE c_gat_template_map;

      RETURN v_gat_template_map;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_QP.sel_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_pk;

   -- Obtiene un cursor via una consulta sobre la constraint TEMA_PK de la tabla GAT_TEMPLATE_MAP
   FUNCTION sel_tema_pk (p_perf_id       IN gat_template_map_tp.perf_id_t,
                         p_ttem_codigo   IN gat_template_map_tp.ttem_codigo_t,
                         p_para_code     IN gat_template_map_tp.para_code_t)
      RETURN gat_template_map_tp.gat_template_map_rc
   IS
      cu_gat_template_map   gat_template_map_tp.gat_template_map_rc;
   BEGIN
      OPEN cu_gat_template_map FOR
         SELECT perf_id,
                ttem_codigo,
                para_code,
                tipr_codigo,
                component,
                subcomponent,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_template_map
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND para_code = p_para_code;

      RETURN cu_gat_template_map;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_QP.sel_TEMA_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tema_pk;

   -- Obtiene un cursor via una consulta sobre la constraint TEMA_TPLT_FK2 de la tabla GAT_TEMPLATE_MAP
   FUNCTION sel_tema_tplt_fk2 (p_perf_id       IN gat_template_map_tp.perf_id_t,
                               p_ttem_codigo   IN gat_template_map_tp.ttem_codigo_t)
      RETURN gat_template_map_tp.gat_template_map_rc
   IS
      cu_gat_template_map   gat_template_map_tp.gat_template_map_rc;
   BEGIN
      OPEN cu_gat_template_map FOR
         SELECT perf_id,
                ttem_codigo,
                para_code,
                tipr_codigo,
                component,
                subcomponent,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_template_map
         WHERE perf_id = p_perf_id AND ttem_codigo = p_ttem_codigo;

      RETURN cu_gat_template_map;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_QP.sel_TEMA_TPLT_FK2',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tema_tplt_fk2;

   -- Obtiene un cursor via una consulta sobre la constraint TEMA_TPAR_FK1 de la tabla GAT_TEMPLATE_MAP
   FUNCTION sel_tema_tpar_fk1 (p_tipr_codigo IN gat_template_map_tp.tipr_codigo_t)
      RETURN gat_template_map_tp.gat_template_map_rc
   IS
      cu_gat_template_map   gat_template_map_tp.gat_template_map_rc;
   BEGIN
      OPEN cu_gat_template_map FOR
         SELECT perf_id,
                ttem_codigo,
                para_code,
                tipr_codigo,
                component,
                subcomponent,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_template_map
         WHERE tipr_codigo = p_tipr_codigo;

      RETURN cu_gat_template_map;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_QP.sel_TEMA_TPAR_FK1',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tema_tpar_fk1;

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_TEMPLATE_MAP
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_template_map_tp.gat_template_map_rc
   IS
      c_gat_template_map   gat_template_map_tp.gat_template_map_rc;
   BEGIN
      OPEN c_gat_template_map FOR '
      select
      PERF_ID
      ,TTEM_CODIGO
      ,PARA_CODE
      ,TIPR_CODIGO
      ,COMPONENT
      ,SUBCOMPONENT
      ,AUD_CREADO_EN
      ,AUD_CREADO_POR
      ,AUD_MODIFICADO_EN
      ,AUD_MODIFICADO_POR
      from GAT_TEMPLATE_MAP
      WHERE ' || p_where;

      RETURN c_gat_template_map;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_TEMPLATE_MAP
   PROCEDURE sel_where (
      p_where                            VARCHAR2,
      p_gat_template_map   IN OUT NOCOPY gat_template_map_tp.gat_template_map_ct)
   IS
      TYPE cursor_rc IS REF CURSOR;

      v_cursor   cursor_rc;
   BEGIN
      OPEN v_cursor FOR '
         select
         PERF_ID
         ,TTEM_CODIGO
         ,PARA_CODE
         ,TIPR_CODIGO
         ,COMPONENT
         ,SUBCOMPONENT
         ,AUD_CREADO_EN
         ,AUD_CREADO_POR
         ,AUD_MODIFICADO_EN
         ,AUD_MODIFICADO_POR
         from GAT_TEMPLATE_MAP
         WHERE ' || p_where;

      LOOP
         FETCH v_cursor
         INTO p_gat_template_map (p_gat_template_map.COUNT + 1);

         EXIT WHEN v_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cursor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;
END gat_template_map_qp;
/
SHOW ERRORS;


