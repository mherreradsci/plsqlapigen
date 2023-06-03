CREATE OR REPLACE PACKAGE GAT.gat_perfiles_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_PERFILES_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               GAT_PERFILES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   SUBTYPE perf_id_t IS gat_perfiles.perf_id%TYPE;

   SUBTYPE empresa_t IS gat_perfiles.empresa%TYPE;

   SUBTYPE nombre_t IS gat_perfiles.nombre%TYPE;

   SUBTYPE nombre_corto_t IS gat_perfiles.nombre_corto%TYPE;

   SUBTYPE descripcion_t IS gat_perfiles.descripcion%TYPE;

   SUBTYPE aud_creado_en_t IS gat_perfiles.aud_creado_en%TYPE;

   SUBTYPE aud_creado_por_t IS gat_perfiles.aud_creado_por%TYPE;

   SUBTYPE aud_modificado_en_t IS gat_perfiles.aud_modificado_en%TYPE;

   SUBTYPE aud_modificado_por_t IS gat_perfiles.aud_modificado_por%TYPE;

   TYPE perf_id_ct IS TABLE OF perf_id_t
                         INDEX BY BINARY_INTEGER;

   TYPE empresa_ct IS TABLE OF empresa_t
                         INDEX BY BINARY_INTEGER;

   TYPE nombre_ct IS TABLE OF nombre_t
                        INDEX BY BINARY_INTEGER;

   TYPE nombre_corto_ct IS TABLE OF nombre_corto_t
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

   SUBTYPE gat_perfiles_rt IS gat_perfiles%ROWTYPE;

   TYPE gat_perfiles_ct IS TABLE OF gat_perfiles_rt
                              INDEX BY BINARY_INTEGER;

   TYPE gat_perfiles_rc IS REF CURSOR;
END gat_perfiles_tp;
/
SHOW ERRORS;


