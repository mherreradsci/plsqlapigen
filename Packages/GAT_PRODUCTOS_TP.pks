CREATE OR REPLACE PACKAGE GAT.gat_productos_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_PRODUCTOS_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               GAT_PRODUCTOS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   SUBTYPE prod_id_t IS gat_productos.prod_id%TYPE;

   SUBTYPE clie_id_t IS gat_productos.clie_id%TYPE;

   SUBTYPE appl_id_t IS gat_productos.appl_id%TYPE;

   SUBTYPE perf_id_t IS gat_productos.perf_id%TYPE;

   SUBTYPE aud_creado_en_t IS gat_productos.aud_creado_en%TYPE;

   SUBTYPE aud_creado_por_t IS gat_productos.aud_creado_por%TYPE;

   SUBTYPE aud_modificado_en_t IS gat_productos.aud_modificado_en%TYPE;

   SUBTYPE aud_modificado_por_t IS gat_productos.aud_modificado_por%TYPE;

   TYPE prod_id_ct IS TABLE OF prod_id_t
                         INDEX BY BINARY_INTEGER;

   TYPE clie_id_ct IS TABLE OF clie_id_t
                         INDEX BY BINARY_INTEGER;

   TYPE appl_id_ct IS TABLE OF appl_id_t
                         INDEX BY BINARY_INTEGER;

   TYPE perf_id_ct IS TABLE OF perf_id_t
                         INDEX BY BINARY_INTEGER;

   TYPE aud_creado_en_ct IS TABLE OF aud_creado_en_t
                               INDEX BY BINARY_INTEGER;

   TYPE aud_creado_por_ct IS TABLE OF aud_creado_por_t
                                INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_en_ct IS TABLE OF aud_modificado_en_t
                                   INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_por_ct IS TABLE OF aud_modificado_por_t
                                    INDEX BY BINARY_INTEGER;

   SUBTYPE gat_productos_rt IS gat_productos%ROWTYPE;

   TYPE gat_productos_ct IS TABLE OF gat_productos_rt
                               INDEX BY BINARY_INTEGER;

   TYPE gat_productos_rc IS REF CURSOR;
END gat_productos_tp;
/
SHOW ERRORS;


