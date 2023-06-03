CREATE OR REPLACE PACKAGE GAT.gat_tplt_source_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TPLT_SOURCE_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               GAT_TPLT_SOURCE
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   SUBTYPE perf_id_t IS gat_tplt_source.perf_id%TYPE;

   SUBTYPE ttem_codigo_t IS gat_tplt_source.ttem_codigo%TYPE;

   SUBTYPE tpso_id_t IS gat_tplt_source.tpso_id%TYPE;

   SUBTYPE linea_t IS gat_tplt_source.linea%TYPE;

   SUBTYPE aud_creado_en_t IS gat_tplt_source.aud_creado_en%TYPE;

   SUBTYPE aud_creado_por_t IS gat_tplt_source.aud_creado_por%TYPE;

   SUBTYPE aud_modificado_en_t IS gat_tplt_source.aud_modificado_en%TYPE;

   SUBTYPE aud_modificado_por_t IS gat_tplt_source.aud_modificado_por%TYPE;

   TYPE perf_id_ct IS TABLE OF perf_id_t
                         INDEX BY BINARY_INTEGER;

   TYPE ttem_codigo_ct IS TABLE OF ttem_codigo_t
                             INDEX BY BINARY_INTEGER;

   TYPE tpso_id_ct IS TABLE OF tpso_id_t
                         INDEX BY BINARY_INTEGER;

   TYPE linea_ct IS TABLE OF linea_t
                       INDEX BY BINARY_INTEGER;

   TYPE aud_creado_en_ct IS TABLE OF aud_creado_en_t
                               INDEX BY BINARY_INTEGER;

   TYPE aud_creado_por_ct IS TABLE OF aud_creado_por_t
                                INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_en_ct IS TABLE OF aud_modificado_en_t
                                   INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_por_ct IS TABLE OF aud_modificado_por_t
                                    INDEX BY BINARY_INTEGER;

   SUBTYPE gat_tplt_source_rt IS gat_tplt_source%ROWTYPE;

   TYPE gat_tplt_source_ct IS TABLE OF gat_tplt_source_rt
                                 INDEX BY BINARY_INTEGER;

   TYPE gat_tplt_source_rc IS REF CURSOR;
END gat_tplt_source_tp;
/
SHOW ERRORS;


