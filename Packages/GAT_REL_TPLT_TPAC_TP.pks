CREATE OR REPLACE PACKAGE GAT.gat_rel_tplt_tpac_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_REL_TPLT_TPAC_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               GAT_REL_TPLT_TPAC
   Descipción de la tabla:
   Relación entre los Templates y Tipos de packages

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   SUBTYPE perf_id_t IS gat_rel_tplt_tpac.perf_id%TYPE;

   SUBTYPE ttem_codigo_t IS gat_rel_tplt_tpac.ttem_codigo%TYPE;

   SUBTYPE tpac_codigo_t IS gat_rel_tplt_tpac.tpac_codigo%TYPE;

   SUBTYPE descripcion_t IS gat_rel_tplt_tpac.descripcion%TYPE;

   SUBTYPE aud_creado_en_t IS gat_rel_tplt_tpac.aud_creado_en%TYPE;

   SUBTYPE aud_creado_por_t IS gat_rel_tplt_tpac.aud_creado_por%TYPE;

   SUBTYPE aud_modificado_en_t IS gat_rel_tplt_tpac.aud_modificado_en%TYPE;

   SUBTYPE aud_modificado_por_t IS gat_rel_tplt_tpac.aud_modificado_por%TYPE;

   TYPE perf_id_ct IS TABLE OF perf_id_t
                         INDEX BY BINARY_INTEGER;

   TYPE ttem_codigo_ct IS TABLE OF ttem_codigo_t
                             INDEX BY BINARY_INTEGER;

   TYPE tpac_codigo_ct IS TABLE OF tpac_codigo_t
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

   SUBTYPE gat_rel_tplt_tpac_rt IS gat_rel_tplt_tpac%ROWTYPE;

   TYPE gat_rel_tplt_tpac_ct IS TABLE OF gat_rel_tplt_tpac_rt
                                   INDEX BY BINARY_INTEGER;

   TYPE gat_rel_tplt_tpac_rc IS REF CURSOR;
END gat_rel_tplt_tpac_tp;
/
SHOW ERRORS;


