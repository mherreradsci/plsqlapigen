CREATE OR REPLACE PACKAGE BODY GAT.gat_tip_packages_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_PACKAGES_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               GAT_TIP_PACKAGES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Inserta un registro de la GAT_TIP_PACKAGES via un record
   PROCEDURE ins (p_gat_tip_packages gat_tip_packages_tp.gat_tip_packages_rt)
   IS
   BEGIN
      INSERT INTO gat_tip_packages (tpac_codigo,
                                    nombre,
                                    glosa,
                                    generado,
                                    aud_creado_en,
                                    aud_creado_por,
                                    aud_modificado_en,
                                    aud_modificado_por)
      VALUES (p_gat_tip_packages.tpac_codigo,
              p_gat_tip_packages.nombre,
              p_gat_tip_packages.glosa,
              p_gat_tip_packages.generado,
              p_gat_tip_packages.aud_creado_en,
              p_gat_tip_packages.aud_creado_por,
              p_gat_tip_packages.aud_modificado_en,
              p_gat_tip_packages.aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta un registro de la GAT_TIP_PACKAGES via la Lista de Columnas
   PROCEDURE ins (
      p_tpac_codigo           gat_tip_packages_tp.tpac_codigo_t,
      p_nombre                gat_tip_packages_tp.nombre_t,
      p_glosa                 gat_tip_packages_tp.glosa_t,
      p_generado              gat_tip_packages_tp.generado_t,
      p_aud_creado_en         gat_tip_packages_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        gat_tip_packages_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     gat_tip_packages_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    gat_tip_packages_tp.aud_modificado_por_t DEFAULT NULL)
   IS
   BEGIN
      INSERT INTO gat_tip_packages (tpac_codigo,
                                    nombre,
                                    glosa,
                                    generado,
                                    aud_creado_en,
                                    aud_creado_por,
                                    aud_modificado_en,
                                    aud_modificado_por)
      VALUES (p_tpac_codigo,
              p_nombre,
              p_glosa,
              p_generado,
              p_aud_creado_en,
              p_aud_creado_por,
              p_aud_modificado_en,
              p_aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_TIP_PACKAGES vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_tip_packages_tp.gat_tip_packages_ct)
   IS
      v_tpac_codigo          gat_tip_packages_tp.tpac_codigo_ct;
      v_nombre               gat_tip_packages_tp.nombre_ct;
      v_glosa                gat_tip_packages_tp.glosa_ct;
      v_generado             gat_tip_packages_tp.generado_ct;
      v_aud_creado_en        gat_tip_packages_tp.aud_creado_en_ct;
      v_aud_creado_por       gat_tip_packages_tp.aud_creado_por_ct;
      v_aud_modificado_en    gat_tip_packages_tp.aud_modificado_en_ct;
      v_aud_modificado_por   gat_tip_packages_tp.aud_modificado_por_ct;
   BEGIN
      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_tpac_codigo (indx) := p_regs (indx).tpac_codigo;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_nombre (indx) := p_regs (indx).nombre;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_glosa (indx) := p_regs (indx).glosa;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_generado (indx) := p_regs (indx).generado;
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
         INSERT INTO gat_tip_packages (tpac_codigo,
                                       nombre,
                                       glosa,
                                       generado,
                                       aud_creado_en,
                                       aud_creado_por,
                                       aud_modificado_en,
                                       aud_modificado_por)
         VALUES (v_tpac_codigo (indx),
                 v_nombre (indx),
                 v_glosa (indx),
                 v_generado (indx),
                 v_aud_creado_en (indx),
                 v_aud_creado_por (indx),
                 v_aud_modificado_en (indx),
                 v_aud_modificado_por (indx));

      v_tpac_codigo.delete;
      v_nombre.delete;
      v_glosa.delete;
      v_generado.delete;
      v_aud_creado_en.delete;
      v_aud_creado_por.delete;
      v_aud_modificado_en.delete;
      v_aud_modificado_por.delete;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_TIP_PACKAGES vía colecciones de columnas
   PROCEDURE ins (p_tpac_codigo          IN gat_tip_packages_tp.tpac_codigo_ct,
                  p_nombre               IN gat_tip_packages_tp.nombre_ct,
                  p_glosa                IN gat_tip_packages_tp.glosa_ct,
                  p_generado             IN gat_tip_packages_tp.generado_ct,
                  p_aud_creado_en        IN gat_tip_packages_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN gat_tip_packages_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN gat_tip_packages_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN gat_tip_packages_tp.aud_modificado_por_ct)
   IS
   BEGIN
      FORALL indx IN p_tpac_codigo.FIRST .. p_tpac_codigo.LAST
         INSERT INTO gat_tip_packages (tpac_codigo,
                                       nombre,
                                       glosa,
                                       generado,
                                       aud_creado_en,
                                       aud_creado_por,
                                       aud_modificado_en,
                                       aud_modificado_por)
         VALUES (p_tpac_codigo (indx),
                 p_nombre (indx),
                 p_glosa (indx),
                 p_generado (indx),
                 p_aud_creado_en (indx),
                 p_aud_creado_por (indx),
                 p_aud_modificado_en (indx),
                 p_aud_modificado_por (indx));
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Actualiza un registro de GAT_TIP_PACKAGES en función de la constraint TPAC_PK
   PROCEDURE upd_tpac_pk (
      p_tpac_codigo        IN gat_tip_packages_tp.tpac_codigo_t,
      p_gat_tip_packages      gat_tip_packages_tp.gat_tip_packages_rt)
   IS
   BEGIN
      UPDATE gat_tip_packages
      SET aud_creado_en = p_gat_tip_packages.aud_creado_en,
          aud_creado_por = p_gat_tip_packages.aud_creado_por,
          aud_modificado_en = p_gat_tip_packages.aud_modificado_en,
          aud_modificado_por = p_gat_tip_packages.aud_modificado_por,
          generado = p_gat_tip_packages.generado,
          nombre = p_gat_tip_packages.nombre,
          glosa = p_gat_tip_packages.glosa
      WHERE tpac_codigo = p_tpac_codigo;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.upd_TPAC_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_tpac_pk;

   -- Actualiza una columna de la tabla GAT_TIP_PACKAGES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_TIP_PACKAGES '
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
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_TIP_PACKAGES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_TIP_PACKAGES '
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
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_TIP_PACKAGES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_TIP_PACKAGES '
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
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza un conjunto de columnas de la tabla GAT_TIP_PACKAGES en función de la constraint TPAC_PK
   PROCEDURE upd_tpac_pk (
      p_tpac_codigo            IN gat_tip_packages_tp.tpac_codigo_t,
      p_nombre                    gat_tip_packages_tp.nombre_t DEFAULT NULL,
      p_glosa                     gat_tip_packages_tp.glosa_t DEFAULT NULL,
      p_generado                  gat_tip_packages_tp.generado_t DEFAULT NULL,
      p_aud_creado_en             gat_tip_packages_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            gat_tip_packages_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         gat_tip_packages_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        gat_tip_packages_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE)
   IS
   BEGIN
      IF p_ignore_valores_nulos
      THEN
         UPDATE gat_tip_packages
         SET nombre = NVL (p_nombre, nombre),
             glosa = NVL (p_glosa, glosa),
             generado = NVL (p_generado, generado),
             aud_creado_en = NVL (p_aud_creado_en, aud_creado_en),
             aud_creado_por = NVL (p_aud_creado_por, aud_creado_por),
             aud_modificado_en = NVL (p_aud_modificado_en, aud_modificado_en),
             aud_modificado_por = NVL (p_aud_modificado_por, aud_modificado_por)
         WHERE tpac_codigo = p_tpac_codigo;
      ELSE
         UPDATE gat_tip_packages
         SET nombre = p_nombre,
             glosa = p_glosa,
             generado = p_generado,
             aud_creado_en = p_aud_creado_en,
             aud_creado_por = p_aud_creado_por,
             aud_modificado_en = p_aud_modificado_en,
             aud_modificado_por = p_aud_modificado_por
         WHERE tpac_codigo = p_tpac_codigo;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.upd_TPAC_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_tpac_pk;

   -- Borra un registro de GAT_TIP_PACKAGES en función de la constraint TPAC_PK
   PROCEDURE del_tpac_pk (p_tpac_codigo   IN     gat_tip_packages_tp.tpac_codigo_t,
                          p_num_regs         OUT NUMBER)
   IS
   BEGIN
      DELETE gat_tip_packages
      WHERE tpac_codigo = p_tpac_codigo;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.del_TPAC_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_tpac_pk;

   -- Borra un registro de GAT_TIP_PACKAGES en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER)
   IS
   BEGIN
      IF p_where IS NULL
      THEN
         EXECUTE IMMEDIATE 'delete GAT_TIP_PACKAGES';
      ELSE
         EXECUTE IMMEDIATE 'delete GAT_TIP_PACKAGES where ' || p_where;
      END IF;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.del_din',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_din;

   -- Borra un registro de GAT_TIP_PACKAGES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_TIP_PACKAGES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_TIP_PACKAGES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_TIP_PACKAGES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_TIP_PACKAGES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_TIP_PACKAGES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_TIP_PACKAGES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;
END gat_tip_packages_cp;
/
SHOW ERRORS;


