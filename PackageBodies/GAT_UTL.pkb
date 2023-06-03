CREATE OR REPLACE PACKAGE BODY GAT.gat_utl
IS
    /*
    Empresa:    Explora-IT
    Proyecto:   Utilidades para desarrolladores PL/SQL
    Objetivo:   Utilidades generales para generar packages de APIs para tablas

    Historia    Quien    Descripción
    ----------- -------- -------------------------------------------------------------
    03-Dic-2004 mherrera Creación
    */

    FUNCTION is_audit_column (
        p_column_name IN dba_tab_columns.column_name%TYPE)
        RETURN BOOLEAN
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'is_audit_column';
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
    -- Variables

    BEGIN
        RETURN p_column_name LIKE 'AUD\_%' ESCAPE '\';
    EXCEPTION
        WHEN OTHERS THEN
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END is_audit_column;

    FUNCTION get_table_short_name (
        p_table_owner    IN dba_objects.owner%TYPE,
        p_table_name     IN dba_tables.table_name%TYPE)
        RETURN VARCHAR2
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'get_table_short_name' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
        -- Variables

        v_constraint_name      dba_constraints.constraint_name%TYPE;
        v_short_name           VARCHAR2 (10);
        v_cons                 utl_desc.dba_constraints_rt;
    BEGIN
        BEGIN
            v_cons :=
                utl_desc.pk (
                    p_owner        => p_table_owner,
                    p_table_name   => p_table_name);
            v_constraint_name := v_cons.constraint_name;
        EXCEPTION
            WHEN utl_desc.ue_pk_does_not_exist THEN
                DECLARE
                    v_tot_cons       PLS_INTEGER;
                    v_constraints    utl_desc.dba_constraints_ct;
                BEGIN
                    v_tot_cons :=
                        utl_desc.constraints_puf (
                            p_owner        => p_table_owner,
                            p_table        => p_table_name,
                            p_cons         => v_constraints,
                            p_const_type   => utl_desc.k_coty_unique_key);

                    IF v_tot_cons = 0.0 THEN
                        raise_application_error (
                            -20500,
                               'Tabla('
                            || p_table_owner
                            || '.'
                            || p_table_name
                            || ') no tiene constraints de pk, uk, fk... no se puede obtener el nombre corto');
                    END IF;

                    v_constraint_name :=
                        v_constraints (v_constraints.FIRST).constraint_name;
                END; -- local scope
        END; -- local scope

        v_short_name :=
            SUBSTR (
                v_constraint_name,
                1,
                INSTR (v_cons.constraint_name, '_') - 1);
        RETURN v_short_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END get_table_short_name;

    --   FUNCTION get_alias (p_owner        IN all_tables.owner%TYPE,
    --                       p_table_name   IN all_tables.table_name%TYPE)
    --      RETURN VARCHAR2
    --   IS
    --      v_constraint_name   dba_constraints.constraint_name%TYPE;
    --   BEGIN
    --      SELECT constraint_name
    --      INTO v_constraint_name
    --      FROM (SELECT constraint_name
    --            FROM dba_constraints
    --            WHERE owner = p_owner
    --              AND table_name = p_table_name
    --              AND constraint_type IN ('P', 'U', 'R')
    --              AND constraint_name NOT LIKE 'BIN$%'
    --            ORDER BY CASE constraint_type
    --                        WHEN 'P' THEN 10
    --                        WHEN 'U' THEN 20
    --                        WHEN 'R' THEN 30
    --                     END)
    --      WHERE ROWNUM < 2;
    --
    --      RETURN SUBSTR (v_constraint_name, 1, 4);
    --   END get_alias;

    FUNCTION gen_package_name (
        p_package_prefix    IN VARCHAR2,
        p_table_name        IN VARCHAR2,
        p_package_type      IN VARCHAR2)
        RETURN fdc_defs.package_name_t
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_package_name';
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
        -- Variables
        v_package_name         fdc_defs.package_name_t;
    BEGIN
        v_package_name :=
               SUBSTR (
                   p_package_prefix || p_table_name,
                   1,
                   gat_defs.k_max_id_len - LENGTH (p_package_type) - 1)
            || '_'
            || p_package_type;

        RETURN v_package_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_package_name;

    FUNCTION gen_program_name (
        p_proc_name             IN VARCHAR2,
        p_subtitution_source    IN VARCHAR2,
        p_name                  IN VARCHAR2)
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'Gen_Program_Name';
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
        -- Variables
        v_name                 VARCHAR2 (60);
    BEGIN
        RETURN SUBSTR (
                   REPLACE (p_proc_name, p_subtitution_source, p_name),
                   1,
                   gat_defs.k_max_id_len);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_program_name;

    PROCEDURE gen_create_pkg_header (
        p_package_owner    IN            all_users.username%TYPE,
        p_package_name     IN            VARCHAR2,
        p_lineas           IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_is_body          IN            BOOLEAN)
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'GEN_CREATE_PKG_HEADER' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
    -- Variables
    BEGIN
        -- Generar encabezado

        --utl_output.put_line (REPLACE (gat_defs.k_prompt, gat_defs.k_nombre_package, p_package_name));
        utl_line.put_line (gat_defs.k_create, p_lineas);
        utl_line.put_line (gat_defs.k_package_name, p_lineas);

        IF p_is_body THEN
            utl_line.rep_curr (gat_defs.k_body, 'BODY', p_lineas);
        ELSE
            utl_line.rep_curr (gat_defs.k_body, NULL, p_lineas);
        END IF;

        utl_line.rep_curr (gat_defs.k_owner_package, p_package_owner, p_lineas);
        utl_line.rep_curr (gat_defs.k_nombre_package, p_package_name, p_lineas);

        --utl_line.put_line (TO_CHAR (gat_defs.k_blank), p_lineas);

        IF uvg_valores_generales.opcion_firma (SYSDATE) THEN
            gen_sign (p_perf_id => 0, p_lineas => p_lineas);
        END IF;
    --utl_line.put_line (gat_defs.k_is_as, p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_create_pkg_header;

    PROCEDURE gen_pkg_header (
        p_prod_id          IN            gat_productos.prod_id%TYPE,
        p_quien            IN            VARCHAR2, -- nombre del que genera (iniciales)
        p_package_owner    IN            all_users.username%TYPE,
        p_package_name     IN            VARCHAR2,
        p_table_owner      IN            all_users.username%TYPE,
        p_table_name       IN            dba_tables.table_name%TYPE, -- tabla
        p_lineas           IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_body             IN            VARCHAR2 DEFAULT NULL)
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'GEN_PKG_HEADER';
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
    -- Variables
    BEGIN
        -- Generar encabezado
        gen_create_pkg_header (
            p_package_owner   => p_package_owner,
            p_package_name    => p_package_name,
            p_lineas          => p_lineas,
            p_is_body         => CASE
                                    WHEN p_body IS NULL THEN FALSE
                                    ELSE TRUE
                                END);

        --      utl_output.put_line (REPLACE (gat_defs.k_prompt, gat_defs.k_nombre_package, p_package_name));
        --      utl_line.put_line (gat_defs.k_create, p_lineas);
        --      utl_line.put_line (gat_defs.k_package_name, p_lineas);
        --      utl_line.rep_curr (gat_defs.k_body, p_body, p_lineas);
        --      utl_line.rep_curr (gat_defs.k_owner_package, p_package_owner, p_lineas);
        --      utl_line.rep_curr (gat_defs.k_nombre_package, p_package_name, p_lineas);
        --      utl_line.put_line (TO_CHAR (gat_defs.k_blank), p_lineas);
        --      utl_line.put_line (' ', p_lineas);

        --* generar comentario
        --* **********************************************************************

        -- TODO: Parametrizar el comment prefix y largo de línea
        gen_pkg_header_comment (
            p_prod_id          => p_prod_id,
            p_tpac_codigo      => SUBSTR (p_package_name, -2),
            p_author           => p_quien,
            p_package_name     => p_package_name,
            p_tobj_codigo      => CASE
                                     WHEN p_body IS NULL THEN
                                         gat_tip_objetos_kp.k_especificacion
                                     ELSE
                                         gat_tip_objetos_kp.k_implementacion
                                 END,
            p_table_owner      => SYS_CONTEXT ('TABLE_CTX', 'table_owner'),
            p_table_name       => SYS_CONTEXT ('TABLE_CTX', 'table_name'),
            p_comment_prefix   => '* ',
            p_lineas           => p_lineas);

        --*
        utl_line.put_line (gat_defs.k_is_as, p_lineas);
        /*
              utl_line.put_line (gat_defs.k_package_com, p_lineas);

              utl_line.rep_curr (gat_defs.k_proy,
                                 'XXXXXXXXXXXXXXXXXXXXXXXXXXX', --p_proy,
                                 p_lineas,
                                 p_lineas.LAST - gat_defs.k_package_com.COUNT + 1,
                                 p_lineas.LAST);

              utl_line.rep_curr (gat_defs.k_tabla,
                                 p_table_name,
                                 p_lineas,
                                 p_lineas.LAST - gat_defs.k_package_com.COUNT + 1,
                                 p_lineas.LAST);
              utl_line.rep_curr (gat_defs.k_fecha_hora,
                                 TO_CHAR (SYSDATE, 'rrrrmmddhh24miss'),
                                 p_lineas,
                                 p_lineas.LAST - gat_defs.k_package_com.COUNT + 1,
                                 p_lineas.LAST);
              --utl_line.put_line (gat_defs.k_package_com_2, p_lineas);
              utl_line.rep_curr (gat_defs.k_proy,
                                 p_proy,
                                 p_lineas,
                                 p_lineas.LAST - gat_defs.k_package_com.COUNT + 1,
                                 p_lineas.LAST);
              utl_line.rep_curr (gat_defs.k_tabla,
                                 p_table_name,
                                 p_lineas,
                                 p_lineas.LAST - gat_defs.k_package_com.COUNT + 1,
                                 p_lineas.LAST);
              utl_line.rep_curr (gat_defs.k_fecha,
                                 TO_CHAR (SYSDATE, 'dd-mon-yyyy'),
                                 p_lineas,
                                 p_lineas.LAST - gat_defs.k_package_com.COUNT + 1,
                                 p_lineas.LAST);
              utl_line.rep_curr (gat_defs.k_quien,
                                 p_quien,
                                 p_lineas,
                                 p_lineas.LAST - gat_defs.k_package_com.COUNT + 1,
                                 p_lineas.LAST);
        */
        --linea en blanco
        utl_line.put_line (gat_defs.k_blank, p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_pkg_header;

    PROCEDURE gen_id_block (
        p_package_name      IN            dba_objects.object_name%TYPE,
        p_program_name      IN            dba_objects.object_name%TYPE,
        p_exception_name    IN            VARCHAR2 DEFAULT NULL,
        p_lineas            IN OUT NOCOPY utl_line.lines_t)
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_id_block';
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
    BEGIN
        -- Constantes para identificar el package/programa que
        -- se está ejecutando
        utl_line.set_level (+1);
        utl_line.put_line (
            '--* Constantes para identificar el programa',
            p_lineas);
        utl_line.put_line ('-- se está ejecutando', p_lineas);

        utl_line.put_line (
               q'<k_programa CONSTANT utl_defs.nombre_programa_t := '>'
            || UPPER (p_program_name)
            || q'<';>',
            p_lineas);
        utl_line.put_line (
            q'<k_modulo CONSTANT utl_defs.nombre_modulo_t := k_package || '.' || k_programa ;>',
            p_lineas);
        utl_line.put_line (
            '-- Variables, constantes, tipos y subtipos locales',
            p_lineas);
        utl_line.set_level (-1);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_id_block;

    PROCEDURE gen_exeption_block (
        p_package_name      IN            dba_objects.object_name%TYPE,
        p_program_name      IN            dba_objects.object_name%TYPE,
        p_exception_name    IN            VARCHAR2 DEFAULT NULL,
        p_lineas            IN OUT NOCOPY utl_line.lines_t -- lineas
                                                          )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_exeption_block';
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
    BEGIN
        utl_line.put_line (gat_defs.k_exception, p_lineas);
        utl_line.set_level (+1);

        -- genera otras excepciones
        IF p_exception_name IS NOT NULL THEN
            utl_line.put_line (
                REPLACE (
                    gat_defs.k_when_exception_then,
                    gat_defs.k_exception_name,
                    p_exception_name),
                p_lineas);
            utl_line.set_level (+1);
            utl_line.put_line (
                   REPLACE (
                       gat_defs.k_raise_exception,
                       gat_defs.k_exception_name,
                       p_exception_name)
                || ';',
                p_lineas);
            utl_line.set_level (-1);
        END IF;

        -- Generar bloque when others

        utl_line.put_line (
               gat_defs.k_when
            || ' '
            || gat_defs.k_exc_value_error
            || ' '
            || gat_defs.k_then,
            p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line ('-- Solo para pasar las reglas de SonarQube', p_lineas); 
        utl_line.put_line ('utl_error.informa (', p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line ('p_programa => k_modulo,', p_lineas);
        utl_line.put_line ('p_mensaje => SQLERRM,', p_lineas);
        utl_line.put_line ('p_rollback => TRUE,', p_lineas);
        utl_line.put_line ('p_raise => TRUE);', p_lineas);
        utl_line.set_level (-2);
            
        -- when others
        utl_line.put_line (
               gat_defs.k_when
            || ' '
            || gat_defs.k_others
            || ' '
            || gat_defs.k_then,
            p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line ('utl_error.informa (', p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line ('p_programa => k_modulo,', p_lineas);
        utl_line.put_line ('p_mensaje => SQLERRM,', p_lineas);
        utl_line.put_line ('p_rollback => TRUE,', p_lineas);
        utl_line.put_line ('p_raise => TRUE);', p_lineas);

        utl_line.set_level (-3);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_exeption_block;

    -- Descripción: Genera parámetros de la forma p_<columna>  <tabla>_TP.<columna>_t
    -- Uso: Se usa para generar una lista de parámetros a partir de una lista de columnas
    -- que pertenecen a algún constraint, lo típico es su uso para genera la lista
    -- de parámetros correspondiente a la pk
    PROCEDURE gen_param_list (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_cons_cols             IN            utl_desc.dba_cons_columns_ct,
        p_lineas                IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_default_value         IN            gat_defs.default_value_t --DEFAULT gat_defs.k_deva_db_default
                                                                      )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_param_list';
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
        -- Variables
        v_indx                 NUMBER (4);
        v_coma                 VARCHAR2 (1);
        v_column_name          dba_tab_columns.column_name%TYPE;
        v_column               utl_desc.dba_tab_columns_rt;
        v_default_val          VARCHAR2 (256);
    BEGIN
        utl_line.app_line ('( ', p_lineas);
        v_indx := p_cons_cols.FIRST;

        WHILE v_indx IS NOT NULL LOOP
            v_column_name := LOWER (p_cons_cols (v_indx).column_name);

            IF p_default_value = gat_defs.k_deva_db_default THEN -- busca si la columna tiene data default o permite nulos
                v_column :=
                    utl_desc.table_col (
                        p_table_owner,
                        p_table_name,
                        v_column_name);

                IF v_column.data_default IS NOT NULL THEN
                    v_default_val := 'DEFAULT  ' || v_column.data_default;
                ELSIF v_column.nullable = 'Y' THEN
                    v_default_val := 'DEFAULT NULL';
                ELSE
                    v_default_val := NULL;
                END IF;
            ELSIF p_default_value = gat_defs.k_deva_db_all_null THEN
                v_default_val := 'DEFAULT NULL';
            ELSE
                v_default_val := NULL;
            END IF;

            utl_line.put_line (
                   v_coma
                || gat_defs.k_prefjo_param
                || SUBSTR (
                       v_column_name,
                       1,
                       30 - LENGTH (gat_defs.k_prefjo_param))
                || ' IN '
                || p_types_package_name
                || '.'
                || SUBSTR (
                       v_column_name,
                       1,
                       30 - LENGTH (gat_defs.k_sufijo_subtype))
                || gat_defs.k_sufijo_subtype
                || ' '
                || v_default_val,
                p_lineas);
            v_coma := ',';
            v_indx := p_cons_cols.NEXT (v_indx);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_param_list;

    -- Descripción: genera lista de variables/parámetros de la forma
    --    p_<columna>  <tabla>_TP.<columna>_t [DEFAULT NULL], ...
    -- a partir de las columnas que vienen en p_cols
    PROCEDURE gen_param_list (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_colums                IN            utl_desc.dba_tab_columns_ct, -- Lista de columnas.
        p_lineas                IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_sufijo_tipo           IN            VARCHAR2 DEFAULT gat_defs.k_sufijo_subtype,
        p_default_value         IN            gat_defs.default_value_t --DEFAULT gat_defs.k_deva_db_default
                                                                      )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_param_list';
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
        -- Variables
        v_indx                 NUMBER (4);
        v_coma                 VARCHAR2 (1);
        v_column_name          dba_tab_columns.column_name%TYPE;
        v_default_val          VARCHAR2 (256);
    BEGIN
        v_indx := p_colums.FIRST;

        WHILE v_indx IS NOT NULL LOOP
            v_column_name := LOWER (p_colums (v_indx).column_name);

            IF p_default_value = gat_defs.k_deva_db_default THEN
                IF p_colums (v_indx).data_default IS NOT NULL THEN
                    v_default_val :=
                        'DEFAULT ' || p_colums (v_indx).data_default;
                ELSIF p_colums (v_indx).nullable = 'Y' THEN
                    v_default_val := 'DEFAULT NULL';
                ELSE
                    v_default_val := NULL;
                END IF;
            ELSIF p_default_value = gat_defs.k_deva_db_all_null THEN
                --v_default_val := 'DEFAULT NULLx';
                v_default_val :=
                       'DEFAULT fdc_null.'
                    || CASE p_colums (v_indx).data_type
                           WHEN 'VARCHAR2' THEN 'nlvc2('
                           WHEN 'NUMBER' THEN 'nlnum('
                           WHEN 'DATE' THEN 'nldate('
                           WHEN 'TIMESTAMP(6)' THEN 'nlts('
                           WHEN 'CLOB' THEN 'nlclob('
                           WHEN 'BLOB' THEN 'nlblob('
                           WHEN 'RAW' THEN 'nlraw('
                       END
                    || ''''
                    || 'P'
                    || TO_CHAR (v_indx)
                    || ''''
                    || ')';
            ELSE
                v_default_val := NULL;
            END IF;

            utl_line.put_line (
                   v_coma
                || gat_defs.k_prefjo_param
                || SUBSTR (
                       v_column_name,
                       1,
                       30 - LENGTH (gat_defs.k_prefjo_param))
                || ' IN '
                || p_types_package_name
                || '.'
                || SUBSTR (v_column_name, 1, 30 - LENGTH (p_sufijo_tipo))
                || p_sufijo_tipo
                || ' '
                || v_default_val,
                p_lineas);
            v_coma := ',';
            v_indx := p_colums.NEXT (v_indx);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_param_list;

    PROCEDURE gen_param_list_sufijo_ct (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_colums                IN            utl_desc.dba_tab_columns_ct, -- Lista de columnas.
        p_lineas                IN OUT NOCOPY utl_line.lines_t)
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'gen_param_list_sufijo_ct' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
        -- Variables
        v_indx                 NUMBER (4);
        v_coma                 VARCHAR2 (1);
        v_column_name          dba_tab_columns.column_name%TYPE;
        v_default_val          VARCHAR2 (256);
    BEGIN
        v_indx := p_colums.FIRST;

        WHILE v_indx IS NOT NULL LOOP
            v_column_name := LOWER (p_colums (v_indx).column_name);
            utl_line.put_line (
                   v_coma
                || gat_defs.k_prefjo_param
                || SUBSTR (
                       v_column_name,
                       1,
                       30 - LENGTH (gat_defs.k_prefjo_param))
                || ' IN '
                || p_types_package_name
                || '.'
                || SUBSTR (v_column_name, 1, 30 - LENGTH ('_ct'))
                || '_ct'
                || ' '
                || v_default_val,
                p_lineas);
            v_coma := ',';
            v_indx := p_colums.NEXT (v_indx);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_param_list_sufijo_ct;

    -- Descripción: genera lista de variables de la forma
    --    v_<columna_1>  <tabla>_TP.<columna>_t;
    --    v_<columna_2>  <tabla>_TP.<columna>_t;
    --    ...
    -- a partir de las columnas que vienen en p_cols
    PROCEDURE gen_vars_columns_list (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_cols                  IN            utl_desc.dba_tab_columns_ct, -- Lista de columnas.
        p_lineas                IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_prefijo               IN            VARCHAR2 DEFAULT gat_defs.k_prefijo_var,
        p_tipo                  IN            VARCHAR2 DEFAULT gat_defs.k_sufijo_subtype)
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'gen_vars_columns_list' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
        -- Variables
        v_column_name          dba_tab_columns.column_name%TYPE;
        v_indx                 NUMBER (4);
    BEGIN
        v_indx := p_cols.FIRST;

        WHILE v_indx IS NOT NULL LOOP
            v_column_name :=
                SUBSTR (
                    LOWER (p_cols (v_indx).column_name),
                    1,
                    gat_defs.k_max_name_len_prefix);
            utl_line.put_line (
                   p_prefijo
                || v_column_name
                || ' '
                || p_types_package_name
                || '.'
                || SUBSTR (
                       p_cols (v_indx).column_name,
                       1,
                       30 - LENGTH (p_tipo))
                || p_tipo
                || ';',
                p_lineas);
            v_indx := p_cols.NEXT (v_indx);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_vars_columns_list;

    -- Genera lista de las columnas de forma [<p_prefijo>_]<columna>, ...
    PROCEDURE gen_col_list (
        p_table_owner     IN            dba_objects.owner%TYPE,
        p_table_name      IN            dba_tables.table_name%TYPE, -- tabla
        p_lineas          IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_tipo_prefijo    IN            gat_defs.tipo_prefijo_lista_cols_t DEFAULT NULL,
        p_prefijo         IN            VARCHAR2 DEFAULT NULL,
        p_subindice       IN            VARCHAR2 DEFAULT NULL)
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_col_list';
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
        -- Variables
        v_indx                 NUMBER (4);
        v_coma                 VARCHAR2 (1);
        v_columns              utl_desc.dba_tab_columns_ct;
        v_numcols              NUMBER (3);
        v_string               VARCHAR2 (128);
    BEGIN
        v_numcols :=
            utl_desc.table_cols (p_table_owner, p_table_name, v_columns);
        v_indx := v_columns.FIRST;

        WHILE v_indx IS NOT NULL LOOP
            IF p_tipo_prefijo IS NULL THEN
                v_string := v_columns (v_indx).column_name;
            ELSIF p_tipo_prefijo = gat_defs.k_tplc_tabla THEN
                -- Se usa p_<tabla>. como prefijo
                v_string :=
                       SUBSTR (
                           p_prefijo || p_table_name,
                           1,
                           gat_defs.k_max_id_len)
                    || '.'
                    || v_columns (v_indx).column_name;
            ELSIF p_tipo_prefijo = gat_defs.k_tplc_columna THEN
                -- El nombre de la columna se usa como parametro
                v_string :=
                       p_prefijo
                    || SUBSTR (
                           v_columns (v_indx).column_name,
                           1,
                           gat_defs.k_max_name_len_prefix);
            ELSE
                raise_application_error (
                    -20100,
                       'gen_col_list: tipo_prefijo_lista_cols_t de prefijo ('
                    || p_tipo_prefijo
                    || ') inálido.',
                    FALSE);
            END IF;

            utl_line.put_line (v_coma || v_string || p_subindice, p_lineas);
            v_coma := ',';
            v_indx := v_columns.NEXT (v_indx);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_col_list;

    PROCEDURE gen_where_list ( --      p_table_owner           IN       dba_objects.owner%TYPE,
        p_cons_cols    IN            utl_desc.dba_cons_columns_ct,
        p_lineas       IN OUT NOCOPY utl_line.lines_t -- lineas
                                                     )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_where_list';
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
        -- Variables
        v_indx                 NUMBER (4);
        v_and                  gat_defs.linea;
        v_column_name          dba_tab_columns.column_name%TYPE;
    BEGIN
        -- Genera condicion where de la forma
        -- <columna> = <p_<columna> para las columnas en p_cons_cols
        utl_line.put_line (gat_defs.k_where, p_lineas);
        utl_line.set_level (+1);
        v_indx := p_cons_cols.FIRST;

        WHILE v_indx IS NOT NULL LOOP
            v_column_name :=
                SUBSTR (
                    LOWER (p_cons_cols (v_indx).column_name),
                    1,
                    gat_defs.k_max_name_len_prefix);
            utl_line.put_line (
                   v_and
                || p_cons_cols (v_indx).column_name
                || ' = '
                || gat_defs.k_prefjo_param
                || v_column_name,
                p_lineas);
            v_indx := p_cons_cols.NEXT (v_indx);
            v_and := gat_defs.k_and;
        END LOOP;

        utl_line.set_level (-1);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_where_list;

    PROCEDURE gen_cursor_where_puf (
        p_table_owner        IN            dba_objects.owner%TYPE,
        p_table_name         IN            dba_tables.table_name%TYPE,
        p_constraint_name    IN            dba_constraints.constraint_name%TYPE,
        p_expand_cols        IN            BOOLEAN DEFAULT TRUE,
        p_lineas             IN OUT NOCOPY utl_line.lines_t -- lineas
                                                           )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'gen_cursor_where_puf' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
        -- Variables
        n_cols                 NUMBER (3);
        v_constraint           utl_desc.dba_constraints_rt;
        v_cons_cols            utl_desc.dba_cons_columns_ct;
    BEGIN
        -- generar cursor con where sobre la PK
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qry_cursor,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_prefix)),
            p_lineas);
        utl_line.set_level (1);

        -- Genera la lista de columnas separada por comas
        IF p_expand_cols THEN
            gen_col_list (p_table_owner, p_table_name, p_lineas);
        ELSE
            utl_line.put_line (' * ', p_lineas);
        END IF;

        utl_line.put_line (
            REPLACE (gat_defs.k_qry_proc_from, gat_defs.k_tabla, p_table_name),
            p_lineas);
        -- agregar el where de acuerdo a la pk
        n_cols :=
            utl_desc.constraint_cols (
                p_table_owner,
                p_constraint_name,
                v_cons_cols);
        gen_where_list (v_cons_cols, p_lineas);
        utl_line.app_line (';', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_cursor_where_puf;

    PROCEDURE gen_select_sin_where (
        p_table_owner    IN            dba_objects.owner%TYPE,
        p_table_name     IN            dba_tables.table_name%TYPE, -- tabla
        p_expand_cols    IN            BOOLEAN DEFAULT TRUE,
        p_lineas         IN OUT NOCOPY utl_line.lines_t -- lineas
                                                       )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'gen_select_sin_where' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
    BEGIN
        -- generar cursor con where sobre la PK
        utl_line.put_line (gat_defs.k_select, p_lineas);

        -- Genera la lista de columnas separada por comas
        IF p_expand_cols THEN
            gen_col_list (p_table_owner, p_table_name, p_lineas);
        ELSE
            utl_line.put_line (' * ', p_lineas);
        END IF;

        utl_line.put_line (
            REPLACE (gat_defs.k_qry_proc_from, gat_defs.k_tabla, p_table_name),
            p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END gen_select_sin_where;

    FUNCTION columns_for_update (
        p_table_owner    IN dba_objects.owner%TYPE,
        p_table_name     IN dba_tables.table_name%TYPE)
        RETURN BOOLEAN
    -- verifica que hay columnas aparte de la pk para actualizar
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'columns_for_update';
        k_modulo      CONSTANT fdc_defs.module_name_t
                                   := gat_utl.k_package || '.' || k_programa ;
        -- Variables
        v_columns              utl_desc.dba_tab_columns_ct;
        v_ncols                NUMBER (4);
        v_exists               BOOLEAN := FALSE;
    BEGIN
        v_ncols := utl_desc.cols_no_pk (p_table_owner, p_table_name, v_columns);

        IF v_ncols > 0 THEN
            v_exists := TRUE;
        END IF;

        v_columns.delete;
        RETURN v_exists;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => TRUE,
                p_raise      => TRUE);
    END columns_for_update;
END gat_utl;
/
SHOW ERRORS;


