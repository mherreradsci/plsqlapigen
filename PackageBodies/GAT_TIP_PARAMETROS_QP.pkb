CREATE OR REPLACE PACKAGE BODY GAT.gat_tip_parametros_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_PARAMETROS_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_TIP_PARAMETROS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_TIP_PARAMETROS basado en la PK
   FUNCTION existe (p_tipr_codigo IN gat_tip_parametros_tp.tipr_codigo_t)
      RETURN BOOLEAN
   IS
      CURSOR un_registro
      IS
         SELECT NULL
         FROM gat_tip_parametros
         WHERE tipr_codigo = p_tipr_codigo;

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
         utl_error.informa (p_programa   => 'GAT_TIP_PARAMETROS_QP.existe',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END existe;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_TIP_PARAMETROS a partir de la pk
   FUNCTION cuenta_por_pk (p_tipr_codigo IN gat_tip_parametros_tp.tipr_codigo_t)
      RETURN PLS_INTEGER
   IS
      v_cantidad   PLS_INTEGER;
   BEGIN
      SELECT COUNT (*)
      INTO v_cantidad
      FROM gat_tip_parametros
      WHERE tipr_codigo = p_tipr_codigo;

      RETURN v_cantidad;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PARAMETROS_QP.cuenta_por_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END cuenta_por_pk;

   -- Consulta un registro de GAT_TIP_PARAMETROS basado en la constraint TPAR_PK
   PROCEDURE sel_tpar_pk (
      p_tipr_codigo          IN            gat_tip_parametros_tp.tipr_codigo_t,
      p_gat_tip_parametros      OUT NOCOPY gat_tip_parametros_tp.gat_tip_parametros_rt)
   IS
      CURSOR c_gat_tip_parametros
      IS
         SELECT tipr_codigo,
                nombre,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_tip_parametros
         WHERE tipr_codigo = p_tipr_codigo;

      v_found   BOOLEAN;
   BEGIN
      OPEN c_gat_tip_parametros;

      FETCH c_gat_tip_parametros
      INTO p_gat_tip_parametros;

      v_found := c_gat_tip_parametros%FOUND;

      CLOSE c_gat_tip_parametros;

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
         utl_error.informa (p_programa   => 'GAT_TIP_PARAMETROS_QP.sel_TPAR_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tpar_pk;

   -- Consulta el registro de GAT_TIP_PARAMETROS basado en la PK
   FUNCTION sel_pk (p_tipr_codigo IN gat_tip_parametros_tp.tipr_codigo_t)
      RETURN gat_tip_parametros_tp.gat_tip_parametros_rt
   IS
      v_gat_tip_parametros   gat_tip_parametros_tp.gat_tip_parametros_rt;

      CURSOR c_gat_tip_parametros
      IS
         SELECT tipr_codigo,
                nombre,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_tip_parametros
         WHERE tipr_codigo = p_tipr_codigo;
   BEGIN
      OPEN c_gat_tip_parametros;

      FETCH c_gat_tip_parametros
      INTO v_gat_tip_parametros;

      CLOSE c_gat_tip_parametros;

      RETURN v_gat_tip_parametros;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PARAMETROS_QP.sel_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_pk;

   -- Obtiene un cursor via una consulta sobre la constraint TPAR_PK de la tabla GAT_TIP_PARAMETROS
   FUNCTION sel_tpar_pk (p_tipr_codigo IN gat_tip_parametros_tp.tipr_codigo_t)
      RETURN gat_tip_parametros_tp.gat_tip_parametros_rc
   IS
      cu_gat_tip_parametros   gat_tip_parametros_tp.gat_tip_parametros_rc;
   BEGIN
      OPEN cu_gat_tip_parametros FOR
         SELECT tipr_codigo,
                nombre,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_tip_parametros
         WHERE tipr_codigo = p_tipr_codigo;

      RETURN cu_gat_tip_parametros;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PARAMETROS_QP.sel_TPAR_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tpar_pk;

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_TIP_PARAMETROS
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_tip_parametros_tp.gat_tip_parametros_rc
   IS
      c_gat_tip_parametros   gat_tip_parametros_tp.gat_tip_parametros_rc;
   BEGIN
      OPEN c_gat_tip_parametros FOR '
      select
      TIPR_CODIGO
      ,NOMBRE
      ,AUD_CREADO_EN
      ,AUD_CREADO_POR
      ,AUD_MODIFICADO_EN
      ,AUD_MODIFICADO_POR
      from GAT_TIP_PARAMETROS
      WHERE ' || p_where;

      RETURN c_gat_tip_parametros;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PARAMETROS_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_TIP_PARAMETROS
   PROCEDURE sel_where (
      p_where                              VARCHAR2,
      p_gat_tip_parametros   IN OUT NOCOPY gat_tip_parametros_tp.gat_tip_parametros_ct)
   IS
      TYPE cursor_rc IS REF CURSOR;

      v_cursor   cursor_rc;
   BEGIN
      OPEN v_cursor FOR '
         select
         TIPR_CODIGO
         ,NOMBRE
         ,AUD_CREADO_EN
         ,AUD_CREADO_POR
         ,AUD_MODIFICADO_EN
         ,AUD_MODIFICADO_POR
         from GAT_TIP_PARAMETROS
         WHERE ' || p_where;

      LOOP
         FETCH v_cursor
         INTO p_gat_tip_parametros (p_gat_tip_parametros.COUNT + 1);

         EXIT WHEN v_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cursor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PARAMETROS_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;
END gat_tip_parametros_qp;
/
SHOW ERRORS;


