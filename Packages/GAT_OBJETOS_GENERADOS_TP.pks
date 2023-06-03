CREATE OR REPLACE PACKAGE GAT.gat_objetos_generados_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_OBJETOS_GENERADOS_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               GAT_OBJETOS_GENERADOS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   SUBTYPE prod_id_t IS gat_objetos_generados.prod_id%TYPE;

   SUBTYPE nombre_objeto_t IS gat_objetos_generados.nombre_objeto%TYPE;

   SUBTYPE tobj_codigo_t IS gat_objetos_generados.tobj_codigo%TYPE;

   SUBTYPE primera_generacion_t IS gat_objetos_generados.primera_generacion%TYPE;

   SUBTYPE ultima_generacion_t IS gat_objetos_generados.ultima_generacion%TYPE;

   SUBTYPE version_generador_t IS gat_objetos_generados.version_generador%TYPE;

   SUBTYPE total_generaciones_t IS gat_objetos_generados.total_generaciones%TYPE;

   SUBTYPE compilado_t IS gat_objetos_generados.compilado%TYPE;

   SUBTYPE aud_creado_en_t IS gat_objetos_generados.aud_creado_en%TYPE;

   SUBTYPE aud_creado_por_t IS gat_objetos_generados.aud_creado_por%TYPE;

   SUBTYPE aud_modificado_en_t IS gat_objetos_generados.aud_modificado_en%TYPE;

   SUBTYPE aud_modificado_por_t IS gat_objetos_generados.aud_modificado_por%TYPE;

   TYPE prod_id_ct IS TABLE OF prod_id_t
                         INDEX BY BINARY_INTEGER;

   TYPE nombre_objeto_ct IS TABLE OF nombre_objeto_t
                               INDEX BY BINARY_INTEGER;

   TYPE tobj_codigo_ct IS TABLE OF tobj_codigo_t
                             INDEX BY BINARY_INTEGER;

   TYPE primera_generacion_ct IS TABLE OF primera_generacion_t
                                    INDEX BY BINARY_INTEGER;

   TYPE ultima_generacion_ct IS TABLE OF ultima_generacion_t
                                   INDEX BY BINARY_INTEGER;

   TYPE version_generador_ct IS TABLE OF version_generador_t
                                   INDEX BY BINARY_INTEGER;

   TYPE total_generaciones_ct IS TABLE OF total_generaciones_t
                                    INDEX BY BINARY_INTEGER;

   TYPE compilado_ct IS TABLE OF compilado_t
                           INDEX BY BINARY_INTEGER;

   TYPE aud_creado_en_ct IS TABLE OF aud_creado_en_t
                               INDEX BY BINARY_INTEGER;

   TYPE aud_creado_por_ct IS TABLE OF aud_creado_por_t
                                INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_en_ct IS TABLE OF aud_modificado_en_t
                                   INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_por_ct IS TABLE OF aud_modificado_por_t
                                    INDEX BY BINARY_INTEGER;

   SUBTYPE gat_objetos_generados_rt IS gat_objetos_generados%ROWTYPE;

   TYPE gat_objetos_generados_ct IS TABLE OF gat_objetos_generados_rt
                                       INDEX BY BINARY_INTEGER;

   TYPE gat_objetos_generados_rc IS REF CURSOR;
END gat_objetos_generados_tp;
/
SHOW ERRORS;


