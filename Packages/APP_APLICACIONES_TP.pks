CREATE OR REPLACE PACKAGE GAT.app_aplicaciones_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     APP_APLICACIONES_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               APP_APLICACIONES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   SUBTYPE appl_id_t IS app_aplicaciones.appl_id%TYPE;

   SUBTYPE nombre_corto_t IS app_aplicaciones.nombre_corto%TYPE;

   SUBTYPE nombre_t IS app_aplicaciones.nombre%TYPE;

   SUBTYPE aud_creado_en_t IS app_aplicaciones.aud_creado_en%TYPE;

   SUBTYPE aud_creado_por_t IS app_aplicaciones.aud_creado_por%TYPE;

   SUBTYPE aud_modificado_en_t IS app_aplicaciones.aud_modificado_en%TYPE;

   SUBTYPE aud_modificado_por_t IS app_aplicaciones.aud_modificado_por%TYPE;

   TYPE appl_id_ct IS TABLE OF appl_id_t
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

   SUBTYPE app_aplicaciones_rt IS app_aplicaciones%ROWTYPE;

   TYPE app_aplicaciones_ct IS TABLE OF app_aplicaciones_rt
                                  INDEX BY BINARY_INTEGER;

   TYPE app_aplicaciones_rc IS REF CURSOR;
END app_aplicaciones_tp;
/
SHOW ERRORS;


