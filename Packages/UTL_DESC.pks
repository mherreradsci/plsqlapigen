CREATE OR REPLACE PACKAGE GAT.utl_desc --AUTHID CURRENT_USER
/*------------------------------------------------------------------------------
Explora IT
Proyecto:   Utilidades para desarrolladores
Objetivo:   Procedimientos para describir tablas usando el diccionario
            de dato Oracle

Historia:
Cuando      Quien    Comantario
----------- -------- --------------------------------------------------------
10-Feb-2003 mherrera Creación
03-Dic-2004 mherrera Cambia la función "pk_exists" por una más
                     genérica, es decir, por "constraint_exists"
07-Mar-2012 mherrera Agrega estructura desc_columns_rt y desc_table_ct
                     para la descripción de las columnas.
19-mar-2012 mherrera Agrega pk_contraint_name para obtener el nombre de la
                     constraint PK
24-abr-2012 mherrera Agrega función is_identified_by_sequence
22-may-2012 mherrera renombra constraints a constraints_puf
------------------------------------------------------------------------------*/
IS
   k_package                CONSTANT fdc_defs.package_name_t := 'utl_desc';

   --*

   TYPE desc_columns_rt IS RECORD
   (
      column_name      VARCHAR2 (32767),
      data_type        VARCHAR2 (32),
      data_precision   BINARY_INTEGER,
      data_scale       BINARY_INTEGER,
      nullable         VARCHAR2 (1)
   );

   TYPE desc_table_ct IS TABLE OF desc_columns_rt
                            INDEX BY BINARY_INTEGER;

   -- Subtipo para los tipos de constraints (Diccionario Oracle)
   SUBTYPE constraint_type_t IS dba_constraints.constraint_type%TYPE;

   k_coty_primary_key       CONSTANT constraint_type_t := 'P';
   k_coty_unique_key        CONSTANT constraint_type_t := 'U';
   k_coty_foreing_key       CONSTANT constraint_type_t := 'R';
   k_coty_check_const_key   CONSTANT constraint_type_t := 'C';

   -- Record de descripcion de una columna
   SUBTYPE dba_tab_columns_rt IS dba_tab_columns%ROWTYPE;

   -- Record de descripcion de una constraint
   SUBTYPE dba_constraints_rt IS dba_constraints%ROWTYPE;

   -- Record de descripcion de columna de una constraint
   SUBTYPE dba_cons_columns_rt IS dba_cons_columns%ROWTYPE;

   -- Lista de constraints
   TYPE dba_constraints_ct IS TABLE OF dba_constraints_rt
                                 INDEX BY BINARY_INTEGER;

   -- Lista de constraints
   TYPE dba_cons_columns_ct IS TABLE OF dba_cons_columns_rt
                                  INDEX BY BINARY_INTEGER;

   -- Lista de columnas
   TYPE dba_tab_columns_ct IS TABLE OF dba_tab_columns_rt
                                 INDEX BY BINARY_INTEGER;

   -- Existe la tabla en el esquema
   FUNCTION table_exists (p_owner dba_tables.owner%TYPE, p_table dba_tables.table_name%TYPE)
      RETURN BOOLEAN;

   FUNCTION constraint_exists (p_owner             IN dba_objects.owner%TYPE,
                               p_table             IN VARCHAR2,
                               p_constraint_type   IN constraint_type_t)
      RETURN BOOLEAN;

   -- Retorna un record con la descripcion de una columna de una tabla
   FUNCTION table_col (p_owner      IN dba_objects.owner%TYPE,
                       p_table      IN dba_tables.table_name%TYPE,
                       p_col_name   IN dba_tab_columns.column_name%TYPE)
      RETURN dba_tab_columns_rt;

   -- Retorna un arreglo con las columnas de una tabla
   FUNCTION table_cols (p_owner   IN     dba_objects.owner%TYPE,
                        p_table   IN     dba_tables.table_name%TYPE,
                        p_cols       OUT dba_tab_columns_ct)
      RETURN NUMBER;

   --*
   FUNCTION col_exists ( --p_owner         IN dba_tab_columns.owner%TYPE,
                        p_column_name    IN dba_tab_columns.column_name%TYPE,
                        p_tab_columns    IN dba_tab_columns_ct)
      RETURN BOOLEAN;

   FUNCTION col_index (p_column_name   IN dba_tab_columns.column_name%TYPE,
                       p_tab_columns   IN dba_tab_columns_ct)
      RETURN PLS_INTEGER;

   FUNCTION col_exists (p_owner          IN dba_objects.owner%TYPE,
                        p_column_name    IN VARCHAR2,
                        p_cons_columns   IN dba_cons_columns_ct)
      RETURN BOOLEAN;

   FUNCTION some_nullable_column (p_cols IN desc_table_ct)
      RETURN BOOLEAN;

   FUNCTION is_identified_by_sequence (p_table_owner   IN dba_objects.owner%TYPE,
                                       p_table_name    IN dba_tables.table_name%TYPE)
      RETURN BOOLEAN;

   -- Obtiene la descripcion de las columnas de una tabla en una estructura más
   -- pequeña que la dba_tab_columns
   PROCEDURE table_cols (p_owner   IN     dba_objects.owner%TYPE,
                         p_table   IN     dba_tables.table_name%TYPE,
                         p_cols       OUT desc_table_ct);

   -- Retorna la PK de una tabla: MHT: debe ser un procedimiento que tenga por parametro de salida el Record

   ue_pk_does_not_exist              EXCEPTION;
   PRAGMA EXCEPTION_INIT (ue_pk_does_not_exist, -20220);

   FUNCTION pk (p_owner dba_constraints.owner%TYPE, p_table_name dba_constraints.table_name%TYPE)
      RETURN dba_constraints_rt; -- raise ue_pk_does_not_exist

   FUNCTION pk_contraint_name (p_owner         dba_constraints.owner%TYPE,
                               p_table_name    dba_constraints.table_name%TYPE)
      RETURN dba_constraints.constraint_name%TYPE;

   -- Retorna un arreglo con la lista de las constraints de una tabla del tipo
   -- especificado por p_const_type. MHT:XXX: Se puede mejorar
   FUNCTION constraints_puf (p_owner        IN     dba_objects.owner%TYPE,
                         p_table        IN     dba_tables.table_name%TYPE,
                         p_cons            OUT dba_constraints_ct,
                         p_const_type   IN     VARCHAR2 DEFAULT '%' --k_coty_primary_key
                                                                   )
      RETURN NUMBER;

   -- Entrega un arreglo con la lista de las columnas de una constraint
   FUNCTION constraint_cols (p_owner       IN     dba_objects.owner%TYPE,
                             p_cons_name   IN     dba_constraints.constraint_name%TYPE,
                             p_cons_cols      OUT dba_cons_columns_ct)
      RETURN NUMBER;

   PROCEDURE constraint_cols (p_owner       IN     dba_objects.owner%TYPE,
                              p_cons_name   IN     dba_constraints.constraint_name%TYPE,
                              p_cons_cols      OUT dba_cons_columns_ct);

   FUNCTION cols_no_pk (p_owner        IN     dba_objects.owner%TYPE,
                        p_table_name   IN     VARCHAR2,
                        p_cols            OUT dba_tab_columns_ct)
      RETURN NUMBER;

   -- retorna una colección con todas las columnas que no son parte de
   -- algún constraint PK/UK/FK
   FUNCTION cols_no_const_puf (p_owner               dba_objects.owner%TYPE,
                               p_table_name   IN     VARCHAR2,
                               p_cols            OUT dba_tab_columns_ct)
      RETURN NUMBER;

   -- Operaciones sobre las listas de columnas
   PROCEDURE col_minus (p_owner                        dba_objects.owner%TYPE,
                        p_columns        IN OUT NOCOPY dba_tab_columns_ct,
                        p_cons_columns   IN            dba_cons_columns_ct);
END utl_desc;
/
SHOW ERRORS;


