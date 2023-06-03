CREATE OR REPLACE PACKAGE GAT.gat_tip_objetos_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_OBJETOS_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               GAT_TIP_OBJETOS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   SUBTYPE tobj_codigo_t IS gat_tip_objetos.tobj_codigo%TYPE;

   SUBTYPE nombre_t IS gat_tip_objetos.nombre%TYPE;

   SUBTYPE aud_creado_en_t IS gat_tip_objetos.aud_creado_en%TYPE;

   SUBTYPE aud_creado_por_t IS gat_tip_objetos.aud_creado_por%TYPE;

   SUBTYPE aud_modificado_en_t IS gat_tip_objetos.aud_modificado_en%TYPE;

   SUBTYPE aud_modificado_por_t IS gat_tip_objetos.aud_modificado_por%TYPE;

   TYPE tobj_codigo_ct IS TABLE OF tobj_codigo_t
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

   SUBTYPE gat_tip_objetos_rt IS gat_tip_objetos%ROWTYPE;

   TYPE gat_tip_objetos_ct IS TABLE OF gat_tip_objetos_rt
                                 INDEX BY BINARY_INTEGER;

   TYPE gat_tip_objetos_rc IS REF CURSOR;
END gat_tip_objetos_tp;
/
SHOW ERRORS;


