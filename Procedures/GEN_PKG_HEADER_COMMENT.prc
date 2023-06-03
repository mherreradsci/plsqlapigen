CREATE OR REPLACE PROCEDURE GAT.gen_pkg_header_comment (
    p_prod_id         IN            gat_productos.prod_id%TYPE,
    p_tpac_codigo     IN            gat_tip_packages.tpac_codigo%TYPE,
    p_author          IN            all_users.username%TYPE,
    p_package_name    IN            all_objects.object_name%TYPE,
    p_tobj_codigo     IN            gat_tip_objetos.tobj_codigo%TYPE,
    p_table_owner     IN            all_objects.owner%TYPE,
    p_table_name      IN            all_tables.table_name%TYPE,
    p_comment_prefix  in            varchar2 default null,
    p_lineas          IN OUT NOCOPY utl_line.lines_t)
IS
    -- Constantes para identificar el package y programa
    k_programa    CONSTANT fdc_defs.program_name_t := 'GEN_PKG_HEADER_COMMENT';
    k_modulo      CONSTANT fdc_defs.module_name_t := --gat_utl.k_package || '.' ||
                                                    k_programa;

    --*

    CURSOR c_tpso (p_perf_id gat_productos.prod_id%TYPE)
    IS
        SELECT   tpso.linea
        FROM     gat_tplt_source tpso
        WHERE        tpso.perf_id = p_perf_id
                 AND tpso.ttem_codigo = gat_tip_templates_kp.k_com_header_pkg
        ORDER BY tpso.tpso_id;

    v_lineas               utl_line.lines_t;

    SUBTYPE r_tema IS gat_template_map%ROWTYPE;

    TYPE tema_ct IS TABLE OF r_tema;

    v_tema                 tema_ct;
    --*
    v_sql_command          VARCHAR2 (4000);
    v_valor                VARCHAR2 (4000);

    TYPE valores_t IS TABLE OF v_valor%TYPE
        INDEX BY BINARY_INTEGER;

    v_valores              valores_t;
    --*
    v_perf_id              gat_productos.perf_id%TYPE;
