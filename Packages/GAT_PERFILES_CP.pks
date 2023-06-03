CREATE OR REPLACE PACKAGE GAT.gat_perfiles_cp
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
      RETURN NUMBER;

   -- Inserta un registro de la GAT_PERFILES via un record
   PROCEDURE ins (p_gat_perfiles gat_perfiles_tp.gat_perfiles_rt);

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
      p_aud_modificado_por    gat_perfiles_tp.aud_modificado_por_t DEFAULT NULL);

   -- Inserta (modo bulk) registros de la GAT_PERFILES vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_perfiles_tp.gat_perfiles_ct);

   -- Inserta (modo bulk) registros de la GAT_PERFILES vía colecciones de columnas
   PROCEDURE ins (p_perf_id              IN gat_perfiles_tp.perf_id_ct,
                  p_empresa              IN gat_perfiles_tp.empresa_ct,
                  p_nombre               IN gat_perfiles_tp.nombre_ct,
                  p_nombre_corto         IN gat_perfiles_tp.nombre_corto_ct,
                  p_descripcion          IN gat_perfiles_tp.descripcion_ct,
                  p_aud_creado_en        IN gat_perfiles_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN gat_perfiles_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN gat_perfiles_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN gat_perfiles_tp.aud_modificado_por_ct);

   -- Actualiza un registro de GAT_PERFILES en función de la constraint PERF_PK
   PROCEDURE upd_perf_pk (p_perf_id        IN gat_perfiles_tp.perf_id_t,
                          p_gat_perfiles      gat_perfiles_tp.gat_perfiles_rt);

   -- Actualiza una columna de la tabla GAT_PERFILES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_PERFILES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_PERFILES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

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
      p_ignore_valores_nulos   IN BOOLEAN := FALSE);

   -- Borra un registro de GAT_PERFILES en función de la constraint PERF_PK
   PROCEDURE del_perf_pk (p_perf_id IN gat_perfiles_tp.perf_id_t, p_num_regs OUT NUMBER);

   -- Borra un registro de GAT_PERFILES en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER);

   -- Borra un registro de GAT_PERFILES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_PERFILES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_PERFILES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);
END gat_perfiles_cp;
/
SHOW ERRORS;


