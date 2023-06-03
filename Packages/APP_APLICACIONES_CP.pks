CREATE OR REPLACE PACKAGE GAT.app_aplicaciones_cp
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
      RETURN NUMBER;

   -- Inserta un registro de la APP_APLICACIONES via un record
   PROCEDURE ins (p_app_aplicaciones app_aplicaciones_tp.app_aplicaciones_rt);

   -- Inserta un registro de la APP_APLICACIONES via la Lista de Columnas
   PROCEDURE ins (
      p_appl_id               app_aplicaciones_tp.appl_id_t,
      p_nombre_corto          app_aplicaciones_tp.nombre_corto_t,
      p_nombre                app_aplicaciones_tp.nombre_t,
      p_aud_creado_en         app_aplicaciones_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        app_aplicaciones_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     app_aplicaciones_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    app_aplicaciones_tp.aud_modificado_por_t DEFAULT NULL);

   -- Inserta (modo bulk) registros de la APP_APLICACIONES vía un record de colección de columnas
   PROCEDURE ins (p_regs app_aplicaciones_tp.app_aplicaciones_ct);

   -- Inserta (modo bulk) registros de la APP_APLICACIONES vía colecciones de columnas
   PROCEDURE ins (p_appl_id              IN app_aplicaciones_tp.appl_id_ct,
                  p_nombre_corto         IN app_aplicaciones_tp.nombre_corto_ct,
                  p_nombre               IN app_aplicaciones_tp.nombre_ct,
                  p_aud_creado_en        IN app_aplicaciones_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN app_aplicaciones_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN app_aplicaciones_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN app_aplicaciones_tp.aud_modificado_por_ct);

   -- Actualiza un registro de APP_APLICACIONES en función de la constraint APPL_PK
   PROCEDURE upd_appl_pk (
      p_appl_id            IN app_aplicaciones_tp.appl_id_t,
      p_app_aplicaciones      app_aplicaciones_tp.app_aplicaciones_rt);

   -- Actualiza una columna de la tabla APP_APLICACIONES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla APP_APLICACIONES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla APP_APLICACIONES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza un conjunto de columnas de la tabla APP_APLICACIONES en función de la constraint APPL_PK
   PROCEDURE upd_appl_pk (
      p_appl_id                IN app_aplicaciones_tp.appl_id_t,
      p_nombre_corto              app_aplicaciones_tp.nombre_corto_t DEFAULT NULL,
      p_nombre                    app_aplicaciones_tp.nombre_t DEFAULT NULL,
      p_aud_creado_en             app_aplicaciones_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            app_aplicaciones_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         app_aplicaciones_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        app_aplicaciones_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE);

   -- Borra un registro de APP_APLICACIONES en función de la constraint APPL_PK
   PROCEDURE del_appl_pk (p_appl_id    IN     app_aplicaciones_tp.appl_id_t,
                          p_num_regs      OUT NUMBER);

   -- Borra un registro de APP_APLICACIONES en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER);

   -- Borra un registro de APP_APLICACIONES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de APP_APLICACIONES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de APP_APLICACIONES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);
END app_aplicaciones_cp;
/
SHOW ERRORS;


