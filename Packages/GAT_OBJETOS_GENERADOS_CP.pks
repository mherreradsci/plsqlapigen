CREATE OR REPLACE PACKAGE GAT.gat_objetos_generados_cp
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
      p_gat_objetos_generados gat_objetos_generados_tp.gat_objetos_generados_rt);

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
      p_aud_modificado_por    gat_objetos_generados_tp.aud_modificado_por_t DEFAULT NULL);

   -- Inserta (modo bulk) registros de la GAT_OBJETOS_GENERADOS vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_objetos_generados_tp.gat_objetos_generados_ct);

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
      p_aud_modificado_por   IN gat_objetos_generados_tp.aud_modificado_por_ct);

   -- Actualiza un registro de GAT_OBJETOS_GENERADOS en función de la constraint OBGE_PK
   PROCEDURE upd_obge_pk (
      p_prod_id                 IN gat_objetos_generados_tp.prod_id_t,
      p_nombre_objeto           IN gat_objetos_generados_tp.nombre_objeto_t,
      p_tobj_codigo             IN gat_objetos_generados_tp.tobj_codigo_t,
      p_gat_objetos_generados      gat_objetos_generados_tp.gat_objetos_generados_rt);

   -- Actualiza una columna de la tabla GAT_OBJETOS_GENERADOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_OBJETOS_GENERADOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_OBJETOS_GENERADOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

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
      p_ignore_valores_nulos   IN BOOLEAN := FALSE);

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de la constraint OBGE_PK
   PROCEDURE del_obge_pk (
      p_prod_id         IN     gat_objetos_generados_tp.prod_id_t,
      p_nombre_objeto   IN     gat_objetos_generados_tp.nombre_objeto_t,
      p_tobj_codigo     IN     gat_objetos_generados_tp.tobj_codigo_t,
      p_num_regs           OUT NUMBER);

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de la constraint OBGE_PROD_FK1
   PROCEDURE del_obge_prod_fk1 (p_prod_id    IN     gat_objetos_generados_tp.prod_id_t,
                                p_num_regs      OUT NUMBER);

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de la constraint OBGE_TOBJ_FK2
   PROCEDURE del_obge_tobj_fk2 (
      p_tobj_codigo   IN     gat_objetos_generados_tp.tobj_codigo_t,
      p_num_regs         OUT NUMBER);

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER);

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_OBJETOS_GENERADOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);
END gat_objetos_generados_cp;
/
SHOW ERRORS;


