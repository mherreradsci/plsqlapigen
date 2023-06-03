CREATE OR REPLACE PACKAGE GAT.gat_tip_templates_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_TEMPLATES_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               GAT_TIP_TEMPLATES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   SUBTYPE ttem_codigo_t IS gat_tip_templates.ttem_codigo%TYPE;

   SUBTYPE nombre_t IS gat_tip_templates.nombre%TYPE;

   SUBTYPE descripcion_t IS gat_tip_templates.descripcion%TYPE;

   SUBTYPE aud_creado_en_t IS gat_tip_templates.aud_creado_en%TYPE;

   SUBTYPE aud_creado_por_t IS gat_tip_templates.aud_creado_por%TYPE;

   SUBTYPE aud_modificado_en_t IS gat_tip_templates.aud_modificado_en%TYPE;

   SUBTYPE aud_modificado_por_t IS gat_tip_templates.aud_modificado_por%TYPE;

   TYPE ttem_codigo_ct IS TABLE OF ttem_codigo_t
                             INDEX BY BINARY_INTEGER;

   TYPE nombre_ct IS TABLE OF nombre_t
                        INDEX BY BINARY_INTEGER;

   TYPE descripcion_ct IS TABLE OF descripcion_t
                             INDEX BY BINARY_INTEGER;

   TYPE aud_creado_en_ct IS TABLE OF aud_creado_en_t
                               INDEX BY BINARY_INTEGER;

   TYPE aud_creado_por_ct IS TABLE OF aud_creado_por_t
                                INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_en_ct IS TABLE OF aud_modificado_en_t
                                   INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_por_ct IS TABLE OF aud_modificado_por_t
                                    INDEX BY BINARY_INTEGER;

   SUBTYPE gat_tip_templates_rt IS gat_tip_templates%ROWTYPE;

   TYPE gat_tip_templates_ct IS TABLE OF gat_tip_templates_rt
                                   INDEX BY BINARY_INTEGER;

   TYPE gat_tip_templates_rc IS REF CURSOR;
END gat_tip_templates_tp;
/
SHOW ERRORS;


