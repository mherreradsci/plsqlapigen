CREATE OR REPLACE PACKAGE GAT.uer_errores_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     UER_ERRORES_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               UER_ERRORES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   FUNCTION siguiente_clave (p_secuencia IN VARCHAR2 DEFAULT 'UER_ERRORES_SEC')
      RETURN NUMBER;

   -- Inserta un registro de la UER_ERRORES via un record
   PROCEDURE ins (p_uer_errores uer_errores_tp.uer_errores_rt);

   -- Inserta un registro de la UER_ERRORES via la Lista de Columnas
   PROCEDURE ins (
      p_erro_id               uer_errores_tp.erro_id_t,
      p_programa              uer_errores_tp.programa_t,
      p_mensaje               uer_errores_tp.mensaje_t DEFAULT NULL,
      p_aud_creado_por        uer_errores_tp.aud_creado_por_t DEFAULT USER,
      p_aud_creado_en         uer_errores_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_modificado_por    uer_errores_tp.aud_modificado_por_t DEFAULT NULL,
      p_aud_modificado_en     uer_errores_tp.aud_modificado_en_t DEFAULT NULL,
      p_lopr_id               uer_errores_tp.lopr_id_t DEFAULT NULL);

   -- Inserta (modo bulk) registros de la UER_ERRORES vía un record de colección de columnas
   PROCEDURE ins (p_regs uer_errores_tp.uer_errores_ct);

   -- Inserta (modo bulk) registros de la UER_ERRORES vía colecciones de columnas
   PROCEDURE ins (p_erro_id              IN uer_errores_tp.erro_id_ct,
                  p_programa             IN uer_errores_tp.programa_ct,
                  p_mensaje              IN uer_errores_tp.mensaje_ct,
                  p_aud_creado_por       IN uer_errores_tp.aud_creado_por_ct,
                  p_aud_creado_en        IN uer_errores_tp.aud_creado_en_ct,
                  p_aud_modificado_por   IN uer_errores_tp.aud_modificado_por_ct,
                  p_aud_modificado_en    IN uer_errores_tp.aud_modificado_en_ct,
                  p_lopr_id              IN uer_errores_tp.lopr_id_ct);

   -- Actualiza un registro de UER_ERRORES en función de la constraint ERRO_PK
   PROCEDURE upd_erro_pk (p_erro_id       IN uer_errores_tp.erro_id_t,
                          p_uer_errores      uer_errores_tp.uer_errores_rt);

   -- Actualiza una columna de la tabla UER_ERRORES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla UER_ERRORES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla UER_ERRORES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza un conjunto de columnas de la tabla UER_ERRORES en función de la constraint ERRO_PK
   PROCEDURE upd_erro_pk (
      p_erro_id                IN uer_errores_tp.erro_id_t,
      p_programa                  uer_errores_tp.programa_t DEFAULT NULL,
      p_mensaje                   uer_errores_tp.mensaje_t DEFAULT NULL,
      p_aud_creado_por            uer_errores_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_creado_en             uer_errores_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_modificado_por        uer_errores_tp.aud_modificado_por_t DEFAULT NULL,
      p_aud_modificado_en         uer_errores_tp.aud_modificado_en_t DEFAULT NULL,
      p_lopr_id                   uer_errores_tp.lopr_id_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE);

   -- Borra un registro de UER_ERRORES en función de la constraint ERRO_PK
   PROCEDURE del_erro_pk (p_erro_id IN uer_errores_tp.erro_id_t, p_num_regs OUT NUMBER);

   -- Borra un registro de UER_ERRORES en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER);

   -- Borra un registro de UER_ERRORES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de UER_ERRORES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de UER_ERRORES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);
END uer_errores_cp;
/
SHOW ERRORS;


