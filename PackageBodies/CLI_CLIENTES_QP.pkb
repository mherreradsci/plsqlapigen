CREATE OR REPLACE PACKAGE BODY GAT.cli_clientes_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     CLI_CLIENTES_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               CLI_CLIENTES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de CLI_CLIENTES basado en la PK
   FUNCTION existe (p_clie_id IN cli_clientes_tp.clie_id_t)
      RETURN BOOLEAN
   IS
      CURSOR un_registro
      IS
         SELECT NULL
         FROM cli_clientes
         WHERE clie_id = p_clie_id;

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
         utl_error.informa (p_programa   => 'CLI_CLIENTES_QP.existe',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END existe;

   -- Funcion para obtener la cantidad de registros de la tabla CLI_CLIENTES a partir de la pk
   FUNCTION cuenta_por_pk (p_clie_id IN cli_clientes_tp.clie_id_t)
      RETURN PLS_INTEGER
   IS
      v_cantidad   PLS_INTEGER;
   BEGIN
      SELECT COUNT (*)
      INTO v_cantidad
      FROM cli_clientes
      WHERE clie_id = p_clie_id;

      RETURN v_cantidad;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_QP.cuenta_por_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END cuenta_por_pk;

   -- Consulta un registro de CLI_CLIENTES basado en la constraint CLIE_PK
   PROCEDURE sel_clie_pk (p_clie_id        IN            cli_clientes_tp.clie_id_t,
                          p_cli_clientes      OUT NOCOPY cli_clientes_tp.cli_clientes_rt)
   IS
      CURSOR c_cli_clientes
      IS
         SELECT clie_id,
                nombre_corto,
                nombre,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM cli_clientes
         WHERE clie_id = p_clie_id;

      v_found   BOOLEAN;
   BEGIN
      OPEN c_cli_clientes;

      FETCH c_cli_clientes
      INTO p_cli_clientes;

      v_found := c_cli_clientes%FOUND;

      CLOSE c_cli_clientes;

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
         utl_error.informa (p_programa   => 'CLI_CLIENTES_QP.sel_CLIE_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_clie_pk;

   -- Consulta el registro de CLI_CLIENTES basado en la PK
   FUNCTION sel_pk (p_clie_id IN cli_clientes_tp.clie_id_t)
      RETURN cli_clientes_tp.cli_clientes_rt
   IS
      v_cli_clientes   cli_clientes_tp.cli_clientes_rt;

      CURSOR c_cli_clientes
      IS
         SELECT clie_id,
                nombre_corto,
                nombre,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM cli_clientes
         WHERE clie_id = p_clie_id;
   BEGIN
      OPEN c_cli_clientes;

      FETCH c_cli_clientes
      INTO v_cli_clientes;

      CLOSE c_cli_clientes;

      RETURN v_cli_clientes;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_QP.sel_pk',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_pk;

   -- Obtiene un cursor via una consulta sobre la constraint CLIE_PK de la tabla CLI_CLIENTES
   FUNCTION sel_clie_pk (p_clie_id IN cli_clientes_tp.clie_id_t)
      RETURN cli_clientes_tp.cli_clientes_rc
   IS
      cu_cli_clientes   cli_clientes_tp.cli_clientes_rc;
   BEGIN
      OPEN cu_cli_clientes FOR
         SELECT clie_id,
                nombre_corto,
                nombre,
                aud_creado_en,
                aud_creado_por,
                aud_modificado_en,
                aud_modificado_por
         FROM cli_clientes
         WHERE clie_id = p_clie_id;

      RETURN cu_cli_clientes;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_QP.sel_CLIE_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_clie_pk;

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla CLI_CLIENTES
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN cli_clientes_tp.cli_clientes_rc
   IS
      c_cli_clientes   cli_clientes_tp.cli_clientes_rc;
   BEGIN
      OPEN c_cli_clientes FOR '
      select
      CLIE_ID
      ,NOMBRE_CORTO
      ,NOMBRE
      ,AUD_CREADO_EN
      ,AUD_CREADO_POR
      ,AUD_MODIFICADO_EN
      ,AUD_MODIFICADO_POR
      from CLI_CLIENTES
      WHERE ' || p_where;

      RETURN c_cli_clientes;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;

   -- Obtiene una tabla (index by) con los registros de la tabla CLI_CLIENTES
   PROCEDURE sel_where (p_where                        VARCHAR2,
                        p_cli_clientes   IN OUT NOCOPY cli_clientes_tp.cli_clientes_ct)
   IS
      TYPE cursor_rc IS REF CURSOR;

      v_cursor   cursor_rc;
   BEGIN
      OPEN v_cursor FOR '
         select
         CLIE_ID
         ,NOMBRE_CORTO
         ,NOMBRE
         ,AUD_CREADO_EN
         ,AUD_CREADO_POR
         ,AUD_MODIFICADO_EN
         ,AUD_MODIFICADO_POR
         from CLI_CLIENTES
         WHERE ' || p_where;

      LOOP
         FETCH v_cursor
         INTO p_cli_clientes (p_cli_clientes.COUNT + 1);

         EXIT WHEN v_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cursor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;
END cli_clientes_qp;
/
SHOW ERRORS;


