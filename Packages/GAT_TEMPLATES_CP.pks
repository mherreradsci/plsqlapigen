CREATE OR REPLACE PACKAGE GAT.gat_templates_cp
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
   PROCEDURE ins (p_gat_templates gat_templates_tp.gat_templates_rt);

   -- Inserta un registro de la GAT_TEMPLATES via la Lista de Columnas
   PROCEDURE ins (
      p_perf_id               gat_templates_tp.perf_id_t,
      p_ttem_codigo           gat_templates_tp.ttem_codigo_t,
      p_nombre                gat_templates_tp.nombre_t DEFAULT NULL,
      p_contenido             gat_templates_tp.contenido_t DEFAULT NULL,
      p_aud_creado_en         gat_templates_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        gat_templates_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     gat_templates_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    gat_templates_tp.aud_modificado_por_t DEFAULT NULL);

   -- Inserta (modo bulk) registros de la GAT_TEMPLATES vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_templates_tp.gat_templates_ct);

   -- Inserta (modo bulk) registros de la GAT_TEMPLATES vía colecciones de columnas
   PROCEDURE ins (p_perf_id              IN gat_templates_tp.perf_id_ct,
                  p_ttem_codigo          IN gat_templates_tp.ttem_codigo_ct,
                  p_nombre               IN gat_templates_tp.nombre_ct,
                  p_contenido            IN gat_templates_tp.contenido_ct,
                  p_aud_creado_en        IN gat_templates_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN gat_templates_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN gat_templates_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN gat_templates_tp.aud_modificado_por_ct);

   -- Actualiza un registro de GAT_TEMPLATES en función de la constraint TPLT_PK
   PROCEDURE upd_tplt_pk (p_perf_id         IN gat_templates_tp.perf_id_t,
                          p_ttem_codigo     IN gat_templates_tp.ttem_codigo_t,
                          p_gat_templates      gat_templates_tp.gat_templates_rt);

   -- Actualiza una columna de la tabla GAT_TEMPLATES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_TEMPLATES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_TEMPLATES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

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
      p_ignore_valores_nulos   IN BOOLEAN := FALSE);

   -- Borra un registro de GAT_TEMPLATES en función de la constraint TPLT_PK
   PROCEDURE del_tplt_pk (p_perf_id       IN     gat_templates_tp.perf_id_t,
                          p_ttem_codigo   IN     gat_templates_tp.ttem_codigo_t,
                          p_num_regs         OUT NUMBER);

   -- Borra un registro de GAT_TEMPLATES en función de la constraint TPLT_PERF_FK1
   PROCEDURE del_tplt_perf_fk1 (p_perf_id    IN     gat_templates_tp.perf_id_t,
                                p_num_regs      OUT NUMBER);

   -- Borra un registro de GAT_TEMPLATES en función de la constraint TPLT_TTEM_FK2
   PROCEDURE del_tplt_ttem_fk2 (p_ttem_codigo   IN     gat_templates_tp.ttem_codigo_t,
                                p_num_regs         OUT NUMBER);

   -- Borra un registro de GAT_TEMPLATES en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER);

   -- Borra un registro de GAT_TEMPLATES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_TEMPLATES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_TEMPLATES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);
END gat_templates_cp;
/
SHOW ERRORS;


