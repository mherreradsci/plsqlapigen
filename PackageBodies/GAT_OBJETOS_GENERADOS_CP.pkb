CREATE OR REPLACE PACKAGE BODY GAT.gat_objetos_generados_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_OBJETOS_GENERADOS_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               GAT_OBJETOS_GENERADOS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Inserta un registro de la GAT_OBJETOS_GENERADOS via un record
   PROCEDURE ins (
      p_gat_objetos_generados gat_objetos_generados_tp.gat_objetos_generados_rt)
   IS
   BEGIN
      INSERT INTO gat_objetos_generados (prod_id,
                                         nombre_objeto,
                                         tobj_codigo,
                                         primera_generacion,
                                         ultima_generacion,
                                         version_generador,
                                         total_generaciones,
                                         compilado,
                                         aud_creado_en,
                                         aud_creado_por,
                                         aud_modificado_en,
                                         aud_modificado_por)
      VALUES (p_gat_objetos_generados.prod_id,
              p_gat_objetos_generados.nombre_objeto,
              p_gat_objetos_generados.tobj_codigo,
              p_gat_objetos_generados.primera_generacion,
              p_gat_objetos_generados.ultima_generacion,
              p_gat_objetos_generados.version_generador,
              p_gat_objetos_generados.total_generaciones,
              p_gat_objetos_generados.compilado,
              p_gat_objetos_generados.aud_creado_en,
              p_gat_objetos_generados.aud_creado_por,
              p_gat_objetos_generados.aud_modificado_en,
              p_gat_objetos_generados.aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta un registro de la GAT_OBJETOS_GENERADOS via la Lista de Columnas
   PROCEDURE ins (
      p_prod_id               gat_objetos_generados_tp.prod_id_t,
      p_nombre_objeto         gat_objetos_generados_tp.nombre_objeto_t,
      p_tobj_codigo           gat_objetos_generados_tp.tobj_codigo_t,
      p_primera_generacion    gat_objetos_generados_tp.primera_generacion_t,
      p_ultima_generacion     gat_objetos_generados_tp.ultima_generacion_t,
      p_version_generador     gat_objetos_generados_tp.version_generador_t DEFAULT NULL,
      p_total_generaciones    gat_objetos_generados_tp.total_generaciones_t,
      p_compilado             gat_objetos_generados_tp.compilado_t DEFAULT NULL,
      p_aud_creado_en         gat_objetos_generados_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        gat_objetos_generados_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     gat_objetos_generados_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    gat_objetos_generados_tp.aud_modificado_por_t DEFAULT NULL)
   IS
   BEGIN
      INSERT INTO gat_objetos_generados (prod_id,
                                         nombre_objeto,
                                         tobj_codigo,
                                         primera_generacion,
                                         ultima_generacion,
                                         version_generador,
                                         total_generaciones,
                                         compilado,
                                         aud_creado_en,
                                         aud_creado_por,
                                         aud_modificado_en,
                                         aud_modificado_por)
      VALUES (p_prod_id,
              p_nombre_objeto,
              p_tobj_codigo,
              p_primera_generacion,
              p_ultima_generacion,
              p_version_generador,
              p_total_generaciones,
              p_compilado,
              p_aud_creado_en,
              p_aud_creado_por,
              p_aud_modificado_en,
              p_aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_OBJETOS_GENERADOS vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_objetos_generados_tp.gat_objetos_generados_ct)
   IS
      v_prod_id              gat_objetos_generados_tp.prod_id_ct;
      v_nombre_objeto        gat_objetos_generados_tp.nombre_objeto_ct;
      v_tobj_codigo          gat_objetos_generados_tp.tobj_codigo_ct;
      v_primera_generacion   gat_objetos_generados_tp.primera_generacion_ct;
      v_ultima_generacion    gat_objetos_generados_tp.ultima_generacion_ct;
      v_version_generador    gat_objetos_generados_tp.version_generador_ct;
      v_total_generaciones   gat_objetos_generados_tp.total_generaciones_ct;
      v_compilado            gat_objetos_generados_tp.compilado_ct;
      v_aud_creado_en        gat_objetos_generados_tp.aud_creado_en_ct;
      v_aud_creado_por       gat_objetos_generados_tp.aud_creado_por_ct;
      v_aud_modificado_en    gat_objetos_generados_tp.aud_modificado_en_ct;
      v_aud_modificado_por   gat_objetos_generados_tp.aud_modificado_por_ct;
   BEGIN
      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_prod_id (indx) := p_regs (indx).prod_id;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_nombre_objeto (indx) := p_regs (indx).nombre_objeto;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_tobj_codigo (indx) := p_regs (indx).tobj_codigo;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_primera_generacion (indx) := p_regs (indx).primera_generacion;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_ultima_generacion (indx) := p_regs (indx).ultima_generacion;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_version_generador (indx) := p_regs (indx).version_generador;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_total_generaciones (indx) := p_regs (indx).total_generaciones;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_compilado (indx) := p_regs (indx).compilado;
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
         INSERT INTO gat_objetos_generados (prod_id,
                                            nombre_objeto,
                                            tobj_codigo,
                                            primera_generacion,
                                            ultima_generacion,
                                            version_generador,
                                            total_generaciones,
                                            compilado,
                                            aud_creado_en,
                                            aud_creado_por,
                                            aud_modificado_en,
                                            aud_modificado_por)
         VALUES (v_prod_id (indx),
                 v_nombre_objeto (indx),
                 v_tobj_codigo (indx),
                 v_primera_generacion (indx),
                 v_ultima_generacion (indx),
                 v_version_generador (indx),
                 v_total_generaciones (indx),
                 v_compilado (indx),
                 v_aud_creado_en (indx),
                 v_aud_creado_por (indx),
                 v_aud_modificado_en (indx),
                 v_aud_modificado_por (indx));

      v_prod_id.delete;
      v_nombre_objeto.delete;
      v_tobj_codigo.delete;
      v_primera_generacion.delete;
      v_ultima_generacion.delete;
      v_version_generador.delete;
      v_total_generaciones.delete;
      v_compilado.delete;
      v_aud_creado_en.delete;
      v_aud_creado_por.delete;
      v_aud_modificado_en.delete;
      v_aud_modificado_por.delete;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_OBJETOS_GENERADOS vía colecciones de columnas
   PROCEDURE ins (
      p_prod_id              IN gat_objetos_generados_tp.prod_id_ct,
      p_nombre_objeto        IN gat_objetos_generados_tp.nombre_objeto_ct,
      p_tobj_codigo          IN gat_objetos_generados_tp.tobj_codigo_ct,
      p_primera_generacion   IN gat_objetos_generados_tp.primera_generacion_ct,
      p_ultima_generacion    IN gat_objetos_generados_tp.ultima_generacion_ct,
      p_version_generador    IN gat_objetos_generados_tp.version_generador_ct,
      p_total_generaciones   IN gat_objetos_generados_tp.total_generaciones_ct,
      p_compilado            IN gat_objetos_generados_tp.compilado_ct,
      p_aud_creado_en        IN gat_objetos_generados_tp.aud_creado_en_ct,
      p_aud_creado_por       IN gat_objetos_generados_tp.aud_creado_por_ct,
      p_aud_modificado_en    IN gat_objetos_generados_tp.aud_modificado_en_ct,
      p_aud_modificado_por   IN gat_objetos_generados_tp.aud_modificado_por_ct)
   IS
   BEGIN
      FORALL indx IN p_prod_id.FIRST .. p_prod_id.LAST
         INSERT INTO gat_objetos_generados (prod_id,
                                            nombre_objeto,
                                            tobj_codigo,
                                            primera_generacion,
                                            ultima_generacion,
                                            version_generador,
                                            total_generaciones,
                                            compilado,
                                            aud_creado_en,
                                            aud_creado_por,
                                            aud_modificado_en,
                                            aud_modificado_por)
         VALUES (p_prod_id (indx),
                 p_nombre_objeto (indx),
                 p_tobj_codigo (indx),
                 p_primera_generacion (indx),
                 p_ultima_generacion (indx),
                 p_version_generador (indx),
                 p_total_generaciones (indx),
                 p_compilado (indx),
                 p_aud_creado_en (indx),
                 p_aud_creado_por (indx),
                 p_aud_modificado_en (indx),
                 p_aud_modificado_por (indx));
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Actualiza un registro de GAT_OBJETOS_GENERADOS en función de la constraint OBGE_PK
   PROCEDURE upd_obge_pk (
      p_prod_id                 IN gat_objetos_generados_tp.prod_id_t,
      p_nombre_objeto           IN gat_objetos_generados_tp.nombre_objeto_t,
      p_tobj_codigo             IN gat_objetos_generados_tp.tobj_codigo_t,
      p_gat_objetos_generados      gat_objetos_generados_tp.gat_objetos_generados_rt)
   IS
   BEGIN
      UPDATE gat_objetos_generados
      SET primera_generacion = p_gat_objetos_generados.primera_generacion,
          ultima_generacion = p_gat_objetos_generados.ultima_generacion,
          version_generador = p_gat_objetos_generados.version_generador,
          total_generaciones = p_gat_objetos_generados.total_generaciones,
          compilado = p_gat_objetos_generados.compilado,
          aud_creado_en = p_gat_objetos_generados.aud_creado_en,
          aud_creado_por = p_gat_objetos_generados.aud_creado_por,
          aud_modificado_en = p_gat_objetos_generados.aud_modificado_en,
          aud_modificado_por = p_gat_objetos_generados.aud_modificado_por
      WHERE prod_id = p_prod_id
        AND nombre_objeto = p_nombre_objeto
        AND tobj_codigo = p_tobj_codigo;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_CP.upd_OBGE_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_obge_pk;

   -- Actualiza una columna de la tabla GAT_OBJETOS_GENERADOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_OBJETOS_GENERADOS '
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
         utl_error.informa (
            p_programa   => 'GAT_OBJETOS_GENERADOS_CP.upd_por_una_columna',
            p_mensaje    => SQLERRM,
            p_rollback   => FALSE,
            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_OBJETOS_GENERADOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_OBJETOS_GENERADOS '
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
         utl_error.informa (
            p_programa   => 'GAT_OBJETOS_GENERADOS_CP.upd_por_una_columna',
            p_mensaje    => SQLERRM,
            p_rollback   => FALSE,
            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_OBJETOS_GENERADOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_OBJETOS_GENERADOS '
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
         utl_error.informa (
            p_programa   => 'GAT_OBJETOS_GENERADOS_CP.upd_por_una_columna',
            p_mensaje    => SQLERRM,
            p_rollback   => FALSE,
            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza un conjunto de columnas de la tabla GAT_OBJETOS_GENERADOS en función de la constraint OBGE_PK
   PROCEDURE upd_obge_pk (
      p_prod_id                IN gat_objetos_generados_tp.prod_id_t,
      p_nombre_objeto          IN gat_objetos_generados_tp.nombre_objeto_t,
      p_tobj_codigo            IN gat_objetos_generados_tp.tobj_codigo_t,
      p_primera_generacion        gat_objetos_generados_tp.primera_generacion_t DEFAULT NULL,
      p_ultima_generacion         gat_objetos_generados_tp.ultima_generacion_t DEFAULT NULL,
      p_version_generador         gat_objetos_generados_tp.version_generador_t DEFAULT NULL,
      p_total_generaciones        gat_objetos_generados_tp.total_generaciones_t DEFAULT NULL,
      p_compilado                 gat_objetos_generados_tp.compilado_t DEFAULT NULL,
      p_aud_creado_en             gat_objetos_generados_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            gat_objetos_generados_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         gat_objetos_generados_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        gat_objetos_generados_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE)
   IS
   BEGIN
      IF p_ignore_valores_nulos
      THEN
         UPDATE gat_objetos_generados
         SET primera_generacion = NVL (p_primera_generacion, primera_generacion),
             ultima_generacion = NVL (p_ultima_generacion, ultima_generacion),
             version_generador = NVL (p_version_generador, version_generador),
             total_generaciones = NVL (p_total_generaciones, total_generaciones),
             compilado = NVL (p_compilado, compilado),
             aud_creado_en = NVL (p_aud_creado_en, aud_creado_en),
             aud_creado_por = NVL (p_aud_creado_por, aud_creado_por),
             aud_modificado_en = NVL (p_aud_modificado_en, aud_modificado_en),
             aud_modificado_por = NVL (p_aud_modificado_por, aud_modificado_por)
         WHERE prod_id = p_prod_id
           AND nombre_objeto = p_nombre_objeto
           AND tobj_codigo = p_tobj_codigo;
      ELSE
         UPDATE gat_objetos_generados
         SET primera_generacion = p_primera_generacion,
             ultima_generacion = p_ultima_generacion,
             version_generador = p_version_generador,
             total_generaciones = p_total_generaciones,
             compilado = p_compilado,
             aud_creado_en = p_aud_creado_en,
             aud_creado_por = p_aud_creado_por,
             aud_modificado_en = p_aud_modificado_en,
             aud_modificado_por = p_aud_modificado_por
         WHERE prod_id = p_prod_id
           AND nombre_objeto = p_nombre_objeto
           AND tobj_codigo = p_tobj_codigo;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_CP.upd_OBGE_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_obge_pk;

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de la constraint OBGE_PK
   PROCEDURE del_obge_pk (
      p_prod_id         IN     gat_objetos_generados_tp.prod_id_t,
      p_nombre_objeto   IN     gat_objetos_generados_tp.nombre_objeto_t,
      p_tobj_codigo     IN     gat_objetos_generados_tp.tobj_codigo_t,
      p_num_regs           OUT NUMBER)
   IS
   BEGIN
      DELETE gat_objetos_generados
      WHERE prod_id = p_prod_id
        AND nombre_objeto = p_nombre_objeto
        AND tobj_codigo = p_tobj_codigo;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_CP.del_OBGE_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_obge_pk;

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de la constraint OBGE_PROD_FK1
   PROCEDURE del_obge_prod_fk1 (p_prod_id    IN     gat_objetos_generados_tp.prod_id_t,
                                p_num_regs      OUT NUMBER)
   IS
   BEGIN
      DELETE gat_objetos_generados
      WHERE prod_id = p_prod_id;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_CP.del_OBGE_PROD_FK1',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_obge_prod_fk1;

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de la constraint OBGE_TOBJ_FK2
   PROCEDURE del_obge_tobj_fk2 (
      p_tobj_codigo   IN     gat_objetos_generados_tp.tobj_codigo_t,
      p_num_regs         OUT NUMBER)
   IS
   BEGIN
      DELETE gat_objetos_generados
      WHERE tobj_codigo = p_tobj_codigo;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_CP.del_OBGE_TOBJ_FK2',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_obge_tobj_fk2;

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER)
   IS
   BEGIN
      IF p_where IS NULL
      THEN
         EXECUTE IMMEDIATE 'delete GAT_OBJETOS_GENERADOS';
      ELSE
         EXECUTE IMMEDIATE 'delete GAT_OBJETOS_GENERADOS where ' || p_where;
      END IF;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_OBJETOS_GENERADOS_CP.del_din',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_din;

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_OBJETOS_GENERADOS' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (
            p_programa   => 'GAT_OBJETOS_GENERADOS_CP.del_por_una_columna',
            p_mensaje    => SQLERRM,
            p_rollback   => FALSE,
            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_OBJETOS_GENERADOS' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (
            p_programa   => 'GAT_OBJETOS_GENERADOS_CP.del_por_una_columna',
            p_mensaje    => SQLERRM,
            p_rollback   => FALSE,
            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_OBJETOS_GENERADOS' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (
            p_programa   => 'GAT_OBJETOS_GENERADOS_CP.del_por_una_columna',
            p_mensaje    => SQLERRM,
            p_rollback   => FALSE,
            p_raise      => TRUE);
   END del_por_una_columna;
END gat_objetos_generados_cp;
/
SHOW ERRORS;


