CREATE OR REPLACE PACKAGE BODY GAT.cli_clientes_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     CLI_CLIENTES_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               CLI_CLIENTES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   FUNCTION siguiente_clave (p_secuencia IN VARCHAR2 DEFAULT 'CLI_CLIENTES_SEC')
      RETURN NUMBER
   IS
      retval   NUMBER;
   BEGIN
      EXECUTE IMMEDIATE 'SELECT ' || p_secuencia || '.NEXTVAL FROM DUAL' INTO retval;

      RETURN retval;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.siguiente_clave',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END siguiente_clave;

   -- Inserta un registro de la CLI_CLIENTES via un record
   PROCEDURE ins (p_cli_clientes cli_clientes_tp.cli_clientes_rt)
   IS
   BEGIN
      INSERT INTO cli_clientes (clie_id,
                                nombre_corto,
                                nombre,
                                aud_creado_en,
                                aud_creado_por,
                                aud_modificado_en,
                                aud_modificado_por)
      VALUES (p_cli_clientes.clie_id,
              p_cli_clientes.nombre_corto,
              p_cli_clientes.nombre,
              p_cli_clientes.aud_creado_en,
              p_cli_clientes.aud_creado_por,
              p_cli_clientes.aud_modificado_en,
              p_cli_clientes.aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta un registro de la CLI_CLIENTES via la Lista de Columnas
   PROCEDURE ins (
      p_clie_id               cli_clientes_tp.clie_id_t,
      p_nombre_corto          cli_clientes_tp.nombre_corto_t DEFAULT NULL,
      p_nombre                cli_clientes_tp.nombre_t,
      p_aud_creado_en         cli_clientes_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        cli_clientes_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     cli_clientes_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    cli_clientes_tp.aud_modificado_por_t DEFAULT NULL)
   IS
   BEGIN
      INSERT INTO cli_clientes (clie_id,
                                nombre_corto,
                                nombre,
                                aud_creado_en,
                                aud_creado_por,
                                aud_modificado_en,
                                aud_modificado_por)
      VALUES (p_clie_id,
              p_nombre_corto,
              p_nombre,
              p_aud_creado_en,
              p_aud_creado_por,
              p_aud_modificado_en,
              p_aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la CLI_CLIENTES vía un record de colección de columnas
   PROCEDURE ins (p_regs cli_clientes_tp.cli_clientes_ct)
   IS
      v_clie_id              cli_clientes_tp.clie_id_ct;
      v_nombre_corto         cli_clientes_tp.nombre_corto_ct;
      v_nombre               cli_clientes_tp.nombre_ct;
      v_aud_creado_en        cli_clientes_tp.aud_creado_en_ct;
      v_aud_creado_por       cli_clientes_tp.aud_creado_por_ct;
      v_aud_modificado_en    cli_clientes_tp.aud_modificado_en_ct;
      v_aud_modificado_por   cli_clientes_tp.aud_modificado_por_ct;
   BEGIN
      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_clie_id (indx) := p_regs (indx).clie_id;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_nombre_corto (indx) := p_regs (indx).nombre_corto;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_nombre (indx) := p_regs (indx).nombre;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_aud_creado_en (indx) := p_regs (indx).aud_creado_en;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_aud_creado_por (indx) := p_regs (indx).aud_creado_por;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_aud_modificado_en (indx) := p_regs (indx).aud_modificado_en;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_aud_modificado_por (indx) := p_regs (indx).aud_modificado_por;
      END LOOP;

      FORALL indx IN p_regs.FIRST .. p_regs.LAST
         INSERT INTO cli_clientes (clie_id,
                                   nombre_corto,
                                   nombre,
                                   aud_creado_en,
                                   aud_creado_por,
                                   aud_modificado_en,
                                   aud_modificado_por)
         VALUES (v_clie_id (indx),
                 v_nombre_corto (indx),
                 v_nombre (indx),
                 v_aud_creado_en (indx),
                 v_aud_creado_por (indx),
                 v_aud_modificado_en (indx),
                 v_aud_modificado_por (indx));

      v_clie_id.delete;
      v_nombre_corto.delete;
      v_nombre.delete;
      v_aud_creado_en.delete;
      v_aud_creado_por.delete;
      v_aud_modificado_en.delete;
      v_aud_modificado_por.delete;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la CLI_CLIENTES vía colecciones de columnas
   PROCEDURE ins (p_clie_id              IN cli_clientes_tp.clie_id_ct,
                  p_nombre_corto         IN cli_clientes_tp.nombre_corto_ct,
                  p_nombre               IN cli_clientes_tp.nombre_ct,
                  p_aud_creado_en        IN cli_clientes_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN cli_clientes_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN cli_clientes_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN cli_clientes_tp.aud_modificado_por_ct)
   IS
   BEGIN
      FORALL indx IN p_clie_id.FIRST .. p_clie_id.LAST
         INSERT INTO cli_clientes (clie_id,
                                   nombre_corto,
                                   nombre,
                                   aud_creado_en,
                                   aud_creado_por,
                                   aud_modificado_en,
                                   aud_modificado_por)
         VALUES (p_clie_id (indx),
                 p_nombre_corto (indx),
                 p_nombre (indx),
                 p_aud_creado_en (indx),
                 p_aud_creado_por (indx),
                 p_aud_modificado_en (indx),
                 p_aud_modificado_por (indx));
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Actualiza un registro de CLI_CLIENTES en función de la constraint CLIE_PK
   PROCEDURE upd_clie_pk (p_clie_id        IN cli_clientes_tp.clie_id_t,
                          p_cli_clientes      cli_clientes_tp.cli_clientes_rt)
   IS
   BEGIN
      UPDATE cli_clientes
      SET aud_creado_en = p_cli_clientes.aud_creado_en,
          aud_creado_por = p_cli_clientes.aud_creado_por,
          aud_modificado_en = p_cli_clientes.aud_modificado_en,
          aud_modificado_por = p_cli_clientes.aud_modificado_por,
          nombre_corto = p_cli_clientes.nombre_corto,
          nombre = p_cli_clientes.nombre
      WHERE clie_id = p_clie_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.upd_CLIE_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_clie_pk;

   -- Actualiza una columna de la tabla CLI_CLIENTES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update CLI_CLIENTES '
         || 'SET '
         || p_nombre_columna
         || '= :1 '
         || 'WHERE '
         || NVL (p_where, '1=1')
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla CLI_CLIENTES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update CLI_CLIENTES '
         || 'SET '
         || p_nombre_columna
         || '= :1 '
         || 'WHERE '
         || NVL (p_where, '1=1')
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla CLI_CLIENTES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update CLI_CLIENTES '
         || 'SET '
         || p_nombre_columna
         || '= :1 '
         || 'WHERE '
         || NVL (p_where, '1=1')
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza un conjunto de columnas de la tabla CLI_CLIENTES en función de la constraint CLIE_PK
   PROCEDURE upd_clie_pk (
      p_clie_id                IN cli_clientes_tp.clie_id_t,
      p_nombre_corto              cli_clientes_tp.nombre_corto_t DEFAULT NULL,
      p_nombre                    cli_clientes_tp.nombre_t DEFAULT NULL,
      p_aud_creado_en             cli_clientes_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            cli_clientes_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         cli_clientes_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        cli_clientes_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE)
   IS
   BEGIN
      IF p_ignore_valores_nulos
      THEN
         UPDATE cli_clientes
         SET nombre_corto = NVL (p_nombre_corto, nombre_corto),
             nombre = NVL (p_nombre, nombre),
             aud_creado_en = NVL (p_aud_creado_en, aud_creado_en),
             aud_creado_por = NVL (p_aud_creado_por, aud_creado_por),
             aud_modificado_en = NVL (p_aud_modificado_en, aud_modificado_en),
             aud_modificado_por = NVL (p_aud_modificado_por, aud_modificado_por)
         WHERE clie_id = p_clie_id;
      ELSE
         UPDATE cli_clientes
         SET nombre_corto = p_nombre_corto,
             nombre = p_nombre,
             aud_creado_en = p_aud_creado_en,
             aud_creado_por = p_aud_creado_por,
             aud_modificado_en = p_aud_modificado_en,
             aud_modificado_por = p_aud_modificado_por
         WHERE clie_id = p_clie_id;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.upd_CLIE_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_clie_pk;

   -- Borra un registro de CLI_CLIENTES en función de la constraint CLIE_PK
   PROCEDURE del_clie_pk (p_clie_id IN cli_clientes_tp.clie_id_t, p_num_regs OUT NUMBER)
   IS
   BEGIN
      DELETE cli_clientes
      WHERE clie_id = p_clie_id;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.del_CLIE_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_clie_pk;

   -- Borra un registro de CLI_CLIENTES en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER)
   IS
   BEGIN
      IF p_where IS NULL
      THEN
         EXECUTE IMMEDIATE 'delete CLI_CLIENTES';
      ELSE
         EXECUTE IMMEDIATE 'delete CLI_CLIENTES where ' || p_where;
      END IF;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.del_din',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_din;

   -- Borra un registro de CLI_CLIENTES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE 'delete CLI_CLIENTES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de CLI_CLIENTES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE 'delete CLI_CLIENTES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de CLI_CLIENTES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE 'delete CLI_CLIENTES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'CLI_CLIENTES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;
END cli_clientes_cp;
/
SHOW ERRORS;


