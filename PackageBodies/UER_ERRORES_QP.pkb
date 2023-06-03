CREATE OR REPLACE PACKAGE BODY GAT.uer_errores_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     UER_ERRORES_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               UER_ERRORES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de UER_ERRORES basado en la PK
   FUNCTION existe (p_erro_id IN uer_errores_tp.erro_id_t)
      RETURN BOOLEAN
   IS
      CURSOR un_registro
      IS
         SELECT NULL
         FROM uer_errores
         WHERE erro_id = p_erro_id;

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
         utl_error.informa (p_programa   => 'UER_ERRORES_QP.existe',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END existe;

   -- Funcion para obtener la cantidad de registros de la tabla UER_ERRORES a partir de la pk
   FUNCTION cuenta_por_pk (p_erro_id IN uer_errores_tp.erro_id_t)
      RETURN PLS_INTEGER
   IS
      v_cantidad   PLS_INTEGER;
   BEGIN
      SELECT COUNT (*)
      INTO v_cantidad
      FROM uer_errores
      WHERE erro_id = p_erro_id;

      RETURN v_cantidad;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_QP.cuenta_por_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END cuenta_por_pk;

   -- Consulta un registro de UER_ERRORES basado en la constraint ERRO_PK
   PROCEDURE sel_erro_pk (p_erro_id       IN            uer_errores_tp.erro_id_t,
                          p_uer_errores      OUT NOCOPY uer_errores_tp.uer_errores_rt)
   IS
      CURSOR c_uer_errores
      IS
         SELECT erro_id,
                programa,
                mensaje,
                aud_creado_por,
                aud_creado_en,
                aud_modificado_por,
                aud_modificado_en,
                lopr_id
         FROM uer_errores
         WHERE erro_id = p_erro_id;

      v_found   BOOLEAN;
   BEGIN
      OPEN c_uer_errores;

      FETCH c_uer_errores
      INTO p_uer_errores;

      v_found := c_uer_errores%FOUND;

      CLOSE c_uer_errores;

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
         utl_error.informa (p_programa   => 'UER_ERRORES_QP.sel_ERRO_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_erro_pk;

   -- Consulta el registro de UER_ERRORES basado en la PK
   FUNCTION sel_pk (p_erro_id IN uer_errores_tp.erro_id_t)
      RETURN uer_errores_tp.uer_errores_rt
   IS
      v_uer_errores   uer_errores_tp.uer_errores_rt;

      CURSOR c_uer_errores
      IS
         SELECT erro_id,
                programa,
                mensaje,
                aud_creado_por,
                aud_creado_en,
                aud_modificado_por,
                aud_modificado_en,
                lopr_id
         FROM uer_errores
         WHERE erro_id = p_erro_id;
   BEGIN
      OPEN c_uer_errores;

      FETCH c_uer_errores
      INTO v_uer_errores;

      CLOSE c_uer_errores;

      RETURN v_uer_errores;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_QP.sel_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_pk;

   -- Obtiene un cursor via una consulta sobre la constraint ERRO_PK de la tabla UER_ERRORES
   FUNCTION sel_erro_pk (p_erro_id IN uer_errores_tp.erro_id_t)
      RETURN uer_errores_tp.uer_errores_rc
   IS
      cu_uer_errores   uer_errores_tp.uer_errores_rc;
   BEGIN
      OPEN cu_uer_errores FOR
         SELECT erro_id,
                programa,
                mensaje,
                aud_creado_por,
                aud_creado_en,
                aud_modificado_por,
                aud_modificado_en,
                lopr_id
         FROM uer_errores
         WHERE erro_id = p_erro_id;

      RETURN cu_uer_errores;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_QP.sel_ERRO_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_erro_pk;

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla UER_ERRORES
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN uer_errores_tp.uer_errores_rc
   IS
      c_uer_errores   uer_errores_tp.uer_errores_rc;
   BEGIN
      OPEN c_uer_errores FOR '
      select
      ERRO_ID
      ,PROGRAMA
      ,MENSAJE
      ,AUD_CREADO_POR
      ,AUD_CREADO_EN
      ,AUD_MODIFICADO_POR
      ,AUD_MODIFICADO_EN
      ,LOPR_ID
      from UER_ERRORES
      WHERE ' || p_where;

      RETURN c_uer_errores;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;

   -- Obtiene una tabla (index by) con los registros de la tabla UER_ERRORES
   PROCEDURE sel_where (p_where                       VARCHAR2,
                        p_uer_errores   IN OUT NOCOPY uer_errores_tp.uer_errores_ct)
   IS
      TYPE cursor_rc IS REF CURSOR;

      v_cursor   cursor_rc;
   BEGIN
      OPEN v_cursor FOR '
         select
         ERRO_ID
         ,PROGRAMA
         ,MENSAJE
         ,AUD_CREADO_POR
         ,AUD_CREADO_EN
         ,AUD_MODIFICADO_POR
         ,AUD_MODIFICADO_EN
         ,LOPR_ID
         from UER_ERRORES
         WHERE ' || p_where;

      LOOP
         FETCH v_cursor
         INTO p_uer_errores (p_uer_errores.COUNT + 1);

         EXIT WHEN v_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cursor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;
END uer_errores_qp;
/
SHOW ERRORS;


