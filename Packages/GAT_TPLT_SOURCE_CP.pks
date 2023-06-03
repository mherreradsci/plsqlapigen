CREATE OR REPLACE PACKAGE GAT.gat_tplt_source_cp
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
   PROCEDURE ins (p_gat_tplt_source gat_tplt_source_tp.gat_tplt_source_rt);

   -- Inserta un registro de la GAT_TPLT_SOURCE via la Lista de Columnas
   PROCEDURE ins (
      p_perf_id               gat_tplt_source_tp.perf_id_t,
      p_ttem_codigo           gat_tplt_source_tp.ttem_codigo_t,
      p_tpso_id               gat_tplt_source_tp.tpso_id_t,
      p_linea                 gat_tplt_source_tp.linea_t,
      p_aud_creado_en         gat_tplt_source_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        gat_tplt_source_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     gat_tplt_source_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    gat_tplt_source_tp.aud_modificado_por_t DEFAULT NULL);

   -- Inserta (modo bulk) registros de la GAT_TPLT_SOURCE vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_tplt_source_tp.gat_tplt_source_ct);

   -- Inserta (modo bulk) registros de la GAT_TPLT_SOURCE vía colecciones de columnas
   PROCEDURE ins (p_perf_id              IN gat_tplt_source_tp.perf_id_ct,
                  p_ttem_codigo          IN gat_tplt_source_tp.ttem_codigo_ct,
                  p_tpso_id              IN gat_tplt_source_tp.tpso_id_ct,
                  p_linea                IN gat_tplt_source_tp.linea_ct,
                  p_aud_creado_en        IN gat_tplt_source_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN gat_tplt_source_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN gat_tplt_source_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN gat_tplt_source_tp.aud_modificado_por_ct);

   -- Actualiza un registro de GAT_TPLT_SOURCE en función de la constraint TPSO_PK
   PROCEDURE upd_tpso_pk (p_perf_id           IN gat_tplt_source_tp.perf_id_t,
                          p_ttem_codigo       IN gat_tplt_source_tp.ttem_codigo_t,
                          p_tpso_id           IN gat_tplt_source_tp.tpso_id_t,
                          p_gat_tplt_source      gat_tplt_source_tp.gat_tplt_source_rt);

   -- Actualiza una columna de la tabla GAT_TPLT_SOURCE en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_TPLT_SOURCE en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_TPLT_SOURCE en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

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
      p_ignore_valores_nulos   IN BOOLEAN := FALSE);

   -- Borra un registro de GAT_TPLT_SOURCE en función de la constraint TPSO_PK
   PROCEDURE del_tpso_pk (p_perf_id       IN     gat_tplt_source_tp.perf_id_t,
                          p_ttem_codigo   IN     gat_tplt_source_tp.ttem_codigo_t,
                          p_tpso_id       IN     gat_tplt_source_tp.tpso_id_t,
                          p_num_regs         OUT NUMBER);

   -- Borra un registro de GAT_TPLT_SOURCE en función de la constraint TPSO_TPLT_FK1
   PROCEDURE del_tpso_tplt_fk1 (p_perf_id       IN     gat_tplt_source_tp.perf_id_t,
                                p_ttem_codigo   IN     gat_tplt_source_tp.ttem_codigo_t,
                                p_num_regs         OUT NUMBER);

   -- Borra un registro de GAT_TPLT_SOURCE en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER);

   -- Borra un registro de GAT_TPLT_SOURCE en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_TPLT_SOURCE en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_TPLT_SOURCE en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);
END gat_tplt_source_cp;
/
SHOW ERRORS;


