CREATE OR REPLACE PACKAGE BODY GAT.gat_templates_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TEMPLATES_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               GAT_TEMPLATES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Inserta un registro de la GAT_TEMPLATES via un record
   PROCEDURE ins (p_gat_templates gat_templates_tp.gat_templates_rt)
   IS
   BEGIN
      INSERT INTO gat_templates (perf_id,
                                 ttem_codigo,
                                 nombre,
                                 contenido,
                                 aud_creado_en,
                                 aud_creado_por,
                                 aud_modificado_en,
                                 aud_modificado_por)
      VALUES (p_gat_templates.perf_id,
              p_gat_templates.ttem_codigo,
              p_gat_templates.nombre,
              p_gat_templates.contenido,
              p_gat_templates.aud_creado_en,
              p_gat_templates.aud_creado_por,
              p_gat_templates.aud_modificado_en,
              p_gat_templates.aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta un registro de la GAT_TEMPLATES via la Lista de Columnas
   PROCEDURE ins (
      p_perf_id               gat_templates_tp.perf_id_t,
      p_ttem_codigo           gat_templates_tp.ttem_codigo_t,
      p_nombre                gat_templates_tp.nombre_t DEFAULT NULL,
      p_contenido             gat_templates_tp.contenido_t DEFAULT NULL,
      p_aud_creado_en         gat_templates_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        gat_templates_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     gat_templates_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    gat_templates_tp.aud_modificado_por_t DEFAULT NULL)
   IS
   BEGIN
      INSERT INTO gat_templates (perf_id,
                                 ttem_codigo,
                                 nombre,
                                 contenido,
                                 aud_creado_en,
                                 aud_creado_por,
                                 aud_modificado_en,
                                 aud_modificado_por)
      VALUES (p_perf_id,
              p_ttem_codigo,
              p_nombre,
              p_contenido,
              p_aud_creado_en,
              p_aud_creado_por,
              p_aud_modificado_en,
              p_aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_TEMPLATES vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_templates_tp.gat_templates_ct)
   IS
      v_perf_id              gat_templates_tp.perf_id_ct;
      v_ttem_codigo          gat_templates_tp.ttem_codigo_ct;
      v_nombre               gat_templates_tp.nombre_ct;
      v_contenido            gat_templates_tp.contenido_ct;
      v_aud_creado_en        gat_templates_tp.aud_creado_en_ct;
      v_aud_creado_por       gat_templates_tp.aud_creado_por_ct;
      v_aud_modificado_en    gat_templates_tp.aud_modificado_en_ct;
      v_aud_modificado_por   gat_templates_tp.aud_modificado_por_ct;
   BEGIN
      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_perf_id (indx) := p_regs (indx).perf_id;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_ttem_codigo (indx) := p_regs (indx).ttem_codigo;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_nombre (indx) := p_regs (indx).nombre;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_contenido (indx) := p_regs (indx).contenido;
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
         INSERT INTO gat_templates (perf_id,
                                    ttem_codigo,
                                    nombre,
                                    contenido,
                                    aud_creado_en,
                                    aud_creado_por,
                                    aud_modificado_en,
                                    aud_modificado_por)
         VALUES (v_perf_id (indx),
                 v_ttem_codigo (indx),
                 v_nombre (indx),
                 v_contenido (indx),
                 v_aud_creado_en (indx),
                 v_aud_creado_por (indx),
                 v_aud_modificado_en (indx),
                 v_aud_modificado_por (indx));

      v_perf_id.delete;
      v_ttem_codigo.delete;
      v_nombre.delete;
      v_contenido.delete;
      v_aud_creado_en.delete;
      v_aud_creado_por.delete;
      v_aud_modificado_en.delete;
      v_aud_modificado_por.delete;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_TEMPLATES vía colecciones de columnas
   PROCEDURE ins (p_perf_id              IN gat_templates_tp.perf_id_ct,
                  p_ttem_codigo          IN gat_templates_tp.ttem_codigo_ct,
                  p_nombre               IN gat_templates_tp.nombre_ct,
                  p_contenido            IN gat_templates_tp.contenido_ct,
                  p_aud_creado_en        IN gat_templates_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN gat_templates_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN gat_templates_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN gat_templates_tp.aud_modificado_por_ct)
   IS
   BEGIN
      FORALL indx IN p_perf_id.FIRST .. p_perf_id.LAST
         INSERT INTO gat_templates (perf_id,
                                    ttem_codigo,
                                    nombre,
                                    contenido,
                                    aud_creado_en,
                                    aud_creado_por,
                                    aud_modificado_en,
                                    aud_modificado_por)
         VALUES (p_perf_id (indx),
                 p_ttem_codigo (indx),
                 p_nombre (indx),
                 p_contenido (indx),
                 p_aud_creado_en (indx),
                 p_aud_creado_por (indx),
                 p_aud_modificado_en (indx),
                 p_aud_modificado_por (indx));
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Actualiza un registro de GAT_TEMPLATES en función de la constraint TPLT_PK
   PROCEDURE upd_tplt_pk (p_perf_id         IN gat_templates_tp.perf_id_t,
                          p_ttem_codigo     IN gat_templates_tp.ttem_codigo_t,
                          p_gat_templates      gat_templates_tp.gat_templates_rt)
   IS
   BEGIN
      UPDATE gat_templates
      SET nombre = p_gat_templates.nombre,
          contenido = p_gat_templates.contenido,
          aud_creado_en = p_gat_templates.aud_creado_en,
          aud_creado_por = p_gat_templates.aud_creado_por,
          aud_modificado_en = p_gat_templates.aud_modificado_en,
          aud_modificado_por = p_gat_templates.aud_modificado_por
      WHERE perf_id = p_perf_id AND ttem_codigo = p_ttem_codigo;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.upd_TPLT_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_tplt_pk;

   -- Actualiza una columna de la tabla GAT_TEMPLATES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_TEMPLATES '
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
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_TEMPLATES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_TEMPLATES '
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
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_TEMPLATES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_TEMPLATES '
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
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza un conjunto de columnas de la tabla GAT_TEMPLATES en función de la constraint TPLT_PK
   PROCEDURE upd_tplt_pk (
      p_perf_id                IN gat_templates_tp.perf_id_t,
      p_ttem_codigo            IN gat_templates_tp.ttem_codigo_t,
      p_nombre                    gat_templates_tp.nombre_t DEFAULT NULL,
      p_contenido                 gat_templates_tp.contenido_t DEFAULT NULL,
      p_aud_creado_en             gat_templates_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            gat_templates_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         gat_templates_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        gat_templates_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE)
   IS
   BEGIN
      IF p_ignore_valores_nulos
      THEN
         UPDATE gat_templates
         SET nombre = NVL (p_nombre, nombre),
             contenido = NVL (p_contenido, contenido),
             aud_creado_en = NVL (p_aud_creado_en, aud_creado_en),
             aud_creado_por = NVL (p_aud_creado_por, aud_creado_por),
             aud_modificado_en = NVL (p_aud_modificado_en, aud_modificado_en),
             aud_modificado_por = NVL (p_aud_modificado_por, aud_modificado_por)
         WHERE perf_id = p_perf_id AND ttem_codigo = p_ttem_codigo;
      ELSE
         UPDATE gat_templates
         SET nombre = p_nombre,
             contenido = p_contenido,
             aud_creado_en = p_aud_creado_en,
             aud_creado_por = p_aud_creado_por,
             aud_modificado_en = p_aud_modificado_en,
             aud_modificado_por = p_aud_modificado_por
         WHERE perf_id = p_perf_id AND ttem_codigo = p_ttem_codigo;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.upd_TPLT_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_tplt_pk;

   -- Borra un registro de GAT_TEMPLATES en función de la constraint TPLT_PK
   PROCEDURE del_tplt_pk (p_perf_id       IN     gat_templates_tp.perf_id_t,
                          p_ttem_codigo   IN     gat_templates_tp.ttem_codigo_t,
                          p_num_regs         OUT NUMBER)
   IS
   BEGIN
      DELETE gat_templates
      WHERE perf_id = p_perf_id AND ttem_codigo = p_ttem_codigo;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.del_TPLT_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_tplt_pk;

   -- Borra un registro de GAT_TEMPLATES en función de la constraint TPLT_PERF_FK1
   PROCEDURE del_tplt_perf_fk1 (p_perf_id    IN     gat_templates_tp.perf_id_t,
                                p_num_regs      OUT NUMBER)
   IS
   BEGIN
      DELETE gat_templates
      WHERE perf_id = p_perf_id;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.del_TPLT_PERF_FK1',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_tplt_perf_fk1;

   -- Borra un registro de GAT_TEMPLATES en función de la constraint TPLT_TTEM_FK2
   PROCEDURE del_tplt_ttem_fk2 (p_ttem_codigo   IN     gat_templates_tp.ttem_codigo_t,
                                p_num_regs         OUT NUMBER)
   IS
   BEGIN
      DELETE gat_templates
      WHERE ttem_codigo = p_ttem_codigo;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.del_TPLT_TTEM_FK2',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_tplt_ttem_fk2;

   -- Borra un registro de GAT_TEMPLATES en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER)
   IS
   BEGIN
      IF p_where IS NULL
      THEN
         EXECUTE IMMEDIATE 'delete GAT_TEMPLATES';
      ELSE
         EXECUTE IMMEDIATE 'delete GAT_TEMPLATES where ' || p_where;
      END IF;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.del_din',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_din;

   -- Borra un registro de GAT_TEMPLATES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_TEMPLATES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_TEMPLATES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_TEMPLATES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_TEMPLATES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_TEMPLATES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;
END gat_templates_cp;
/
SHOW ERRORS;


