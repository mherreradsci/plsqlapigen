CREATE OR REPLACE PACKAGE GAT.gat_rel_tplt_tpac_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_REL_TPLT_TPAC_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               GAT_REL_TPLT_TPAC
   Descipción de la tabla:
   Relación entre los Templates y Tipos de packages

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Inserta un registro de la GAT_REL_TPLT_TPAC via un record
   PROCEDURE ins (p_gat_rel_tplt_tpac gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rt);

   -- Inserta un registro de la GAT_REL_TPLT_TPAC via la Lista de Columnas
   PROCEDURE ins (
      p_perf_id               gat_rel_tplt_tpac_tp.perf_id_t,
      p_ttem_codigo           gat_rel_tplt_tpac_tp.ttem_codigo_t,
      p_tpac_codigo           gat_rel_tplt_tpac_tp.tpac_codigo_t,
      p_descripcion           gat_rel_tplt_tpac_tp.descripcion_t DEFAULT NULL,
      p_aud_creado_en         gat_rel_tplt_tpac_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        gat_rel_tplt_tpac_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     gat_rel_tplt_tpac_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    gat_rel_tplt_tpac_tp.aud_modificado_por_t DEFAULT NULL);

   -- Inserta (modo bulk) registros de la GAT_REL_TPLT_TPAC vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_ct);

   -- Inserta (modo bulk) registros de la GAT_REL_TPLT_TPAC vía colecciones de columnas
   PROCEDURE ins (p_perf_id              IN gat_rel_tplt_tpac_tp.perf_id_ct,
                  p_ttem_codigo          IN gat_rel_tplt_tpac_tp.ttem_codigo_ct,
                  p_tpac_codigo          IN gat_rel_tplt_tpac_tp.tpac_codigo_ct,
                  p_descripcion          IN gat_rel_tplt_tpac_tp.descripcion_ct,
                  p_aud_creado_en        IN gat_rel_tplt_tpac_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN gat_rel_tplt_tpac_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN gat_rel_tplt_tpac_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN gat_rel_tplt_tpac_tp.aud_modificado_por_ct);

   -- Actualiza un registro de GAT_REL_TPLT_TPAC en función de la constraint TPTP_PK
   PROCEDURE upd_tptp_pk (
      p_perf_id             IN gat_rel_tplt_tpac_tp.perf_id_t,
      p_ttem_codigo         IN gat_rel_tplt_tpac_tp.ttem_codigo_t,
      p_tpac_codigo         IN gat_rel_tplt_tpac_tp.tpac_codigo_t,
      p_gat_rel_tplt_tpac      gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rt);

   -- Actualiza una columna de la tabla GAT_REL_TPLT_TPAC en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_REL_TPLT_TPAC en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_REL_TPLT_TPAC en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza un conjunto de columnas de la tabla GAT_REL_TPLT_TPAC en función de la constraint TPTP_PK
   PROCEDURE upd_tptp_pk (
      p_perf_id                IN gat_rel_tplt_tpac_tp.perf_id_t,
      p_ttem_codigo            IN gat_rel_tplt_tpac_tp.ttem_codigo_t,
      p_tpac_codigo            IN gat_rel_tplt_tpac_tp.tpac_codigo_t,
      p_descripcion               gat_rel_tplt_tpac_tp.descripcion_t DEFAULT NULL,
      p_aud_creado_en             gat_rel_tplt_tpac_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            gat_rel_tplt_tpac_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         gat_rel_tplt_tpac_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        gat_rel_tplt_tpac_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE);

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de la constraint TPTP_PK
   PROCEDURE del_tptp_pk (p_perf_id       IN     gat_rel_tplt_tpac_tp.perf_id_t,
                          p_ttem_codigo   IN     gat_rel_tplt_tpac_tp.ttem_codigo_t,
                          p_tpac_codigo   IN     gat_rel_tplt_tpac_tp.tpac_codigo_t,
                          p_num_regs         OUT NUMBER);

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de la constraint TPTP_TPLT_FK2
   PROCEDURE del_tptp_tplt_fk2 (
      p_perf_id       IN     gat_rel_tplt_tpac_tp.perf_id_t,
      p_ttem_codigo   IN     gat_rel_tplt_tpac_tp.ttem_codigo_t,
      p_num_regs         OUT NUMBER);

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de la constraint TPTP_TPAC_FK1
   PROCEDURE del_tptp_tpac_fk1 (
      p_tpac_codigo   IN     gat_rel_tplt_tpac_tp.tpac_codigo_t,
      p_num_regs         OUT NUMBER);

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER);

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_REL_TPLT_TPAC en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);
END gat_rel_tplt_tpac_cp;
/
SHOW ERRORS;


