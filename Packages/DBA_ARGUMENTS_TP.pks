CREATE OR REPLACE PACKAGE GAT.dba_arguments_tp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     DBA_ARGUMENTS_TP
   Proposito:  Package de Tipos: Incluye un subtipo por cada columna, un tipo
               colección por cada columna, un tipo record,
               un tipo colección de recors y un tipo ref cursor para
               la tabla
               DBA_ARGUMENTS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   22-mar-2012 mherrera     Creación
   *******************************************************************************/

   SUBTYPE owner_t IS dba_arguments.owner%TYPE;

   SUBTYPE object_name_t IS dba_arguments.object_name%TYPE;

   SUBTYPE package_name_t IS dba_arguments.package_name%TYPE;

   SUBTYPE object_id_t IS dba_arguments.object_id%TYPE;

   SUBTYPE overload_t IS dba_arguments.overload%TYPE;

   SUBTYPE subprogram_id_t IS dba_arguments.subprogram_id%TYPE;

   SUBTYPE argument_name_t IS dba_arguments.argument_name%TYPE;

   SUBTYPE position_t IS dba_arguments.position%TYPE;

   SUBTYPE sequence_t IS dba_arguments.sequence%TYPE;

   SUBTYPE data_level_t IS dba_arguments.data_level%TYPE;

   SUBTYPE data_type_t IS dba_arguments.data_type%TYPE;

   SUBTYPE defaulted_t IS dba_arguments.defaulted%TYPE;

   SUBTYPE default_value_t IS dba_arguments.DEFAULT_VALUE%TYPE;

   SUBTYPE default_length_t IS dba_arguments.default_length%TYPE;

   SUBTYPE in_out_t IS dba_arguments.in_out%TYPE;

   SUBTYPE data_length_t IS dba_arguments.data_length%TYPE;

   SUBTYPE data_precision_t IS dba_arguments.data_precision%TYPE;

   SUBTYPE data_scale_t IS dba_arguments.data_scale%TYPE;

   SUBTYPE radix_t IS dba_arguments.radix%TYPE;

   SUBTYPE character_set_name_t IS dba_arguments.character_set_name%TYPE;

   SUBTYPE type_owner_t IS dba_arguments.type_owner%TYPE;

   SUBTYPE type_name_t IS dba_arguments.type_name%TYPE;

   SUBTYPE type_subname_t IS dba_arguments.type_subname%TYPE;

   SUBTYPE type_link_t IS dba_arguments.type_link%TYPE;

   SUBTYPE pls_type_t IS dba_arguments.pls_type%TYPE;

   SUBTYPE char_length_t IS dba_arguments.char_length%TYPE;

   SUBTYPE char_used_t IS dba_arguments.char_used%TYPE;

   TYPE owner_ct IS TABLE OF owner_t
                       INDEX BY BINARY_INTEGER;

   TYPE object_name_ct IS TABLE OF object_name_t
                             INDEX BY BINARY_INTEGER;

   TYPE package_name_ct IS TABLE OF package_name_t
                              INDEX BY BINARY_INTEGER;

   TYPE object_id_ct IS TABLE OF object_id_t
                           INDEX BY BINARY_INTEGER;

   TYPE overload_ct IS TABLE OF overload_t
                          INDEX BY BINARY_INTEGER;

   TYPE subprogram_id_ct IS TABLE OF subprogram_id_t
                               INDEX BY BINARY_INTEGER;

   TYPE argument_name_ct IS TABLE OF argument_name_t
                               INDEX BY BINARY_INTEGER;

   TYPE position_ct IS TABLE OF position_t
                          INDEX BY BINARY_INTEGER;

   TYPE sequence_ct IS TABLE OF sequence_t
                          INDEX BY BINARY_INTEGER;

   TYPE data_level_ct IS TABLE OF data_level_t
                            INDEX BY BINARY_INTEGER;

   TYPE data_type_ct IS TABLE OF data_type_t
                           INDEX BY BINARY_INTEGER;

   TYPE defaulted_ct IS TABLE OF defaulted_t
                           INDEX BY BINARY_INTEGER;

   TYPE default_value_ct IS TABLE OF default_value_t
                               INDEX BY BINARY_INTEGER;

   TYPE default_length_ct IS TABLE OF default_length_t
                                INDEX BY BINARY_INTEGER;

   TYPE in_out_ct IS TABLE OF in_out_t
                        INDEX BY BINARY_INTEGER;

   TYPE data_length_ct IS TABLE OF data_length_t
                             INDEX BY BINARY_INTEGER;

   TYPE data_precision_ct IS TABLE OF data_precision_t
                                INDEX BY BINARY_INTEGER;

   TYPE data_scale_ct IS TABLE OF data_scale_t
                            INDEX BY BINARY_INTEGER;

   TYPE radix_ct IS TABLE OF radix_t
                       INDEX BY BINARY_INTEGER;

   TYPE character_set_name_ct IS TABLE OF character_set_name_t
                                    INDEX BY BINARY_INTEGER;

   TYPE type_owner_ct IS TABLE OF type_owner_t
                            INDEX BY BINARY_INTEGER;

   TYPE type_name_ct IS TABLE OF type_name_t
                           INDEX BY BINARY_INTEGER;

   TYPE type_subname_ct IS TABLE OF type_subname_t
                              INDEX BY BINARY_INTEGER;

   TYPE type_link_ct IS TABLE OF type_link_t
                           INDEX BY BINARY_INTEGER;

   TYPE pls_type_ct IS TABLE OF pls_type_t
                          INDEX BY BINARY_INTEGER;

   TYPE char_length_ct IS TABLE OF char_length_t
                             INDEX BY BINARY_INTEGER;

   TYPE char_used_ct IS TABLE OF char_used_t
                           INDEX BY BINARY_INTEGER;

   SUBTYPE dba_arguments_rt IS dba_arguments%ROWTYPE;

   TYPE dba_arguments_ct IS TABLE OF dba_arguments_rt
                               INDEX BY BINARY_INTEGER;

   TYPE dba_arguments_rc IS REF CURSOR;
END dba_arguments_tp;
/
SHOW ERRORS;


