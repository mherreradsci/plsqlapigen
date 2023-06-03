CREATE OR REPLACE PACKAGE GAT.gat_template_map_cp
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
   PROCEDURE ins (p_gat_template_map gat_template_map_tp.gat_template_map_rt);

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
      p_aud_modificado_por    gat_template_map_tp.aud_modificado_por_t DEFAULT NULL);

   -- Inserta (modo bulk) registros de la GAT_TEMPLATE_MAP vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_template_map_tp.gat_template_map_ct);

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
                  p_aud_modificado_por   IN gat_template_map_tp.aud_modificado_por_ct);

   -- Actualiza un registro de GAT_TEMPLATE_MAP en función de la constraint TEMA_PK
   PROCEDURE upd_tema_pk (
      p_perf_id            IN gat_template_map_tp.perf_id_t,
      p_ttem_codigo        IN gat_template_map_tp.ttem_codigo_t,
      p_para_code          IN gat_template_map_tp.para_code_t,
      p_gat_template_map      gat_template_map_tp.gat_template_map_rt);

   -- Actualiza una columna de la tabla GAT_TEMPLATE_MAP en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_TEMPLATE_MAP en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_TEMPLATE_MAP en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

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
      p_ignore_valores_nulos   IN BOOLEAN := FALSE);

   -- Borra un registro de GAT_TEMPLATE_MAP en función de la constraint TEMA_PK
   PROCEDURE del_tema_pk (p_perf_id       IN     gat_template_map_tp.perf_id_t,
                          p_ttem_codigo   IN     gat_template_map_tp.ttem_codigo_t,
                          p_para_code     IN     gat_template_map_tp.para_code_t,
                          p_num_regs         OUT NUMBER);

   -- Borra un registro de GAT_TEMPLATE_MAP en función de la constraint TEMA_TPLT_FK2
   PROCEDURE del_tema_tplt_fk2 (p_perf_id       IN     gat_template_map_tp.perf_id_t,
                                p_ttem_codigo   IN     gat_template_map_tp.ttem_codigo_t,
                                p_num_regs         OUT NUMBER);

   -- Borra un registro de GAT_TEMPLATE_MAP en función de la constraint TEMA_TPAR_FK1
   PROCEDURE del_tema_tpar_fk1 (p_tipr_codigo   IN     gat_template_map_tp.tipr_codigo_t,
                                p_num_regs         OUT NUMBER);

   -- Borra un registro de GAT_TEMPLATE_MAP en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER);

   -- Borra un registro de GAT_TEMPLATE_MAP en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_TEMPLATE_MAP en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_TEMPLATE_MAP en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);
END gat_template_map_cp;
/
SHOW ERRORS;


