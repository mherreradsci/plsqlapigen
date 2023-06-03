CREATE OR REPLACE PACKAGE BODY GAT.uer_errores_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     UER_ERRORES_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               UER_ERRORES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   FUNCTION siguiente_clave (p_secuencia IN VARCHAR2 DEFAULT 'UER_ERRORES_SEC')
      RETURN NUMBER
   IS
      retval   NUMBER;
   BEGIN
      EXECUTE IMMEDIATE 'SELECT ' || p_secuencia || '.NEXTVAL FROM DUAL' INTO retval;

      RETURN retval;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.siguiente_clave',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END siguiente_clave;

   -- Inserta un registro de la UER_ERRORES via un record
   PROCEDURE ins (p_uer_errores uer_errores_tp.uer_errores_rt)
   IS
   BEGIN
      INSERT INTO uer_errores (erro_id,
                               programa,
                               mensaje,
                               aud_creado_por,
                               aud_creado_en,
                               aud_modificado_por,
                               aud_modificado_en,
                               lopr_id)
      VALUES (p_uer_errores.erro_id,
              p_uer_errores.programa,
              p_uer_errores.mensaje,
              p_uer_errores.aud_creado_por,
              p_uer_errores.aud_creado_en,
              p_uer_errores.aud_modificado_por,
              p_uer_errores.aud_modificado_en,
              p_uer_errores.lopr_id);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta un registro de la UER_ERRORES via la Lista de Columnas
   PROCEDURE ins (
      p_erro_id               uer_errores_tp.erro_id_t,
      p_programa              uer_errores_tp.programa_t,
      p_mensaje               uer_errores_tp.mensaje_t DEFAULT NULL,
      p_aud_creado_por        uer_errores_tp.aud_creado_por_t DEFAULT USER,
      p_aud_creado_en         uer_errores_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_modificado_por    uer_errores_tp.aud_modificado_por_t DEFAULT NULL,
      p_aud_modificado_en     uer_errores_tp.aud_modificado_en_t DEFAULT NULL,
      p_lopr_id               uer_errores_tp.lopr_id_t DEFAULT NULL)
   IS
   BEGIN
      INSERT INTO uer_errores (erro_id,
                               programa,
                               mensaje,
                               aud_creado_por,
                               aud_creado_en,
                               aud_modificado_por,
                               aud_modificado_en,
                               lopr_id)
      VALUES (p_erro_id,
              p_programa,
              p_mensaje,
              p_aud_creado_por,
              p_aud_creado_en,
              p_aud_modificado_por,
              p_aud_modificado_en,
              p_lopr_id);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la UER_ERRORES vía un record de colección de columnas
   PROCEDURE ins (p_regs uer_errores_tp.uer_errores_ct)
   IS
      v_erro_id              uer_errores_tp.erro_id_ct;
      v_programa             uer_errores_tp.programa_ct;
      v_mensaje              uer_errores_tp.mensaje_ct;
      v_aud_creado_por       uer_errores_tp.aud_creado_por_ct;
      v_aud_creado_en        uer_errores_tp.aud_creado_en_ct;
      v_aud_modificado_por   uer_errores_tp.aud_modificado_por_ct;
      v_aud_modificado_en    uer_errores_tp.aud_modificado_en_ct;
      v_lopr_id              uer_errores_tp.lopr_id_ct;
   BEGIN
      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_erro_id (indx) := p_regs (indx).erro_id;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_programa (indx) := p_regs (indx).programa;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_mensaje (indx) := p_regs (indx).mensaje;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_aud_creado_por (indx) := p_regs (indx).aud_creado_por;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_aud_creado_en (indx) := p_regs (indx).aud_creado_en;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_aud_modificado_por (indx) := p_regs (indx).aud_modificado_por;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_aud_modificado_en (indx) := p_regs (indx).aud_modificado_en;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_lopr_id (indx) := p_regs (indx).lopr_id;
      END LOOP;

      FORALL indx IN p_regs.FIRST .. p_regs.LAST
         INSERT INTO uer_errores (erro_id,
                                  programa,
                                  mensaje,
                                  aud_creado_por,
                                  aud_creado_en,
                                  aud_modificado_por,
                                  aud_modificado_en,
                                  lopr_id)
         VALUES (v_erro_id (indx),
                 v_programa (indx),
                 v_mensaje (indx),
                 v_aud_creado_por (indx),
                 v_aud_creado_en (indx),
                 v_aud_modificado_por (indx),
                 v_aud_modificado_en (indx),
                 v_lopr_id (indx));

      v_erro_id.delete;
      v_programa.delete;
      v_mensaje.delete;
      v_aud_creado_por.delete;
      v_aud_creado_en.delete;
      v_aud_modificado_por.delete;
      v_aud_modificado_en.delete;
      v_lopr_id.delete;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la UER_ERRORES vía colecciones de columnas
   PROCEDURE ins (p_erro_id              IN uer_errores_tp.erro_id_ct,
                  p_programa             IN uer_errores_tp.programa_ct,
                  p_mensaje              IN uer_errores_tp.mensaje_ct,
                  p_aud_creado_por       IN uer_errores_tp.aud_creado_por_ct,
                  p_aud_creado_en        IN uer_errores_tp.aud_creado_en_ct,
                  p_aud_modificado_por   IN uer_errores_tp.aud_modificado_por_ct,
                  p_aud_modificado_en    IN uer_errores_tp.aud_modificado_en_ct,
                  p_lopr_id              IN uer_errores_tp.lopr_id_ct)
   IS
   BEGIN
      FORALL indx IN p_erro_id.FIRST .. p_erro_id.LAST
         INSERT INTO uer_errores (erro_id,
                                  programa,
                                  mensaje,
                                  aud_creado_por,
                                  aud_creado_en,
                                  aud_modificado_por,
                                  aud_modificado_en,
                                  lopr_id)
         VALUES (p_erro_id (indx),
                 p_programa (indx),
                 p_mensaje (indx),
                 p_aud_creado_por (indx),
                 p_aud_creado_en (indx),
                 p_aud_modificado_por (indx),
                 p_aud_modificado_en (indx),
                 p_lopr_id (indx));
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Actualiza un registro de UER_ERRORES en función de la constraint ERRO_PK
   PROCEDURE upd_erro_pk (p_erro_id       IN uer_errores_tp.erro_id_t,
                          p_uer_errores      uer_errores_tp.uer_errores_rt)
   IS
   BEGIN
      UPDATE uer_errores
      SET programa = p_uer_errores.programa,
          mensaje = p_uer_errores.mensaje,
          aud_creado_por = p_uer_errores.aud_creado_por,
          aud_creado_en = p_uer_errores.aud_creado_en,
          aud_modificado_por = p_uer_errores.aud_modificado_por,
          aud_modificado_en = p_uer_errores.aud_modificado_en,
          lopr_id = p_uer_errores.lopr_id
      WHERE erro_id = p_erro_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.upd_ERRO_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_erro_pk;

   -- Actualiza una columna de la tabla UER_ERRORES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update UER_ERRORES '
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
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla UER_ERRORES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update UER_ERRORES '
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
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla UER_ERRORES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update UER_ERRORES '
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
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza un conjunto de columnas de la tabla UER_ERRORES en función de la constraint ERRO_PK
   PROCEDURE upd_erro_pk (
      p_erro_id                IN uer_errores_tp.erro_id_t,
      p_programa                  uer_errores_tp.programa_t DEFAULT NULL,
      p_mensaje                   uer_errores_tp.mensaje_t DEFAULT NULL,
      p_aud_creado_por            uer_errores_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_creado_en             uer_errores_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_modificado_por        uer_errores_tp.aud_modificado_por_t DEFAULT NULL,
      p_aud_modificado_en         uer_errores_tp.aud_modificado_en_t DEFAULT NULL,
      p_lopr_id                   uer_errores_tp.lopr_id_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE)
   IS
   BEGIN
      IF p_ignore_valores_nulos
      THEN
         UPDATE uer_errores
         SET programa = NVL (p_programa, programa),
             mensaje = NVL (p_mensaje, mensaje),
             aud_creado_por = NVL (p_aud_creado_por, aud_creado_por),
             aud_creado_en = NVL (p_aud_creado_en, aud_creado_en),
             aud_modificado_por = NVL (p_aud_modificado_por, aud_modificado_por),
             aud_modificado_en = NVL (p_aud_modificado_en, aud_modificado_en),
             lopr_id = NVL (p_lopr_id, lopr_id)
         WHERE erro_id = p_erro_id;
      ELSE
         UPDATE uer_errores
         SET programa = p_programa,
             mensaje = p_mensaje,
             aud_creado_por = p_aud_creado_por,
             aud_creado_en = p_aud_creado_en,
             aud_modificado_por = p_aud_modificado_por,
             aud_modificado_en = p_aud_modificado_en,
             lopr_id = p_lopr_id
         WHERE erro_id = p_erro_id;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.upd_ERRO_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_erro_pk;

   -- Borra un registro de UER_ERRORES en función de la constraint ERRO_PK
   PROCEDURE del_erro_pk (p_erro_id IN uer_errores_tp.erro_id_t, p_num_regs OUT NUMBER)
   IS
   BEGIN
      DELETE uer_errores
      WHERE erro_id = p_erro_id;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.del_ERRO_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_erro_pk;

   -- Borra un registro de UER_ERRORES en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER)
   IS
   BEGIN
      IF p_where IS NULL
      THEN
         EXECUTE IMMEDIATE 'delete UER_ERRORES';
      ELSE
         EXECUTE IMMEDIATE 'delete UER_ERRORES where ' || p_where;
      END IF;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.del_din',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_din;

   -- Borra un registro de UER_ERRORES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE 'delete UER_ERRORES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de UER_ERRORES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE 'delete UER_ERRORES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de UER_ERRORES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE 'delete UER_ERRORES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UER_ERRORES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;
END uer_errores_cp;
/
SHOW ERRORS;


