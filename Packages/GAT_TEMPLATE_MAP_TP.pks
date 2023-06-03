CREATE OR REPLACE PACKAGE GAT.gat_template_map_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TEMPLATE_MAP_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               GAT_TEMPLATE_MAP
   Descipción de la tabla:
   Mapa de template

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   SUBTYPE perf_id_t IS gat_template_map.perf_id%TYPE;

   SUBTYPE ttem_codigo_t IS gat_template_map.ttem_codigo%TYPE;

   SUBTYPE para_code_t IS gat_template_map.para_code%TYPE;

   SUBTYPE tipr_codigo_t IS gat_template_map.tipr_codigo%TYPE;

   SUBTYPE component_t IS gat_template_map.component%TYPE;

   SUBTYPE subcomponent_t IS gat_template_map.subcomponent%TYPE;

   SUBTYPE aud_creado_en_t IS gat_template_map.aud_creado_en%TYPE;

   SUBTYPE aud_creado_por_t IS gat_template_map.aud_creado_por%TYPE;

   SUBTYPE aud_modificado_en_t IS gat_template_map.aud_modificado_en%TYPE;

   SUBTYPE aud_modificado_por_t IS gat_template_map.aud_modificado_por%TYPE;

   TYPE perf_id_ct IS TABLE OF perf_id_t
                         INDEX BY BINARY_INTEGER;

   TYPE ttem_codigo_ct IS TABLE OF ttem_codigo_t
                             INDEX BY BINARY_INTEGER;

   TYPE para_code_ct IS TABLE OF para_code_t
                           INDEX BY BINARY_INTEGER;

   TYPE tipr_codigo_ct IS TABLE OF tipr_codigo_t
                             INDEX BY BINARY_INTEGER;

   TYPE component_ct IS TABLE OF component_t
                           INDEX BY BINARY_INTEGER;

   TYPE subcomponent_ct IS TABLE OF subcomponent_t
                              INDEX BY BINARY_INTEGER;

   TYPE aud_creado_en_ct IS TABLE OF aud_creado_en_t
                               INDEX BY BINARY_INTEGER;

   TYPE aud_creado_por_ct IS TABLE OF aud_creado_por_t
                                INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_en_ct IS TABLE OF aud_modificado_en_t
                                   INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_por_ct IS TABLE OF aud_modificado_por_t
                                    INDEX BY BINARY_INTEGER;

   SUBTYPE gat_template_map_rt IS gat_template_map%ROWTYPE;

   TYPE gat_template_map_ct IS TABLE OF gat_template_map_rt
                                  INDEX BY BINARY_INTEGER;

   TYPE gat_template_map_rc IS REF CURSOR;
END gat_template_map_tp;
/
SHOW ERRORS;


