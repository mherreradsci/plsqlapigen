CREATE OR REPLACE PACKAGE BODY GAT.gat_tplt_source_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TPLT_SOURCE_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               GAT_TPLT_SOURCE
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Inserta un registro de la GAT_TPLT_SOURCE via un record
   PROCEDURE ins (p_gat_tplt_source gat_tplt_source_tp.gat_tplt_source_rt)
   IS
   BEGIN
      INSERT INTO gat_tplt_source (perf_id,
                                   ttem_codigo,
                                   tpso_id,
                                   linea,
                                   aud_creado_en,
                                   aud_creado_por,
                                   aud_modificado_en,
                                   aud_modificado_por)
      VALUES (p_gat_tplt_source.perf_id,
              p_gat_tplt_source.ttem_codigo,
              p_gat_tplt_source.tpso_id,
              p_gat_tplt_source.linea,
              p_gat_tplt_source.aud_creado_en,
              p_gat_tplt_source.aud_creado_por,
              p_gat_tplt_source.aud_modificado_en,
              p_gat_tplt_source.aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta un registro de la GAT_TPLT_SOURCE via la Lista de Columnas
   PROCEDURE ins (
      p_perf_id               gat_tplt_source_tp.perf_id_t,
      p_ttem_codigo           gat_tplt_source_tp.ttem_codigo_t,
      p_tpso_id               gat_tplt_source_tp.tpso_id_t,
      p_linea                 gat_tplt_source_tp.linea_t,
      p_aud_creado_en         gat_tplt_source_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        gat_tplt_source_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     gat_tplt_source_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    gat_tplt_source_tp.aud_modificado_por_t DEFAULT NULL)
   IS
   BEGIN
      INSERT INTO gat_tplt_source (perf_id,
                                   ttem_codigo,
                                   tpso_id,
                                   linea,
                                   aud_creado_en,
                                   aud_creado_por,
                                   aud_modificado_en,
                                   aud_modificado_por)
      VALUES (p_perf_id,
              p_ttem_codigo,
              p_tpso_id,
              p_linea,
              p_aud_creado_en,
              p_aud_creado_por,
              p_aud_modificado_en,
              p_aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_TPLT_SOURCE vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_tplt_source_tp.gat_tplt_source_ct)
   IS
      v_perf_id              gat_tplt_source_tp.perf_id_ct;
      v_ttem_codigo          gat_tplt_source_tp.ttem_codigo_ct;
      v_tpso_id              gat_tplt_source_tp.tpso_id_ct;
      v_linea                gat_tplt_source_tp.linea_ct;
      v_aud_creado_en        gat_tplt_source_tp.aud_creado_en_ct;
      v_aud_creado_por       gat_tplt_source_tp.aud_creado_por_ct;
      v_aud_modificado_en    gat_tplt_source_tp.aud_modificado_en_ct;
      v_aud_modificado_por   gat_tplt_source_tp.aud_modificado_por_ct;
   BEGIN
      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_perf_id (indx) := p_regs (indx).perf_id;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_ttem_codigo (indx) := p_regs (indx).ttem_codigo;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_tpso_id (indx) := p_regs (indx).tpso_id;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_linea (indx) := p_regs (indx).linea;
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
         INSERT INTO gat_tplt_source (perf_id,
                                      ttem_codigo,
                                      tpso_id,
                                      linea,
                                      aud_creado_en,
                                      aud_creado_por,
                                      aud_modificado_en,
                                      aud_modificado_por)
         VALUES (v_perf_id (indx),
                 v_ttem_codigo (indx),
                 v_tpso_id (indx),
                 v_linea (indx),
                 v_aud_creado_en (indx),
                 v_aud_creado_por (indx),
                 v_aud_modificado_en (indx),
                 v_aud_modificado_por (indx));

      v_perf_id.delete;
      v_ttem_codigo.delete;
      v_tpso_id.delete;
      v_linea.delete;
      v_aud_creado_en.delete;
      v_aud_creado_por.delete;
      v_aud_modificado_en.delete;
      v_aud_modificado_por.delete;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_TPLT_SOURCE vía colecciones de columnas
   PROCEDURE ins (p_perf_id              IN gat_tplt_source_tp.perf_id_ct,
                  p_ttem_codigo          IN gat_tplt_source_tp.ttem_codigo_ct,
                  p_tpso_id              IN gat_tplt_source_tp.tpso_id_ct,
                  p_linea                IN gat_tplt_source_tp.linea_ct,
                  p_aud_creado_en        IN gat_tplt_source_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN gat_tplt_source_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN gat_tplt_source_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN gat_tplt_source_tp.aud_modificado_por_ct)
   IS
   BEGIN
      FORALL indx IN p_perf_id.FIRST .. p_perf_id.LAST
         INSERT INTO gat_tplt_source (perf_id,
                                      ttem_codigo,
                                      tpso_id,
                                      linea,
                                      aud_creado_en,
                                      aud_creado_por,
                                      aud_modificado_en,
                                      aud_modificado_por)
         VALUES (p_perf_id (indx),
                 p_ttem_codigo (indx),
                 p_tpso_id (indx),
                 p_linea (indx),
                 p_aud_creado_en (indx),
                 p_aud_creado_por (indx),
                 p_aud_modificado_en (indx),
                 p_aud_modificado_por (indx));
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Actualiza un registro de GAT_TPLT_SOURCE en función de la constraint TPSO_PK
   PROCEDURE upd_tpso_pk (p_perf_id           IN gat_tplt_source_tp.perf_id_t,
                          p_ttem_codigo       IN gat_tplt_source_tp.ttem_codigo_t,
                          p_tpso_id           IN gat_tplt_source_tp.tpso_id_t,
                          p_gat_tplt_source      gat_tplt_source_tp.gat_tplt_source_rt)
   IS
   BEGIN
      UPDATE gat_tplt_source
      SET aud_creado_en = p_gat_tplt_source.aud_creado_en,
          aud_creado_por = p_gat_tplt_source.aud_creado_por,
          aud_modificado_en = p_gat_tplt_source.aud_modificado_en,
          aud_modificado_por = p_gat_tplt_source.aud_modificado_por,
          linea = p_gat_tplt_source.linea
      WHERE perf_id = p_perf_id AND ttem_codigo = p_ttem_codigo AND tpso_id = p_tpso_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.upd_TPSO_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_tpso_pk;

   -- Actualiza una columna de la tabla GAT_TPLT_SOURCE en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_TPLT_SOURCE '
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
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_TPLT_SOURCE en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_TPLT_SOURCE '
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
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_TPLT_SOURCE en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_TPLT_SOURCE '
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
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza un conjunto de columnas de la tabla GAT_TPLT_SOURCE en función de la constraint TPSO_PK
   PROCEDURE upd_tpso_pk (
      p_perf_id                IN gat_tplt_source_tp.perf_id_t,
      p_ttem_codigo            IN gat_tplt_source_tp.ttem_codigo_t,
      p_tpso_id                IN gat_tplt_source_tp.tpso_id_t,
      p_linea                     gat_tplt_source_tp.linea_t DEFAULT NULL,
      p_aud_creado_en             gat_tplt_source_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            gat_tplt_source_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         gat_tplt_source_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        gat_tplt_source_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE)
   IS
   BEGIN
      IF p_ignore_valores_nulos
      THEN
         UPDATE gat_tplt_source
         SET linea = NVL (p_linea, linea),
             aud_creado_en = NVL (p_aud_creado_en, aud_creado_en),
             aud_creado_por = NVL (p_aud_creado_por, aud_creado_por),
             aud_modificado_en = NVL (p_aud_modificado_en, aud_modificado_en),
             aud_modificado_por = NVL (p_aud_modificado_por, aud_modificado_por)
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND tpso_id = p_tpso_id;
      ELSE
         UPDATE gat_tplt_source
         SET linea = p_linea,
             aud_creado_en = p_aud_creado_en,
             aud_creado_por = p_aud_creado_por,
             aud_modificado_en = p_aud_modificado_en,
             aud_modificado_por = p_aud_modificado_por
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND tpso_id = p_tpso_id;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.upd_TPSO_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_tpso_pk;

   -- Borra un registro de GAT_TPLT_SOURCE en función de la constraint TPSO_PK
   PROCEDURE del_tpso_pk (p_perf_id       IN     gat_tplt_source_tp.perf_id_t,
                          p_ttem_codigo   IN     gat_tplt_source_tp.ttem_codigo_t,
                          p_tpso_id       IN     gat_tplt_source_tp.tpso_id_t,
                          p_num_regs         OUT NUMBER)
   IS
   BEGIN
      DELETE gat_tplt_source
      WHERE perf_id = p_perf_id AND ttem_codigo = p_ttem_codigo AND tpso_id = p_tpso_id;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.del_TPSO_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_tpso_pk;

   -- Borra un registro de GAT_TPLT_SOURCE en función de la constraint TPSO_TPLT_FK1
   PROCEDURE del_tpso_tplt_fk1 (p_perf_id       IN     gat_tplt_source_tp.perf_id_t,
                                p_ttem_codigo   IN     gat_tplt_source_tp.ttem_codigo_t,
                                p_num_regs         OUT NUMBER)
   IS
   BEGIN
      DELETE gat_tplt_source
      WHERE perf_id = p_perf_id AND ttem_codigo = p_ttem_codigo;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.del_TPSO_TPLT_FK1',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_tpso_tplt_fk1;

   -- Borra un registro de GAT_TPLT_SOURCE en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER)
   IS
   BEGIN
      IF p_where IS NULL
      THEN
         EXECUTE IMMEDIATE 'delete GAT_TPLT_SOURCE';
      ELSE
         EXECUTE IMMEDIATE 'delete GAT_TPLT_SOURCE where ' || p_where;
      END IF;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.del_din',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_din;

   -- Borra un registro de GAT_TPLT_SOURCE en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_TPLT_SOURCE' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_TPLT_SOURCE en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_TPLT_SOURCE' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_TPLT_SOURCE en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_TPLT_SOURCE' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TPLT_SOURCE_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;
END gat_tplt_source_cp;
/
SHOW ERRORS;


