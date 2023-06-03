CREATE OR REPLACE PACKAGE GAT.gat_tip_objetos_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_OBJETOS_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               GAT_TIP_OBJETOS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Inserta un registro de la GAT_TIP_OBJETOS via un record
   PROCEDURE ins (p_gat_tip_objetos gat_tip_objetos_tp.gat_tip_objetos_rt);

   -- Inserta un registro de la GAT_TIP_OBJETOS via la Lista de Columnas
   PROCEDURE ins (
      p_tobj_codigo           gat_tip_objetos_tp.tobj_codigo_t,
      p_nombre                gat_tip_objetos_tp.nombre_t DEFAULT NULL,
      p_aud_creado_en         gat_tip_objetos_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        gat_tip_objetos_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     gat_tip_objetos_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    gat_tip_objetos_tp.aud_modificado_por_t DEFAULT NULL);

   -- Inserta (modo bulk) registros de la GAT_TIP_OBJETOS vía un record de colección de columnas
   PROCEDURE ins (p_regs gat_tip_objetos_tp.gat_tip_objetos_ct);

   -- Inserta (modo bulk) registros de la GAT_TIP_OBJETOS vía colecciones de columnas
   PROCEDURE ins (p_tobj_codigo          IN gat_tip_objetos_tp.tobj_codigo_ct,
                  p_nombre               IN gat_tip_objetos_tp.nombre_ct,
                  p_aud_creado_en        IN gat_tip_objetos_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN gat_tip_objetos_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN gat_tip_objetos_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN gat_tip_objetos_tp.aud_modificado_por_ct);

   -- Actualiza un registro de GAT_TIP_OBJETOS en función de la constraint TOBJ_PK
   PROCEDURE upd_tobj_pk (p_tobj_codigo       IN gat_tip_objetos_tp.tobj_codigo_t,
                          p_gat_tip_objetos      gat_tip_objetos_tp.gat_tip_objetos_rt);

   -- Actualiza una columna de la tabla GAT_TIP_OBJETOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_TIP_OBJETOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla GAT_TIP_OBJETOS en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza un conjunto de columnas de la tabla GAT_TIP_OBJETOS en función de la constraint TOBJ_PK
   PROCEDURE upd_tobj_pk (
      p_tobj_codigo            IN gat_tip_objetos_tp.tobj_codigo_t,
      p_nombre                    gat_tip_objetos_tp.nombre_t DEFAULT NULL,
      p_aud_creado_en             gat_tip_objetos_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            gat_tip_objetos_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         gat_tip_objetos_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        gat_tip_objetos_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE);

   -- Borra un registro de GAT_TIP_OBJETOS en función de la constraint TOBJ_PK
   PROCEDURE del_tobj_pk (p_tobj_codigo   IN     gat_tip_objetos_tp.tobj_codigo_t,
                          p_num_regs         OUT NUMBER);

   -- Borra un registro de GAT_TIP_OBJETOS en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER);

   -- Borra un registro de GAT_TIP_OBJETOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_TIP_OBJETOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de GAT_TIP_OBJETOS en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);
END gat_tip_objetos_cp;
/
SHOW ERRORS;


