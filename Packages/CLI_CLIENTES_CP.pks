CREATE OR REPLACE PACKAGE GAT.cli_clientes_cp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     CLI_CLIENTES_CP
   Proposito:  Package que implementa las DML o Changes sobre la tabla
               CLI_CLIENTES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   FUNCTION siguiente_clave (p_secuencia IN VARCHAR2 DEFAULT 'CLI_CLIENTES_SEC')
      RETURN NUMBER;

   -- Inserta un registro de la CLI_CLIENTES via un record
   PROCEDURE ins (p_cli_clientes cli_clientes_tp.cli_clientes_rt);

   -- Inserta un registro de la CLI_CLIENTES via la Lista de Columnas
   PROCEDURE ins (
      p_clie_id               cli_clientes_tp.clie_id_t,
      p_nombre_corto          cli_clientes_tp.nombre_corto_t DEFAULT NULL,
      p_nombre                cli_clientes_tp.nombre_t,
      p_aud_creado_en         cli_clientes_tp.aud_creado_en_t DEFAULT LOCALTIMESTAMP,
      p_aud_creado_por        cli_clientes_tp.aud_creado_por_t DEFAULT USER,
      p_aud_modificado_en     cli_clientes_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por    cli_clientes_tp.aud_modificado_por_t DEFAULT NULL);

   -- Inserta (modo bulk) registros de la CLI_CLIENTES vía un record de colección de columnas
   PROCEDURE ins (p_regs cli_clientes_tp.cli_clientes_ct);

   -- Inserta (modo bulk) registros de la CLI_CLIENTES vía colecciones de columnas
   PROCEDURE ins (p_clie_id              IN cli_clientes_tp.clie_id_ct,
                  p_nombre_corto         IN cli_clientes_tp.nombre_corto_ct,
                  p_nombre               IN cli_clientes_tp.nombre_ct,
                  p_aud_creado_en        IN cli_clientes_tp.aud_creado_en_ct,
                  p_aud_creado_por       IN cli_clientes_tp.aud_creado_por_ct,
                  p_aud_modificado_en    IN cli_clientes_tp.aud_modificado_en_ct,
                  p_aud_modificado_por   IN cli_clientes_tp.aud_modificado_por_ct);

   -- Actualiza un registro de CLI_CLIENTES en función de la constraint CLIE_PK
   PROCEDURE upd_clie_pk (p_clie_id        IN cli_clientes_tp.clie_id_t,
                          p_cli_clientes      cli_clientes_tp.cli_clientes_rt);

   -- Actualiza una columna de la tabla CLI_CLIENTES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla CLI_CLIENTES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza una columna de la tabla CLI_CLIENTES en función de un where dinámico
   PROCEDURE upd_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_where            IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);

   -- Actualiza un conjunto de columnas de la tabla CLI_CLIENTES en función de la constraint CLIE_PK
   PROCEDURE upd_clie_pk (
      p_clie_id                IN cli_clientes_tp.clie_id_t,
      p_nombre_corto              cli_clientes_tp.nombre_corto_t DEFAULT NULL,
      p_nombre                    cli_clientes_tp.nombre_t DEFAULT NULL,
      p_aud_creado_en             cli_clientes_tp.aud_creado_en_t DEFAULT NULL,
      p_aud_creado_por            cli_clientes_tp.aud_creado_por_t DEFAULT NULL,
      p_aud_modificado_en         cli_clientes_tp.aud_modificado_en_t DEFAULT NULL,
      p_aud_modificado_por        cli_clientes_tp.aud_modificado_por_t DEFAULT NULL,
      p_ignore_valores_nulos   IN BOOLEAN := FALSE);

   -- Borra un registro de CLI_CLIENTES en función de la constraint CLIE_PK
   PROCEDURE del_clie_pk (p_clie_id IN cli_clientes_tp.clie_id_t, p_num_regs OUT NUMBER);

   -- Borra un registro de CLI_CLIENTES en función de un where dinámico
   PROCEDURE del_din (p_where IN VARCHAR2, p_num_regs OUT NUMBER);

   -- Borra un registro de CLI_CLIENTES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     NUMBER,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de CLI_CLIENTES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     DATE,
                                  p_num_regs            OUT NUMBER);

   -- Borra un registro de CLI_CLIENTES en función de una columna especifica
   PROCEDURE del_por_una_columna (p_nombre_columna   IN     VARCHAR2,
                                  p_valor_columna    IN     VARCHAR2,
                                  p_num_regs            OUT NUMBER);
END cli_clientes_cp;
/
SHOW ERRORS;


