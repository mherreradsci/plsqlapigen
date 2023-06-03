CREATE OR REPLACE PACKAGE BODY GAT.gat_objetos_generados_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_OBJETOS_GENERADOS_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_OBJETOS_GENERADOS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_OBJETOS_GENERADOS basado en la PK
   FUNCTION existe (p_prod_id         IN gat_objetos_generados_tp.prod_id_t,
                    p_nombre_objeto   IN gat_objetos_generados_tp.nombre_objeto_t,
                    p_tobj_codigo     IN gat_objetos_generados_tp.tobj_codigo_t)
      RETURN BOOLEAN
   IS
      CURSOR un_registro
      IS
         SELECT NULL
         FROM gat_objetos_generados
         WHERE prod_id = p_prod_id
           AND nombre_objeto = p_nombre_objeto
           AND tobj_codigo = p_tobj_codigo;

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
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_QP.existe',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END existe;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_OBJETOS_GENERADOS a partir de la pk
   FUNCTION cuenta_por_pk (p_prod_id         IN gat_objetos_generados_tp.prod_id_t,
                           p_nombre_objeto   IN gat_objetos_generados_tp.nombre_objeto_t,
                           p_tobj_codigo     IN gat_objetos_generados_tp.tobj_codigo_t)
      RETURN PLS_INTEGER
   IS
      v_cantidad   PLS_INTEGER;
   BEGIN
      SELECT COUNT (*)
      INTO v_cantidad
      FROM gat_objetos_generados
      WHERE prod_id = p_prod_id
        AND nombre_objeto = p_nombre_objeto
        AND tobj_codigo = p_tobj_codigo;

      RETURN v_cantidad;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_QP.cuenta_por_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END cuenta_por_pk;

   -- Consulta un registro de GAT_OBJETOS_GENERADOS basado en la constraint OBGE_PK
   PROCEDURE sel_obge_pk (
      p_prod_id                 IN            gat_objetos_generados_tp.prod_id_t,
      p_nombre_objeto           IN            gat_objetos_generados_tp.nombre_objeto_t,
      p_tobj_codigo             IN            gat_objetos_generados_tp.tobj_codigo_t,
      p_gat_objetos_generados      OUT NOCOPY gat_objetos_generados_tp.gat_objetos_generados_rt)
   IS
      CURSOR c_gat_objetos_generados
      IS
         SELECT prod_id,
                nombre_objeto,
                tobj_codigo,
                primera_generacion,
                ultima_generacion,
                version_generador,
                total_generaciones,
                compilado,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_objetos_generados
         WHERE prod_id = p_prod_id
           AND nombre_objeto = p_nombre_objeto
           AND tobj_codigo = p_tobj_codigo;

      v_found   BOOLEAN;
   BEGIN
      OPEN c_gat_objetos_generados;

      FETCH c_gat_objetos_generados
      INTO p_gat_objetos_generados;

      v_found := c_gat_objetos_generados%FOUND;

      CLOSE c_gat_objetos_generados;

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
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_QP.sel_OBGE_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_obge_pk;

   -- Consulta el registro de GAT_OBJETOS_GENERADOS basado en la PK
   FUNCTION sel_pk (p_prod_id         IN gat_objetos_generados_tp.prod_id_t,
                    p_nombre_objeto   IN gat_objetos_generados_tp.nombre_objeto_t,
                    p_tobj_codigo     IN gat_objetos_generados_tp.tobj_codigo_t)
      RETURN gat_objetos_generados_tp.gat_objetos_generados_rt
   IS
      v_gat_objetos_generados   gat_objetos_generados_tp.gat_objetos_generados_rt;

      CURSOR c_gat_objetos_generados
      IS
         SELECT prod_id,
                nombre_objeto,
                tobj_codigo,
                primera_generacion,
                ultima_generacion,
                version_generador,
                total_generaciones,
                compilado,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_objetos_generados
         WHERE prod_id = p_prod_id
           AND nombre_objeto = p_nombre_objeto
           AND tobj_codigo = p_tobj_codigo;
   BEGIN
      OPEN c_gat_objetos_generados;

      FETCH c_gat_objetos_generados
      INTO v_gat_objetos_generados;

      CLOSE c_gat_objetos_generados;

      RETURN v_gat_objetos_generados;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_QP.sel_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_pk;

   -- Obtiene un cursor via una consulta sobre la constraint OBGE_PK de la tabla GAT_OBJETOS_GENERADOS
   FUNCTION sel_obge_pk (p_prod_id         IN gat_objetos_generados_tp.prod_id_t,
                         p_nombre_objeto   IN gat_objetos_generados_tp.nombre_objeto_t,
                         p_tobj_codigo     IN gat_objetos_generados_tp.tobj_codigo_t)
      RETURN gat_objetos_generados_tp.gat_objetos_generados_rc
   IS
      cu_gat_objetos_generados   gat_objetos_generados_tp.gat_objetos_generados_rc;
   BEGIN
      OPEN cu_gat_objetos_generados FOR
         SELECT prod_id,
                nombre_objeto,
                tobj_codigo,
                primera_generacion,
                ultima_generacion,
                version_generador,
                total_generaciones,
                compilado,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_objetos_generados
         WHERE prod_id = p_prod_id
           AND nombre_objeto = p_nombre_objeto
           AND tobj_codigo = p_tobj_codigo;

      RETURN cu_gat_objetos_generados;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_QP.sel_OBGE_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_obge_pk;

   -- Obtiene un cursor via una consulta sobre la constraint OBGE_PROD_FK1 de la tabla GAT_OBJETOS_GENERADOS
   FUNCTION sel_obge_prod_fk1 (p_prod_id IN gat_objetos_generados_tp.prod_id_t)
      RETURN gat_objetos_generados_tp.gat_objetos_generados_rc
   IS
      cu_gat_objetos_generados   gat_objetos_generados_tp.gat_objetos_generados_rc;
   BEGIN
      OPEN cu_gat_objetos_generados FOR
         SELECT prod_id,
                nombre_objeto,
                tobj_codigo,
                primera_generacion,
                ultima_generacion,
                version_generador,
                total_generaciones,
                compilado,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_objetos_generados
         WHERE prod_id = p_prod_id;

      RETURN cu_gat_objetos_generados;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_QP.sel_OBGE_PROD_FK1',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_obge_prod_fk1;

   -- Obtiene un cursor via una consulta sobre la constraint OBGE_TOBJ_FK2 de la tabla GAT_OBJETOS_GENERADOS
   FUNCTION sel_obge_tobj_fk2 (p_tobj_codigo IN gat_objetos_generados_tp.tobj_codigo_t)
      RETURN gat_objetos_generados_tp.gat_objetos_generados_rc
   IS
      cu_gat_objetos_generados   gat_objetos_generados_tp.gat_objetos_generados_rc;
   BEGIN
      OPEN cu_gat_objetos_generados FOR
         SELECT prod_id,
                nombre_objeto,
                tobj_codigo,
                primera_generacion,
                ultima_generacion,
                version_generador,
                total_generaciones,
                compilado,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_objetos_generados
         WHERE tobj_codigo = p_tobj_codigo;

      RETURN cu_gat_objetos_generados;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_QP.sel_OBGE_TOBJ_FK2',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_obge_tobj_fk2;

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_OBJETOS_GENERADOS
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_objetos_generados_tp.gat_objetos_generados_rc
   IS
      c_gat_objetos_generados   gat_objetos_generados_tp.gat_objetos_generados_rc;
   BEGIN
      OPEN c_gat_objetos_generados FOR '
      select
      PROD_ID
      ,NOMBRE_OBJETO
      ,TOBJ_CODIGO
      ,PRIMERA_GENERACION
      ,ULTIMA_GENERACION
      ,VERSION_GENERADOR
      ,TOTAL_GENERACIONES
      ,COMPILADO
      ,AUD_CREADO_EN
      ,AUD_CREADO_POR
      ,AUD_MODIFICADO_EN
      ,AUD_MODIFICADO_POR
      from GAT_OBJETOS_GENERADOS
      WHERE ' || p_where;

      RETURN c_gat_objetos_generados;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_OBJETOS_GENERADOS
   PROCEDURE sel_where (
      p_where                                 VARCHAR2,
      p_gat_objetos_generados   IN OUT NOCOPY gat_objetos_generados_tp.gat_objetos_generados_ct)
   IS
      TYPE cursor_rc IS REF CURSOR;

      v_cursor   cursor_rc;
   BEGIN
      OPEN v_cursor FOR '
         select
         PROD_ID
         ,NOMBRE_OBJETO
         ,TOBJ_CODIGO
         ,PRIMERA_GENERACION
         ,ULTIMA_GENERACION
         ,VERSION_GENERADOR
         ,TOTAL_GENERACIONES
         ,COMPILADO
         ,AUD_CREADO_EN
         ,AUD_CREADO_POR
         ,AUD_MODIFICADO_EN
         ,AUD_MODIFICADO_POR
         from GAT_OBJETOS_GENERADOS
         WHERE ' || p_where;

      LOOP
         FETCH v_cursor
         INTO p_gat_objetos_generados (p_gat_objetos_generados.COUNT + 1);

         EXIT WHEN v_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cursor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;
END gat_objetos_generados_qp;
/
SHOW ERRORS;


