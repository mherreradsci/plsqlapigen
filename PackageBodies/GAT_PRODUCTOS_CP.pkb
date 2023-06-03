CREATE OR REPLACE PACKAGE BODY GAT.gat_productos_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_PRODUCTOS_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               GAT_PRODUCTOS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   FUNCTION siguiente_clave (p_secuencia IN VARCHAR2 DEFAULT 'GAT_PRODUCTOS_SEC')
      RETURN NUMBER
   IS
      retval   NUMBER;
   BEGIN
      EXECUTE IMMEDIATE 'SELECT ' || p_secuencia || '.NEXTVAL FROM DUAL' INTO retval;

      RETURN retval;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.siguiente_clave',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END siguiente_clave;

   -- Inserta un registro de la GAT_PRODUCTOS via un record
   PROCEDURE ins (p_gat_productos gat_productos_tp.gat_productos_rt)
   IS
   BEGIN
      INSERT INTO gat_productos (prod_id,
                                 clie_id,
                                 appl_id,
                                 perf_id,
                                 aud_creado_en,
                                 aud_creado_por,
                                 aud_modificado_en,
                                 aud_modificado_por)
      VALUES (p_gat_productos.prod_id,
              p_gat_productos.clie_id,
              p_gat_productos.appl_id,
              p_gat_productos.perf_id,
              p_gat_productos.aud_creado_en,
              p_gat_productos.aud_creado_por,
              p_gat_productos.aud_modificado_en,
              p_gat_productos.aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta un registro de la GAT_PRODUCTOS via la Lista de Columnas
   PROCEDURE ins (
      p_prod_id               gat_productos_tp.prod_id_t,
      p_clie_id               gat_productos_tp.clie_id_t,
      p_appl_id               gat_productos_tp.appl_id_t,
      p_perf_id               gat_productos_tp.perf_id_t,
      p_aud_creado_en         gat_productos_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        gat_productos_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     gat_productos_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    gat_productos_tp.aud_modificado_por_t DEFAULT NULL)
   IS
   BEGIN
      INSERT INTO gat_productos (prod_id,
                                 clie_id,
                                 appl_id,
                                 perf_id,
                                 aud_creado_en,
                                 aud_creado_por,
                                 aud_modificado_en,
                                 aud_modificado_por)
      VALUES (p_prod_id,
              p_clie_id,
              p_appl_id,
              p_perf_id,
              p_aud_creado_en,
              p_aud_creado_por,
              p_aud_modificado_en,
              p_aud_modificado_por);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_PRODUCTOS vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_productos_tp.gat_productos_ct)
   IS
      v_prod_id              gat_productos_tp.prod_id_ct;
      v_clie_id              gat_productos_tp.clie_id_ct;
      v_appl_id              gat_productos_tp.appl_id_ct;
      v_perf_id              gat_productos_tp.perf_id_ct;
      v_aud_creado_en        gat_productos_tp.aud_creado_en_ct;
      v_aud_creado_por       gat_productos_tp.aud_creado_por_ct;
      v_aud_modificado_en    gat_productos_tp.aud_modificado_en_ct;
      v_aud_modificado_por   gat_productos_tp.aud_modificado_por_ct;
   BEGIN
      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_prod_id (indx) := p_regs (indx).prod_id;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_clie_id (indx) := p_regs (indx).clie_id;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_appl_id (indx) := p_regs (indx).appl_id;
      END LOOP;

      FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP
         v_perf_id (indx) := p_regs (indx).perf_id;
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
         INSERT INTO gat_productos (prod_id,
                                    clie_id,
                                    appl_id,
                                    perf_id,
                                    aud_creado_en,
                                    aud_creado_por,
                                    aud_modificado_en,
                                    aud_modificado_por)
         VALUES (v_prod_id (indx),
                 v_clie_id (indx),
                 v_appl_id (indx),
                 v_perf_id (indx),
                 v_aud_creado_en (indx),
                 v_aud_creado_por (indx),
                 v_aud_modificado_en (indx),
                 v_aud_modificado_por (indx));

      v_prod_id.delete;
      v_clie_id.delete;
      v_appl_id.delete;
      v_perf_id.delete;
      v_aud_creado_en.delete;
      v_aud_creado_por.delete;
      v_aud_modificado_en.delete;
      v_aud_modificado_por.delete;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Inserta (modo bulk) registros de la GAT_PRODUCTOS vía colecciones de columnas
   PROCEDURE ins (p_prod_id              IN gat_productos_tp.prod_id_ct,
                  p_clie_id              IN gat_productos_tp.clie_id_ct,
                  p_appl_id              IN gat_productos_tp.appl_id_ct,
                  p_perf_id              IN gat_productos_tp.perf_id_ct,
                  p_aud_creado_en        IN gat_productos_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN gat_productos_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN gat_productos_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN gat_productos_tp.aud_modificado_por_ct)
   IS
   BEGIN
      FORALL indx IN p_prod_id.FIRST .. p_prod_id.LAST
         INSERT INTO gat_productos (prod_id,
                                    clie_id,
                                    appl_id,
                                    perf_id,
                                    aud_creado_en,
                                    aud_creado_por,
                                    aud_modificado_en,
                                    aud_modificado_por)
         VALUES (p_prod_id (indx),
                 p_clie_id (indx),
                 p_appl_id (indx),
                 p_perf_id (indx),
                 p_aud_creado_en (indx),
                 p_aud_creado_por (indx),
                 p_aud_modificado_en (indx),
                 p_aud_modificado_por (indx));
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.ins',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END ins;

   -- Actualiza un registro de GAT_PRODUCTOS en función de la constraint PROD_PK
   PROCEDURE upd_prod_pk (p_prod_id         IN gat_productos_tp.prod_id_t,
                          p_gat_productos      gat_productos_tp.gat_productos_rt)
   IS
   BEGIN
      UPDATE gat_productos
      SET clie_id = p_gat_productos.clie_id,
          appl_id = p_gat_productos.appl_id,
          perf_id = p_gat_productos.perf_id,
          aud_creado_en = p_gat_productos.aud_creado_en,
          aud_creado_por = p_gat_productos.aud_creado_por,
          aud_modificado_en = p_gat_productos.aud_modificado_en,
          aud_modificado_por = p_gat_productos.aud_modificado_por
      WHERE prod_id = p_prod_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.upd_PROD_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_prod_pk;

   -- Actualiza una columna de la tabla GAT_PRODUCTOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_PRODUCTOS '
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
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_PRODUCTOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_PRODUCTOS '
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
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza una columna de la tabla GAT_PRODUCTOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'update GAT_PRODUCTOS '
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
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.upd_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_por_una_columna;

   -- Actualiza un conjunto de columnas de la tabla GAT_PRODUCTOS en función de la constraint PROD_PK
   PROCEDURE upd_prod_pk (
      p_prod_id                IN gat_productos_tp.prod_id_t,
      p_clie_id                   gat_productos_tp.clie_id_t DEFAULT NULL,
      p_appl_id                   gat_productos_tp.appl_id_t DEFAULT NULL,
      p_perf_id                   gat_productos_tp.perf_id_t DEFAULT NULL,
      p_aud_creado_en             gat_productos_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            gat_productos_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         gat_productos_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        gat_productos_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE)
   IS
   BEGIN
      IF p_ignore_valores_nulos
      THEN
         UPDATE gat_productos
         SET clie_id = NVL (p_clie_id, clie_id),
             appl_id = NVL (p_appl_id, appl_id),
             perf_id = NVL (p_perf_id, perf_id),
             aud_creado_en = NVL (p_aud_creado_en, aud_creado_en),
             aud_creado_por = NVL (p_aud_creado_por, aud_creado_por),
             aud_modificado_en = NVL (p_aud_modificado_en, aud_modificado_en),
             aud_modificado_por = NVL (p_aud_modificado_por, aud_modificado_por)
         WHERE prod_id = p_prod_id;
      ELSE
         UPDATE gat_productos
         SET clie_id = p_clie_id,
             appl_id = p_appl_id,
             perf_id = p_perf_id,
             aud_creado_en = p_aud_creado_en,
             aud_creado_por = p_aud_creado_por,
             aud_modificado_en = p_aud_modificado_en,
             aud_modificado_por = p_aud_modificado_por
         WHERE prod_id = p_prod_id;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.upd_PROD_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END upd_prod_pk;

   -- Borra un registro de GAT_PRODUCTOS en función de la constraint PROD_PK
   PROCEDURE del_prod_pk (p_prod_id IN gat_productos_tp.prod_id_t, p_num_regs OUT NUMBER)
   IS
   BEGIN
      DELETE gat_productos
      WHERE prod_id = p_prod_id;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.del_PROD_PK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_prod_pk;

   -- Borra un registro de GAT_PRODUCTOS en función de la constraint PROD_PERF_FK3
   PROCEDURE del_prod_perf_fk3 (p_perf_id    IN     gat_productos_tp.perf_id_t,
                                p_num_regs      OUT NUMBER)
   IS
   BEGIN
      DELETE gat_productos
      WHERE perf_id = p_perf_id;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.del_PROD_PERF_FK3',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_prod_perf_fk3;

   -- Borra un registro de GAT_PRODUCTOS en función de la constraint PROD_APPL_FK1
   PROCEDURE del_prod_appl_fk1 (p_appl_id    IN     gat_productos_tp.appl_id_t,
                                p_num_regs      OUT NUMBER)
   IS
   BEGIN
      DELETE gat_productos
      WHERE appl_id = p_appl_id;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.del_PROD_APPL_FK1',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_prod_appl_fk1;

   -- Borra un registro de GAT_PRODUCTOS en función de la constraint PROD_CLIE_FK2
   PROCEDURE del_prod_clie_fk2 (p_clie_id    IN     gat_productos_tp.clie_id_t,
                                p_num_regs      OUT NUMBER)
   IS
   BEGIN
      DELETE gat_productos
      WHERE clie_id = p_clie_id;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.del_PROD_CLIE_FK2',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_prod_clie_fk2;

   -- Borra un registro de GAT_PRODUCTOS en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER)
   IS
   BEGIN
      IF p_where IS NULL
      THEN
         EXECUTE IMMEDIATE 'delete GAT_PRODUCTOS';
      ELSE
         EXECUTE IMMEDIATE 'delete GAT_PRODUCTOS where ' || p_where;
      END IF;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.del_din',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_din;

   -- Borra un registro de GAT_PRODUCTOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_PRODUCTOS' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_PRODUCTOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_PRODUCTOS' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;

   -- Borra un registro de GAT_PRODUCTOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
         'delete GAT_PRODUCTOS' || ' WHERE ' || p_nombre_columna || ' = :1'
         USING p_valor_columna;

      p_num_regs := SQL%ROWCOUNT;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'GAT_PRODUCTOS_CP.del_por_una_columna',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END del_por_una_columna;
END gat_productos_cp;
/
SHOW ERRORS;


