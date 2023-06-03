CREATE OR REPLACE PACKAGE GAT.gat_tip_packages_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_PACKAGES_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               GAT_TIP_PACKAGES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   SUBTYPE tpac_codigo_t IS gat_tip_packages.tpac_codigo%TYPE;

   SUBTYPE nombre_t IS gat_tip_packages.nombre%TYPE;

   SUBTYPE glosa_t IS gat_tip_packages.glosa%TYPE;

   SUBTYPE generado_t IS gat_tip_packages.generado%TYPE;

   SUBTYPE aud_creado_en_t IS gat_tip_packages.aud_creado_en%TYPE;

   SUBTYPE aud_creado_por_t IS gat_tip_packages.aud_creado_por%TYPE;

   SUBTYPE aud_modificado_en_t IS gat_tip_packages.aud_modificado_en%TYPE;

   SUBTYPE aud_modificado_por_t IS gat_tip_packages.aud_modificado_por%TYPE;

   TYPE tpac_codigo_ct IS TABLE OF tpac_codigo_t
                             INDEX BY BINARY_INTEGER;

   TYPE nombre_ct IS TABLE OF nombre_t
                        INDEX BY BINARY_INTEGER;

   TYPE glosa_ct IS TABLE OF glosa_t
                       INDEX BY BINARY_INTEGER;

   TYPE generado_ct IS TABLE OF generado_t
                          INDEX BY BINARY_INTEGER;

   TYPE aud_creado_en_ct IS TABLE OF aud_creado_en_t
                               INDEX BY BINARY_INTEGER;

   TYPE aud_creado_por_ct IS TABLE OF aud_creado_por_t
                                INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_en_ct IS TABLE OF aud_modificado_en_t
                                   INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_por_ct IS TABLE OF aud_modificado_por_t
                                    INDEX BY BINARY_INTEGER;

   SUBTYPE gat_tip_packages_rt IS gat_tip_packages%ROWTYPE;

   TYPE gat_tip_packages_ct IS TABLE OF gat_tip_packages_rt
                                  INDEX BY BINARY_INTEGER;

   TYPE gat_tip_packages_rc IS REF CURSOR;
END gat_tip_packages_tp;
/
SHOW ERRORS;


