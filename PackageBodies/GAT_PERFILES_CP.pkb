CREATE OR REPLACE PACKAGE BODY GAT.gat_perfiles_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_PERFILES_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               GAT_PERFILES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   FUNCTION siguiente_clave (p_secuencia IN VARCHAR2 DEFAULT 'GAT_PERFILES_SEC')
      RETURN NUMBER
   IS
      retval   NUMBER;
   BEGIN
      EXECUTE IMMEDIATE 'SELECT ' || p_secuencia || '.NEXTVAL FROM DUAL' INTO retval;

      RETURN retval;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.siguiente_clave',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END siguiente_clave;

   -- Inserta un registro de la GAT_PERFILES via un record
   PROCEDURE ins (p_gat_perfiles gat_perfiles_tp.gat_perfiles_rt)
   IS
   BEGIN
      INSERT INTO gat_perfiles (perf_id,
                                empresa,
                                nombre,
                                nombre_corto,
                                descripcion,
                                aud_creado_en,
                                aud_creado_por,
                                aud_modificado_en,
                                aud_modificado_por)
      VALUES (p_gat_perfiles.perf_id,
              p_gat_perfiles.empresa,
              p_gat_perfiles.nombre,
              p_gat_perfiles.nombre_corto,
              p_gat_perfiles.descripcion,
              p_gat_perfiles.aud_creado_en,
              p_gat_perfiles.aud_creado_por,
              p_gat_perfiles.aud_modificado_en,
              p_gat_perfiles.aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta un registro de la GAT_PERFILES via la Lista de Columnas
   PROCEDURE ins (
      p_perf_id               gat_perfiles_tp.perf_id_t,
      p_empresa               gat_perfiles_tp.empresa_t,
      p_nombre                gat_perfiles_tp.nombre_t,
      p_nombre_corto          gat_perfiles_tp.nombre_corto_t,
      p_descripcion           gat_perfiles_tp.descripcion_t DEFAULT NULL,
      p_aud_creado_en         gat_perfiles_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        gat_perfiles_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     gat_perfiles_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    gat_perfiles_tp.aud_modificado_por_t DEFAULT NULL)
   IS
   BEGIN
      INSERT INTO gat_perfiles (perf_id,
                                empresa,
                                nombre,
                                nombre_corto,
                                descripcion,
                                aud_creado_en,
                                aud_creado_por,
                                aud_modificado_en,
                                aud_modificado_por)
      VALUES (p_perf_id,
              p_empresa,
              p_nombre,
              p_nombre_corto,
              p_descripcion,
              p_aud_creado_en,
              p_aud_creado_por,
              p_aud_modificado_en,
              p_aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_PERFILES vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_perfiles_tp.gat_perfiles_ct)
   IS
      v_perf_id              gat_perfiles_tp.perf_id_ct;
      v_empresa              gat_perfiles_tp.empresa_ct;
      v_nombre               gat_perfiles_tp.nombre_ct;
      v_nombre_corto         gat_perfiles_tp.nombre_corto_ct;
      v_descripcion          gat_perfiles_tp.descripcion_ct;
      v_aud_creado_en        gat_perfiles_tp.aud_creado_en_ct;
      v_aud_creado_por       gat_perfiles_tp.aud_creado_por_ct;
      v_aud_modificado_en    gat_perfiles_tp.aud_modificado_en_ct;
      v_aud_modificado_por   gat_perfiles_tp.aud_modificado_por_ct;
   BEGIN
      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_perf_id (indx) := p_regs (indx).perf_id;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_empresa (indx) := p_regs (indx).empresa;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_nombre (indx) := p_regs (indx).nombre;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_nombre_corto (indx) := p_regs (indx).nombre_corto;
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
         INSERT INTO gat_perfiles (perf_id,
                                   empresa,
                                   nombre,
                                   nombre_corto,
                                   descripcion,
                                   aud_creado_en,
                                   aud_creado_por,
                                   aud_modificado_en,
                                   aud_modificado_por)
         VALUES (v_perf_id (indx),
                 v_empresa (indx),
                 v_nombre (indx),
                 v_nombre_corto (indx),
                 v_descripcion (indx),
                 v_aud_creado_en (indx),
                 v_aud_creado_por (indx),
                 v_aud_modificado_en (indx),
                 v_aud_modificado_por (indx));

      v_perf_id.delete;
      v_empresa.delete;
      v_nombre.delete;
      v_nombre_corto.delete;
      v_descripcion.delete;
      v_aud_creado_en.delete;
      v_aud_creado_por.delete;
      v_aud_modificado_en.delete;
      v_aud_modificado_por.delete;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_PERFILES vía colecciones de columnas
   PROCEDURE ins (p_perf_id              IN gat_perfiles_tp.perf_id_ct,
                  p_empresa              IN gat_perfiles_tp.empresa_ct,
                  p_nombre               IN gat_perfiles_tp.nombre_ct,
                  p_nombre_corto         IN gat_perfiles_tp.nombre_corto_ct,
                  p_descripcion          IN gat_perfiles_tp.descripcion_ct,
                  p_aud_creado_en        IN gat_perfiles_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN gat_perfiles_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN gat_perfiles_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN gat_perfiles_tp.aud_modificado_por_ct)
   IS
   BEGIN
      FORALL indx IN p_perf_id.FIRST .. p_perf_id.LAST
         INSERT INTO gat_perfiles (perf_id,
                                   empresa,
                                   nombre,
                                   nombre_corto,
                                   descripcion,
                                   aud_creado_en,
                                   aud_creado_por,
                                   aud_modificado_en,
                                   aud_modificado_por)
         VALUES (p_perf_id (indx),
                 p_empresa (indx),
                 p_nombre (indx),
                 p_nombre_corto (indx),
                 p_descripcion (indx),
                 p_aud_creado_en (indx),
                 p_aud_creado_por (indx),
                 p_aud_modificado_en (indx),
                 p_aud_modificado_por (indx));
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Actualiza un registro de GAT_PERFILES en función de la constraint PERF_PK
   PROCEDURE upd_perf_pk (p_perf_id        IN gat_perfiles_tp.perf_id_t,
                          p_gat_perfiles      gat_perfiles_tp.gat_perfiles_rt)
   IS
   BEGIN
      UPDATE gat_perfiles
      SET empresa = p_gat_perfiles.empresa,
          nombre = p_gat_perfiles.nombre,
          nombre_corto = p_gat_perfiles.nombre_corto,
          descripcion = p_gat_perfiles.descripcion,
          aud_creado_en = p_gat_perfiles.aud_creado_en,
          aud_creado_por = p_gat_perfiles.aud_creado_por,
          aud_modificado_en = p_gat_perfiles.aud_modificado_en,
          aud_modificado_por = p_gat_perfiles.aud_modificado_por
      WHERE perf_id = p_perf_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.upd_PERF_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_perf_pk;

   -- Actualiza una columna de la tabla GAT_PERFILES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_PERFILES '
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
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_PERFILES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_PERFILES '
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
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_PERFILES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_PERFILES '
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
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza un conjunto de columnas de la tabla GAT_PERFILES en función de la constraint PERF_PK
   PROCEDURE upd_perf_pk (
      p_perf_id                IN gat_perfiles_tp.perf_id_t,
      p_empresa                   gat_perfiles_tp.empresa_t DEFAULT NULL,
      p_nombre                    gat_perfiles_tp.nombre_t DEFAULT NULL,
      p_nombre_corto              gat_perfiles_tp.nombre_corto_t DEFAULT NULL,
      p_descripcion               gat_perfiles_tp.descripcion_t DEFAULT NULL,
      p_aud_creado_en             gat_perfiles_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            gat_perfiles_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         gat_perfiles_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        gat_perfiles_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE)
   IS
   BEGIN
      IF p_ignore_valores_nulos
      THEN
         UPDATE gat_perfiles
         SET empresa = NVL (p_empresa, empresa),
             nombre = NVL (p_nombre, nombre),
             nombre_corto = NVL (p_nombre_corto, nombre_corto),
             descripcion = NVL (p_descripcion, descripcion),
             aud_creado_en = NVL (p_aud_creado_en, aud_creado_en),
             aud_creado_por = NVL (p_aud_creado_por, aud_creado_por),
             aud_modificado_en = NVL (p_aud_modificado_en, aud_modificado_en),
             aud_modificado_por = NVL (p_aud_modificado_por, aud_modificado_por)
         WHERE perf_id = p_perf_id;
      ELSE
         UPDATE gat_perfiles
         SET empresa = p_empresa,
             nombre = p_nombre,
             nombre_corto = p_nombre_corto,
             descripcion = p_descripcion,
             aud_creado_en = p_aud_creado_en,
             aud_creado_por = p_aud_creado_por,
             aud_modificado_en = p_aud_modificado_en,
             aud_modificado_por = p_aud_modificado_por
         WHERE perf_id = p_perf_id;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.upd_PERF_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_perf_pk;

   -- Borra un registro de GAT_PERFILES en función de la constraint PERF_PK
   PROCEDURE del_perf_pk (p_perf_id IN gat_perfiles_tp.perf_id_t, p_num_regs OUT NUMBER)
   IS
   BEGIN
      DELETE gat_perfiles
      WHERE perf_id = p_perf_id;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.del_PERF_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_perf_pk;

   -- Borra un registro de GAT_PERFILES en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER)
   IS
   BEGIN
      IF p_where IS NULL
      THEN
         EXECUTE IMMEDIATE 'delete GAT_PERFILES';
      ELSE
         EXECUTE IMMEDIATE 'delete GAT_PERFILES where ' || p_where;
      END IF;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.del_din',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_din;

   -- Borra un registro de GAT_PERFILES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE 'delete GAT_PERFILES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_PERFILES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE 'delete GAT_PERFILES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_PERFILES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE 'delete GAT_PERFILES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PERFILES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;
END gat_perfiles_cp;
/
SHOW ERRORS;


