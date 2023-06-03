CREATE OR REPLACE PACKAGE BODY GAT.app_aplicaciones_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     APP_APLICACIONES_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               APP_APLICACIONES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   FUNCTION siguiente_clave (p_secuencia IN VARCHAR2 DEFAULT 'APP_APLICACIONES_SEC')
      RETURN NUMBER
   IS
      retval   NUMBER;
   BEGIN
      EXECUTE IMMEDIATE 'SELECT ' || p_secuencia || '.NEXTVAL FROM DUAL' INTO retval;

      RETURN retval;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.siguiente_clave',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END siguiente_clave;

   -- Inserta un registro de la APP_APLICACIONES via un record
   PROCEDURE ins (p_app_aplicaciones app_aplicaciones_tp.app_aplicaciones_rt)
   IS
   BEGIN
      INSERT INTO app_aplicaciones (appl_id,
                                    nombre_corto,
                                    nombre,
                                    aud_creado_en,
                                    aud_creado_por,
                                    aud_modificado_en,
                                    aud_modificado_por)
      VALUES (p_app_aplicaciones.appl_id,
              p_app_aplicaciones.nombre_corto,
              p_app_aplicaciones.nombre,
              p_app_aplicaciones.aud_creado_en,
              p_app_aplicaciones.aud_creado_por,
              p_app_aplicaciones.aud_modificado_en,
              p_app_aplicaciones.aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta un registro de la APP_APLICACIONES via la Lista de Columnas
   PROCEDURE ins (
      p_appl_id               app_aplicaciones_tp.appl_id_t,
      p_nombre_corto          app_aplicaciones_tp.nombre_corto_t,
      p_nombre                app_aplicaciones_tp.nombre_t,
      p_aud_creado_en         app_aplicaciones_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        app_aplicaciones_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     app_aplicaciones_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    app_aplicaciones_tp.aud_modificado_por_t DEFAULT NULL)
   IS
   BEGIN
      INSERT INTO app_aplicaciones (appl_id,
                                    nombre_corto,
                                    nombre,
                                    aud_creado_en,
                                    aud_creado_por,
                                    aud_modificado_en,
                                    aud_modificado_por)
      VALUES (p_appl_id,
              p_nombre_corto,
              p_nombre,
              p_aud_creado_en,
              p_aud_creado_por,
              p_aud_modificado_en,
              p_aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la APP_APLICACIONES vía un record de colección de columnas
   PROCEDURE ins (p_regs app_aplicaciones_tp.app_aplicaciones_ct)
   IS
      v_appl_id              app_aplicaciones_tp.appl_id_ct;
      v_nombre_corto         app_aplicaciones_tp.nombre_corto_ct;
      v_nombre               app_aplicaciones_tp.nombre_ct;
      v_aud_creado_en        app_aplicaciones_tp.aud_creado_en_ct;
      v_aud_creado_por       app_aplicaciones_tp.aud_creado_por_ct;
      v_aud_modificado_en    app_aplicaciones_tp.aud_modificado_en_ct;
      v_aud_modificado_por   app_aplicaciones_tp.aud_modificado_por_ct;
   BEGIN
      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_appl_id (indx) := p_regs (indx).appl_id;
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
         INSERT INTO app_aplicaciones (appl_id,
                                       nombre_corto,
                                       nombre,
                                       aud_creado_en,
                                       aud_creado_por,
                                       aud_modificado_en,
                                       aud_modificado_por)
         VALUES (v_appl_id (indx),
                 v_nombre_corto (indx),
                 v_nombre (indx),
                 v_aud_creado_en (indx),
                 v_aud_creado_por (indx),
                 v_aud_modificado_en (indx),
                 v_aud_modificado_por (indx));

      v_appl_id.delete;
      v_nombre_corto.delete;
      v_nombre.delete;
      v_aud_creado_en.delete;
      v_aud_creado_por.delete;
      v_aud_modificado_en.delete;
      v_aud_modificado_por.delete;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la APP_APLICACIONES vía colecciones de columnas
   PROCEDURE ins (p_appl_id              IN app_aplicaciones_tp.appl_id_ct,
                  p_nombre_corto         IN app_aplicaciones_tp.nombre_corto_ct,
                  p_nombre               IN app_aplicaciones_tp.nombre_ct,
                  p_aud_creado_en        IN app_aplicaciones_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN app_aplicaciones_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN app_aplicaciones_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN app_aplicaciones_tp.aud_modificado_por_ct)
   IS
   BEGIN
      FORALL indx IN p_appl_id.FIRST .. p_appl_id.LAST
         INSERT INTO app_aplicaciones (appl_id,
                                       nombre_corto,
                                       nombre,
                                       aud_creado_en,
                                       aud_creado_por,
                                       aud_modificado_en,
                                       aud_modificado_por)
         VALUES (p_appl_id (indx),
                 p_nombre_corto (indx),
                 p_nombre (indx),
                 p_aud_creado_en (indx),
                 p_aud_creado_por (indx),
                 p_aud_modificado_en (indx),
                 p_aud_modificado_por (indx));
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Actualiza un registro de APP_APLICACIONES en función de la constraint APPL_PK
   PROCEDURE upd_appl_pk (
      p_appl_id            IN app_aplicaciones_tp.appl_id_t,
      p_app_aplicaciones      app_aplicaciones_tp.app_aplicaciones_rt)
   IS
   BEGIN
      UPDATE app_aplicaciones
      SET nombre_corto = p_app_aplicaciones.nombre_corto,
          nombre = p_app_aplicaciones.nombre,
          aud_creado_en = p_app_aplicaciones.aud_creado_en,
          aud_creado_por = p_app_aplicaciones.aud_creado_por,
          aud_modificado_en = p_app_aplicaciones.aud_modificado_en,
          aud_modificado_por = p_app_aplicaciones.aud_modificado_por
      WHERE appl_id = p_appl_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.upd_APPL_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_appl_pk;

   -- Actualiza una columna de la tabla APP_APLICACIONES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update APP_APLICACIONES '
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
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla APP_APLICACIONES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update APP_APLICACIONES '
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
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla APP_APLICACIONES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update APP_APLICACIONES '
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
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza un conjunto de columnas de la tabla APP_APLICACIONES en función de la constraint APPL_PK
   PROCEDURE upd_appl_pk (
      p_appl_id                IN app_aplicaciones_tp.appl_id_t,
      p_nombre_corto              app_aplicaciones_tp.nombre_corto_t DEFAULT NULL,
      p_nombre                    app_aplicaciones_tp.nombre_t DEFAULT NULL,
      p_aud_creado_en             app_aplicaciones_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            app_aplicaciones_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         app_aplicaciones_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        app_aplicaciones_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE)
   IS
   BEGIN
      IF p_ignore_valores_nulos
      THEN
         UPDATE app_aplicaciones
         SET nombre_corto = NVL (p_nombre_corto, nombre_corto),
             nombre = NVL (p_nombre, nombre),
             aud_creado_en = NVL (p_aud_creado_en, aud_creado_en),
             aud_creado_por = NVL (p_aud_creado_por, aud_creado_por),
             aud_modificado_en = NVL (p_aud_modificado_en, aud_modificado_en),
             aud_modificado_por = NVL (p_aud_modificado_por, aud_modificado_por)
         WHERE appl_id = p_appl_id;
      ELSE
         UPDATE app_aplicaciones
         SET nombre_corto = p_nombre_corto,
             nombre = p_nombre,
             aud_creado_en = p_aud_creado_en,
             aud_creado_por = p_aud_creado_por,
             aud_modificado_en = p_aud_modificado_en,
             aud_modificado_por = p_aud_modificado_por
         WHERE appl_id = p_appl_id;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.upd_APPL_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_appl_pk;

   -- Borra un registro de APP_APLICACIONES en función de la constraint APPL_PK
   PROCEDURE del_appl_pk (p_appl_id    IN     app_aplicaciones_tp.appl_id_t,
                          p_num_regs      OUT NUMBER)
   IS
   BEGIN
      DELETE app_aplicaciones
      WHERE appl_id = p_appl_id;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.del_APPL_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_appl_pk;

   -- Borra un registro de APP_APLICACIONES en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER)
   IS
   BEGIN
      IF p_where IS NULL
      THEN
         EXECUTE IMMEDIATE 'delete APP_APLICACIONES';
      ELSE
         EXECUTE IMMEDIATE 'delete APP_APLICACIONES where ' || p_where;
      END IF;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.del_din',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_din;

   -- Borra un registro de APP_APLICACIONES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete APP_APLICACIONES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de APP_APLICACIONES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete APP_APLICACIONES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de APP_APLICACIONES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete APP_APLICACIONES' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'APP_APLICACIONES_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;
END app_aplicaciones_cp;
/
SHOW ERRORS;


