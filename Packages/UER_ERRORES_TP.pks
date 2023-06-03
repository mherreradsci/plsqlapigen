CREATE OR REPLACE PACKAGE GAT.uer_errores_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     UER_ERRORES_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               UER_ERRORES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   SUBTYPE erro_id_t IS uer_errores.erro_id%TYPE;

   SUBTYPE programa_t IS uer_errores.programa%TYPE;

   SUBTYPE mensaje_t IS uer_errores.mensaje%TYPE;

   SUBTYPE aud_creado_por_t IS uer_errores.aud_creado_por%TYPE;

   SUBTYPE aud_creado_en_t IS uer_errores.aud_creado_en%TYPE;

   SUBTYPE aud_modificado_por_t IS uer_errores.aud_modificado_por%TYPE;

   SUBTYPE aud_modificado_en_t IS uer_errores.aud_modificado_en%TYPE;

   SUBTYPE lopr_id_t IS uer_errores.lopr_id%TYPE;

   TYPE erro_id_ct IS TABLE OF erro_id_t
                         INDEX BY BINARY_INTEGER;

   TYPE programa_ct IS TABLE OF programa_t
                          INDEX BY BINARY_INTEGER;

   TYPE mensaje_ct IS TABLE OF mensaje_t
                         INDEX BY BINARY_INTEGER;

   TYPE aud_creado_por_ct IS TABLE OF aud_creado_por_t
                                INDEX BY BINARY_INTEGER;

   TYPE aud_creado_en_ct IS TABLE OF aud_creado_en_t
                               INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_por_ct IS TABLE OF aud_modificado_por_t
                                    INDEX BY BINARY_INTEGER;

   TYPE aud_modificado_en_ct IS TABLE OF aud_modificado_en_t
                                   INDEX BY BINARY_INTEGER;

   TYPE lopr_id_ct IS TABLE OF lopr_id_t
                         INDEX BY BINARY_INTEGER;

   SUBTYPE uer_errores_rt IS uer_errores%ROWTYPE;

   TYPE uer_errores_ct IS TABLE OF uer_errores_rt
                             INDEX BY BINARY_INTEGER;

   TYPE uer_errores_rc IS REF CURSOR;
END uer_errores_tp;
/
SHOW ERRORS;


