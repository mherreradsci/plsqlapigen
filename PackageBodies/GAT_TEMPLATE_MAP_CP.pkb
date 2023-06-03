CREATE OR REPLACE PACKAGE BODY GAT.gat_template_map_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TEMPLATE_MAP_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               GAT_TEMPLATE_MAP
   Descipción de la tabla:
   Mapa de template

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Inserta un registro de la GAT_TEMPLATE_MAP via un record
   PROCEDURE ins (p_gat_template_map gat_template_map_tp.gat_template_map_rt)
   IS
   BEGIN
      INSERT INTO gat_template_map (perf_id,
                                    ttem_codigo,
                                    para_code,
                                    tipr_codigo,
                                    component,
                                    subcomponent,
                                    aud_creado_en,
                                    aud_creado_por,
                                    aud_modificado_en,
                                    aud_modificado_por)
      VALUES (p_gat_template_map.perf_id,
              p_gat_template_map.ttem_codigo,
              p_gat_template_map.para_code,
              p_gat_template_map.tipr_codigo,
              p_gat_template_map.component,
              p_gat_template_map.subcomponent,
              p_gat_template_map.aud_creado_en,
              p_gat_template_map.aud_creado_por,
              p_gat_template_map.aud_modificado_en,
              p_gat_template_map.aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta un registro de la GAT_TEMPLATE_MAP via la Lista de Columnas
   PROCEDURE ins (
      p_perf_id               gat_template_map_tp.perf_id_t,
      p_ttem_codigo           gat_template_map_tp.ttem_codigo_t,
      p_para_code             gat_template_map_tp.para_code_t,
      p_tipr_codigo           gat_template_map_tp.tipr_codigo_t,
      p_component             gat_template_map_tp.component_t DEFAULT NULL,
      p_subcomponent          gat_template_map_tp.subcomponent_t DEFAULT NULL,
      p_aud_creado_en         gat_template_map_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        gat_template_map_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     gat_template_map_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    gat_template_map_tp.aud_modificado_por_t DEFAULT NULL)
   IS
   BEGIN
      INSERT INTO gat_template_map (perf_id,
                                    ttem_codigo,
                                    para_code,
                                    tipr_codigo,
                                    component,
                                    subcomponent,
                                    aud_creado_en,
                                    aud_creado_por,
                                    aud_modificado_en,
                                    aud_modificado_por)
      VALUES (p_perf_id,
              p_ttem_codigo,
              p_para_code,
              p_tipr_codigo,
              p_component,
              p_subcomponent,
              p_aud_creado_en,
              p_aud_creado_por,
              p_aud_modificado_en,
              p_aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_TEMPLATE_MAP vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_template_map_tp.gat_template_map_ct)
   IS
      v_perf_id              gat_template_map_tp.perf_id_ct;
      v_ttem_codigo          gat_template_map_tp.ttem_codigo_ct;
      v_para_code            gat_template_map_tp.para_code_ct;
      v_tipr_codigo          gat_template_map_tp.tipr_codigo_ct;
      v_component            gat_template_map_tp.component_ct;
      v_subcomponent         gat_template_map_tp.subcomponent_ct;
      v_aud_creado_en        gat_template_map_tp.aud_creado_en_ct;
      v_aud_creado_por       gat_template_map_tp.aud_creado_por_ct;
      v_aud_modificado_en    gat_template_map_tp.aud_modificado_en_ct;
      v_aud_modificado_por   gat_template_map_tp.aud_modificado_por_ct;
   BEGIN
      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_perf_id (indx) := p_regs (indx).perf_id;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_ttem_codigo (indx) := p_regs (indx).ttem_codigo;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_para_code (indx) := p_regs (indx).para_code;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_tipr_codigo (indx) := p_regs (indx).tipr_codigo;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_component (indx) := p_regs (indx).component;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_subcomponent (indx) := p_regs (indx).subcomponent;
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
         INSERT INTO gat_template_map (perf_id,
                                       ttem_codigo,
                                       para_code,
                                       tipr_codigo,
                                       component,
                                       subcomponent,
                                       aud_creado_en,
                                       aud_creado_por,
                                       aud_modificado_en,
                                       aud_modificado_por)
         VALUES (v_perf_id (indx),
                 v_ttem_codigo (indx),
                 v_para_code (indx),
                 v_tipr_codigo (indx),
                 v_component (indx),
                 v_subcomponent (indx),
                 v_aud_creado_en (indx),
                 v_aud_creado_por (indx),
                 v_aud_modificado_en (indx),
                 v_aud_modificado_por (indx));

      v_perf_id.delete;
      v_ttem_codigo.delete;
      v_para_code.delete;
      v_tipr_codigo.delete;
      v_component.delete;
      v_subcomponent.delete;
      v_aud_creado_en.delete;
      v_aud_creado_por.delete;
      v_aud_modificado_en.delete;
      v_aud_modificado_por.delete;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_TEMPLATE_MAP vía colecciones de columnas
   PROCEDURE ins (p_perf_id              IN gat_template_map_tp.perf_id_ct,
                  p_ttem_codigo          IN gat_template_map_tp.ttem_codigo_ct,
                  p_para_code            IN gat_template_map_tp.para_code_ct,
                  p_tipr_codigo          IN gat_template_map_tp.tipr_codigo_ct,
                  p_component            IN gat_template_map_tp.component_ct,
                  p_subcomponent         IN gat_template_map_tp.subcomponent_ct,
                  p_aud_creado_en        IN gat_template_map_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN gat_template_map_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN gat_template_map_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN gat_template_map_tp.aud_modificado_por_ct)
   IS
   BEGIN
      FORALL indx IN p_perf_id.FIRST .. p_perf_id.LAST
         INSERT INTO gat_template_map (perf_id,
                                       ttem_codigo,
                                       para_code,
                                       tipr_codigo,
                                       component,
                                       subcomponent,
                                       aud_creado_en,
                                       aud_creado_por,
                                       aud_modificado_en,
                                       aud_modificado_por)
         VALUES (p_perf_id (indx),
                 p_ttem_codigo (indx),
                 p_para_code (indx),
                 p_tipr_codigo (indx),
                 p_component (indx),
                 p_subcomponent (indx),
                 p_aud_creado_en (indx),
                 p_aud_creado_por (indx),
                 p_aud_modificado_en (indx),
                 p_aud_modificado_por (indx));
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Actualiza un registro de GAT_TEMPLATE_MAP en función de la constraint TEMA_PK
   PROCEDURE upd_tema_pk (
      p_perf_id            IN gat_template_map_tp.perf_id_t,
      p_ttem_codigo        IN gat_template_map_tp.ttem_codigo_t,
      p_para_code          IN gat_template_map_tp.para_code_t,
      p_gat_template_map      gat_template_map_tp.gat_template_map_rt)
   IS
   BEGIN
      UPDATE gat_template_map
      SET tipr_codigo = p_gat_template_map.tipr_codigo,
          component = p_gat_template_map.component,
          subcomponent = p_gat_template_map.subcomponent,
          aud_creado_en = p_gat_template_map.aud_creado_en,
          aud_creado_por = p_gat_template_map.aud_creado_por,
          aud_modificado_en = p_gat_template_map.aud_modificado_en,
          aud_modificado_por = p_gat_template_map.aud_modificado_por
      WHERE perf_id = p_perf_id
        AND ttem_codigo = p_ttem_codigo
        AND para_code = p_para_code;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.upd_TEMA_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_tema_pk;

   -- Actualiza una columna de la tabla GAT_TEMPLATE_MAP en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_TEMPLATE_MAP '
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
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_TEMPLATE_MAP en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_TEMPLATE_MAP '
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
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_TEMPLATE_MAP en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_TEMPLATE_MAP '
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
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza un conjunto de columnas de la tabla GAT_TEMPLATE_MAP en función de la constraint TEMA_PK
   PROCEDURE upd_tema_pk (
      p_perf_id                IN gat_template_map_tp.perf_id_t,
      p_ttem_codigo            IN gat_template_map_tp.ttem_codigo_t,
      p_para_code              IN gat_template_map_tp.para_code_t,
      p_tipr_codigo               gat_template_map_tp.tipr_codigo_t DEFAULT NULL,
      p_component                 gat_template_map_tp.component_t DEFAULT NULL,
      p_subcomponent              gat_template_map_tp.subcomponent_t DEFAULT NULL,
      p_aud_creado_en             gat_template_map_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            gat_template_map_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         gat_template_map_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        gat_template_map_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE)
   IS
   BEGIN
      IF p_ignore_valores_nulos
      THEN
         UPDATE gat_template_map
         SET tipr_codigo = NVL (p_tipr_codigo, tipr_codigo),
             component = NVL (p_component, component),
             subcomponent = NVL (p_subcomponent, subcomponent),
             aud_creado_en = NVL (p_aud_creado_en, aud_creado_en),
             aud_creado_por = NVL (p_aud_creado_por, aud_creado_por),
             aud_modificado_en = NVL (p_aud_modificado_en, aud_modificado_en),
             aud_modificado_por = NVL (p_aud_modificado_por, aud_modificado_por)
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND para_code = p_para_code;
      ELSE
         UPDATE gat_template_map
         SET tipr_codigo = p_tipr_codigo,
             component = p_component,
             subcomponent = p_subcomponent,
             aud_creado_en = p_aud_creado_en,
             aud_creado_por = p_aud_creado_por,
             aud_modificado_en = p_aud_modificado_en,
             aud_modificado_por = p_aud_modificado_por
         WHERE perf_id = p_perf_id
           AND ttem_codigo = p_ttem_codigo
           AND para_code = p_para_code;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.upd_TEMA_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_tema_pk;

   -- Borra un registro de GAT_TEMPLATE_MAP en función de la constraint TEMA_PK
   PROCEDURE del_tema_pk (p_perf_id       IN     gat_template_map_tp.perf_id_t,
                          p_ttem_codigo   IN     gat_template_map_tp.ttem_codigo_t,
                          p_para_code     IN     gat_template_map_tp.para_code_t,
                          p_num_regs         OUT NUMBER)
   IS
   BEGIN
      DELETE gat_template_map
      WHERE perf_id = p_perf_id
        AND ttem_codigo = p_ttem_codigo
        AND para_code = p_para_code;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.del_TEMA_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_tema_pk;

   -- Borra un registro de GAT_TEMPLATE_MAP en función de la constraint TEMA_TPLT_FK2
   PROCEDURE del_tema_tplt_fk2 (p_perf_id       IN     gat_template_map_tp.perf_id_t,
                                p_ttem_codigo   IN     gat_template_map_tp.ttem_codigo_t,
                                p_num_regs         OUT NUMBER)
   IS
   BEGIN
      DELETE gat_template_map
      WHERE perf_id = p_perf_id AND ttem_codigo = p_ttem_codigo;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.del_TEMA_TPLT_FK2',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_tema_tplt_fk2;

   -- Borra un registro de GAT_TEMPLATE_MAP en función de la constraint TEMA_TPAR_FK1
   PROCEDURE del_tema_tpar_fk1 (p_tipr_codigo   IN     gat_template_map_tp.tipr_codigo_t,
                                p_num_regs         OUT NUMBER)
   IS
   BEGIN
      DELETE gat_template_map
      WHERE tipr_codigo = p_tipr_codigo;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.del_TEMA_TPAR_FK1',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_tema_tpar_fk1;

   -- Borra un registro de GAT_TEMPLATE_MAP en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER)
   IS
   BEGIN
      IF p_where IS NULL
      THEN
         EXECUTE IMMEDIATE 'delete GAT_TEMPLATE_MAP';
      ELSE
         EXECUTE IMMEDIATE 'delete GAT_TEMPLATE_MAP where ' || p_where;
      END IF;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.del_din',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_din;

   -- Borra un registro de GAT_TEMPLATE_MAP en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_TEMPLATE_MAP' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_TEMPLATE_MAP en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_TEMPLATE_MAP' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_TEMPLATE_MAP en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_TEMPLATE_MAP' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TEMPLATE_MAP_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;
END gat_template_map_cp;
/
SHOW ERRORS;


