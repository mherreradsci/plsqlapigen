CREATE OR REPLACE PACKAGE BODY GAT.app_aplicaciones_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     APP_APLICACIONES_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               APP_APLICACIONES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de APP_APLICACIONES basado en la PK
   FUNCTION existe (p_appl_id IN app_aplicaciones_tp.appl_id_t)
      RETURN BOOLEAN
   IS
      CURSOR un_registro
      IS
         SELECT NULL
         FROM app_aplicaciones
         WHERE appl_id = p_appl_id;

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
         utl_error.informa (p_programa   => 'APP_APLICACIONES_QP.existe',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END existe;

   -- Funcion para obtener la cantidad de registros de la tabla APP_APLICACIONES a partir de la pk
   FUNCTION cuenta_por_pk (p_appl_id IN app_aplicaciones_tp.appl_id_t)
      RETURN PLS_INTEGER
   IS
      v_cantidad   PLS_INTEGER;
   BEGIN
      SELECT COUNT (*)
      INTO v_cantidad
      FROM app_aplicaciones
      WHERE appl_id = p_appl_id;

      RETURN v_cantidad;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_QP.cuenta_por_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END cuenta_por_pk;

   -- Consulta un registro de APP_APLICACIONES basado en la constraint APPL_PK
   PROCEDURE sel_appl_pk (
      p_appl_id            IN            app_aplicaciones_tp.appl_id_t,
      p_app_aplicaciones      OUT NOCOPY app_aplicaciones_tp.app_aplicaciones_rt)
   IS
      CURSOR c_app_aplicaciones
      IS
         SELECT appl_id,
                nombre_corto,
                nombre,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM app_aplicaciones
         WHERE appl_id = p_appl_id;

      v_found   BOOLEAN;
   BEGIN
      OPEN c_app_aplicaciones;

      FETCH c_app_aplicaciones
      INTO p_app_aplicaciones;

      v_found := c_app_aplicaciones%FOUND;

      CLOSE c_app_aplicaciones;

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
         utl_error.informa (p_programa   => 'APP_APLICACIONES_QP.sel_APPL_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_appl_pk;

   -- Consulta el registro de APP_APLICACIONES basado en la PK
   FUNCTION sel_pk (p_appl_id IN app_aplicaciones_tp.appl_id_t)
      RETURN app_aplicaciones_tp.app_aplicaciones_rt
   IS
      v_app_aplicaciones   app_aplicaciones_tp.app_aplicaciones_rt;

      CURSOR c_app_aplicaciones
      IS
         SELECT appl_id,
                nombre_corto,
                nombre,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM app_aplicaciones
         WHERE appl_id = p_appl_id;
   BEGIN
      OPEN c_app_aplicaciones;

      FETCH c_app_aplicaciones
      INTO v_app_aplicaciones;

      CLOSE c_app_aplicaciones;

      RETURN v_app_aplicaciones;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_QP.sel_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_pk;

   -- Obtiene un cursor via una consulta sobre la constraint APPL_PK de la tabla APP_APLICACIONES
   FUNCTION sel_appl_pk (p_appl_id IN app_aplicaciones_tp.appl_id_t)
      RETURN app_aplicaciones_tp.app_aplicaciones_rc
   IS
      cu_app_aplicaciones   app_aplicaciones_tp.app_aplicaciones_rc;
   BEGIN
      OPEN cu_app_aplicaciones FOR
         SELECT appl_id,
                nombre_corto,
                nombre,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM app_aplicaciones
         WHERE appl_id = p_appl_id;

      RETURN cu_app_aplicaciones;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_QP.sel_APPL_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_appl_pk;

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla APP_APLICACIONES
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN app_aplicaciones_tp.app_aplicaciones_rc
   IS
      c_app_aplicaciones   app_aplicaciones_tp.app_aplicaciones_rc;
   BEGIN
      OPEN c_app_aplicaciones FOR '
      select
      APPL_ID
      ,NOMBRE_CORTO
      ,NOMBRE
      ,AUD_CREADO_EN
      ,AUD_CREADO_POR
      ,AUD_MODIFICADO_EN
      ,AUD_MODIFICADO_POR
      from APP_APLICACIONES
      WHERE ' || p_where;

      RETURN c_app_aplicaciones;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;

   -- Obtiene una tabla (index by) con los registros de la tabla APP_APLICACIONES
   PROCEDURE sel_where (
      p_where                            VARCHAR2,
      p_app_aplicaciones   IN OUT NOCOPY app_aplicaciones_tp.app_aplicaciones_ct)
   IS
      TYPE cursor_rc IS REF CURSOR;

      v_cursor   cursor_rc;
   BEGIN
      OPEN v_cursor FOR '
         select
         APPL_ID
         ,NOMBRE_CORTO
         ,NOMBRE
         ,AUD_CREADO_EN
         ,AUD_CREADO_POR
         ,AUD_MODIFICADO_EN
         ,AUD_MODIFICADO_POR
         from APP_APLICACIONES
         WHERE ' || p_where;

      LOOP
         FETCH v_cursor
         INTO p_app_aplicaciones (p_app_aplicaciones.COUNT + 1);

         EXIT WHEN v_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cursor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;
END app_aplicaciones_qp;
/
SHOW ERRORS;


