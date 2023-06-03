CREATE OR REPLACE PACKAGE BODY GAT.gat_tab_gen_kp
AS
   /*******************************************************************************
   Empresa:    Explora IT
   Proyecto:   Genera APIs de Tablas
               GAT

   Nombre:     GAT_TAB_GEN_KP
   Proposito:  Genera un package para definir los valores Konstantes
               para las tablas de tipos estáticas

   Cuando     Quien    Que
   ---------- -------- ------------------------------------------------------------
   02/03/2012 mherrera Creación
   *******************************************************************************/

   -- Variables, constantes, tipos y subtipos locales

   PROCEDURE gen_konstants_spec (p_table_owner     IN            dba_objects.owner%TYPE,
                                 p_table_name      IN            dba_tables.table_name%TYPE,
                                 p_package_owner   IN            all_users.username%TYPE,
                                 p_lineas          IN OUT NOCOPY utl_line.lines_t -- lineas
                                                                                 )
   IS
      -- Constantes para identificar el package y el programa
      k_programa       CONSTANT fdc_defs.program_name_t := 'gen_Konstants_spec';
      k_modulo         CONSTANT fdc_defs.module_name_t := gat_tab_gen_kp.k_package || '.' || k_programa;

      -- Variables

      v_pos                     NUMBER (2);
      v_nombre_primario         VARCHAR2 (30);
      v_nombre_corto            VARCHAR2 (120);

      v_name                    VARCHAR2 (255);
      v_subtipo                 VARCHAR2 (255);
      --*
      v_select                  VARCHAR2 (4000);

      --v_linea                   VARCHAR2 (4000);

      --*
      TYPE cursor_ref_t IS REF CURSOR;

      v_cursor                  cursor_ref_t;
      v_valor_id_columna        VARCHAR2 (255);
      v_valor_desc_columna      VARCHAR2 (255);
      v_nombre_base_constante   VARCHAR2 (120);
      v_nombre_constante        VARCHAR2 (220);
      --*
      v_constraint_name         dba_constraints.constraint_name%TYPE;
      v_column_name_pk          dba_tab_columns.column_name%TYPE;
      v_table_short_name        VARCHAR2 (4);
      --*
      v_column_name_order       dba_tab_columns.column_name%TYPE;
      --*
      v_indx                    NUMBER (4);
      v_columns                 utl_desc.dba_tab_columns_ct;
      n_cols                    NUMBER (3);
   BEGIN
      v_pos := INSTR (p_table_name, '_', 1) + 1.0;
      v_nombre_primario := SUBSTR (p_table_name, v_pos);

      SELECT constraint_name
      INTO v_constraint_name
      FROM dba_constraints
      WHERE owner = p_table_owner
      AND   table_name = p_table_name
      AND   constraint_type = 'P';

      v_table_short_name := SUBSTR (v_constraint_name, 1, 4);

      BEGIN
         SELECT column_name
         INTO v_column_name_pk
         FROM dba_cons_columns
         WHERE owner = p_table_owner
         AND   table_name = p_table_name
         AND   constraint_name = v_constraint_name
         AND -- Columna no es foranea
            column_name NOT IN (SELECT column_name
                                FROM dba_constraints cons, dba_cons_columns coco
                                WHERE cons.r_owner = coco.owner
                                AND   cons.r_constraint_name = coco.constraint_name
                                AND -- Restricciones
                                   cons.owner = p_table_owner
                                AND   cons.table_name = p_table_name);
      EXCEPTION
         WHEN TOO_MANY_ROWS
         THEN
            raise_application_error (
               -20100,
                  'tabla:'
               || p_table_name
               || 'tiene una PK con más de una columna independiente, aún no implementado');
      END;

      BEGIN
         SELECT column_name
         INTO v_name
         FROM dba_tab_columns
         WHERE owner = p_table_owner
         AND   table_name = p_table_name
         AND   column_name = 'NOMBRE';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SELECT column_name
            INTO v_name
            FROM dba_tab_columns
            WHERE owner = p_table_owner
            AND   table_name = p_table_name
            AND   column_name = 'DESCRIPCION';
      END;

      --v_name := 'NOMBRE';
      v_subtipo := v_column_name_pk || '_st';
      v_nombre_corto := SUBSTR (p_table_name, v_pos, 2) || SUBSTR (p_table_name, v_pos + 4, 2);
      utl_line.put_line (
         'subtype  ' || v_subtipo || ' is ' || p_table_name || '.' || v_column_name_pk || '%TYPE' || ';',
         p_lineas);

      --* Busca si tiene una columna de orden alternativo

      BEGIN
         SELECT column_name
         INTO v_column_name_order
         FROM (SELECT column_name
               FROM dba_tab_columns
               WHERE owner = p_table_owner
               AND   table_name = p_table_name
               AND   column_name LIKE 'ORDEN%'
               ORDER BY column_id)
         WHERE ROWNUM < 2 -- ordena por la primera columna orden, en el caso que hubiese más de una
                         ;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_column_name_order := NULL;
      END; -- local scope

      --*
      --* 03-Jan-2012:MHT: Agrega distinct para cuando una pk es compuesta y se
      --* repiten los valores de la columna de la pk que es
      --* independiente (no es clave foranea)
      v_select :=
            'select distinct '
         || v_column_name_pk
         || ', '
         || v_name
         || ' from '
         || p_table_owner
         || '.'
         || p_table_name
         || ' WHERE 1=1 '
         || ' order by '
         || CASE WHEN v_column_name_order IS NULL THEN '1' ELSE v_column_name_order END;

      OPEN v_cursor FOR v_select;

      LOOP
         FETCH v_cursor
         INTO v_valor_id_columna, v_valor_desc_columna;

         EXIT WHEN v_cursor%NOTFOUND;
         v_nombre_base_constante := TRANSLATE (v_valor_desc_columna, ' -/.()[]{}*,', '____________');
         v_nombre_base_constante := REPLACE (v_nombre_base_constante, '>', '_MAYOR_');
         v_nombre_base_constante := REPLACE (v_nombre_base_constante, '<', '_MENOR_');
         v_nombre_base_constante := REPLACE (v_nombre_base_constante, '___', '_');
         v_nombre_base_constante := REPLACE (v_nombre_base_constante, '__', '_');
         v_nombre_base_constante := RTRIM (v_nombre_base_constante, '_');
         --*
         v_nombre_base_constante :=
            TRANSLATE (v_nombre_base_constante, 'áéíóúÁÉÍÓÚÑ', 'aeiouaeiouñ');
         --*
         v_nombre_constante := 'k_' || v_nombre_base_constante;

         utl_line.put_line (
               v_nombre_constante
            || ' CONSTANT '
            || v_subtipo
            || ' := '
            || ''''
            || v_valor_id_columna
            || ''''
            || ';'
            || '-- '
            || CASE
                  WHEN LENGTHB (v_nombre_constante) > 30 THEN '[Debe modificar el largo a <= 30 chars]'
                  ELSE NULL
               END
            || INITCAP (v_valor_desc_columna),
            p_lineas);
      END LOOP;

      CLOSE v_cursor;

      utl_line.put_line (gat_defs.k_blank, p_lineas);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (k_modulo);
   END gen_konstants_spec;

   PROCEDURE gencod (p_prod_id         IN gat_productos.prod_id%TYPE,
                     --p_app_name        IN VARCHAR2,
                     p_author          IN all_users.username%TYPE,
                     p_table_owner     IN all_objects.owner%TYPE,
                     p_table_name      IN all_tables.table_name%TYPE,
                     p_package_owner   IN all_users.username%TYPE,
                     p_compile         IN BOOLEAN DEFAULT FALSE)
   IS
      k_programa   CONSTANT VARCHAR2 (30) := UPPER ('gencod');
      k_modulo     CONSTANT VARCHAR2 (61) := SUBSTR (k_package || '.' || k_programa, 1, 61);

      v_lineas              utl_line.lines_t;

      v_package_name        gat_defs.id_name_t;
      v_table_short_name    VARCHAR2 (30);
   BEGIN
      -- Valida que la tabla exista en el esquema
      IF NOT utl_desc.table_exists (UPPER (p_table_owner), UPPER (p_table_name))
      THEN
         raise_application_error (
            -20100,
            'La tabla (' || p_table_name || ') no existe en el esquema del usuario:' || p_table_owner,
            FALSE);
      END IF;

      --* Set Context
      gat.gat_table_ctx.initialize;

      v_table_short_name := gat_utl.get_table_short_name (p_table_owner, p_table_name);

      DBMS_OUTPUT.put_line ('--' || k_modulo || ':' || v_table_short_name);

      gat.gat_table_ctx.set_table_context (p_table_owner      => p_table_owner,
                                           p_table_name       => p_table_name,
                                           p_table_short_name => v_table_short_name);
      -- Genera package para declarar Konstantes
      v_package_name :=
         gat_utl.gen_package_name (gat_defs.k_package_perfix,
                                   p_table_name,
                                   GAT_TIP_PACKAGES_KP.K_PACKAGE_KONSTANTS);

      -- Generar encabezado
      gat_utl.gen_create_pkg_header (p_package_owner => p_package_owner,
                                     p_package_name  => v_package_name,
                                     p_lineas        => v_lineas,
                                     p_is_body       => FALSE);

      utl_line.set_level (-utl_line.get_level);

      gen_pkg_header_comment (p_prod_id      => p_prod_id,
                              p_tpac_codigo  => GAT_TIP_PACKAGES_KP.K_PACKAGE_KONSTANTS,
                              p_author       => p_author,
                              p_package_name => v_package_name,
                              p_tobj_codigo  => gat_tip_objetos_kp.k_especificacion,
                              p_table_owner  => p_table_owner,
                              p_table_name   => p_table_name,
                              p_lineas       => v_lineas);
      utl_line.set_level (1);

      gen_konstants_spec (p_table_owner   => UPPER (p_table_owner),
                          p_table_name    => UPPER (p_table_name),
                          p_package_owner => UPPER (p_package_owner),
                          p_lineas        => v_lineas);

      utl_line.set_level (-1);
      /* cerrar el package */
      utl_line.put_line (REPLACE (gat_defs.k_package_end, gat_defs.k_nombre_package, v_package_name),
                         v_lineas);
      utl_line.put_line ('/', v_lineas);

      utl_line.spool_out (v_lineas);

      IF p_compile
      THEN
         gat_compila.compila_codigo (v_lineas);
      END IF;

      v_lineas.delete;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
         utl_error.informa (k_modulo);
   END gencod;
END gat_tab_gen_kp;
/
SHOW ERRORS;


