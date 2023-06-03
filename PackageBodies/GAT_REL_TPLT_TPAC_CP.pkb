CREATE OR REPLACE PACKAGE BODY GAT.gat_rel_tplt_tpac_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_REL_TPLT_TPAC_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               GAT_REL_TPLT_TPAC
   Descipción de la tabla:
   Relación entre los Templates y Tipos de packages

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Inserta un registro de la GAT_REL_TPLT_TPAC via un record
   PROCEDURE ins (p_gat_rel_tplt_tpac gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rt)
   IS
   BEGIN
      INSERT INTO gat_rel_tplt_tpac (perf_id,
                                     ttem_codigo,
                                     tpac_codigo,
                                     descripcion,
                                     aud_creado_en,
                                     aud_creado_por,
                                     aud_modificado_en,
                                     aud_modificado_por)
      VALUES (p_gat_rel_tplt_tpac.perf_id,
              p_gat_rel_tplt_tpac.ttem_codigo,
              p_gat_rel_tplt_tpac.tpac_codigo,
              p_gat_rel_tplt_tpac.descripcion,
              p_gat_rel_tplt_tpac.aud_creado_en,
              p_gat_rel_tplt_tpac.aud_creado_por,
              p_gat_rel_tplt_tpac.aud_modificado_en,
              p_gat_rel_tplt_tpac.aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta un registro de la GAT_REL_TPLT_TPAC via la Lista de Columnas
   PROCEDURE ins (
      p_perf_id               gat_rel_tplt_tpac_tp.perf_id_t,
      p_ttem_codigo           gat_rel_tplt_tpac_tp.ttem_codigo_t,
      p_tpac_codigo           gat_rel_tplt_tpac_tp.tpac_codigo_t,
      p_descripcion           gat_rel_tplt_tpac_tp.descripcion_t DEFAULT NULL,
      p_aud_creado_en         gat_rel_tplt_tpac_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        gat_rel_tplt_tpac_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     gat_rel_tplt_tpac_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    gat_rel_tplt_tpac_tp.aud_modificado_por_t DEFAULT NULL)
   IS
   BEGIN
      INSERT INTO gat_rel_tplt_tpac (perf_id,
                                     ttem_codigo,
                                     tpac_codigo,
                                     descripcion,
                                     aud_creado_en,
                                     aud_creado_por,
                                     aud_modificado_en,
                                     aud_modificado_por)
      VALUES (p_perf_id,
              p_ttem_codigo,
              p_tpac_codigo,
              p_descripcion,
              p_aud_creado_en,
              p_aud_creado_por,
              p_aud_modificado_en,
              p_aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_REL_TPLT_TPAC vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_ct)
   IS
      v_perf_id              gat_rel_tplt_tpac_tp.perf_id_ct;
      v_ttem_codigo          gat_rel_tplt_tpac_tp.ttem_codigo_ct;
      v_tpac_codigo          gat_rel_tplt_tpac_tp.tpac_codigo_ct;
      v_descripcion          gat_rel_tplt_tpac_tp.descripcion_ct;
      v_aud_creado_en        gat_rel_tplt_tpac_tp.aud_creado_en_ct;
      v_aud_creado_por       gat_rel_tplt_tpac_tp.aud_creado_por_ct;
      v_aud_modificado_en    gat_rel_tplt_tpac_tp.aud_modificado_en_ct;
      v_aud_modificado_por   gat_rel_tplt_tpac_tp.aud_modificado_por_ct;
   BEGIN
      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_perf_id (indx) := p_regs (indx).perf_id;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_ttem_codigo (indx) := p_regs (indx).ttem_codigo;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_tpac_codigo (indx) := p_regs (indx).tpac_codigo;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_descripcion (indx) := p_regs (indx).descripcion;
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
         INSERT INTO gat_rel_tplt_tpac (perf_id,
                                        ttem_codigo,
                                        tpac_codigo,
                                        descripcion,
                                        aud_creado_en,
                                        aud_creado_por,
                                        aud_modificado_en,
                                        aud_modificado_por)
         VALUES (v_perf_id (indx),
                 v_ttem_codigo (indx),
                 v_tpac_codigo (indx),
                 v_descripcion (indx),
                 v_aud_creado_en (indx),
                 v_aud_creado_por (indx),
                 v_aud_modificado_en (indx),
                 v_aud_modificado_por (indx));

      v_perf_id.delete;
      v_ttem_codigo.delete;
      v_tpac_codigo.delete;
      v_descripcion.delete;
      v_aud_creado_en.delete;
      v_aud_creado_por.delete;
      v_aud_modificado_en.delete;
      v_aud_modificado_por.delete;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_REL_TPLT_TPAC vía colecciones de columnas
   PROCEDURE ins (p_perf_id              IN gat_rel_tplt_tpac_tp.perf_id_ct,
                  p_ttem_codigo          IN gat_rel_tplt_tpac_tp.ttem_codigo_ct,
                  p_tpac_codigo          IN gat_rel_tplt_tpac_tp.tpac_codigo_ct,
                  p_descripcion          IN gat_rel_tplt_tpac_tp.descripcion_ct,
                  p_aud_creado_en        IN gat_rel_tplt_tpac_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN gat_rel_tplt_tpac_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN gat_rel_tplt_tpac_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN gat_rel_tplt_tpac_tp.aud_modificado_por_ct)
   IS
   BEGIN
      FORALL indx IN p_perf_id.FIRST .. p_perf_id.LAST
         INSERT INTO gat_rel_tplt_tpac (perf_id,
                                        ttem_codigo,
                                        tpac_codigo,
                                        descripcion,
                                        aud_creado_en,
                                        aud_creado_por,
                                        aud_modificado_en,
                                        aud_modificado_por)
         VALUES (p_perf_id (indx),
                 p_ttem_codigo (indx),
                 p_tpac_codigo (indx),
                 p_descripcion (indx),
                 p_aud_creado_en (indx),
                 p_aud_creado_por (indx),
                 p_aud_modificado_en (indx),
                 p_aud_modificado_por (indx));
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Actualiza un registro de GAT_REL_TPLT_TPAC en función de la constraint TPTP_PK
   PROCEDURE upd_tptp_pk (
      p_perf_id             IN gat_rel_tplt_tpac_tp.perf_id_t,
      p_ttem_codigo         IN gat_rel_tplt_tpac_tp.ttem_codigo_t,
      p_tpac_codigo         IN gat_rel_tplt_tpac_tp.tpac_codigo_t,
      p_gat_rel_tplt_tpac      gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rt)
   IS
   BEGIN
      UPDATE gat_rel_tplt_tpac
      SET descripcion = p_gat_rel_tplt_tpac.descripcion,
          aud_creado_en = p_gat_rel_tplt_tpac.aud_creado_en,
          aud_creado_por = p_gat_rel_tplt_tpac.aud_creado_por,
          aud_modificado_en = p_gat_rel_tplt_tpac.aud_modificado_en,
          aud_modificado_por = p_gat_rel_tplt_tpac.aud_modificado_por
      WHERE perf_id = p_perf_id
        AND ttem_codigo = p_ttem_codigo
        AND tpac_codigo = p_tpac_codigo;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.upd_TPTP_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_tptp_pk;

   -- Actualiza una columna de la tabla GAT_REL_TPLT_TPAC en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_REL_TPLT_TPAC '
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
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_REL_TPLT_TPAC en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_REL_TPLT_TPAC '
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
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_REL_TPLT_TPAC en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_REL_TPLT_TPAC '
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
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza un conjunto de columnas de la tabla GAT_REL_TPLT_TPAC en función de la constraint TPTP_PK
   PROCEDURE upd_tptp_pk (
      p_perf_id                IN gat_rel_tplt_tpac_tp.perf_id_t,
      p_ttem_codigo            IN gat_rel_tplt_tpac_tp.ttem_codigo_t,
      p_tpac_codigo            IN gat_rel_tplt_tpac_tp.tpac_codigo_t,
      p_descripcion               gat_rel_tplt_tpac_tp.descripcion_t DEFAULT NULL,
      p_aud_creado_en             gat_rel_tplt_tpac_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            gat_rel_tplt_tpac_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         gat_rel_tplt_tpac_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        gat_rel_tplt_tpac_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE)
   IS
   BEGIN
      IF p_ignore_valores_nulos
      THEN
         UPDATE gat_rel_tplt_tpac
         SET descripcion = NVL (p_descripcion, descripcion),
             aud_creado_en = NVL (p_aud_creado_en, aud_creado_en),
             aud_creado_por = NVL (p_aud_creado_por, aud_creado_por),
             aud_modificado_en = NVL (p_aud_modificado_en, aud_modificado_en),
             aud_modificado_por = NVL (p_aud_modificado_por, aud_modificado_por)
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND tpac_codigo = p_tpac_codigo;
      ELSE
         UPDATE gat_rel_tplt_tpac
         SET descripcion = p_descripcion,
             aud_creado_en = p_aud_creado_en,
             aud_creado_por = p_aud_creado_por,
             aud_modificado_en = p_aud_modificado_en,
             aud_modificado_por = p_aud_modificado_por
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND tpac_codigo = p_tpac_codigo;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.upd_TPTP_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_tptp_pk;

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de la constraint TPTP_PK
   PROCEDURE del_tptp_pk (p_perf_id       IN     gat_rel_tplt_tpac_tp.perf_id_t,
                          p_ttem_codigo   IN     gat_rel_tplt_tpac_tp.ttem_codigo_t,
                          p_tpac_codigo   IN     gat_rel_tplt_tpac_tp.tpac_codigo_t,
                          p_num_regs         OUT NUMBER)
   IS
   BEGIN
      DELETE gat_rel_tplt_tpac
      WHERE perf_id = p_perf_id
        AND ttem_codigo = p_ttem_codigo
        AND tpac_codigo = p_tpac_codigo;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.del_TPTP_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_tptp_pk;

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de la constraint TPTP_TPLT_FK2
   PROCEDURE del_tptp_tplt_fk2 (
      p_perf_id       IN     gat_rel_tplt_tpac_tp.perf_id_t,
      p_ttem_codigo   IN     gat_rel_tplt_tpac_tp.ttem_codigo_t,
      p_num_regs         OUT NUMBER)
   IS
   BEGIN
      DELETE gat_rel_tplt_tpac
      WHERE perf_id = p_perf_id AND ttem_codigo = p_ttem_codigo;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.del_TPTP_TPLT_FK2',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_tptp_tplt_fk2;

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de la constraint TPTP_TPAC_FK1
   PROCEDURE del_tptp_tpac_fk1 (
      p_tpac_codigo   IN     gat_rel_tplt_tpac_tp.tpac_codigo_t,
      p_num_regs         OUT NUMBER)
   IS
   BEGIN
      DELETE gat_rel_tplt_tpac
      WHERE tpac_codigo = p_tpac_codigo;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.del_TPTP_TPAC_FK1',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_tptp_tpac_fk1;

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER)
   IS
   BEGIN
      IF p_where IS NULL
      THEN
         EXECUTE IMMEDIATE 'delete GAT_REL_TPLT_TPAC';
      ELSE
         EXECUTE IMMEDIATE 'delete GAT_REL_TPLT_TPAC where ' || p_where;
      END IF;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.del_din',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_din;

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_REL_TPLT_TPAC' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_REL_TPLT_TPAC' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_REL_TPLT_TPAC' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_REL_TPLT_TPAC_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;
END gat_rel_tplt_tpac_cp;
/
SHOW ERRORS;


