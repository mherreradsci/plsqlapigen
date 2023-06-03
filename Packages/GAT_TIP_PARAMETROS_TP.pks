CREATE OR REPLACE PACKAGE GAT.gat_tip_parametros_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_PARAMETROS_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               GAT_TIP_PARAMETROS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   SUBTYPE tipr_codigo_t IS gat_tip_parametros.tipr_codigo%TYPE;

   SUBTYPE nombre_t IS gat_tip_parametros.nombre%TYPE;

   SUBTYPE aud_creado_en_t IS gat_tip_parametros.aud_creado_en%TYPE;

   SUBTYPE aud_creado_por_t IS gat_tip_parametros.aud_creado_por%TYPE;

   SUBTYPE aud_modificado_en_t IS gat_tip_parametros.aud_modificado_en%TYPE;

   SUBTYPE aud_modificado_por_t IS gat_tip_parametros.aud_modificado_por%TYPE;

   TYPE tipr_codigo_ct IS TABLE OF tipr_codigo_t
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

   SUBTYPE gat_tip_parametros_rt IS gat_tip_parametros%ROWTYPE;

   TYPE gat_tip_parametros_ct IS TABLE OF gat_tip_parametros_rt
                                    INDEX BY BINARY_INTEGER;

   TYPE gat_tip_parametros_rc IS REF CURSOR;
END gat_tip_parametros_tp;
/
SHOW ERRORS;


