CREATE OR REPLACE PACKAGE BODY GAT.gat_perfiles_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_PERFILES_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_PERFILES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_PERFILES basado en la PK
   FUNCTION existe (p_perf_id IN gat_perfiles_tp.perf_id_t)
      RETURN BOOLEAN
   IS
      CURSOR un_registro
      IS
         SELECT NULL
         FROM gat_perfiles
         WHERE perf_id = p_perf_id;

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
         utl_error.informa (p_programa   => 'GAT_PERFILES_QP.existe',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END existe;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_PERFILES a partir de la pk
   FUNCTION cuenta_por_pk (p_perf_id IN gat_perfiles_tp.perf_id_t)
      RETURN PLS_INTEGER
   IS
      v_cantidad   PLS_INTEGER;
   BEGIN
      SELECT COUNT (*)
      INTO v_cantidad
      FROM gat_perfiles
      WHERE perf_id = p_perf_id;

      RETURN v_cantidad;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_QP.cuenta_por_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END cuenta_por_pk;

   -- Consulta un registro de GAT_PERFILES basado en la constraint PERF_PK
   PROCEDURE sel_perf_pk (p_perf_id        IN            gat_perfiles_tp.perf_id_t,
                          p_gat_perfiles      OUT NOCOPY gat_perfiles_tp.gat_perfiles_rt)
   IS
      CURSOR c_gat_perfiles
      IS
         SELECT perf_id,
                empresa,
                nombre,
                nombre_corto,
                descripcion,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_perfiles
         WHERE perf_id = p_perf_id;

      v_found   BOOLEAN;
   BEGIN
      OPEN c_gat_perfiles;

      FETCH c_gat_perfiles
      INTO p_gat_perfiles;

      v_found := c_gat_perfiles%FOUND;

      CLOSE c_gat_perfiles;

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
         utl_error.informa (p_programa   => 'GAT_PERFILES_QP.sel_PERF_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_perf_pk;

   -- Consulta el registro de GAT_PERFILES basado en la PK
   FUNCTION sel_pk (p_perf_id IN gat_perfiles_tp.perf_id_t)
      RETURN gat_perfiles_tp.gat_perfiles_rt
   IS
      v_gat_perfiles   gat_perfiles_tp.gat_perfiles_rt;

      CURSOR c_gat_perfiles
      IS
         SELECT perf_id,
                empresa,
                nombre,
                nombre_corto,
                descripcion,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_perfiles
         WHERE perf_id = p_perf_id;
   BEGIN
      OPEN c_gat_perfiles;

      FETCH c_gat_perfiles
      INTO v_gat_perfiles;

      CLOSE c_gat_perfiles;

      RETURN v_gat_perfiles;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_QP.sel_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_pk;

   -- Obtiene un cursor via una consulta sobre la constraint PERF_PK de la tabla GAT_PERFILES
   FUNCTION sel_perf_pk (p_perf_id IN gat_perfiles_tp.perf_id_t)
      RETURN gat_perfiles_tp.gat_perfiles_rc
   IS
      cu_gat_perfiles   gat_perfiles_tp.gat_perfiles_rc;
   BEGIN
      OPEN cu_gat_perfiles FOR
         SELECT perf_id,
                empresa,
                nombre,
                nombre_corto,
                descripcion,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM gat_perfiles
         WHERE perf_id = p_perf_id;

      RETURN cu_gat_perfiles;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_QP.sel_PERF_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_perf_pk;

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_PERFILES
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_perfiles_tp.gat_perfiles_rc
   IS
      c_gat_perfiles   gat_perfiles_tp.gat_perfiles_rc;
   BEGIN
      OPEN c_gat_perfiles FOR '
      select
      PERF_ID
      ,EMPRESA
      ,NOMBRE
      ,NOMBRE_CORTO
      ,DESCRIPCION
      ,AUD_CREADO_EN
      ,AUD_CREADO_POR
      ,AUD_MODIFICADO_EN
      ,AUD_MODIFICADO_POR
      from GAT_PERFILES
      WHERE ' || p_where;

      RETURN c_gat_perfiles;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_PERFILES
   PROCEDURE sel_where (p_where                        VARCHAR2,
                        p_gat_perfiles   IN OUT NOCOPY gat_perfiles_tp.gat_perfiles_ct)
   IS
      TYPE cursor_rc IS REF CURSOR;

      v_cursor   cursor_rc;
   BEGIN
      OPEN v_cursor FOR '
         select
         PERF_ID
         ,EMPRESA
         ,NOMBRE
         ,NOMBRE_CORTO
         ,DESCRIPCION
         ,AUD_CREADO_EN
         ,AUD_CREADO_POR
         ,AUD_MODIFICADO_EN
         ,AUD_MODIFICADO_POR
         from GAT_PERFILES
         WHERE ' || p_where;

      LOOP
         FETCH v_cursor
         INTO p_gat_perfiles (p_gat_perfiles.COUNT + 1);

         EXIT WHEN v_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cursor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;
END gat_perfiles_qp;
/
SHOW ERRORS;


