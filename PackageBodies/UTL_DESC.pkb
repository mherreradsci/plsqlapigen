CREATE OR REPLACE PACKAGE BODY GAT.utl_desc
/*
--------------------------------------------------------------------------------
Explora IT
Proyecto:  Utilidades para desarrolladores
Objetivo:  Procedimientos para describir tablas usando el diccionario
           de datosa Oracle

Historia:
Cuando      Quien    Comantario
----------- -------- -----------------------------------------------------------
10-Feb-2003 mherrera Creación
17-Dic-2004 mherrera Función: constraints: La versión de la tabla/vista
                     "dba_constraints" cambia entre la versión 8.1.7 y 9.2, así
                     que, por compatibilidad, es mejor usar "select *" en vez de
                     las columnas nombradas.
08-Abr-2012 mherrera Agrega programa some_nullable_column
08-Abr-2012 mherrera Agrega programa pk_contraint_name
22-May-2012 mherrera Renombra constraints a constraints_puf y modifica el select
                     respectivo para obtener los registros en orden según 
                     clave primaria, claves únicas y claves foraneas
--------------------------------------------------------------------------------
*/
IS
   FUNCTION col_exists ( --p_owner         IN dba_tab_columns.owner%TYPE,
                        p_column_name    IN dba_tab_columns.column_name%TYPE,
                        p_tab_columns    IN dba_tab_columns_ct)
      RETURN BOOLEAN
   IS
      i         NUMBER (4);
      v_found   BOOLEAN := FALSE;
   BEGIN
      i := p_tab_columns.FIRST;

      WHILE i IS NOT NULL
            AND NOT v_found LOOP
         IF p_column_name = p_tab_columns (i).column_name
         THEN
            v_found := TRUE;
         END IF;

         i := p_tab_columns.NEXT (i);
      END LOOP;

      RETURN v_found;
   END col_exists;

   FUNCTION col_index (p_column_name   IN dba_tab_columns.column_name%TYPE,
                       p_tab_columns   IN dba_tab_columns_ct)
      RETURN PLS_INTEGER
   IS
      i         PLS_INTEGER;
      v_index   PLS_INTEGER := NULL;
   BEGIN
      IF p_tab_columns.COUNT = 0
      THEN
         RETURN NULL;
      END IF;

      i := p_tab_columns.FIRST;

      WHILE i IS NOT NULL
            AND v_index IS NULL LOOP
         IF p_column_name = p_tab_columns (i).column_name
         THEN
            v_index := i;
         END IF;

         i := p_tab_columns.NEXT (i);
      END LOOP;

      RETURN v_index;
   END col_index;

   FUNCTION col_exists (p_owner          IN dba_objects.owner%TYPE,
                        p_column_name    IN VARCHAR2,
                        p_cons_columns   IN dba_cons_columns_ct)
      RETURN BOOLEAN
   IS
      i         NUMBER (4);
      v_found   BOOLEAN := FALSE;
   BEGIN
      i := p_cons_columns.FIRST;

      WHILE i IS NOT NULL
            AND NOT v_found LOOP
         IF p_column_name = p_cons_columns (i).column_name
         THEN
            v_found := TRUE;
         END IF;

         i := p_cons_columns.NEXT (i);
      END LOOP;

      RETURN v_found;
   END col_exists;

   -- Resta de las columnas las columnas contenidas en el constraint
   PROCEDURE col_minus (p_owner          IN            dba_objects.owner%TYPE,
                        p_columns        IN OUT NOCOPY dba_tab_columns_ct,
                        p_cons_columns   IN            dba_cons_columns_ct)
   IS
      v_indx_cols        NUMBER (4);
      ue_nothing_to_do   EXCEPTION;
   BEGIN
      -- MHT:XXX:Esto se puede implementar via SELECT de BD y creo que sería más optimo
      IF p_cons_columns IS NULL
         OR p_cons_columns.COUNT = 0
      THEN
         RAISE ue_nothing_to_do;
      END IF;

      IF p_columns IS NULL
         OR p_columns.COUNT = 0
      THEN
         RAISE ue_nothing_to_do;
      END IF;

      v_indx_cols := p_columns.FIRST;

      WHILE v_indx_cols IS NOT NULL LOOP
         IF col_exists (p_owner, p_columns (v_indx_cols).column_name, p_cons_columns)
         THEN
            p_columns.delete (v_indx_cols);
         END IF;

         v_indx_cols := p_columns.NEXT (v_indx_cols);
      END LOOP;
   EXCEPTION
      WHEN ue_nothing_to_do
      THEN
         NULL; -- retorna sin hacer nada
   END col_minus;

   FUNCTION table_exists (p_owner dba_tables.owner%TYPE, p_table dba_tables.table_name%TYPE)
      RETURN BOOLEAN
   IS
      k_programa   CONSTANT VARCHAR2 (30) := UPPER ('table_exists');
      k_modulo     CONSTANT VARCHAR2 (61) := SUBSTR (k_package || '.' || k_programa, 1, 61);
      v_stub                VARCHAR2 (1);
   BEGIN
      SELECT NULL
      INTO v_stub
      FROM dba_tables
      WHERE owner = UPPER (p_owner)
      AND   table_name = p_table;

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN FALSE;
      WHEN OTHERS
      THEN
         utl_error.informa (k_modulo);
   END table_exists;

   -- Retorna un record con la descripcion de una columna de una tabla
   FUNCTION table_col (p_owner      IN dba_objects.owner%TYPE,
                       p_table      IN dba_tables.table_name%TYPE,
                       p_col_name   IN dba_tab_columns.column_name%TYPE)
      RETURN dba_tab_columns_rt
   IS
      v_col   dba_tab_columns_rt;
   BEGIN
      SELECT *
      INTO v_col
      FROM dba_tab_columns
      WHERE table_name = UPPER (p_table)
      AND   column_name = UPPER (p_col_name)
      AND   owner = UPPER (p_owner);

      RETURN v_col;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         raise_application_error (
            -20100,
            k_package || '.table_col: No existe columna ' || p_table || '.' || p_col_name);
   END table_col;

   FUNCTION table_cols (p_owner   IN     dba_objects.owner%TYPE,
                        p_table   IN     dba_tables.table_name%TYPE,
                        p_cols       OUT dba_tab_columns_ct)
      RETURN NUMBER
   IS
      -- Columnas de la tabla/vista
      CURSOR cur_cols
      IS
         SELECT *
         FROM dba_tab_columns
         WHERE table_name = UPPER (p_table)
         AND   owner = UPPER (p_owner)
         ORDER BY column_id;

      i   PLS_INTEGER;
   BEGIN
      i := 0;

      FOR v_col IN cur_cols LOOP
         i := i + 1;
         p_cols (i) := v_col;
      END LOOP;

      RETURN i;
   END table_cols;

   PROCEDURE table_cols (p_owner   IN     dba_objects.owner%TYPE,
                         p_table   IN     dba_tables.table_name%TYPE,
                         p_cols       OUT desc_table_ct)
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'gen_transfer_objects';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;

      --*
      CURSOR cur_cols
      IS
         SELECT column_name,
                data_type,
                CASE
                   WHEN data_type IN ('CHAR', 'VARCHAR', 'VARCHAR2', 'BLOB', 'CLOB') THEN data_length
                   ELSE data_precision
                END
                   data_precision,
                data_scale,
                nullable
         --column_id
         FROM dba_tab_columns
         WHERE table_name = UPPER (p_table)
         AND   owner = UPPER (p_owner)
         ORDER BY column_id;
   BEGIN
      OPEN cur_cols;

      FETCH cur_cols
      BULK COLLECT INTO p_cols;

      CLOSE cur_cols;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END table_cols;

   FUNCTION some_nullable_column (p_cols IN desc_table_ct)
      RETURN BOOLEAN -- Exclude AUD_% Cols
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'some_nullable_column';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
      --*
      v_exists              BOOLEAN := FALSE;
   BEGIN
      IF p_cols.COUNT > 0
      THEN
        <<ll_finder>>
         FOR i IN p_cols.FIRST .. p_cols.LAST LOOP
            IF p_cols (i).nullable = 'Y'
               AND p_cols (i).column_name NOT LIKE 'AUD\_%' ESCAPE '\'
            THEN
               v_exists := TRUE;
               EXIT ll_finder;
            END IF;
         END LOOP;
      END IF;

      DBMS_OUTPUT.put_line (k_modulo || ':' || CASE WHEN v_exists THEN 'TRUE' ELSE 'FALSE' END);
      RETURN v_exists;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END some_nullable_column;

   FUNCTION is_identified_by_sequence (p_table_owner   IN dba_objects.owner%TYPE,
                                       p_table_name    IN dba_tables.table_name%TYPE)
      RETURN BOOLEAN
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'is_identified_by_sequence';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
      --*
      v_dummy               VARCHAR2 (1);
   BEGIN
      SELECT 'x'
      INTO v_dummy
      FROM dba_constraints cons, dba_cons_columns coco
      WHERE cons.owner = coco.owner
      AND   cons.table_name = coco.table_name
      AND   cons.constraint_name = coco.constraint_name
      AND -- Restricciones
         cons.owner = p_table_owner
      AND   cons.table_name = p_table_name
      AND   cons.constraint_type = utl_desc.k_coty_primary_key
      AND   coco.column_name LIKE '____\_ID' ESCAPE '\';

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND OR TOO_MANY_ROWS
      THEN
         RETURN FALSE;
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END is_identified_by_sequence;

   /*
      FUNCTION CONSTRAINTS (
         p_owner          IN   dba_objects.owner%TYPE,
         p_table   IN       VARCHAR2,
         p_cons    OUT      dba_constraints_ct,
      )
         RETURN NUMBER
      IS
         -- Constraints de la tabla
         CURSOR cur_cons
         IS
            SELECT *
            FROM   dba_constraints
            WHERE  table_name = UPPER (p_table)
            and    owner = UPPER(p_owner);

         i   PLS_INTEGER;
      BEGIN
         i := 0;

         FOR v_cons IN cur_cons LOOP
            i := i + 1;
            p_cons (i) := v_cons;
         END LOOP;

         RETURN i;
      END CONSTRAINTS;
   */
   -- obtiene un tipo de constraint determinado por  p_const_type
   FUNCTION constraints_puf (p_owner        IN     dba_objects.owner%TYPE,
                         p_table        IN     dba_tables.table_name%TYPE,
                         p_cons            OUT dba_constraints_ct,
                         p_const_type   IN     VARCHAR2 DEFAULT '%' --k_coty_primary_key
                                                                   )
      RETURN NUMBER
   IS
      -- constraints de la tabla/vista
      CURSOR cur_cons
      IS
         SELECT * -- La versión de esta tabla/vista cambia entre 817 y 9.2, así
                  -- que, por compatibilidad, es mejor usar * en vez de las
                  -- columnas nombradas
         FROM dba_constraints
         WHERE owner = UPPER (p_owner)
         AND   table_name = UPPER (p_table)
         AND   constraint_type LIKE p_const_type
         AND   constraint_type IN (k_coty_primary_key, k_coty_unique_key, k_coty_foreing_key)
         ORDER BY CASE constraint_type
                     WHEN k_coty_primary_key THEN 'A'
                     WHEN k_coty_unique_key THEN 'E'
                     WHEN k_coty_foreing_key THEN 'I'
                  END,
                  constraint_name;

      i   PLS_INTEGER;
   BEGIN
      i := 0;

      FOR v_cons IN cur_cons LOOP
         i := i + 1;
         p_cons (i) := v_cons;
      END LOOP;

      RETURN i;
   END constraints_puf;

   -- Busca si existe la contraint del tipo p_contstraint_type
   FUNCTION constraint_exists (p_owner             IN dba_objects.owner%TYPE,
                               p_table             IN VARCHAR2,
                               p_constraint_type   IN constraint_type_t)
      RETURN BOOLEAN
   IS
      -- Constantes para identificar el package y el programa
      k_programa   CONSTANT fdc_defs.program_name_t := 'constraint_exists';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;

      -- Variables
      CURSOR un_registro
      IS
         SELECT NULL
         FROM dba_constraints
         WHERE owner = UPPER (p_owner)
         AND   table_name = UPPER (p_table)
         AND   constraint_type = UPPER (p_constraint_type);

      v_dummy               VARCHAR2 (1);
      v_retval              BOOLEAN;
   BEGIN
      OPEN un_registro;

      FETCH un_registro
      INTO v_dummy;

      v_retval := un_registro%FOUND;

      CLOSE un_registro;

      RETURN v_retval;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
         utl_error.informa (k_modulo);
   END constraint_exists;

   -- Retorna la PK de una tabla
   FUNCTION pk (p_owner dba_constraints.owner%TYPE, p_table_name dba_constraints.table_name%TYPE)
      RETURN dba_constraints_rt
   IS
      v_cons   dba_constraints_rt;
   BEGIN
      SELECT *
      INTO v_cons
      FROM dba_constraints
      WHERE owner = UPPER (p_owner)
      AND   table_name = UPPER (p_table_name)
      AND   constraint_type = k_coty_primary_key
      ORDER BY 1;

      RETURN v_cons;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         raise_application_error (-20220, k_package || '.pk: Tabla ' || p_table_name || ' no tiene PK');
   END pk;

   FUNCTION pk_contraint_name (p_owner         dba_constraints.owner%TYPE,
                               p_table_name    dba_constraints.table_name%TYPE)
      RETURN dba_constraints.constraint_name%TYPE
   IS
      -- Constantes para identificar el package y el programa
      k_programa   CONSTANT fdc_defs.program_name_t := 'pk_contraint_name';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
      --*
      v_constraint_name     dba_constraints.constraint_name%TYPE;
   BEGIN
      SELECT cons.constraint_name
      INTO v_constraint_name
      FROM dba_constraints cons
      WHERE cons.owner = p_owner
      AND   cons.table_name = p_table_name
      AND   cons.constraint_type = k_coty_primary_key;

      RETURN v_constraint_name;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END pk_contraint_name;

   FUNCTION constraint_cols (p_owner       IN     dba_objects.owner%TYPE,
                             p_cons_name   IN     dba_constraints.constraint_name%TYPE,
                             p_cons_cols      OUT dba_cons_columns_ct)
      RETURN NUMBER
   IS
      -- columnas de una constraint
      CURSOR cur_cons_cols
      IS
         SELECT *
         FROM dba_cons_columns
         WHERE constraint_name = UPPER (p_cons_name)
         AND   owner = UPPER (p_owner)
         ORDER BY position;

      i   PLS_INTEGER;
   BEGIN
      i := 0;

      FOR v_cons_col IN cur_cons_cols LOOP
         i := i + 1;
         p_cons_cols (i) := v_cons_col;
      END LOOP;

      RETURN i;
   END constraint_cols;

   PROCEDURE constraint_cols (p_owner       IN     dba_objects.owner%TYPE,
                              p_cons_name   IN     dba_constraints.constraint_name%TYPE,
                              p_cons_cols      OUT dba_cons_columns_ct)
   IS
      v_dummy   NUMBER (10);
   BEGIN
      v_dummy := constraint_cols (p_owner, p_cons_name, p_cons_cols);
   END;

   FUNCTION cols_no_pk (p_owner        IN     dba_objects.owner%TYPE,
                        p_table_name   IN     VARCHAR2,
                        p_cols            OUT dba_tab_columns_ct)
      RETURN NUMBER
   IS
      CURSOR cur_cols_no_pk (p_table_name VARCHAR2)
      IS
         SELECT *
         FROM dba_tab_columns utc
         WHERE table_name = UPPER (p_table_name)
         AND   utc.owner = UPPER (p_owner)
         AND   NOT EXISTS
                  (SELECT NULL
                   FROM dba_constraints uc, dba_cons_columns ucc
                   WHERE uc.constraint_type = k_coty_primary_key
                   AND   uc.constraint_name = ucc.constraint_name
                   AND   ucc.table_name = utc.table_name
                   AND   ucc.column_name = utc.column_name
                   AND   uc.owner = UPPER (p_owner)
                   AND   uc.owner = ucc.owner);

      i   PLS_INTEGER;
   BEGIN
      i := 0;

      FOR v_cols IN cur_cols_no_pk (p_table_name) LOOP
         i := i + 1;
         p_cols (i) := v_cols;
      END LOOP;

      RETURN i;
   END cols_no_pk;

   FUNCTION cols_no_const_puf (p_owner        IN     dba_objects.owner%TYPE,
                               p_table_name   IN     VARCHAR2,
                               p_cols            OUT dba_tab_columns_ct)
      RETURN NUMBER
   IS
      CURSOR cur_cols_const_puf (p_table_name dba_tables.table_name%TYPE)
      IS
         -- MHT: ELIMINAR LAS COLUMNAS QUE NO SE USAN o CRAR UN XP para
         -- este cursor
         SELECT *
         FROM dba_tab_columns utc
         WHERE table_name = UPPER (p_table_name)
         AND   owner = UPPER (p_owner)
         AND   NOT EXISTS
                  (SELECT NULL
                   FROM dba_constraints uc, dba_cons_columns ucc
                   WHERE uc.constraint_type IN (k_coty_primary_key, k_coty_unique_key, k_coty_foreing_key)
                   AND   uc.constraint_name = ucc.constraint_name
                   AND   uc.table_name = ucc.table_name
                   AND   ucc.table_name = utc.table_name
                   AND   ucc.column_name = utc.column_name
                   AND   uc.owner = UPPER (p_owner)
                   AND   uc.owner = ucc.owner);

      i   PLS_INTEGER;
   BEGIN
      i := 0;

      FOR v_cols IN cur_cols_const_puf (p_table_name) LOOP
         i := i + 1;
         p_cols (i) := v_cols;
      END LOOP;

      RETURN i;
   END cols_no_const_puf;
END utl_desc;
/
SHOW ERRORS;