BEGIN
/*
    DBMS_OUTPUT.put_line ('--' || k_modulo || ':' || 'INI');

    DBMS_OUTPUT.put_line ('--' || k_modulo || ':' || 'p_prod_id:' || p_prod_id);
    DBMS_OUTPUT.put_line (
        '--' || k_modulo || ':' || 'p_tpac_codigo:' || p_tpac_codigo);
    DBMS_OUTPUT.put_line ('--' || k_modulo || ':' || 'p_author:' || p_author);
    DBMS_OUTPUT.put_line (
        '--' || k_modulo || ':' || 'p_package_name:' || p_package_name);
    DBMS_OUTPUT.put_line (
        '--' || k_modulo || ':' || 'p_tobj_codigo:' || p_tobj_codigo);
    DBMS_OUTPUT.put_line (
        '--' || k_modulo || ':' || 'p_table_owner:' || p_table_owner);
    DBMS_OUTPUT.put_line (
        '--' || k_modulo || ':' || 'p_table_name:' || p_table_name);

    DBMS_OUTPUT.put_line (
        '--' || k_modulo || ':p_lineas.count:' || p_lineas.COUNT);
    DBMS_OUTPUT.put_line (
        '--' || k_modulo || ':p_lineas.FIRST:' || p_lineas.FIRST);
    DBMS_OUTPUT.put_line (
        '--' || k_modulo || ':p_lineas.LAST:' || p_lineas.LAST);

    DBMS_OUTPUT.put_line ('--' || k_modulo || ':' || 'Inicio:v_lineas');
    utl_line.spool_out (v_lineas);

    DBMS_OUTPUT.put_line ('--' || k_modulo || ':' || 'Fin:v_lineas');
*/

    SELECT perf_id
    INTO   v_perf_id
    FROM   gat_productos prod
    WHERE  prod.prod_id = p_prod_id;

    --* Carga el template
    OPEN c_tpso (v_perf_id);

    FETCH c_tpso
        BULK COLLECT INTO v_lineas;

    CLOSE c_tpso;

    IF v_lineas.COUNT = 0 THEN
        DBMS_OUTPUT.put_line ('--' || k_modulo || ':' || 'No existe template');
        RETURN;
    END IF;

    DBMS_OUTPUT.put_line ('--' || k_modulo || ':' || 'Template cargado ok');

    --* Carga de Parametros que se resuelven de tablas
    --* *************************************************************************
    DBMS_OUTPUT.put_line ('--' || k_modulo || ':' || 'uno');

    SELECT *
    BULK   COLLECT INTO v_tema
    FROM   gat_template_map tema
    WHERE      tema.perf_id = v_perf_id
           AND tema.tipr_codigo = gat_tip_parametros_kp.k_definido_por_tabla;

    DBMS_OUTPUT.put_line ('--' || k_modulo || ':' || 'dos:' || v_tema.COUNT);

    --* Reemplaza los parametros que son de tabla
    --* *************************************************************************
    IF v_tema.COUNT > 0 THEN
        FOR i IN v_tema.FIRST .. v_tema.LAST LOOP
            v_sql_command :=
                   'SELECT '
                || v_tema (i).subcomponent
                || ' from '
                || v_tema (i).component
                || ' where p_perf_id = :p_perf_id';

            DBMS_OUTPUT.put_line (
                '--' || k_modulo || ':' || 'tres:' || v_sql_command);

            EXECUTE IMMEDIATE v_sql_command INTO v_valores (i) USING v_perf_id;

            DBMS_OUTPUT.put_line (
                '--' || k_modulo || ':' || 'cuatro:' || v_sql_command);
            utl_line.rep_curr (
                v_tema (i).para_code,
                v_valores (i),
                v_lineas,
                v_lineas.FIRST,
                v_lineas.LAST);
            DBMS_OUTPUT.put_line ('--' || k_modulo || ':' || 'cinco');
        END LOOP;

        v_tema.delete;
    END IF;

    --* Carga de parametros que no son del tipo tabla
    --* *************************************************************************
    SELECT *
    BULK   COLLECT INTO v_tema
    FROM   gat_template_map tema
    WHERE      tema.perf_id = v_perf_id
           AND tema.tipr_codigo NOT IN
                   (gat_tip_parametros_kp.k_definido_por_tabla,
                    gat_tip_parametros_kp.k_hard);

    DBMS_OUTPUT.put_line (
           '--'
        || k_modulo
        || ':'
        || 'Carga de parametros que no son del tipo tabla:v_tema.COUNT: '
        || v_tema.COUNT);

    IF v_tema.COUNT > 0 THEN
        -- Reemplaza los parametros que no son de tabla
        FOR i IN v_tema.FIRST .. v_tema.LAST LOOP
            v_sql_command :=
                   CASE v_tema (i).tipr_codigo
                       WHEN gat_tip_parametros_kp.k_valores_generales THEN
                              'SELECT '
                           || v_tema (i).component
                           || '.'
                           || v_tema (i).subcomponent
                       --|| '(sysdate)'
                       WHEN gat_tip_parametros_kp.k_funcion_primitiva THEN
                           'SELECT ' || v_tema (i).component
                       WHEN gat_tip_parametros_kp.k_valores_x_contexto THEN
                           'SELECT ' || v_tema (i).component
                   END
                || ' from dual';

            --DBMS_OUTPUT.put_line ('v_sql_command:' || v_sql_command);

            BEGIN
                EXECUTE IMMEDIATE v_sql_command INTO v_valores (i);
            EXCEPTION
                WHEN OTHERS THEN
                    raise_application_error (-20100, SQLERRM || v_sql_command);
            END; -- local scope

            utl_line.rep_curr (
                v_tema (i).para_code,
                v_valores (i),
                v_lineas,
                v_lineas.FIRST,
                v_lineas.LAST);
        END LOOP;

        v_tema.delete;
    END IF;

    --* Reemplaza los parametros de tiempo de ejecución
    --* *************************************************************************
    /*
    DBMS_OUTPUT.put_line (
           '--'
        || k_modulo
        || ':'
        || 'INI: Reemplaza los parametros de tiempo de ejecución');

    DBMS_OUTPUT.put_line (
        '--' || k_modulo || ':v_lineas.COUNT:' || v_lineas.COUNT);
    DBMS_OUTPUT.put_line (
        '--' || k_modulo || ':v_lineas.FIRST:' || v_lineas.FIRST);
    DBMS_OUTPUT.put_line (
        '--' || k_modulo || ':v_lineas.LAST:' || v_lineas.LAST);
    
    utl_line.spool_out (v_lineas);


    DBMS_OUTPUT.put_line (
           '--'
        || k_modulo
        || ':'
        || 'Reemplaza los parametros de tiempo de ejecución:2');
    */        

    DECLARE
        v_descripcion    gat_rel_tplt_tpac.descripcion%TYPE;
    BEGIN
        utl_line.rep_curr (
            '%NOMBRE_PACKAGE%',
            p_package_name,
            v_lineas,
            v_lineas.FIRST,
            v_lineas.LAST);

        SELECT tptp.descripcion
        INTO   v_descripcion
        FROM   gat_rel_tplt_tpac tptp
        WHERE      tptp.perf_id = v_perf_id
               AND tptp.ttem_codigo = gat_tip_templates_kp.k_com_header_pkg
               AND tptp.tpac_codigo = p_tpac_codigo;

        -- TODO: Es más eficiente esta forma, se busca el parametro, se reemplaza y finalmente se formatea con el largo de línea máximo. Implementar esto en el UTL_LINE !!!
        DECLARE  
            v_line_no         PLS_INTEGER;
            v_start_pos       PLS_INTEGER;
            v_buffer          VARCHAR (4000);
            v_lineas_aux      utl_line.lines_t;
            v_lineas_resto    utl_line.lines_t;
            --*
            v_taget_index     PLS_INTEGER;
        BEGIN
            -- Busca el número de la línea donde está la descripción
            v_line_no :=
                utl_line.inline (
                    p_string_to_search   => '%DESCRIPCION%',
                    p_lines              => v_lineas,
                    p_from_line          => 1,
                    p_to_line            => NULL);

            IF v_line_no > 0 THEN
                v_buffer :=
                    RTRIM (
                        REPLACE (
                            v_lineas (v_line_no),
                            '%DESCRIPCION%',
                            v_descripcion));
                --DBMS_OUTPUT.put_line ('v_buffer:' || v_buffer);

                IF LENGTH (v_buffer) > 80 - LENGTH (p_comment_prefix) THEN
                    utl_line.put_wraped (
                        p_string        => v_buffer,
                        p_lineas        => v_lineas_aux,
                        p_line_len      => 80 - LENGTH (p_comment_prefix),
                        p_compress      => TRUE,
                        p_line_prefix   => p_comment_prefix);
