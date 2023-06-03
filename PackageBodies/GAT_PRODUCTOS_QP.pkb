CREATE OR REPLACE PACKAGE BODY GAT.gat_productos_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_PRODUCTOS_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_PRODUCTOS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_PRODUCTOS basado en la PK
   FUNCTION existe (p_prod_id IN gat_productos_tp.prod_id_t)
      RETURN BOOLEAN
   IS
      CURSOR un_registro
      IS
         SELECT NULL
         FROM gat_productos
         WHERE prod_id = p_prod_id;

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
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_QP.existe',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END existe;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_PRODUCTOS a partir de la pk
   FUNCTION cuenta_por_pk (p_prod_id IN gat_productos_tp.prod_id_t)
      RETURN PLS_INTEGER
   IS
      v_cantidad   PLS_INTEGER;
   BEGIN
      SELECT COUNT (*)
      INTO v_cantidad
      FROM gat_productos
      WHERE prod_id = p_prod_id;

      RETURN v_cantidad;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_QP.cuenta_por_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END cuenta_por_pk;

   -- Consulta un registro de GAT_PRODUCTOS basado en la constraint PROD_PK
   PROCEDURE sel_prod_pk (
      p_prod_id         IN            gat_productos_tp.prod_id_t,
      p_gat_productos      OUT NOCOPY gat_productos_tp.gat_productos_rt)
   IS
      CURSOR c_gat_productos
      IS
         SELECT prod_id,
                clie_id,
                appl_id,
                perf_id,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_productos
         WHERE prod_id = p_prod_id;

      v_found   BOOLEAN;
   BEGIN
      OPEN c_gat_productos;

      FETCH c_gat_productos
      INTO p_gat_productos;

      v_found := c_gat_productos%FOUND;

      CLOSE c_gat_productos;

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
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_QP.sel_PROD_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_prod_pk;

   -- Consulta el registro de GAT_PRODUCTOS basado en la PK
   FUNCTION sel_pk (p_prod_id IN gat_productos_tp.prod_id_t)
      RETURN gat_productos_tp.gat_productos_rt
   IS
      v_gat_productos   gat_productos_tp.gat_productos_rt;

      CURSOR c_gat_productos
      IS
         SELECT prod_id,
                clie_id,
                appl_id,
                perf_id,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_productos
         WHERE prod_id = p_prod_id;
   BEGIN
      OPEN c_gat_productos;

      FETCH c_gat_productos
      INTO v_gat_productos;

      CLOSE c_gat_productos;

      RETURN v_gat_productos;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_QP.sel_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_pk;

   -- Obtiene un cursor via una consulta sobre la constraint PROD_PK de la tabla GAT_PRODUCTOS
   FUNCTION sel_prod_pk (p_prod_id IN gat_productos_tp.prod_id_t)
      RETURN gat_productos_tp.gat_productos_rc
   IS
      cu_gat_productos   gat_productos_tp.gat_productos_rc;
   BEGIN
      OPEN cu_gat_productos FOR
         SELECT prod_id,
                clie_id,
                appl_id,
                perf_id,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_productos
         WHERE prod_id = p_prod_id;

      RETURN cu_gat_productos;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_QP.sel_PROD_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_prod_pk;

   -- Obtiene un cursor via una consulta sobre la constraint PROD_PERF_FK3 de la tabla GAT_PRODUCTOS
   FUNCTION sel_prod_perf_fk3 (p_perf_id IN gat_productos_tp.perf_id_t)
      RETURN gat_productos_tp.gat_productos_rc
   IS
      cu_gat_productos   gat_productos_tp.gat_productos_rc;
   BEGIN
      OPEN cu_gat_productos FOR
         SELECT prod_id,
                clie_id,
                appl_id,
                perf_id,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_productos
         WHERE perf_id = p_perf_id;

      RETURN cu_gat_productos;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_QP.sel_PROD_PERF_FK3',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_prod_perf_fk3;

   -- Obtiene un cursor via una consulta sobre la constraint PROD_APPL_FK1 de la tabla GAT_PRODUCTOS
   FUNCTION sel_prod_appl_fk1 (p_appl_id IN gat_productos_tp.appl_id_t)
      RETURN gat_productos_tp.gat_productos_rc
   IS
      cu_gat_productos   gat_productos_tp.gat_productos_rc;
   BEGIN
      OPEN cu_gat_productos FOR
         SELECT prod_id,
                clie_id,
                appl_id,
                perf_id,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_productos
         WHERE appl_id = p_appl_id;

      RETURN cu_gat_productos;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_QP.sel_PROD_APPL_FK1',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_prod_appl_fk1;

   -- Obtiene un cursor via una consulta sobre la constraint PROD_CLIE_FK2 de la tabla GAT_PRODUCTOS
   FUNCTION sel_prod_clie_fk2 (p_clie_id IN gat_productos_tp.clie_id_t)
      RETURN gat_productos_tp.gat_productos_rc
   IS
      cu_gat_productos   gat_productos_tp.gat_productos_rc;
   BEGIN
      OPEN cu_gat_productos FOR
         SELECT prod_id,
                clie_id,
                appl_id,
                perf_id,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_productos
         WHERE clie_id = p_clie_id;

      RETURN cu_gat_productos;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_QP.sel_PROD_CLIE_FK2',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_prod_clie_fk2;

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_PRODUCTOS
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_productos_tp.gat_productos_rc
   IS
      c_gat_productos   gat_productos_tp.gat_productos_rc;
   BEGIN
      OPEN c_gat_productos FOR '
      select
      PROD_ID
      ,CLIE_ID
      ,APPL_ID
      ,PERF_ID
      ,AUD_CREADO_EN
      ,AUD_CREADO_POR
      ,AUD_MODIFICADO_EN
      ,AUD_MODIFICADO_POR
      from GAT_PRODUCTOS
      WHERE ' || p_where;

      RETURN c_gat_productos;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_PRODUCTOS
   PROCEDURE sel_where (
      p_where                         VARCHAR2,
      p_gat_productos   IN OUT NOCOPY gat_productos_tp.gat_productos_ct)
   IS
      TYPE cursor_rc IS REF CURSOR;

      v_cursor   cursor_rc;
   BEGIN
      OPEN v_cursor FOR '
         select
         PROD_ID
         ,CLIE_ID
         ,APPL_ID
         ,PERF_ID
         ,AUD_CREADO_EN
         ,AUD_CREADO_POR
         ,AUD_MODIFICADO_EN
         ,AUD_MODIFICADO_POR
         from GAT_PRODUCTOS
         WHERE ' || p_where;

      LOOP
         FETCH v_cursor
         INTO p_gat_productos (p_gat_productos.COUNT + 1);

         EXIT WHEN v_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cursor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;
END gat_productos_qp;
/
SHOW ERRORS;


