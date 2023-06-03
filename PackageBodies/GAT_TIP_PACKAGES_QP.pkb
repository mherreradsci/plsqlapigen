CREATE OR REPLACE PACKAGE BODY GAT.gat_tip_packages_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_PACKAGES_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_TIP_PACKAGES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_TIP_PACKAGES basado en la PK
   FUNCTION existe (p_tpac_codigo IN gat_tip_packages_tp.tpac_codigo_t)
      RETURN BOOLEAN
   IS
      CURSOR un_registro
      IS
         SELECT NULL
         FROM gat_tip_packages
         WHERE tpac_codigo = p_tpac_codigo;

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
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_QP.existe',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END existe;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_TIP_PACKAGES a partir de la pk
   FUNCTION cuenta_por_pk (p_tpac_codigo IN gat_tip_packages_tp.tpac_codigo_t)
      RETURN PLS_INTEGER
   IS
      v_cantidad   PLS_INTEGER;
   BEGIN
      SELECT COUNT (*)
      INTO v_cantidad
      FROM gat_tip_packages
      WHERE tpac_codigo = p_tpac_codigo;

      RETURN v_cantidad;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_QP.cuenta_por_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END cuenta_por_pk;

   -- Consulta un registro de GAT_TIP_PACKAGES basado en la constraint TPAC_PK
   PROCEDURE sel_tpac_pk (
      p_tpac_codigo        IN            gat_tip_packages_tp.tpac_codigo_t,
      p_gat_tip_packages      OUT NOCOPY gat_tip_packages_tp.gat_tip_packages_rt)
   IS
      CURSOR c_gat_tip_packages
      IS
         SELECT tpac_codigo,
                nombre,
                glosa,
                generado,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_tip_packages
         WHERE tpac_codigo = p_tpac_codigo;

      v_found   BOOLEAN;
   BEGIN
      OPEN c_gat_tip_packages;

      FETCH c_gat_tip_packages
      INTO p_gat_tip_packages;

      v_found := c_gat_tip_packages%FOUND;

      CLOSE c_gat_tip_packages;

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
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_QP.sel_TPAC_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tpac_pk;

   -- Consulta el registro de GAT_TIP_PACKAGES basado en la PK
   FUNCTION sel_pk (p_tpac_codigo IN gat_tip_packages_tp.tpac_codigo_t)
      RETURN gat_tip_packages_tp.gat_tip_packages_rt
   IS
      v_gat_tip_packages   gat_tip_packages_tp.gat_tip_packages_rt;

      CURSOR c_gat_tip_packages
      IS
         SELECT tpac_codigo,
                nombre,
                glosa,
                generado,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_tip_packages
         WHERE tpac_codigo = p_tpac_codigo;
   BEGIN
      OPEN c_gat_tip_packages;

      FETCH c_gat_tip_packages
      INTO v_gat_tip_packages;

      CLOSE c_gat_tip_packages;

      RETURN v_gat_tip_packages;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_QP.sel_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_pk;

   -- Obtiene un cursor via una consulta sobre la constraint TPAC_PK de la tabla GAT_TIP_PACKAGES
   FUNCTION sel_tpac_pk (p_tpac_codigo IN gat_tip_packages_tp.tpac_codigo_t)
      RETURN gat_tip_packages_tp.gat_tip_packages_rc
   IS
      cu_gat_tip_packages   gat_tip_packages_tp.gat_tip_packages_rc;
   BEGIN
      OPEN cu_gat_tip_packages FOR
         SELECT tpac_codigo,
                nombre,
                glosa,
                generado,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_tip_packages
         WHERE tpac_codigo = p_tpac_codigo;

      RETURN cu_gat_tip_packages;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_QP.sel_TPAC_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_tpac_pk;

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_TIP_PACKAGES
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_tip_packages_tp.gat_tip_packages_rc
   IS
      c_gat_tip_packages   gat_tip_packages_tp.gat_tip_packages_rc;
   BEGIN
      OPEN c_gat_tip_packages FOR '
      select
      TPAC_CODIGO
      ,NOMBRE
      ,GLOSA
      ,GENERADO
      ,AUD_CREADO_EN
      ,AUD_CREADO_POR
      ,AUD_MODIFICADO_EN
      ,AUD_MODIFICADO_POR
      from GAT_TIP_PACKAGES
      WHERE ' || p_where;

      RETURN c_gat_tip_packages;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_TIP_PACKAGES
   PROCEDURE sel_where (
      p_where                            VARCHAR2,
      p_gat_tip_packages   IN OUT NOCOPY gat_tip_packages_tp.gat_tip_packages_ct)
   IS
      TYPE cursor_rc IS REF CURSOR;

      v_cursor   cursor_rc;
   BEGIN
      OPEN v_cursor FOR '
         select
         TPAC_CODIGO
         ,NOMBRE
         ,GLOSA
         ,GENERADO
         ,AUD_CREADO_EN
         ,AUD_CREADO_POR
         ,AUD_MODIFICADO_EN
         ,AUD_MODIFICADO_POR
         from GAT_TIP_PACKAGES
         WHERE ' || p_where;

      LOOP
         FETCH v_cursor
         INTO p_gat_tip_packages (p_gat_tip_packages.COUNT + 1);

         EXIT WHEN v_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cursor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;
END gat_tip_packages_qp;
/
SHOW ERRORS;