--                    DBMS_OUTPUT.put_line (
--                           '--'
--                        || k_modulo
--                        || ':'
--                        || 'v_lineas_aux.>>>>>>>>>>>>>>>>>>>>>>');
--                    utl_line.spool_out (v_lineas_aux);
--                    DBMS_OUTPUT.put_line (
--                           '--'
--                        || k_modulo
--                        || ':'
--                        || 'v_lineas_aux:<<<<<<<<<<<<<<<<<<<<<<');

                    v_lineas_resto :=
                        utl_line.extract_lines (
                            v_lineas,
                            v_line_no + 1,
                            v_lineas.LAST);

                    v_taget_index := v_line_no;

                    FOR i IN v_lineas_aux.FIRST .. v_lineas_aux.LAST LOOP
                        v_lineas (v_taget_index) := v_lineas_aux (i);
                        v_taget_index := v_lineas.NEXT (v_taget_index);
                    END LOOP;

                    FOR i IN v_taget_index .. v_lineas.LAST LOOP
                        v_lineas.delete (i);
                    END LOOP;

                    utl_line.append_lines (v_lineas_resto, v_lineas);
                ELSE
                    v_lineas(v_line_no) := p_comment_prefix || v_buffer;
                END IF;
            END IF;
        END;

        --*

        utl_line.rep_curr (
            gat_defs.k_tabla,
            p_table_name,
            v_lineas,
            v_lineas.FIRST,
            v_lineas.LAST);

        --* Llena el área de historia
        --* **********************************************************************

        DECLARE
            v_comments    dba_tab_comments.comments%TYPE;
            v_tmp_line    utl_line.lines_t;
            v_line_no     NUMBER (10);
        BEGIN
            SELECT comments
            INTO   v_comments
            FROM   dba_tab_comments
            WHERE      owner = p_table_owner
                   AND table_name = p_table_name;

            IF v_comments IS NULL THEN
                v_comments := '--** No disponible **--';
            END IF;

            utl_line.put_wraped (
                v_comments,
                v_tmp_line,
                80 - LENGTH (p_comment_prefix),
                TRUE,
                p_line_prefix   => p_comment_prefix);
            v_line_no :=
                utl_line.inline (
                    p_string_to_search   => '%COMENTARIO_TABLA%',
                    p_lines              => v_lineas,
                    p_from_line          => v_lineas.FIRST,
                    p_to_line            => v_lineas.LAST);

            utl_line.replace_and_embed (
                '%COMENTARIO_TABLA%',
                v_tmp_line,
                v_lineas,
                v_line_no);
        END; -- local scope

        DBMS_OUTPUT.put_line ('--' || k_modulo || ':' || 'cien:');

        --* Llena el área de historia
        --* **********************************************************************
        DECLARE
            v_obge                  gat_objetos_generados_tp.gat_objetos_generados_rt;
            v_primera_generacion    gat_objetos_generados_tp.primera_generacion_t;
        BEGIN
            BEGIN
                gat_objetos_generados_qp.sel_obge_pk (
                    p_prod_id                 => p_prod_id,
                    p_nombre_objeto           => p_package_name,
                    p_tobj_codigo             => p_tobj_codigo,
                    p_gat_objetos_generados   => v_obge);
                v_primera_generacion := v_obge.primera_generacion;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    v_primera_generacion := TRUNC (SYSDATE);
            END;

            utl_line.rep_curr (
                '%CUANDO%',
                TO_CHAR (v_primera_generacion, 'dd-Mon-yyyy'),
                v_lineas,
                v_lineas.FIRST,
                v_lineas.LAST);
        END;

        utl_line.rep_curr (
            gat_defs.k_quien,
            RPAD (TRIM (p_author), 12, ' '),
            v_lineas,
            v_lineas.FIRST,
            v_lineas.LAST);
    END;

    --* Asigna el parámetro de salida
    --* *************************************************************************
    utl_line.put_line (p_lines_from => v_lineas, p_lines => p_lineas);
    v_lineas.delete;
EXCEPTION
    WHEN OTHERS THEN
        utl_error.informa (
            p_programa   => k_modulo,
            p_mensaje    => SQLERRM,
            p_rollback   => FALSE,
            p_raise      => TRUE);
END gen_pkg_header_comment;
/
SHOW ERRORS;


