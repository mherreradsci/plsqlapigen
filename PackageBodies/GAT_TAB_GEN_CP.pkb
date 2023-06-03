CREATE OR REPLACE PACKAGE BODY GAT.gat_tab_gen_cp
/*
Empresa:    Explora-IT
Proyecto:   Utilidades para desarrolladores PL/SQL
Objetivo:   Genera el spec y body del "Change Package"

Historia    Quien    Descripción
----------- -------- -----------------------------------------------------------
10-Dic-2004 mherrera Creación: Separa del package UTL_TAB_API.
11-Abr-2009 mherrera Modifica procedimiento gen_ucc_proc_body por error en largo
                     de nombre de parámetro de la tabla.
26-Apr-2012 mherrera Modifica la generación de los programas del% y upd% que
                     tenian un parametro de salida p_num_regs para que ahora
                     retornen la cantidad de registros afectados por la
                     operación, esto en el contexto de generación de componentes
                     java a partir de las dml pl/sql generadas por GAT
*/

IS
    PROCEDURE gen_nke_spec (
        p_table_name    IN            dba_tables.table_name%TYPE, -- tabla
        p_lineas        IN OUT NOCOPY utl_line.lines_t -- lineas
                                                      )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_nke_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
    -- generar una función que obtiene la siguiente key a partir de una secuencia
    BEGIN
        utl_line.put_line (
            REPLACE (
                gat_defs.k_prog_next_key_spec,
                gat_defs.k_tabla,
                p_table_name),
            p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_nke_spec;

    /*
    * Genera programa para obtener la "Next KEy"
    */
    PROCEDURE gen_nke_body (
        p_package_name    IN            dba_objects.object_name%TYPE,
        p_table_name      IN            dba_tables.table_name%TYPE, -- tabla
        p_lineas          IN OUT NOCOPY utl_line.lines_t -- lineas
                                                        )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_nke_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        --*
        v_curr                 PLS_INTEGER;
    BEGIN
        -- generar procedimiento de insert de un registro
        --utl_line.put_line (REPLACE (gat_defs.k_prog_next_key_body, gat_defs.k_tabla, p_table_name),
        --                   p_lineas
        --                  );
        v_curr := p_lineas.LAST;
        utl_line.put_line (gat_defs.k_prog_next_key_body, p_lineas);
        utl_line.rep_curr (
            p_name        => gat_defs.k_tabla,
            p_val         => p_table_name,
            p_lines       => p_lineas,
            p_from_line   => v_curr,
            p_to_line     => p_lineas.LAST);
        -- Generar bloque when others
        gat_utl.gen_exeption_block (
            p_package_name,
            gat_defs.k_prog_next_key_name,
            p_lineas   => p_lineas);
        -- terminar el codigo de la funcion
        utl_line.put_line (gat_defs.k_prog_next_key_body_end || ';', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_nke_body;

    -- Genera Insert de un registro
    FUNCTION gen_ins_proc_spec (
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_ins_proc_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t := gat_defs.k_ins_proc;
    BEGIN
        -- generar procedimiento de insert de un registro
        utl_line.put_line (
            REPLACE (
                gat_defs.k_ins_proc_rec_com,
                gat_defs.k_tabla,
                p_table_name),
            p_lineas);
        utl_line.put_line (
            gat_defs.k_procedure || ' ' || gat_defs.k_ins_proc || '(',
            p_lineas);
        -- parámetros: registro de tipo tabla.rowtype
        utl_line.set_level (1);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_ins_proc_rec_parm1,
                gat_defs.k_tabla_nc_prefix,
                SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_prefix)),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_nombre_package_tipo,
            p_types_package_name,
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_tabla_nc,
            SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_sufix),
            p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (')', p_lineas);
        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_ins_proc_spec;

    PROCEDURE gen_ins_proc_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_ins_proc_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
    BEGIN
        -- generar procedimiento de insert de un registro
        v_program_name :=
            gen_ins_proc_spec (p_table_name, p_types_package_name, p_lineas);
        utl_line.app_line (' IS', p_lineas);

        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);

        -- iniciar el codigo
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (1);
        -- generar el insert
        utl_line.put_line (
               REPLACE (
                   gat_defs.k_ins_proc_sql,
                   gat_defs.k_tabla,
                   p_table_name)
            || '(',
            p_lineas);
        -- generar la lista de columnas de la tabla
        utl_line.set_level (1);
        gat_utl.gen_col_list (p_table_owner, p_table_name, p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (')', p_lineas);
        -- generar la sentencia values (Parámetros)
        utl_line.put_line (gat_defs.k_values || ' (', p_lineas);
        utl_line.set_level (1);
        gat_utl.gen_col_list (
            p_table_owner,
            p_table_name,
            p_lineas,
            gat_defs.k_tplc_tabla,
            gat_defs.k_prefjo_param);
        utl_line.set_level (-1);
        utl_line.put_line (');', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- finaliza procedimiento
        utl_line.put_line (gat_defs.k_ins_end || ';', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_ins_proc_body;

    -- Genera procedimiento que inserta un registro, usa por parámetros cada columna del registro
    -- IBC: Insert By Columns
    FUNCTION gen_ibc_proc_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_ibc_proc_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t := gat_defs.k_ins_proc;
        v_numcols              NUMBER (3);
        v_columns              utl_desc.dba_tab_columns_ct;
    BEGIN
        -- generar procedimiento de insert de un registro
        utl_line.put_line (
            REPLACE (
                gat_defs.k_ins_proc_lco_com,
                gat_defs.k_tabla,
                p_table_name),
            p_lineas);
        utl_line.put_line (
            gat_defs.k_procedure || ' ' || v_program_name || '(',
            p_lineas);
        -- parámetros: columnas
        utl_line.set_level (1);
        v_numcols :=
            utl_desc.table_cols (p_table_owner, p_table_name, v_columns);
        gat_utl.gen_param_list (
            p_table_owner,
            p_table_name,
            p_types_package_name,
            v_columns,
            p_lineas);
        v_columns.delete;
        utl_line.set_level (-1);
        utl_line.put_line (')', p_lineas);
        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_ibc_proc_spec;

    -- Genera el cuerpo de un procedimiento que inserta un registro,
    -- usa por parámetros cada columna del registro
    -- IBC: Insert By Columns
    PROCEDURE gen_ibc_proc_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_ibc_proc_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
    BEGIN
        -- generar procedimiento de insert de un registro
        v_program_name :=
            gen_ibc_proc_spec (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (' IS', p_lineas);

        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);

        -- iniciar el codigo
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (1);
        -- generar el insert
        utl_line.put_line (
               REPLACE (
                   gat_defs.k_ins_proc_sql,
                   gat_defs.k_tabla,
                   p_table_name)
            || '(',
            p_lineas);
        -- generar la lista de columnas de la tabla
        utl_line.set_level (1);
        gat_utl.gen_col_list (p_table_owner, p_table_name, p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (')', p_lineas);
        -- generar la sentencia values
        utl_line.put_line (gat_defs.k_values || ' (', p_lineas);
        utl_line.set_level (1);
        gat_utl.gen_col_list (
            p_table_owner,
            p_table_name,
            p_lineas,
            gat_defs.k_tplc_columna,
            gat_defs.k_prefjo_param);
        utl_line.set_level (-1);
        utl_line.put_line (');', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- Finaliza procedimiento
        utl_line.put_line (gat_defs.k_ins_end || ';', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_ibc_proc_body;

    -- Genera procedimiento que inserta un conjunto de registros a partir de un registro que
    -- contiene una colección
    -- ICO: Insert Collection
    FUNCTION gen_ico_proc_spec (
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_ico_proc_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t := gat_defs.k_ins_proc;
    BEGIN
        -- generar procedimiento de insert de un conjunto de registros
        utl_line.put_line (
            REPLACE (
                gat_defs.k_ins_proc_col_com,
                gat_defs.k_tabla,
                p_table_name),
            p_lineas);
        utl_line.put_line (
            gat_defs.k_procedure || ' ' || v_program_name || '(',
            p_lineas);
        -- parámetros: registro.columnas
        utl_line.set_level (1);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_ins_proc_col_parm1,
                gat_defs.k_nombre_package_tipo,
                p_types_package_name),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_tabla_nc,
            SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_sufix),
            p_lineas);
        --      utl_line.put_line (REPLACE (gat_defs.k_ins_proc_col_parm,
        --                                  gat_defs.k_tabla_nc,
        --                                  SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_sufix)
        --                                 ),
        --                         p_lineas
        --                        );
        utl_line.set_level (-1);
        utl_line.put_line (')', p_lineas);
        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_ico_proc_spec;

    -- Genera procedimiento que inserta un conjunto de registros a partir de una colección de registros
    -- ICO: Insert Collection
    PROCEDURE gen_ico_proc_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_ico_proc_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
        v_columns              utl_desc.dba_tab_columns_ct;
        n_cols                 NUMBER (3);
    BEGIN
        -- generar procedimiento de insert de un registro
        n_cols := utl_desc.table_cols (p_table_owner, p_table_name, v_columns);
        v_program_name :=
            gen_ico_proc_spec (p_table_name, p_types_package_name, p_lineas);
        utl_line.app_line (' IS', p_lineas);
        
        
        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        
        
        -- Lista de variables del tipo colección
        utl_line.set_level (+1);
        gat_utl.gen_vars_columns_list (
            p_table_owner,
            p_table_name,
            p_types_package_name,
            v_columns,
            p_lineas,
            p_tipo   => '_ct');
        utl_line.set_level (-1);
        -- iniciar el codigo
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (1);

        -- Genera código para copiar la lista de record a las listas de columnas
        FOR i IN v_columns.FIRST .. v_columns.LAST LOOP
            utl_line.put_line (gat_defs.k_for_table_col, p_lineas);
            utl_line.set_level (+1);
            -- Asigna los valores de la columna
            utl_line.put_line (
                REPLACE (
                    gat_defs.k_rcoll_to_collection,
                    gat_defs.k_columna_nc,
                    SUBSTR (
                        v_columns (i).column_name,
                        1,
                        gat_defs.k_max_name_len_prefix)),
                p_lineas);
            utl_line.rep_curr (
                gat_defs.k_columna,
                v_columns (i).column_name,
                p_lineas);
            utl_line.set_level (-1);
            utl_line.put_line (gat_defs.k_end_loop, p_lineas);
        END LOOP;

        -- generar el forall bulk insert
        utl_line.put_line (
            REPLACE (gat_defs.k_forall, gat_defs.k_collection, 'p_regs'),
            p_lineas);
        utl_line.set_level (1);
        -- lines insert
        utl_line.put_line (
               REPLACE (
                   gat_defs.k_ins_proc_sql,
                   gat_defs.k_tabla,
                   p_table_name)
            || '(',
            p_lineas);
        -- generar la lista de columnas de la tabla
        utl_line.set_level (1);
        gat_utl.gen_col_list (p_table_owner, p_table_name, p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (')', p_lineas);
        -- generar la sentencia values
        utl_line.put_line (gat_defs.k_values || ' (', p_lineas);
        utl_line.set_level (1);
        gat_utl.gen_col_list (
            p_table_owner,
            p_table_name,
            p_lineas,
            gat_defs.k_tplc_columna,
            gat_defs.k_prefijo_var,
            '(indx)');
        utl_line.set_level (-1);
        utl_line.put_line (');', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);

        -- Fin de "generar el forall bulk insert"

        -- Borra las listas ocupadas
        FOR i IN v_columns.FIRST .. v_columns.LAST LOOP
            -- Asigna los valores de la columna
            utl_line.put_line (
                   REPLACE (
                       gat_defs.k_column_var,
                       gat_defs.k_columna_nc,
                       SUBSTR (
                           v_columns (i).column_name,
                           1,
                           gat_defs.k_max_name_len_prefix))
                || '.DELETE;',
                p_lineas);
        END LOOP;

        v_columns.delete;
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- Finaliza procedimiento
        utl_line.set_level (-1);
        utl_line.put_line (gat_defs.k_ins_end || ';', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_ico_proc_body;

    -- Genera procedimiento que inserta un conjunto de registros a partir de una colección de
    -- columnas
    -- ICC: Insert Columns Collection
    FUNCTION gen_icc_proc_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_icc_proc_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t := gat_defs.k_ins_proc;
        v_numcols              NUMBER (4);
        v_columns              utl_desc.dba_tab_columns_ct;
    BEGIN
        -- generar procedimiento de insert de un conjunto de registros vía
        -- colección de columnas
        utl_line.put_line (
            REPLACE (
                gat_defs.k_ins_proc_col_col_com,
                gat_defs.k_tabla,
                p_table_name),
            p_lineas);
        utl_line.put_line (
            gat_defs.k_procedure || ' ' || v_program_name || '(',
            p_lineas);
        -- parámetros: columnas (colecciones)
        utl_line.set_level (1);
        -- Genera la lista de columnas que contienen colecciones
        v_numcols :=
            utl_desc.table_cols (p_table_owner, p_table_name, v_columns);
        gat_utl.gen_param_list_sufijo_ct (
            p_table_owner,
            p_table_name,
            p_types_package_name,
            v_columns,
            p_lineas);
        v_columns.delete;
        utl_line.set_level (-1);
        utl_line.put_line (')', p_lineas);
        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_icc_proc_spec;

    -- Genera procedimiento que inserta un conjunto de registros a partir de una colección de
    -- columnas
    -- ICC: Insert Columns Collection
    PROCEDURE gen_icc_proc_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_icc_proc_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
        v_columns              utl_desc.dba_tab_columns_ct;
        n_cols                 NUMBER (3);
    BEGIN
        -- generar procedimiento de insert de un registro
        n_cols := utl_desc.table_cols (p_table_owner, p_table_name, v_columns);
        v_program_name :=
            gen_icc_proc_spec (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (' IS', p_lineas);
        
        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        
        -- iniciar el codigo
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (1);
        -- generar el forall bulk insert
        utl_line.put_line (
            REPLACE (
                gat_defs.k_forall,
                gat_defs.k_collection,
                   gat_defs.k_prefjo_param
                || SUBSTR (
                       v_columns (1).column_name,
                       1,
                       gat_defs.k_max_name_len_prefix)),
            p_lineas);
        v_columns.delete;
        utl_line.set_level (1);
        -- lines insert
        utl_line.put_line (
               REPLACE (
                   gat_defs.k_ins_proc_sql,
                   gat_defs.k_tabla,
                   p_table_name)
            || '(',
            p_lineas);
        -- generar la lista de columnas de la tabla
        utl_line.set_level (1);
        gat_utl.gen_col_list (p_table_owner, p_table_name, p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (')', p_lineas);
        -- generar la sentencia values
        utl_line.put_line (gat_defs.k_values || ' (', p_lineas);
        utl_line.set_level (1);
        gat_utl.gen_col_list (
            p_table_owner,
            p_table_name,
            p_lineas,
            gat_defs.k_tplc_columna,
            gat_defs.k_prefjo_param,
            p_subindice   => '(indx)');
        utl_line.set_level (-1);
        utl_line.put_line (');', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Fin de "generar el forall bulk insert"

        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- Finaliza procedimiento
        utl_line.set_level (-1);
        utl_line.put_line (gat_defs.k_ins_end || ';', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_icc_proc_body;

    ----------------------------------------------------------------------------
    --                                 Updates                                --
    ----------------------------------------------------------------------------
    PROCEDURE gen_upd_set (
        p_table_owner                  IN            dba_objects.owner%TYPE,
        p_table_name                   IN            dba_tables.table_name%TYPE,
        p_cols                         IN            utl_desc.dba_tab_columns_ct, -- columnas
        p_lineas                       IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_tipo_prefijo                 IN            gat_defs.tipo_prefijo_lista_cols_t,
        p_prefix                       IN            VARCHAR2,
        p_update_named_columns_only    IN            BOOLEAN DEFAULT FALSE)
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_upd_set';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_indx                 NUMBER (4);
        v_coma                 VARCHAR2 (1);
        v_column_name          gat_defs.linea;
        v_column_param         gat_defs.linea;
    BEGIN
        -- genera SET de la sentencia update
        utl_line.put_line (gat_defs.k_set, p_lineas);
        utl_line.set_level (+1);
        v_indx := p_cols.FIRST;

        WHILE v_indx IS NOT NULL LOOP
            v_column_name := LOWER (p_cols (v_indx).column_name);

            IF p_tipo_prefijo = gat_defs.k_tplc_columna THEN
                v_column_param :=
                    SUBSTR (
                        p_prefix || v_column_name,
                        1,
                        gat_defs.k_max_id_len);
            ELSIF p_tipo_prefijo = gat_defs.k_tplc_tabla THEN
                v_column_param :=
                       SUBSTR (p_prefix || p_table_name, 1, 30)
                    || '.'
                    || v_column_name;
            ELSE
                raise_application_error (
                    -20100,
                       k_modulo
                    || 'tipo de prefijo ('
                    || p_tipo_prefijo
                    || ') inálido.',
                    FALSE);
            END IF;

            --                        v_default_val :=
            --               'DEFAULT fdc_null.'
            --               || CASE v_column.data_type
            --                     WHEN 'VARCHAR2' THEN 'nlvc2('
            --                     WHEN 'NUMBER' THEN 'nlnum('
            --                     WHEN 'DATE' THEN 'nldate('
            --                     WHEN 'TIMESTAMP(6)' THEN 'nlts('
            --                     WHEN 'CLOB' THEN 'nlclob('
            --                     WHEN 'BLOB' THEN 'nlblob('
            --                  END
            --               || ''''
            --               || 'P'
            --               || TO_CHAR (v_indx)
            --               || ''''
            --               ||')';

            IF NOT p_update_named_columns_only THEN
                utl_line.put_line (
                    v_coma || v_column_name || ' = ' || v_column_param,
                    p_lineas);
            ELSE
                --            utl_line.put_line (
                --                  v_coma
                --               || v_column_name
                --               || ' = '
                --               || 'NVL('
                --               || v_column_param
                --               || ','
                --               || v_column_name
                --               || ')',
                --               p_lineas);

                utl_line.put_line (
                       v_coma
                    || v_column_name
                    || ' = '
                    || 'CASE WHEN INSTR(v_client_info, '
                    || '''#P'
                    || TO_CHAR (v_indx)
                    || '#'''
                    || ') > 0 then '
                    || v_column_name
                    || ' ELSE '
                    || v_column_param
                    || ' END',
                    p_lineas);
            --descripcion = CASE WHEN INSTR (v_client_info, '#P3#') > 0 THEN descripcion ELSE p_descripcion END,

            END IF;

            v_indx := p_cols.NEXT (v_indx);
            v_coma := ',';
        END LOOP;

        utl_line.set_level (-1);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_upd_set;

    /* MHT: 20120417
       PROCEDURE gen_upd_set (
          p_table_owner    IN            dba_objects.owner%TYPE,
          p_table_name     IN            dba_tables.table_name%TYPE,
          p_cols           IN            utl_desc.dba_tab_columns_ct, -- columnas
          p_lineas         IN OUT NOCOPY utl_line.lines_t, -- lineas
          p_tipo_prefijo   IN            gat_defs.tipo_prefijo_lista_cols_t,
          p_prefix         IN            VARCHAR2
          )
       IS
          -- Constantes para identificar el package y el programa
          k_programa   CONSTANT fdc_defs.program_name_t := 'gen_upd_set';
          k_modulo     CONSTANT fdc_defs.module_name_t
                                   := gat_tab_gen_cp.k_package || '.' || k_programa ;
          -- Variables
          v_indx                NUMBER (4);
          v_coma                VARCHAR2 (1);
          v_column_name         gat_defs.linea;
          v_column_param        gat_defs.linea;
       BEGIN
          -- genera SET de la sentencia update
          utl_line.put_line (gat_defs.k_set, p_lineas);
          utl_line.set_level (+1);
          v_indx := p_cols.FIRST;

          WHILE v_indx IS NOT NULL LOOP
             v_column_name := LOWER (p_cols (v_indx).column_name);

             IF p_tipo_prefijo = gat_defs.k_tplc_columna
             THEN
                v_column_param := SUBSTR (p_prefix || v_column_name, 1, gat_defs.k_max_id_len);
             ELSIF p_tipo_prefijo = gat_defs.k_tplc_tabla
             THEN
                v_column_param :=
                   SUBSTR (p_prefix || p_table_name, 1, 30) || '.' || v_column_name;
             ELSE
                raise_application_error (
                   -20100,
                   k_modulo || 'tipo de prefijo (' || p_tipo_prefijo || ') inálido.',
                   FALSE);
             END IF;

             utl_line.put_line (v_coma || v_column_name || ' = ' || v_column_param,
                                   p_lineas);

             v_indx := p_cols.NEXT (v_indx);
             v_coma := ',';
          END LOOP;

          utl_line.set_level (-1);
       EXCEPTION
          WHEN OTHERS
          THEN
             utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
             utl_error.informa (k_modulo);
       END gen_upd_set;
    */

    /*
       procedure gen_upd_set(
          p_cols        in utl_desc.dba_tab_columns_ct, -- columnas
          p_lineas   IN OUT NOCOPY   utl_line.lines_t,   -- lineas
          p_update_named_columns_only IN BOOLEAN default_value_t TRUE
       ) is
          v_indx          NUMBER (4);
          v_coma          VARCHAR2 (1);
          v_column_name   linea;
          v_column_param  linea;
       begin
          -- genera SET de la sentencia update

          v_indx := p_cols.FIRST;
          WHILE v_indx IS NOT NULL LOOP
             v_column_name := LOWER (p_cols (v_indx).column_name);
     || v_column_name
             v_column_param := REPLACE (gat_defs.k_par_tab, gat_defs.k_tabla, p_table_name) || '.' || v_column_name;
             if p_update_named_columns_only then
                utl_line.put_line (v_coma || v_column_name || ' = ' || v_column_param, p_lineas);
             else
                utl_line.put_line (v_coma || v_column_name || ' = ' || 'NVL(' || v_column_param || ',' ||v_column_name || ')' , p_lineas);
             end if;
             v_coma := ',';
          END LOOP;

       end gen_upd_set;

       procedure gen_upd_set(
          p_table_name    IN       dba_tables.table_name%TYPE, -- tabla
          p_cols        in utl_desc.dba_tab_columns_ct, -- columnas
          p_lineas   IN OUT NOCOPY   utl_line.lines_t,   -- lineas
          p_update_named_columns_only IN BOOLEAN default_value_t TRUE
       ) is
          v_indx          NUMBER (4);
          v_coma          VARCHAR2 (1);
          v_column_name   linea;
       begin
          -- genera SET de la sentencia update

          v_indx := p_cols.FIRST;
          WHILE v_indx IS NOT NULL LOOP

             v_column_name := LOWER (p_cols (v_indx).column_name);
             utl_line.put_line (v_coma || v_col || ' = ' || ,
                                p_lineas
                               );
          END LOOP;

          utl_line.Set_LEVEL (-1);



       end gen_upd_set;
    */

    -- Genera Update de un registro (in) completo vía su PK
    FUNCTION gen_upd_proc_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    -- generar procedimiento de update de un registro completo
    -- parámetros: columnas de la pk
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_upd_proc_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
        n_cols                 NUMBER (3);
        v_constraint           utl_desc.dba_constraints_rt;
        v_constraint_cols      utl_desc.dba_cons_columns_ct;
    BEGIN
        v_constraint := utl_desc.pk (p_table_owner, p_table_name);
        n_cols :=
            utl_desc.constraint_cols (
                p_table_owner,
                v_constraint.constraint_name,
                v_constraint_cols);
        -- Genera el cuerpo
        utl_line.put_line (
            REPLACE (gat_defs.k_upd_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_constraint_puf,
            v_constraint.constraint_name,
            p_lineas);

        /*
        utl_line.put_line (
            '--##@ Delcaración genarada por:' || k_modulo,
            p_lineas);
        */

        v_program_name :=
            REPLACE (
                gat_defs.k_upd_proc_upd_const,
                gat_defs.k_constraint_puf_nc,
                SUBSTR (v_constraint.constraint_name, 1, 26));

        utl_line.put_line (
            gat_defs.k_procedure || ' ' || v_program_name,
            p_lineas);
        utl_line.set_level (+1);
        gat_utl.gen_param_list (
            p_table_owner,
            p_table_name,
            p_types_package_name,
            v_constraint_cols,
            p_lineas);
        -- parámetros: registro de tipo tabla.rowtype
        utl_line.put_line (
               ','
            || REPLACE (
                   gat_defs.k_upd_proc_parm1,
                   gat_defs.k_tabla_nc_prefix,
                   SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_prefix)),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_nombre_package_tipo,
            p_types_package_name,
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_tabla_nc,
            SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_sufix),
            p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (')', p_lineas);
        v_constraint_cols.delete;

        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_upd_proc_spec;

    PROCEDURE gen_upd_proc_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_upd_proc_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
        v_columns              utl_desc.dba_tab_columns_ct;
        v_pk                   utl_desc.dba_constraints_rt;
        n_cols                 NUMBER (3);
        v_cons_cols            utl_desc.dba_cons_columns_ct;
    BEGIN
        -- generar procedimiento de update de un registro
        v_program_name :=
            gen_upd_proc_spec (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (' is ', p_lineas);

        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);

        -- iniciar el codigo
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (1);
        -- genera sentencia update
        utl_line.put_line (
            REPLACE (gat_defs.k_upd_proc_sql, gat_defs.k_tabla, p_table_name),
            p_lineas);
        n_cols := utl_desc.cols_no_pk (p_table_owner, p_table_name, v_columns);
        -- Genera el set columna = p_table_name.columna
        utl_line.set_level (1);
        gen_upd_set (
            p_table_owner,
            p_table_name,
            v_columns,
            p_lineas,
            gat_defs.k_tplc_tabla,
            gat_defs.k_prefjo_param);
        v_columns.delete;
        utl_line.set_level (-1);
        -- genera el where del update por la PK
        v_pk := utl_desc.pk (p_table_owner, p_table_name);
        n_cols :=
            utl_desc.constraint_cols (
                p_table_owner,
                v_pk.constraint_name,
                v_cons_cols);
        gat_utl.gen_where_list (v_cons_cols, p_lineas);
        v_cons_cols.delete;
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- finaliza procedure
        utl_line.put_line (
               REPLACE (
                   gat_defs.k_upd_end,
                   gat_defs.k_constraint_puf_nc,
                   SUBSTR (v_pk.constraint_name, 1, 26))
            || ';',
            p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_upd_proc_body;

    -- Genera Update de un registro usando por parámetros las columnas (in),
    -- del constraint para el where y el resto para actualizar los campos
    -- Update By Columns Via COnstraint PK/UK/Fk
    FUNCTION gen_ubc_vco_proc_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_constraint_name       IN            dba_constraints.constraint_name%TYPE,
        p_constraint_cols       IN            utl_desc.dba_cons_columns_ct,
        p_columns               IN            utl_desc.dba_tab_columns_ct,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'gen_ubc_vco_proc_spec' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
    BEGIN
        -- Genera el comentario de encabezado
        utl_line.put_line (
            REPLACE (gat_defs.k_ubc_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_constraint_puf,
            p_constraint_name,
            p_lineas);
        /*
        utl_line.put_line (
            '--##@ Delcaración genarada por:' || k_modulo,
            p_lineas);
        */
        -- Genera el nombre del procedimiento
        v_program_name :=
            REPLACE (
                gat_defs.k_upd_proc_upd_const,
                gat_defs.k_constraint_puf_nc,
                SUBSTR (p_constraint_name, 1, 26));
        utl_line.put_line (
            gat_defs.k_procedure || ' ' || v_program_name,
            p_lineas);
        utl_line.set_level (+1);
        -- Genera parámetros: Columnas de la constraint (que seran parte del where)
        gat_utl.gen_param_list (
            p_table_owner,
            p_table_name,
            p_types_package_name,
            p_constraint_cols,
            p_lineas,
            p_default_value   => gat_defs.k_deva_db_no_default);

        IF     p_columns IS NOT NULL
           AND p_columns.COUNT > 0 THEN
            utl_line.app_line (',', p_lineas);
            -- Genera parámetros: Genera una lista de parámetros con las columnas que no participan en el constraint
            gat_utl.gen_param_list (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_columns,
                p_lineas,
                p_default_value   => gat_defs.k_deva_db_all_null);
        END IF;

        --utl_line.app_line (',', p_lineas);
        ---- Indicador de nulidad
        --utl_line.put_line (gat_defs.k_ubc_param_in_param, p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (')', p_lineas);
        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_ubc_vco_proc_spec;

    PROCEDURE gen_ubc_vco_proc_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_constraint_name       IN            VARCHAR2, -- constraint name
        p_constraint_cols       IN            utl_desc.dba_cons_columns_ct,
        p_columns               IN            utl_desc.dba_tab_columns_ct,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'gen_ubc_vco_proc_body' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
    BEGIN
        -- generar procedimiento de update de un registro pasando por parámetro
        -- las columnas de la key y los campos actualizables con DEFAULT NULL
        v_program_name :=
            gen_ubc_vco_proc_spec (
                p_table_owner,
                p_table_name,
                p_constraint_name,
                p_constraint_cols,
                p_columns,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (' IS ', p_lineas);

        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);

        -- iniciar el codigo
        utl_line.set_level (+1);
        utl_line.put_line (' v_client_info   VARCHAR2 (2048);', p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line (
            'app_nulls_params_context.read_client_info (v_client_info);',
            p_lineas);
        -- genera IF de la condición de nulidad
        /*
        utl_line.put_line (
              gat_defs.k_if
           || ' '
           || gat_defs.k_ubc_param_ignore_null || '= GAT_TYPES.K_DBB_FALSE'
           || ' '
           || gat_defs.k_then,
           p_lineas);
        utl_line.set_level (+1);
        */
        -- genera sentencia update
        utl_line.put_line (
            REPLACE (gat_defs.k_upd_proc_sql, gat_defs.k_tabla, p_table_name),
            p_lineas);
        -- Genera el set columna = NVL(p_columna, columna)
        utl_line.set_level (+1);
        gen_upd_set (
            p_table_owner,
            p_table_name,
            p_columns,
            p_lineas,
            gat_defs.k_tplc_columna,
            gat_defs.k_prefjo_param,
            TRUE);
        utl_line.set_level (-1);
        gat_utl.gen_where_list (p_constraint_cols, p_lineas);
        utl_line.app_line (';', p_lineas);

        /*
        -- Else
        utl_line.put_line (gat_defs.k_else, p_lineas);
        utl_line.set_level (+1);
        -- genera sentencia update
        utl_line.put_line (
           REPLACE (gat_defs.k_upd_proc_sql, gat_defs.k_tabla, p_table_name),
           p_lineas);
        utl_line.set_level (+1);
        gen_upd_set (p_table_owner,
                     p_table_name,
                     p_columns,
                     p_lineas,
                     gat_defs.k_tplc_columna,
                     gat_defs.k_prefjo_param,
                     TRUE);
        utl_line.set_level (-1);
        gat_utl.gen_where_list (p_constraint_cols, p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.set_level (-1);
        -- Endif
        utl_line.put_line (gat_defs.k_endif, p_lineas);
        utl_line.app_line (';', p_lineas);
        */
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        utl_line.put_line (
            'app_nulls_params_context.set_client_info (NULL);',
            p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- finaliza procedure
        utl_line.put_line (
               REPLACE (
                   gat_defs.k_upd_end,
                   gat_defs.k_constraint_puf_nc,
                   SUBSTR (p_constraint_name, 1, 26))
            || ';',
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_constraint_puf,
            p_constraint_name,
            p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_ubc_vco_proc_body;

    -- Genera una funcion de update por cada primary/unique/(tambien puede ser una foreing key, pero no le veo
    -- utilidad) de la tabla
    -- Este procedimiento usa por parámetro, una lista de columnas de la tabla, la primera parte
    -- corresponde a las columnas del constraint que son usados en el where, la segunda
    -- coresponde al conjunto de columnas que no son parte del constraint y que por
    -- omisión (default) pasan como nulas, El tercer parámetro indica si se hace el update de todos las
    -- columnas o si el valor es nulo, se mantiene el de la base de datos. Esto permite hacer el update
    -- de columnas específicas o de todo el registro
    PROCEDURE gen_upd_all_cons_by_puf (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_lineas                IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_spec                  IN            BOOLEAN DEFAULT TRUE, -- Determina si genera spect o body
        p_constraint_type       IN            utl_desc.constraint_type_t DEFAULT utl_desc.k_coty_primary_key,
        p_types_package_name    IN            all_objects.object_name%TYPE)
    IS
        -- Constantes para identificar el package y el programa
        k_programa     CONSTANT fdc_defs.program_name_t
                                    := 'gen_upd_all_cons_by_puf' ;
        k_modulo       CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_dummy_program_name    fdc_defs.program_name_t;
        v_constraints           utl_desc.dba_constraints_ct;
        v_cons_cols             utl_desc.dba_cons_columns_ct;
        v_columns               utl_desc.dba_tab_columns_ct;
        k                       NUMBER (4);
    BEGIN
        -- Obtiene todas las constraints p_constraint_type de la tabla
        k :=
            utl_desc.constraints_puf (
                p_table_owner,
                p_table_name,
                v_constraints,
                p_constraint_type);

        IF     v_constraints IS NOT NULL
           AND v_constraints.COUNT > 0 THEN
            FOR i IN v_constraints.FIRST .. v_constraints.LAST LOOP
                k :=
                    utl_desc.constraint_cols (
                        p_table_owner,
                        v_constraints (i).constraint_name,
                        v_cons_cols);
                k :=
                    utl_desc.table_cols (
                        p_table_owner,
                        p_table_name,
                        v_columns);
                utl_desc.col_minus (p_table_owner, v_columns, v_cons_cols);

                IF     v_columns IS NOT NULL
                   AND v_columns.COUNT > 0 THEN -- Hay columnas para actualizar
                    IF p_spec THEN
                        v_dummy_program_name :=
                            gen_ubc_vco_proc_spec (
                                p_table_owner,
                                p_table_name,
                                v_constraints (i).constraint_name,
                                v_cons_cols,
                                v_columns,
                                p_types_package_name,
                                p_lineas);
                        utl_line.app_line (';', p_lineas);
                    ELSE
                        gen_ubc_vco_proc_body (
                            p_package_name,
                            p_table_owner,
                            p_table_name,
                            v_constraints (i).constraint_name,
                            v_cons_cols,
                            v_columns,
                            p_types_package_name,
                            p_lineas);
                    END IF;

                    v_columns.delete;
                    v_cons_cols.delete;
                ELSE
                    utl_line.put_line (
                        REPLACE (
                            gat_defs.k_ubc_nothing_to_do,
                            gat_defs.k_constraint_puf,
                            p_constraint_type),
                        p_lineas);
                END IF;
            END LOOP;
        END IF;

        v_constraints.delete;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_upd_all_cons_by_puf;

    /*
       -- genera el código necesario para llamar (call) del procedimiento de update
       procedure gen_upd_proc_call (
          p_table_name    IN       dba_tables.table_name%TYPE, -- tabla
          p_lineas   IN OUT   utl_line.lines_t -- lineas
       )

       IS
          i             NUMBER (4)                    := 0;
          v_pk          utl_desc.dba_constraints_rt;
          n_cols        NUMBER (3);
          v_cons_cols   utl_desc.dba_cons_columns_ct;
       BEGIN
          -- generar procedimiento de update de un registro
          utl_line.put_line (REPLACE (gat_defs.k_upd_proc_call_com, gat_defs.k_tabla, p_table_name), p_lineas);
          utl_line.put_line (gat_defs.k_upd_proc_call, p_lineas);
          -- parámetros: columnas de la pk
          v_pk := utl_desc.pk (p_table_name);
          n_cols := utl_desc.constraint_cols (v_pk.constraint_name, v_cons_cols);
             gat_utl.gen_col_list (v_cons_cols, p_lineas,
                           REPLACE (gat_defs.k_par_tab, gat_defs.k_tabla, p_table_name) || '.');
          -- parámetros: registro de tipo tabla.rowtype
          utl_line.put_line (', ' || REPLACE (gat_defs.k_par_tab, gat_defs.k_tabla, p_table_name), p_lineas);
          utl_line.put_line (');', p_lineas);
       END gen_upd_proc_call;
    */

    -- Generate Update by Columns using Constraints
    FUNCTION gen_ucc_proc_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_constraint_name       IN            VARCHAR2, -- constraint name
        p_constraint_cols       IN            utl_desc.dba_cons_columns_ct,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_ucc_proc_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
    BEGIN
        -- Genera el nombre del programa
        v_program_name :=
            REPLACE (
                gat_defs.k_upd_proc_upd_const,
                gat_defs.k_constraint_puf_nc,
                SUBSTR (p_constraint_name, 1, 26));

        -- Generar procedimiento de update de un registro

        utl_line.put_line (
            REPLACE (gat_defs.k_upd_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_constraint_puf,
            p_constraint_name,
            p_lineas);
        /*
        utl_line.put_line (
            '--##@ Delcaración genarada por:' || k_modulo,
            p_lineas);
        */

        --*
        utl_line.put_line (
            gat_defs.k_procedure || ' ' || v_program_name,
            p_lineas);
        utl_line.set_level (+1);
        -- parámetros: columnas de la constraint
        gat_utl.gen_param_list (
            p_table_owner,
            p_table_name,
            p_types_package_name,
            p_constraint_cols,
            p_lineas,
            p_default_value   => gat_defs.k_deva_db_no_default);
        -- parámetros: registro de tipo tabla.rowtype
        utl_line.put_line (
               ','
            || REPLACE (
                   gat_defs.k_upd_proc_parm1,
                   gat_defs.k_tabla_nc_prefix,
                   SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_prefix)),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_nombre_package_tipo,
            p_types_package_name,
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_tabla_nc,
            SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_sufix),
            p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (')', p_lineas);
        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_ucc_proc_spec;

    -- Generate Update by Columns using Constraints
    PROCEDURE gen_ucc_proc_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_constraint_name       IN            dba_constraints.constraint_name%TYPE, -- constraint name
        p_constraint_cols       IN            utl_desc.dba_cons_columns_ct,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_ucc_proc_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
        v_indx                 NUMBER (4);
        v_columns              utl_desc.dba_tab_columns_ct;
        n_cols                 NUMBER (3);
        v_col                  gat_defs.linea;
        v_delimitador          VARCHAR2 (32);
    BEGIN
        -- generar procedimiento de update de un registro
        v_program_name :=
            gen_ucc_proc_spec (
                p_table_owner,
                p_table_name,
                p_constraint_name,
                p_constraint_cols,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (' is ', p_lineas);

        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);

        -- iniciar el codigo
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (1);
        -- genera sentencia update
        utl_line.put_line (
            REPLACE (gat_defs.k_upd_proc_sql, gat_defs.k_tabla, p_table_name),
            p_lineas);
        n_cols :=
            utl_desc.cols_no_const_puf (p_table_owner, p_table_name, v_columns); -- En general los update no actuan sobre columnas de fk
        utl_line.put_line (gat_defs.k_set, p_lineas);
        utl_line.set_level (+2);
        v_indx := v_columns.FIRST;

        -- Genera el set de columnas
        WHILE v_indx IS NOT NULL LOOP
            v_col := LOWER (v_columns (v_indx).column_name);
            utl_line.put_line (
                   v_delimitador
                || v_col
                || ' = '
                || SUBSTR (
                       gat_defs.k_prefjo_param || p_table_name,
                       1,
                       gat_defs.k_max_id_len -- LENGTH (gat_defs.k_prefjo_param)
                                            )
                || '.'
                || v_col,
                p_lineas);
            v_delimitador := ',';
            v_indx := v_columns.NEXT (v_indx);
        END LOOP;

        v_columns.delete;
        -- Genera el where
        utl_line.set_level (-2);
        utl_line.put_line (gat_defs.k_where, p_lineas);
        utl_line.set_level (+2);
        v_delimitador := NULL;
        v_indx := p_constraint_cols.FIRST;

        WHILE v_indx IS NOT NULL LOOP
            v_col := LOWER (p_constraint_cols (v_indx).column_name);
            utl_line.put_line (
                   v_delimitador
                || v_col
                || ' = '
                || SUBSTR (
                       gat_defs.k_prefjo_param || p_table_name,
                       1,
                       gat_defs.k_max_id_len -- LENGTH (gat_defs.k_prefjo_param)
                                            )
                || '.'
                || v_col,
                p_lineas);
            v_delimitador := ' AND ';
            v_indx := p_constraint_cols.NEXT (v_indx);
        END LOOP;

        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-3);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- finaliza procedure
        utl_line.put_line (
               REPLACE (
                   gat_defs.k_upd_end,
                   gat_defs.k_constraint_puf_nc,
                   SUBSTR (p_constraint_name, 1, 26))
            || ';',
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_constraint_puf,
            p_constraint_name,
            p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_ucc_proc_body;

    -- genera una funcion de update por cada primary/unique/foreing key de la tabla
    PROCEDURE gen_ucc_all_cons_by_puf (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_lineas                IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_spec                  IN            BOOLEAN DEFAULT TRUE, -- Determina si genera spect o body
        p_constraint_type       IN            utl_desc.constraint_type_t DEFAULT utl_desc.k_coty_primary_key,
        p_types_package_name    IN            all_objects.object_name%TYPE)
    IS
        -- Constantes para identificar el package y el programa
        k_programa     CONSTANT fdc_defs.program_name_t
                                    := 'gen_ucc_all_cons_by_puf' ;
        k_modulo       CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_dummy_program_name    fdc_defs.program_name_t;
        v_cons                  utl_desc.dba_constraints_ct;
        v_cons_cols             utl_desc.dba_cons_columns_ct;
        k                       NUMBER (4);
    BEGIN
        -- Obtiene todas las constraints p_constraint_type de la tabla
        k :=
            utl_desc.constraints_puf (
                p_table_owner,
                p_table_name,
                v_cons,
                p_constraint_type);

        IF v_cons.COUNT > 0 THEN
            FOR i IN v_cons.FIRST .. v_cons.LAST LOOP
                k :=
                    utl_desc.constraint_cols (
                        p_table_owner,
                        v_cons (i).constraint_name,
                        v_cons_cols);

                IF p_spec THEN
                    v_dummy_program_name :=
                        gen_ucc_proc_spec (
                            p_table_owner,
                            p_table_name,
                            v_cons (i).constraint_name,
                            v_cons_cols,
                            p_types_package_name,
                            p_lineas);
                    utl_line.app_line (';', p_lineas);
                ELSE
                    gen_ucc_proc_body (
                        p_package_name,
                        p_table_owner,
                        p_table_name,
                        v_cons (i).constraint_name,
                        v_cons_cols,
                        p_types_package_name,
                        p_lineas);
                END IF;

                v_cons_cols.delete;
            END LOOP;
        END IF;

        v_cons.delete;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_ucc_all_cons_by_puf;

    FUNCTION gen_uoc_one_col_spec (
        p_table_name    IN            dba_tables.table_name%TYPE, -- tabla
        p_col_type      IN            VARCHAR2,
        p_lineas        IN OUT NOCOPY utl_line.lines_t -- lineas
                                                      )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'gen_uoc_one_col_spec' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t := gat_defs.k_uoc_proc;
    BEGIN -- generar procedimiento para delete con where dinámico
        utl_line.put_line (
            REPLACE (gat_defs.k_uoc_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        --*
        /*
        utl_line.put_line (
            '--##@ Delcaración genarada por:' || k_modulo,
            p_lineas);
    */
        --*
        utl_line.put_line (
            gat_defs.k_function || ' ' || v_program_name || '(',
            p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line (gat_defs.k_uoc_proc_in_parm_1, p_lineas);
        utl_line.app_line (',', p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_uoc_proc_in_parm_2,
                gat_defs.k_column_type,
                p_col_type),
            p_lineas);
        utl_line.app_line (',', p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_uoc_proc_in_parm_3,
                gat_defs.k_column_type,
                p_col_type),
            p_lineas);
        --utl_line.app_line (',', p_lineas);
        --utl_line.put_line (gat_defs.k_uoc_proc_out_parm, p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (') ' || gat_defs.k_uoc_proc_ret, p_lineas);

        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_uoc_one_col_spec;

    -- Prepara delete que usa una columna para condición de borrado
    PROCEDURE gen_uoc_one_col_body (
        p_package_name    IN            dba_objects.object_name%TYPE,
        p_table_name      IN            dba_tables.table_name%TYPE, -- tabla
        p_col_type        IN            VARCHAR2,
        p_lineas          IN OUT NOCOPY utl_line.lines_t -- lineas
                                                        )
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'gen_uoc_one_col_body' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
    BEGIN -- generar procedimiento de delete con where dinámico
        v_program_name :=
            gen_uoc_one_col_spec (p_table_name, p_col_type, p_lineas);
        utl_line.app_line (' IS', p_lineas);

        
        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);

        -- declarar variable para obtener el count
        utl_line.set_level (+1);
        --*
        utl_line.put_line (
            gat_defs.k_uoc_var_ret || ' ' || gat_defs.k_uoc_type_ret || ';',
            p_lineas);

        utl_line.set_level (-1);
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (+1);

        utl_line.put_line (
            REPLACE (
                gat_defs.k_uoc_execute_del,
                gat_defs.k_tabla,
                p_table_name),
            p_lineas);
        utl_line.put_line (gat_defs.k_uoc_set_column, p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line (gat_defs.k_uoc_where, p_lineas);
        utl_line.put_line (gat_defs.k_uoc_using, p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.set_level (-1);
        -- Genera linea para contar cuantos registros fueron afectados
        utl_line.put_line (gat_defs.k_sql_var_rowcount, p_lineas);
        utl_line.put_line (gat_defs.k_uoc_proc_retv || ';', p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- Finaliza procedimiento
        utl_line.put_line (gat_defs.k_uoc_end, p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_uoc_one_col_body;

    ----------------------------------------------------------------------------
    --                                 Deletes                                --
    ----------------------------------------------------------------------------
    FUNCTION gen_dco_proc_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_constraint_name       IN            VARCHAR2, -- constraint name
        p_constraint_cols       IN            utl_desc.dba_cons_columns_ct,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_dco_proc_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
    BEGIN
        -- Generar procedimiento para delete de un registro vía p_constraint_name
        utl_line.put_line (
            REPLACE (gat_defs.k_dco_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_constraint_puf,
            p_constraint_name,
            p_lineas);
        --*
        /*
        utl_line.put_line (
            '--##@ Delcaración genarada por:' || k_modulo,
            p_lineas);
    */
        -- Nombre del programa
        v_program_name :=
            REPLACE (
                gat_defs.k_dco_proc,
                gat_defs.k_constraint_puf_nc,
                SUBSTR (p_constraint_name, 1, 26));

        utl_line.put_line (
            gat_defs.k_function || ' ' || v_program_name,
            p_lineas);
        utl_line.set_level (+1);
        -- parámetros: columnas de la pk
        gat_utl.gen_param_list (
            p_table_owner,
            p_table_name,
            p_types_package_name,
            p_constraint_cols,
            p_lineas,
            p_default_value   => gat_defs.k_deva_db_no_default);
        -- parámetros: numero de registros borrados
        --utl_line.put_line (', ' || gat_defs.k_dco_proc_out_parm, p_lineas);
        --utl_line.put_line (')', p_lineas);

        utl_line.set_level (-1);
        utl_line.put_line (') ' || gat_defs.k_dco_proc_ret, p_lineas);

        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_dco_proc_spec;

    PROCEDURE gen_dco_proc_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_constraint_name       IN            VARCHAR2, -- constraint name
        p_constraint_cols       IN            utl_desc.dba_cons_columns_ct,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_dco_proc_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
    BEGIN
        -- generar procedimiento de update de un registro
        v_program_name :=
            gen_dco_proc_spec (
                p_table_owner,
                p_table_name,
                p_constraint_name,
                p_constraint_cols,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (' IS', p_lineas);

        
        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);

        -- declarar variable para obtener el count
        utl_line.set_level (+1);
        --*
        utl_line.put_line (
            gat_defs.k_dco_var_ret || ' ' || gat_defs.k_dco_type_ret || ' := 0;',
            p_lineas);

        -- iniciar el codigo
        utl_line.set_level (-1);
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (+1);
        -- genera sentencia update
        utl_line.put_line (
            REPLACE (gat_defs.k_dco_proc_sql, gat_defs.k_tabla, p_table_name),
            p_lineas);
        gat_utl.gen_where_list (p_constraint_cols, p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera linea para contar cuantos registros fueron afectados
        utl_line.put_line (gat_defs.k_sql_var_rowcount, p_lineas);
        utl_line.put_line (gat_defs.k_uoc_proc_retv || ';', p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- finaliza procedure
        utl_line.put_line (gat_defs.k_dco_end || ';', p_lineas);
        utl_line.rep_curr (
            gat_defs.k_constraint_puf_nc,
            SUBSTR (p_constraint_name, 1, 26),
            p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_dco_proc_body;

    -- genera una funcion de update por cada primary/unique/foreing key de la tabla
    PROCEDURE gen_dco_all_cons_by_puf (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_lineas                IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_spec                  IN            BOOLEAN DEFAULT TRUE, -- Determina si genera spect o body
        p_constraint_type       IN            utl_desc.constraint_type_t DEFAULT utl_desc.k_coty_primary_key,
        p_types_package_name    IN            all_objects.object_name%TYPE)
    IS
        -- Constantes para identificar el package y el programa
        k_programa     CONSTANT fdc_defs.program_name_t
                                    := 'gen_dco_all_cons_by_puf' ;
        k_modulo       CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_dummy_program_name    fdc_defs.program_name_t;
        v_cons                  utl_desc.dba_constraints_ct;
        v_cons_cols             utl_desc.dba_cons_columns_ct;
        k                       NUMBER (4);
    BEGIN
        -- Obtiene todas las constraints p_constraint_type de la tabla
        k :=
            utl_desc.constraints_puf (
                p_table_owner,
                p_table_name,
                v_cons,
                p_constraint_type);

        IF v_cons.COUNT > 0 THEN
            FOR i IN v_cons.FIRST .. v_cons.LAST LOOP
                k :=
                    utl_desc.constraint_cols (
                        p_table_owner,
                        v_cons (i).constraint_name,
                        v_cons_cols);

                IF p_spec THEN
                    v_dummy_program_name :=
                        gen_dco_proc_spec (
                            p_table_owner,
                            p_table_name,
                            v_cons (i).constraint_name,
                            v_cons_cols,
                            p_types_package_name,
                            p_lineas);
                    utl_line.app_line (';', p_lineas);
                    utl_line.put_line ('', p_lineas);
                ELSE
                    gen_dco_proc_body (
                        p_package_name,
                        p_table_owner,
                        p_table_name,
                        v_cons (i).constraint_name,
                        v_cons_cols,
                        p_types_package_name,
                        p_lineas);
                    utl_line.put_line ('', p_lineas);
                END IF;

                v_cons_cols.delete;
            END LOOP;
        END IF;

        v_cons.delete;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_dco_all_cons_by_puf;

    -- Generar procedimiento de delete con where dinámico
    FUNCTION gen_ddw_dyn_where_spec (
        p_table_name    IN            dba_tables.table_name%TYPE, -- tabla
        p_lineas        IN OUT NOCOPY utl_line.lines_t -- lineas
                                                      )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'gen_ddw_dyn_where_spec' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t := gat_defs.k_ddw_proc;
    BEGIN -- generar procedimiento de delete con where dinámico
        utl_line.put_line (
            REPLACE (gat_defs.k_ddw_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        --*
        /*
        utl_line.put_line (
            '--##@ Delcaración genarada por:' || k_modulo,
            p_lineas);
        */
        --*
        utl_line.put_line (
            gat_defs.k_function || ' ' || v_program_name || '(',
            p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line (gat_defs.k_ddw_proc_in_parm, p_lineas);
        --utl_line.app_line (',', p_lineas);
        --utl_line.put_line (gat_defs.k_ddw_proc_out_parm, p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (') ' || gat_defs.k_ddw_proc_ret, p_lineas);

        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_ddw_dyn_where_spec;

    -- Generar procedimiento de delete con where dinámico
    PROCEDURE gen_ddw_dyn_where_body (
        p_package_name    IN            dba_objects.object_name%TYPE,
        p_table_name      IN            dba_tables.table_name%TYPE, -- tabla
        p_lineas          IN OUT NOCOPY utl_line.lines_t -- lineas
                                                        )
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'gen_ddw_dyn_where_body' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
    BEGIN -- generar procedimiento de delete con where dinámico
        v_program_name := gen_ddw_dyn_where_spec (p_table_name, p_lineas);
        utl_line.app_line (' IS', p_lineas);

        
        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);

        -- declarar variable para obtener el count
        utl_line.set_level (+1);
        --*
        utl_line.put_line (
            gat_defs.k_ddw_var_ret || ' ' || gat_defs.k_ddw_type_ret || ';',
            p_lineas);
        utl_line.set_level (-1);

        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line (gat_defs.k_ddw_eval_null_cond, p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_ddw_execute_del,
                gat_defs.k_tabla,
                p_table_name),
            p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (gat_defs.k_else, p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_ddw_execute_del_ww,
                gat_defs.k_tabla,
                p_table_name),
            p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (gat_defs.k_endif, p_lineas);
        utl_line.app_line (';', p_lineas);
        -- Genera linea para contar cuantos registros fueron afectados
        utl_line.app_line ('', p_lineas);
        utl_line.put_line (gat_defs.k_sql_var_rowcount, p_lineas);
        utl_line.put_line (gat_defs.k_ddw_proc_retv || ';', p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- Finaliza procedimiento
        utl_line.put_line (gat_defs.k_ddw_end, p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_ddw_dyn_where_body;

    -- Prepara delete que usa una columna para condición de borrado
    FUNCTION gen_doc_one_col_spec (
        p_table_name    IN            dba_tables.table_name%TYPE, -- tabla
        p_col_type      IN            VARCHAR2,
        p_lineas        IN OUT NOCOPY utl_line.lines_t -- lineas
                                                      )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'gen_doc_one_col_spec' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t := gat_defs.k_doc_proc;
    BEGIN -- generar procedimiento para delete con where dinámico
        utl_line.put_line (
            REPLACE (gat_defs.k_doc_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        --*
        /*
        utl_line.put_line (
            '--##@ Delcaración genarada por:' || k_modulo,
            p_lineas);
        */
        --*
        utl_line.put_line (
            gat_defs.k_function || ' ' || v_program_name || '(',
            p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line (gat_defs.k_doc_proc_in_parm_1, p_lineas);
        utl_line.app_line (',', p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_doc_proc_in_parm_2,
                gat_defs.k_column_type,
                p_col_type),
            p_lineas);
        --utl_line.app_line (',', p_lineas);
        --utl_line.put_line (gat_defs.k_doc_proc_out_parm, p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (') ' || gat_defs.k_doc_proc_ret, p_lineas);

        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_doc_one_col_spec;

    -- Prepara delete que usa una columna para condición de borrado
    PROCEDURE gen_doc_one_col_body (
        p_package_name    IN            dba_objects.object_name%TYPE,
        p_table_name      IN            dba_tables.table_name%TYPE, -- tabla
        p_col_type        IN            VARCHAR2,
        p_lineas          IN OUT NOCOPY utl_line.lines_t -- lineas
                                                        )
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t
                                   := 'gen_doc_one_col_body' ;
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
    BEGIN -- generar procedimiento de delete con where dinámico
        v_program_name :=
            gen_doc_one_col_spec (p_table_name, p_col_type, p_lineas);
        utl_line.app_line (' IS', p_lineas);

        
        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);

        --* declarar variable para obtener el count
        utl_line.set_level (+1);
        utl_line.put_line (
            gat_defs.k_doc_var_ret || ' ' || gat_defs.k_uoc_type_ret || ';',
            p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_doc_execute_del,
                gat_defs.k_tabla,
                p_table_name),
            p_lineas);
        utl_line.set_level (+1);
        utl_line.put_line (gat_defs.k_doc_where, p_lineas);
        utl_line.put_line (gat_defs.k_doc_using, p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.set_level (-1);
        -- Genera linea para contar cuantos registros fueron afectados
        utl_line.put_line (gat_defs.k_sql_var_rowcount, p_lineas);
        utl_line.put_line (gat_defs.k_doc_proc_retv || ';', p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- Finaliza procedimiento
        utl_line.put_line (gat_defs.k_doc_end, p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_doc_one_col_body;

    --*
    --* Programa principal SPEC
    --*

    PROCEDURE gen_pkg_change_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t)
    IS
        -- Constantes para identificar el package y el programa
        k_programa     CONSTANT fdc_defs.program_name_t := 'gen_pkg_change_spec';
        k_modulo       CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        -- Variables
        v_dummy_program_name    fdc_defs.program_name_t;
        v_constraint_name       dba_constraints.constraint_name%TYPE;
        v_cons_columns          utl_desc.dba_cons_columns_ct;
    --*
    BEGIN
        v_constraint_name :=
            utl_desc.pk_contraint_name (p_table_owner, p_table_name);

        -- Genera una funcion para obtener NEXVAL de la secuencia de la tabla
        IF v_constraint_name IS NOT NULL THEN
            utl_desc.constraint_cols (
                p_table_owner,
                v_constraint_name,
                v_cons_columns);

            IF     v_cons_columns.COUNT = 1
               AND v_cons_columns (1).column_name =
                       gat_gen_names.pk_sequence_column_name (
                           p_table_owner,
                           p_table_name) THEN
                gen_nke_spec (p_table_name, p_lineas);
                utl_line.app_line (';', p_lineas);
                utl_line.put_line (gat_defs.k_blank, p_lineas);
            END IF;
        END IF;

        -- Generar procedure ins (inserta via record)
        v_dummy_program_name :=
            gen_ins_proc_spec (p_table_name, p_types_package_name, p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Generar procedure ins (inserta via lista de columnas)
        v_dummy_program_name :=
            gen_ibc_proc_spec (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera procedimiento para insert de un conjunto de regitros,
        -- parametro: Colección de registros
        v_dummy_program_name :=
            gen_ico_proc_spec (p_table_name, p_types_package_name, p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera procedimiento que inserta un conjunto de registros a partir de una colección de
        -- columnas
        -- ICC: Insert Columns Collection
        v_dummy_program_name :=
            gen_icc_proc_spec (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);

        -- Updates
        ----------------------------------------------------------------------
        IF utl_desc.constraint_exists (
               p_table_owner,
               p_table_name,
               utl_desc.k_coty_primary_key) THEN
            IF gat_utl.columns_for_update (p_table_owner, p_table_name) THEN
                -- Genera procedimiento para update vía la pk
                v_dummy_program_name :=
                    gen_upd_proc_spec (
                        p_table_owner,
                        p_table_name,
                        p_types_package_name,
                        p_lineas);
                utl_line.app_line (';', p_lineas);
                utl_line.put_line (gat_defs.k_blank, p_lineas);
            END IF;
        END IF;

        -- Genera procedimiento para update por las Unique Key
        gen_ucc_all_cons_by_puf (
            NULL,
            p_table_owner,
            p_table_name,
            p_lineas,
            p_constraint_type      => utl_desc.k_coty_unique_key,
            p_types_package_name   => p_types_package_name);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera un procedimiento upd que actualiza una columna via un where dinámico
        v_dummy_program_name :=
            gen_uoc_one_col_spec (p_table_name, 'NUMBER', p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        v_dummy_program_name :=
            gen_uoc_one_col_spec (p_table_name, 'DATE', p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        v_dummy_program_name :=
            gen_uoc_one_col_spec (p_table_name, 'VARCHAR2', p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera los update que usa por parámetros las columnas de la tabla más el indicador
        -- de Ignorar/No ignorar parámetros de columnas nulas
        gen_upd_all_cons_by_puf (
            NULL,
            p_table_owner,
            p_table_name,
            p_lineas,
            p_constraint_type      => utl_desc.k_coty_primary_key,
            p_types_package_name   => p_types_package_name);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        gen_upd_all_cons_by_puf (
            NULL,
            p_table_owner,
            p_table_name,
            p_lineas,
            p_constraint_type      => utl_desc.k_coty_unique_key,
            p_types_package_name   => p_types_package_name);
        utl_line.put_line (gat_defs.k_blank, p_lineas);

        -- Genera procedimientos para delete
        ----------------------------------------------------------------------
        IF utl_desc.constraint_exists (
               p_table_owner,
               p_table_name,
               utl_desc.k_coty_primary_key) THEN
            -- Genera procedimiento para delete vía la pk
            gen_dco_all_cons_by_puf (
                NULL,
                p_table_owner,
                p_table_name,
                p_lineas,
                p_constraint_type      => utl_desc.k_coty_primary_key,
                p_types_package_name   => p_types_package_name);
            utl_line.put_line (gat_defs.k_blank, p_lineas);
        END IF;

        -- Genera procedimiento para delete vía la(s) uk
        gen_dco_all_cons_by_puf (
            NULL,
            p_table_owner,
            p_table_name,
            p_lineas,
            p_constraint_type      => utl_desc.k_coty_unique_key,
            p_types_package_name   => p_types_package_name);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera procedimiento para delete vía la(s) fk
        gen_dco_all_cons_by_puf (
            NULL,
            p_table_owner,
            p_table_name,
            p_lineas,
            p_constraint_type      => utl_desc.k_coty_foreing_key,
            p_types_package_name   => p_types_package_name);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera procedimiento para delete con where dinámico
        v_dummy_program_name := gen_ddw_dyn_where_spec (p_table_name, p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera procedimiento para delete usando por condición una columna
        v_dummy_program_name :=
            gen_doc_one_col_spec (p_table_name, 'NUMBER', p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        v_dummy_program_name :=
            gen_doc_one_col_spec (p_table_name, 'DATE', p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        v_dummy_program_name :=
            gen_doc_one_col_spec (p_table_name, 'VARCHAR2', p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_pkg_change_spec;

    --*
    --* Programa principal BODY
    --*

    PROCEDURE gen_pkg_change_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t)
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_pkg_change_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_cp.k_package || '.' || k_programa ;
        --*
        v_constraint_name      dba_constraints.constraint_name%TYPE;
        v_cons_columns         utl_desc.dba_cons_columns_ct;
    --*
    BEGIN
        v_constraint_name :=
            utl_desc.pk_contraint_name (p_table_owner, p_table_name);

        IF v_constraint_name IS NOT NULL THEN
            utl_desc.constraint_cols (
                p_table_owner,
                v_constraint_name,
                v_cons_columns);

            IF     v_cons_columns.COUNT = 1
               AND v_cons_columns (1).column_name =
                       gat_gen_names.pk_sequence_column_name (
                           p_table_owner,
                           p_table_name) THEN
                gen_nke_body (p_package_name, p_table_name, p_lineas);
                utl_line.put_line (gat_defs.k_blank, p_lineas);
            END IF;
        END IF;

        -- Genera procedimiento para insert de un regitro
        gen_ins_proc_body (
            p_package_name,
            p_table_owner,
            p_table_name,
            p_types_package_name,
            p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera procedimiento para insert de un regitro,
        -- parametro: columnas del registro
        gen_ibc_proc_body (
            p_package_name,
            p_table_owner,
            p_table_name,
            p_types_package_name,
            p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera procedimiento para insert de un conjunto de regitros,
        -- parametro: Colección de registros
        gen_ico_proc_body (
            p_package_name,
            p_table_owner,
            p_table_name,
            p_types_package_name,
            p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera procedimiento que inserta un conjunto de registros a partir de una colección de
        -- columnas
        -- ICC: Insert Columns Collection
        gen_icc_proc_body (
            p_package_name,
            p_table_owner,
            p_table_name,
            p_types_package_name,
            p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);

        -- Updates
        ----------------------------------------------------------------------
        IF utl_desc.constraint_exists (
               p_table_owner,
               p_table_name,
               utl_desc.k_coty_primary_key) THEN
            IF gat_utl.columns_for_update (p_table_owner, p_table_name) THEN
                -- Genera procedimiento para update vía la pk
                gen_upd_proc_body (
                    p_package_name,
                    p_table_owner,
                    p_table_name,
                    p_types_package_name,
                    p_lineas);
                utl_line.put_line (gat_defs.k_blank, p_lineas);
            END IF;
        END IF;

        -- Genera procedimiento para update por las Unique Key
        gen_ucc_all_cons_by_puf (
            p_package_name,
            p_table_owner,
            p_table_name,
            p_lineas,
            p_spec                 => FALSE,
            p_constraint_type      => utl_desc.k_coty_unique_key,
            p_types_package_name   => p_types_package_name);
        utl_line.put_line (gat_defs.k_blank, p_lineas);

        -- Genera un procedimiento upd que actualiza una columna via un where dinámico
        gen_uoc_one_col_body (
            p_package_name,
            p_table_name,
            'NUMBER',
            p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        gen_uoc_one_col_body (
            p_package_name,
            p_table_name,
            'DATE',
            p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        gen_uoc_one_col_body (
            p_package_name,
            p_table_name,
            'VARCHAR2',
            p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);

        -- Genera los update que usa por parámetros las columnas de la tabla más el indicador
        -- de Ignorar/No ignorar parámetros de columnas nulas
        gen_upd_all_cons_by_puf (
            p_package_name,
            p_table_owner,
            p_table_name,
            p_lineas,
            p_spec                 => FALSE,
            p_constraint_type      => utl_desc.k_coty_primary_key,
            p_types_package_name   => p_types_package_name);
        utl_line.put_line (gat_defs.k_blank, p_lineas);

        -- Genera los update por las UKs
        gen_upd_all_cons_by_puf (
            p_package_name,
            p_table_owner,
            p_table_name,
            p_lineas,
            p_spec                 => FALSE,
            p_constraint_type      => utl_desc.k_coty_unique_key,
            p_types_package_name   => p_types_package_name);
        utl_line.put_line (gat_defs.k_blank, p_lineas);

        -- Genera procedimientos para delete
        ----------------------------------------------------------------------
        IF utl_desc.constraint_exists (
               p_table_owner,
               p_table_name,
               utl_desc.k_coty_primary_key) THEN
            -- Genera procedimiento para delete vía la pk
            gen_dco_all_cons_by_puf (
                p_package_name,
                p_table_owner,
                p_table_name,
                p_lineas,
                p_spec                 => FALSE,
                p_constraint_type      => utl_desc.k_coty_primary_key,
                p_types_package_name   => p_types_package_name);
            utl_line.put_line (gat_defs.k_blank, p_lineas);
        END IF;

        -- Genera procedimiento para delete vía la(s) uk
        gen_dco_all_cons_by_puf (
            p_package_name,
            p_table_owner,
            p_table_name,
            p_lineas,
            p_spec                 => FALSE,
            p_constraint_type      => utl_desc.k_coty_unique_key,
            p_types_package_name   => p_types_package_name);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera procedimiento para delete vía la(s) fk
        gen_dco_all_cons_by_puf (
            p_package_name,
            p_table_owner,
            p_table_name,
            p_lineas,
            p_spec                 => FALSE,
            p_constraint_type      => utl_desc.k_coty_foreing_key,
            p_types_package_name   => p_types_package_name);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera procedimiento para delete con where dinámico
        gen_ddw_dyn_where_body (p_package_name, p_table_name, p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Genera procedimiento para delete usando por condición una columna
        gen_doc_one_col_body (
            p_package_name,
            p_table_name,
            'NUMBER',
            p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        gen_doc_one_col_body (
            p_package_name,
            p_table_name,
            'DATE',
            p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        gen_doc_one_col_body (
            p_package_name,
            p_table_name,
            'VARCHAR2',
            p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_pkg_change_body;
END gat_tab_gen_cp;
/
SHOW ERRORS;


