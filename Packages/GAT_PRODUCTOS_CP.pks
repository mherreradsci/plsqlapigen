CREATE OR REPLACE PACKAGE GAT.gat_productos_cp
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
      RETURN NUMBER;

   -- Inserta un registro de la GAT_PRODUCTOS via un record
   PROCEDURE ins (p_gat_productos gat_productos_tp.gat_productos_rt);

   -- Inserta un registro de la GAT_PRODUCTOS via la Lista de Columnas
   PROCEDURE ins (
      p_prod_id               gat_productos_tp.prod_id_t,
      p_clie_id               gat_productos_tp.clie_id_t,
      p_appl_id               gat_productos_tp.appl_id_t,
      p_perf_id               gat_productos_tp.perf_id_t,
      p_aud_creado_en         gat_productos_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        gat_productos_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     gat_productos_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    gat_productos_tp.aud_modificado_por_t DEFAULT NULL);

   -- Inserta (modo bulk) registros de la GAT_PRODUCTOS vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_productos_tp.gat_productos_ct);

   -- Inserta (modo bulk) registros de la GAT_PRODUCTOS vía colecciones de columnas
   PROCEDURE ins (p_prod_id              IN gat_productos_tp.prod_id_ct,
                  p_clie_id              IN gat_productos_tp.clie_id_ct,
                  p_appl_id              IN gat_productos_tp.appl_id_ct,
                  p_perf_id              IN gat_productos_tp.perf_id_ct,
                  p_aud_creado_en        IN gat_productos_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN gat_productos_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN gat_productos_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN gat_productos_tp.aud_modificado_por_ct);

   -- Actualiza un registro de GAT_PRODUCTOS en función de la constraint PROD_PK
   PROCEDURE upd_prod_pk (p_prod_id         IN gat_productos_tp.prod_id_t,
                          p_gat_productos      gat_productos_tp.gat_productos_rt);

   -- Actualiza una columna de la tabla GAT_PRODUCTOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_PRODUCTOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_PRODUCTOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

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
      p_ignore_valores_nulos   IN BOOLEAN := FALSE);

   -- Borra un registro de GAT_PRODUCTOS en función de la constraint PROD_PK
   PROCEDURE del_prod_pk (p_prod_id IN gat_productos_tp.prod_id_t, p_num_regs OUT NUMBER);

   -- Borra un registro de GAT_PRODUCTOS en función de la constraint PROD_PERF_FK3
   PROCEDURE del_prod_perf_fk3 (p_perf_id    IN     gat_productos_tp.perf_id_t,
                                p_num_regs      OUT NUMBER);

   -- Borra un registro de GAT_PRODUCTOS en función de la constraint PROD_APPL_FK1
   PROCEDURE del_prod_appl_fk1 (p_appl_id    IN     gat_productos_tp.appl_id_t,
                                p_num_regs      OUT NUMBER);

   -- Borra un registro de GAT_PRODUCTOS en función de la constraint PROD_CLIE_FK2
   PROCEDURE del_prod_clie_fk2 (p_clie_id    IN     gat_productos_tp.clie_id_t,
                                p_num_regs      OUT NUMBER);

   -- Borra un registro de GAT_PRODUCTOS en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER);

   -- Borra un registro de GAT_PRODUCTOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_PRODUCTOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_PRODUCTOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);
END gat_productos_cp;
/
SHOW ERRORS;


