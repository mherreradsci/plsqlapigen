CREATE OR REPLACE PACKAGE GAT.cli_clientes_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     CLI_CLIENTES_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               CLI_CLIENTES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   SUBTYPE clie_id_t IS cli_clientes.clie_id%TYPE;

   SUBTYPE nombre_corto_t IS cli_clientes.nombre_corto%TYPE;

   SUBTYPE nombre_t IS cli_clientes.nombre%TYPE;

   SUBTYPE aud_creado_en_t IS cli_clientes.aud_creado_en%TYPE;

   SUBTYPE aud_creado_por_t IS cli_clientes.aud_creado_por%TYPE;

   SUBTYPE aud_modificado_en_t IS cli_clientes.aud_modificado_en%TYPE;

   SUBTYPE aud_modificado_por_t IS cli_clientes.aud_modificado_por%TYPE;

   TYPE clie_id_ct IS TABLE OF clie_id_t
                         INDEX BY BINARY_INTEGER;

   TYPE nombre_corto_ct IS TABLE OF nombre_corto_t
                              INDEX BY BINARY_INTEGER;

   TYPE nombre_ct IS TABLE OF nombre_t
                        INDEX BY BINARY_INTEGER;

   TYPE aud_creado_en_ct IS TABLE OF aud_creado_en_t
                               INDEX BY BINARY_INTEGER;

   TYPE aud_creado_por_ct IS TABLE OF aud_creado_por_t
                                INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_en_ct IS TABLE OF aud_modificado_en_t
                                   INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_por_ct IS TABLE OF aud_modificado_por_t
                                    INDEX BY BINARY_INTEGER;

   SUBTYPE cli_clientes_rt IS cli_clientes%ROWTYPE;

   TYPE cli_clientes_ct IS TABLE OF cli_clientes_rt
                              INDEX BY BINARY_INTEGER;

   TYPE cli_clientes_rc IS REF CURSOR;
END cli_clientes_tp;
/
SHOW ERRORS;


