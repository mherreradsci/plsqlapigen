CREATE OR REPLACE PACKAGE BODY GAT.dba_arguments_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     DBA_ARGUMENTS_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               DBA_ARGUMENTS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   22-mar-2012 mherrera     Creación
   *******************************************************************************/

   -- Consulta un registro de DBA_ARGUMENTS basado en la constraint ARGU_UK1
   PROCEDURE sel_argu_uk1 (
      p_owner           IN            dba_arguments_tp.owner_t,
      p_object_name     IN            dba_arguments_tp.object_name_t DEFAULT NULL,
      p_package_name    IN            dba_arguments_tp.package_name_t DEFAULT NULL,
      p_subprogram_id   IN            dba_arguments_tp.subprogram_id_t DEFAULT NULL,
      p_sequence        IN            dba_arguments_tp.sequence_t,
      p_dba_arguments      OUT NOCOPY dba_arguments_tp.dba_arguments_rt)
   IS
      CURSOR c_dba_arguments
      IS
         SELECT owner,
                object_name,
                package_name,
                object_id,
                overload,
                subprogram_id,
                argument_name,
                position,
                sequence,
                data_level,
                data_type,
                defaulted,
                DEFAULT_VALUE,
                default_length,
                in_out,
                data_length,
                data_precision,
                data_scale,
                radix,
                character_set_name,
                type_owner,
                type_name,
                type_subname,
                type_link,
                pls_type,
                char_length,
                char_used
         FROM dba_arguments
         WHERE owner = p_owner
           AND object_name = p_object_name
           AND package_name = p_package_name
           AND subprogram_id = p_subprogram_id
           AND sequence = p_sequence;

      v_found   BOOLEAN;
   BEGIN
      OPEN c_dba_arguments;

      FETCH c_dba_arguments
      INTO p_dba_arguments;

      v_found := c_dba_arguments%FOUND;

      CLOSE c_dba_arguments;

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
         utl_error.informa (p_programa   => 'DBA_ARGUMENTS_QP.sel_ARGU_UK1',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_argu_uk1;

   -- Obtiene un cursor via una consulta sobre la constraint ARGU_UK1 de la tabla DBA_ARGUMENTS
   FUNCTION sel_argu_uk1 (
      p_owner           IN dba_arguments_tp.owner_t,
      p_object_name     IN dba_arguments_tp.object_name_t DEFAULT NULL,
      p_package_name    IN dba_arguments_tp.package_name_t DEFAULT NULL,
      p_subprogram_id   IN dba_arguments_tp.subprogram_id_t DEFAULT NULL,
      p_sequence        IN dba_arguments_tp.sequence_t)
      RETURN dba_arguments_tp.dba_arguments_rc
   IS
      cu_dba_arguments   dba_arguments_tp.dba_arguments_rc;
   BEGIN
      OPEN cu_dba_arguments FOR
         SELECT owner,
                object_name,
                package_name,
                object_id,
                overload,
                subprogram_id,
                argument_name,
                position,
                sequence,
                data_level,
                data_type,
                defaulted,
                DEFAULT_VALUE,
                default_length,
                in_out,
                data_length,
                data_precision,
                data_scale,
                radix,
                character_set_name,
                type_owner,
                type_name,
                type_subname,
                type_link,
                pls_type,
                char_length,
                char_used
         FROM dba_arguments
         WHERE owner = p_owner
           AND object_name = p_object_name
           AND package_name = p_package_name
           AND subprogram_id = p_subprogram_id
           AND sequence = p_sequence;

      RETURN cu_dba_arguments;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'DBA_ARGUMENTS_QP.sel_ARGU_UK1',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_argu_uk1;

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla DBA_ARGUMENTS
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN dba_arguments_tp.dba_arguments_rc
   IS
      c_dba_arguments   dba_arguments_tp.dba_arguments_rc;
   BEGIN
      OPEN c_dba_arguments FOR '
      select
      OWNER
      ,OBJECT_NAME
      ,PACKAGE_NAME
      ,OBJECT_ID
      ,OVERLOAD
      ,SUBPROGRAM_ID
      ,ARGUMENT_NAME
      ,POSITION
      ,SEQUENCE
      ,DATA_LEVEL
      ,DATA_TYPE
      ,DEFAULTED
      ,DEFAULT_VALUE
      ,DEFAULT_LENGTH
      ,IN_OUT
      ,DATA_LENGTH
      ,DATA_PRECISION
      ,DATA_SCALE
      ,RADIX
      ,CHARACTER_SET_NAME
      ,TYPE_OWNER
      ,TYPE_NAME
      ,TYPE_SUBNAME
      ,TYPE_LINK
      ,PLS_TYPE
      ,CHAR_LENGTH
      ,CHAR_USED
      from DBA_ARGUMENTS
      WHERE ' || p_where;

      RETURN c_dba_arguments;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'DBA_ARGUMENTS_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;

   -- Obtiene una tabla (index by) con los registros de la tabla DBA_ARGUMENTS
   PROCEDURE sel_where (
      p_where                         VARCHAR2,
      p_dba_arguments   IN OUT NOCOPY dba_arguments_tp.dba_arguments_ct)
   IS
      TYPE cursor_rc IS REF CURSOR;

      v_cursor   cursor_rc;
   BEGIN
      OPEN v_cursor FOR '
         select
         OWNER
         ,OBJECT_NAME
         ,PACKAGE_NAME
         ,OBJECT_ID
         ,OVERLOAD
         ,SUBPROGRAM_ID
         ,ARGUMENT_NAME
         ,POSITION
         ,SEQUENCE
         ,DATA_LEVEL
         ,DATA_TYPE
         ,DEFAULTED
         ,DEFAULT_VALUE
         ,DEFAULT_LENGTH
         ,IN_OUT
         ,DATA_LENGTH
         ,DATA_PRECISION
         ,DATA_SCALE
         ,RADIX
         ,CHARACTER_SET_NAME
         ,TYPE_OWNER
         ,TYPE_NAME
         ,TYPE_SUBNAME
         ,TYPE_LINK
         ,PLS_TYPE
         ,CHAR_LENGTH
         ,CHAR_USED
         from DBA_ARGUMENTS
         WHERE ' || p_where;

      LOOP
         FETCH v_cursor
         INTO p_dba_arguments (p_dba_arguments.COUNT + 1);

         EXIT WHEN v_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cursor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'DBA_ARGUMENTS_QP.sel_where',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END sel_where;
END dba_arguments_qp;
/
SHOW ERRORS;


