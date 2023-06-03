CREATE OR REPLACE PACKAGE GAT.dba_col_comments_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     DBA_COL_COMMENTS_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               DBA_COL_COMMENTS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   22-mar-2012 mherrera     Creación
   *******************************************************************************/

   SUBTYPE owner_t IS dba_col_comments.owner%TYPE;

   SUBTYPE table_name_t IS dba_col_comments.table_name%TYPE;

   SUBTYPE column_name_t IS dba_col_comments.column_name%TYPE;

   SUBTYPE comments_t IS dba_col_comments.comments%TYPE;

   TYPE owner_ct IS TABLE OF owner_t
                       INDEX BY BINARY_INTEGER;

   TYPE table_name_ct IS TABLE OF table_name_t
                            INDEX BY BINARY_INTEGER;

   TYPE column_name_ct IS TABLE OF column_name_t
                             INDEX BY BINARY_INTEGER;

   TYPE comments_ct IS TABLE OF comments_t
                          INDEX BY BINARY_INTEGER;

   SUBTYPE dba_col_comments_rt IS dba_col_comments%ROWTYPE;

   TYPE dba_col_comments_ct IS TABLE OF dba_col_comments_rt
                                  INDEX BY BINARY_INTEGER;

   TYPE dba_col_comments_rc IS REF CURSOR;
END dba_col_comments_tp;
/
SHOW ERRORS;


