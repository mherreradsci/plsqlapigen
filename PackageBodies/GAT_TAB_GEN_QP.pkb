CREATE OR REPLACE PACKAGE BODY GAT.gat_tab_gen_qp
IS
    /*------------------------------------------------------------------------------
    Empresa:    Explora IT
    Proyecto:   Utilidades para desarrolladores PL/SQL
    Objetivo:   Procedimientos para generar un package de API de una tabla

    Historia:
    Cuando      Quien    Comantario
    ----------- -------- -----------------------------------------------------------
    03-Dic-2004 mherrera Separa los programas que generan los %QP del package
                         UTL_TAB_API


    03-Dic-2004 mherrera 1) Agrega When others y utl_error a los programas
                         2) Agrega las intrucciones para generar el when others
                            y el handler de la excepcion via el UTL_ERROR
                         3) Agrega con_<Constraints> para la PK y UK que
                            devuelven un Record Type, hasta antes de esta
                            modificación solo existía la consulta por la UK que
                            retorna un cursor, además, este nuevo procedimiento
                            deja obsoleta a la función Consulta_pk
    24-Nov-2009 mherrera Separa el programa gen_qcc_all_cons_by_puf para que uno
                         genere la especificación y el otro el body incluyendo
                         el parametro p_package_name para poder poner el nombre
                         del package en el manejador de exepciones generado
    ----------- -------- -----------------------------------------------------------
    */

    -- La función que genera este programa está obsoleta, debe reemplazarse por
    -- gen_qrr_spec y gen_qrr_body. El nuevo código generado
    -- levanta una excepción cuando no existe el registro, además, ya
    -- no retornan los record sino que se hace vía parámetro in out nocopy
    -- para mejor performance
    FUNCTION gen_qry_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qry_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t
                                   := gat_defs.k_qry_proc_name;
        v_constraint           utl_desc.dba_constraints_rt;
        n_cols                 NUMBER (3);
        v_cons_cols            utl_desc.dba_cons_columns_ct;
    BEGIN
        utl_line.set_level (-utl_line.get_level + 1);
        /* generar funcion de query basada en la pk */
        utl_line.put_line (
            REPLACE (gat_defs.k_qry_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.put_line (gat_defs.k_qry_proc, p_lineas);
        /* parámetros: columnas de la pk */
        utl_line.set_level (+1);
        v_constraint := utl_desc.pk (p_table_owner, p_table_name);
        n_cols :=
            utl_desc.constraint_cols (
                p_table_owner,
                v_constraint.constraint_name,
                v_cons_cols);
        gat_utl.gen_param_list (
            p_table_owner,
            p_table_name,
            p_types_package_name,
            v_cons_cols,
            p_lineas);
        v_cons_cols.delete;
        /* cerrar la declaracion de la funcion con return tab_<tabla> */
        utl_line.set_level (-1);
        utl_line.put_line (
               ') '
            || REPLACE (
                   gat_defs.k_qry_proc_ret,
                   gat_defs.k_nombre_package_tipo,
                   p_types_package_name),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_tabla_nc,
            SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_sufix),
            p_lineas);
        --      utl_line.put_line (   ') '
        --                         || REPLACE (gat_defs.k_qry_proc_ret,
        --                                     gat_defs.k_tabla_nc,
        --                                     SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_sufix)
        --                                    ),
        --                         p_lineas
        --                        );
        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qry_spec;

    PROCEDURE gen_qry_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_expand_cols           IN            BOOLEAN DEFAULT TRUE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t)
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qry_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
        v_tot_constraints      NUMBER (4);
        v_constraints          utl_desc.dba_constraints_ct;
    BEGIN
        -- Generar especificación procedure qry
        v_program_name :=
            gen_qry_spec (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (' is', p_lineas);
        utl_line.set_level (1);

        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);

        -- declarar variable para obtener el record

        --*
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qry_proc_var,
                gat_defs.k_nombre_package_tipo,
                p_types_package_name),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_tabla_nc_prefix,
            SUBSTR (p_table_name, 1, 28),
            p_lineas);
        --*

        --      utl_line.put_line (REPLACE (gat_defs.k_qry_proc_var1,
        --                                  gat_defs.k_tabla_nc_prefix,
        --                                  SUBSTR (p_table_name, 1, 28)
        --                                 ),
        --                         p_lineas
        --                        );
        utl_line.rep_curr (
            gat_defs.k_tabla_nc,
            SUBSTR (p_table_name, 1, 27),
            p_lineas);
        v_tot_constraints :=
            utl_desc.constraints_puf (
                p_table_owner,
                p_table_name,
                v_constraints,
                utl_desc.k_coty_primary_key);
        gat_utl.gen_cursor_where_puf (
            p_table_owner,
            p_table_name,
            v_constraints (v_constraints.FIRST).constraint_name,
            p_expand_cols,
            p_lineas);
        v_constraints.delete;
        utl_line.set_level (-2);
        utl_line.put_line ('--*', p_lineas);
        -- iniciar el codigo
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        utl_line.set_level (1);
        -- Obtiene un registro a partir del cursor
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qry_proc_open,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qry_proc_fetch,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qry_proc_close,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        -- agregar el return
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qry_proc_retv,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- terminar el codigo de la funcion
        utl_line.put_line (gat_defs.k_qry_end || ';', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qry_body;

    PROCEDURE gen_qrr_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_constraint_name       IN            dba_constraints.constraint_name%TYPE,
        p_program_name          IN            fdc_defs.program_name_t,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qrr_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_constraint           utl_desc.dba_constraints_rt;
        n_cols                 NUMBER (3);
        v_cons_cols            utl_desc.dba_cons_columns_ct;
    BEGIN
        utl_line.set_level (-utl_line.get_level + 1.0);
        -- generar procedimeito de query basada en la constraint
        -- que viene por parámetro
        utl_line.put_line (
            REPLACE (gat_defs.k_qrr_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_constraint_puf,
            p_constraint_name,
            p_lineas);
        utl_line.put_line (
            gat_defs.k_procedure || ' ' || p_program_name,
            p_lineas);
        -- parámetros: columnas de la pk
        utl_line.set_level (+1);
        n_cols :=
            utl_desc.constraint_cols (
                p_table_owner,
                p_constraint_name,
                v_cons_cols);
        gat_utl.gen_param_list (
            p_table_owner,
            p_table_name,
            p_types_package_name,
            v_cons_cols,
            p_lineas);
        v_cons_cols.delete;
        -- Genera el parámetro de salida
        utl_line.put_line (
               ','
            || REPLACE (
                   gat_defs.k_qrr_proc_out_record1,
                   gat_defs.k_tabla_nc_prefix,
                   SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_prefix)),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_nombre_package_tipo,
            p_types_package_name,
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_tabla_nc,
            SUBSTR (p_table_name, 1, 27),
            p_lineas);
        -- cerrar la declaracion del procedimiento
        utl_line.set_level (-1.0);
        utl_line.put_line (') ', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qrr_spec;

    -- genera un procedimiento de consulta para los contraints del
    -- tipo PK/UK de la tabla
    PROCEDURE gen_qrr_all_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_constraint_type       IN            utl_desc.constraint_type_t,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t)
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qrr_all_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_cons                 utl_desc.dba_constraints_ct;
        k                      NUMBER (4);
        v_program_name         fdc_defs.program_name_t;
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
                v_program_name :=
                    gat_utl.gen_program_name (
                        gat_defs.k_qrr_proc_name,
                        gat_defs.k_constraint_puf_nc,
                        v_cons (i).constraint_name);
                gen_qrr_spec (
                    p_table_owner,
                    p_table_name,
                    v_cons (i).constraint_name,
                    v_program_name,
                    p_types_package_name,
                    p_lineas);
                utl_line.app_line (';', p_lineas);
            END LOOP;
        END IF;

        v_cons.delete;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qrr_all_spec;

    -- Genera el cuerpo de un procedimiento de consulta para los contraints del
    -- tipo PK/UK de la tabla
    PROCEDURE gen_qrr_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_constraint_name       IN            dba_constraints.constraint_name%TYPE,
        p_program_name          IN            fdc_defs.program_name_t,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_expand_cols           IN            BOOLEAN DEFAULT TRUE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t)
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qrr_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
    BEGIN
        v_program_name :=
            gat_utl.gen_program_name (
                gat_defs.k_qrr_proc_name,
                gat_defs.k_constraint_puf_nc,
                p_constraint_name);
        -- Generar especificación de un procedure qry via la pk
        gen_qrr_spec (
            p_table_owner          => p_table_owner,
            p_table_name           => p_table_name,
            p_constraint_name      => p_constraint_name,
            p_program_name         => p_program_name,
            p_types_package_name   => p_types_package_name,
            p_lineas               => p_lineas);
        utl_line.app_line (' is', p_lineas);

        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        
        
        -- declarar variable para obtener el record
        utl_line.set_level (1);
        --utl_line.rep_curr (gat_defs.k_tabla_nc, SUBSTR (p_table_name, 1, 27), p_lineas);
        gat_utl.gen_cursor_where_puf (
            p_table_owner,
            p_table_name,
            p_constraint_name,
            p_expand_cols,
            p_lineas);
        utl_line.put_line (gat_defs.k_qrr_proc_v_found, p_lineas);
        utl_line.set_level (-2);
        -- iniciar el codigo
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        utl_line.set_level (1);
        -- Obtiene un registro a partir del cursor
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qrr_proc_open,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qrr_proc_fetch,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qrr_proc_set_found,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qrr_proc_close,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qrr_proc_if_ndf_raise,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            gat_defs.k_no_data_found,
            p_lineas);
        -- terminar el codigo de la funcion
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qrr_end,
                gat_defs.k_qrr_proc_name,
                v_program_name),
            p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qrr_body;

    PROCEDURE gen_qrr_all_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_constraint_type       IN            utl_desc.constraint_type_t,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_expand_cols           IN            BOOLEAN DEFAULT TRUE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t)
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qrr_all_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_cons                 utl_desc.dba_constraints_ct;
        k                      NUMBER (4) := 0;
        v_program_name         fdc_defs.program_name_t;
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
                v_program_name :=
                    gat_utl.gen_program_name (
                        gat_defs.k_qrr_proc_name,
                        gat_defs.k_constraint_puf_nc,
                        v_cons (i).constraint_name);
                gen_qrr_body (
                    p_package_name,
                    p_table_owner,
                    p_table_name,
                    v_cons (i).constraint_name,
                    v_program_name,
                    p_types_package_name,
                    p_expand_cols,
                    p_lineas);
                utl_line.app_line (';', p_lineas);
            END LOOP;
        END IF;

        v_cons.delete;
    /*
          v_program_name := gat_utl.gen_program_name(gat_defs.k_qrr_proc_name, gat_defs.k_constraint_puf_nc, p_constraint_name);
          -- Generar especificación de un procedure qry via la pk
          gen_qrr_all_spec (p_table_owner, p_table_name, p_constraint_type => p_constraint_type, p_lineas);
          utl_line.app_line (' is', p_lineas);
          -- declarar variable para obtener el record
          utl_line.Set_LEVEL (1);
          utl_line.put_line (REPLACE (gat_defs.k_qrr_proc_var, gat_defs.k_tabla_nc_prefix, SUBSTR (p_table_name, 1, 28)), p_lineas);
          utl_line.rep_curr (gat_defs.k_tabla_nc, SUBSTR (p_table_name, 1, 27), p_lineas);
          gen_cursor_where_puf (p_table_owner, p_table_name, p_lineas);
          utl_line.Set_LEVEL (-2);
          -- iniciar el codigo
          utl_line.put_line (gat_defs.k_begin, p_lineas);
          utl_line.put_line (gat_defs.k_blank, p_lineas);
          utl_line.Set_LEVEL (1);
          -- Obtiene un registro a partir del cursor
          utl_line.put_line (REPLACE (gat_defs.k_qrr_proc_open, gat_defs.k_tabla_nc, SUBSTR (p_table_name, 1, 28)), p_lineas);
          utl_line.put_line (REPLACE (gat_defs.k_qrr_proc_fetch, gat_defs.k_tabla_nc, SUBSTR (p_table_name, 1, 28)), p_lineas);
          utl_line.put_line (REPLACE (gat_defs.k_qrr_proc_close, gat_defs.k_tabla_nc, SUBSTR (p_table_name, 1, 28)), p_lineas);
          -- agregar el return
          utl_line.put_line (gat_defs.k_blank, p_lineas);
          utl_line.put_line (REPLACE (gat_defs.k_qrr_proc_retv, gat_defs.k_tabla_nc, SUBSTR (p_table_name, 1, 28)), p_lineas);
          -- Generar bloque when others
          utl_line.Set_LEVEL (-1);
          gat_utl.gen_exeption_block (p_package_name, v_program_name, p_lineas);
          -- terminar el codigo de la funcion
          utl_line.put_line (gat_defs.k_qrr_end || ';', p_lineas);
    */
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qrr_all_body;

    -- Genera una Consulta la exitencia de un registro de %TABLA% basado en la PK
    FUNCTION gen_exi_func_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_exi_func_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_modulo               fdc_defs.program_name_t;
        v_pk                   utl_desc.dba_constraints_rt;
        n_cols                 NUMBER (3);
        v_cons_cols            utl_desc.dba_cons_columns_ct;
    BEGIN
        /* generar funcion de query basada en la pk */
        utl_line.put_line (
            REPLACE (gat_defs.k_exi_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        v_modulo := gat_defs.k_exi_proc;
        utl_line.put_line (gat_defs.k_function || ' ' || v_modulo, p_lineas);
        /* parámetros: columnas de la pk */
        v_pk := utl_desc.pk (p_table_owner, p_table_name);
        n_cols :=
            utl_desc.constraint_cols (
                p_table_owner,
                v_pk.constraint_name,
                v_cons_cols);
        gat_utl.gen_param_list (
            p_table_owner,
            p_table_name,
            p_types_package_name,
            v_cons_cols,
            p_lineas);
        v_cons_cols.delete;
        /* cerrar la declaracion de la funcion con return tab_<tabla> */
        utl_line.put_line (
               ') '
            || REPLACE (
                   gat_defs.k_exi_proc_ret,
                   gat_defs.k_tabla,
                   p_table_name),
            p_lineas);
        RETURN v_modulo;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_exi_func_spec;

    -- Genera una Consulta la exitencia de un registro de %TABLA% basado en la PK
    PROCEDURE gen_exi_func_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_exi_func_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
        v_pk                   utl_desc.dba_constraints_rt;
        n_cols                 NUMBER (3);
        v_cons_cols            utl_desc.dba_cons_columns_ct;
    BEGIN
        -- Generar especificación procedure existe
        v_program_name :=
            gen_exi_func_spec (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (' is', p_lineas);
        
        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        
        -- declarar variable para obtener el record
        utl_line.set_level (1);
        -- generar cursor select
        utl_line.put_line (
            REPLACE (
                gat_defs.k_exi_proc_cursor,
                gat_defs.k_tabla,
                p_table_name),
            p_lineas);
        -- agregar el where de acuerdo a la pk
        v_pk := utl_desc.pk (p_table_owner, p_table_name);
        n_cols :=
            utl_desc.constraint_cols (
                p_table_owner,
                v_pk.constraint_name,
                v_cons_cols);
        gat_utl.gen_where_list (v_cons_cols, p_lineas);
        v_cons_cols.delete;
        utl_line.app_line (';', p_lineas);
        -- declarar variable para obtener el record
        utl_line.put_line (gat_defs.k_exi_proc_var_l01, p_lineas);
        utl_line.put_line (gat_defs.k_exi_proc_var_l02, p_lineas);
        utl_line.set_level (-1);
        -- iniciar el codigo
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (1);
        -- generar body
        utl_line.put_line (gat_defs.k_exi_proc_open, p_lineas);
        utl_line.put_line (gat_defs.k_exi_proc_fetch, p_lineas);
        utl_line.put_line (gat_defs.k_exi_proc_found, p_lineas);
        utl_line.put_line (gat_defs.k_exi_proc_close, p_lineas);
        utl_line.put_line (gat_defs.k_exi_proc_return, p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- terminar el codigo de la funcion
        utl_line.put_line (gat_defs.k_exi_end || ';', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_exi_func_body;

    -- cuenta la cantidad de ocurrencias de la %TABLA% basado en la PK (sirve para control)
    FUNCTION gen_cpk_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_cpk_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t
                                   := gat_defs.k_cpk_proc_name;
        v_pk                   utl_desc.dba_constraints_rt;
        n_cols                 NUMBER (3);
        v_cons_cols            utl_desc.dba_cons_columns_ct;
    BEGIN
        -- generar funcion de query basada en la pk
        utl_line.put_line (
            REPLACE (gat_defs.k_cpk_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.put_line (gat_defs.k_cpk_proc, p_lineas);
        -- parámetros: columnas de la pk
        v_pk := utl_desc.pk (p_table_owner, p_table_name);
        n_cols :=
            utl_desc.constraint_cols (
                p_table_owner,
                v_pk.constraint_name,
                v_cons_cols);
        gat_utl.gen_param_list (
            p_table_owner,
            p_table_name,
            p_types_package_name,
            v_cons_cols,
            p_lineas);
        v_cons_cols.delete;
        -- cerrar la declaracion de la funcion con return tab_<tabla>
        utl_line.put_line (
               ') '
            || REPLACE (
                   gat_defs.k_cpk_proc_ret,
                   gat_defs.k_tabla,
                   p_table_name),
            p_lineas);
        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_cpk_spec;

    -- Consulta la exitencia de un registro de %TABLA% basado en la PK
    PROCEDURE gen_cpk_func_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_cpk_func_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t;
        v_pk                   utl_desc.dba_constraints_rt;
        n_cols                 NUMBER (3);
        v_cons_cols            utl_desc.dba_cons_columns_ct;
    BEGIN
        -- Generar especificación procedure existe
        v_program_name :=
            gen_cpk_spec (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (' is', p_lineas);
        
        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        
        -- declarar variable para obtener el record
        utl_line.set_level (1);
        utl_line.put_line (gat_defs.k_cpk_var_count, p_lineas);
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        -- generar select count
        utl_line.put_line (
            REPLACE (gat_defs.k_cpk_sel_count, gat_defs.k_tabla, p_table_name),
            p_lineas);
        -- agregar el where de acuerdo a la pk
        v_pk := utl_desc.pk (p_table_owner, p_table_name);
        n_cols :=
            utl_desc.constraint_cols (
                p_table_owner,
                v_pk.constraint_name,
                v_cons_cols);
        gat_utl.gen_where_list (v_cons_cols, p_lineas);
        v_cons_cols.delete;
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_cpk_proc_return, p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- terminar el codigo de la funcion
        utl_line.put_line (gat_defs.k_cpk_end || ';', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_cpk_func_body;

    -- Obtiene una coleccion con los registros de la tabla %TABLA% con where dinámico
    FUNCTION gen_qwt_proc_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qwt_proc_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- variables
        v_program_name         fdc_defs.program_name_t
                                   := gat_defs.k_qwt_proc_name;
    BEGIN
        -- generar funcion de query basada en la pk
        utl_line.put_line (
            REPLACE (gat_defs.k_qwt_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qwt_proc1,
                gat_defs.k_tabla_nc_prefix,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_nombre_package_tipo,
            p_types_package_name,
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_tabla_nc,
            SUBSTR (p_table_name, 1, 27),
            p_lineas);
        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qwt_proc_spec;





    -- Obtiene una coleccion con los registros de la tabla %TABLA% con where dinámico
    PROCEDURE gen_qwt_proc_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_expand_cols           IN            BOOLEAN DEFAULT TRUE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qwt_proc_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        v_program_name         fdc_defs.program_name_t;
    BEGIN
        -- Generar especificación procedure existe
        v_program_name :=
            gen_qwt_proc_spec (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (' is', p_lineas);
        
        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        
        -- declarar variable para obtener el record
        utl_line.set_level (1);
        -- declarar variable para obtener el record
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qwt_proc_var_l01,
                gat_defs.k_tabla,
                p_table_name),
            p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qwt_proc_var_l02,
                gat_defs.k_tabla,
                p_table_name),
            p_lineas);
        utl_line.set_level (-1);
        -- iniciar el codigo
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (1);
        -- generar cursor dinámico
        utl_line.put_line (
            REPLACE (gat_defs.k_qwt_proc_open, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.set_level (1);
        utl_line.put_line ('''', p_lineas);
        gat_utl.gen_select_sin_where (
            p_table_owner,
            p_table_name,
            p_expand_cols,
            p_lineas);
        utl_line.put_line ('WHERE '' || p_where;', p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        utl_line.put_line (gat_defs.k_loop, p_lineas);
        utl_line.set_level (1);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qwt_proc_fetch,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        utl_line.put_line (gat_defs.k_qwt_proc_exit, p_lineas);
        utl_line.set_level (-1);
        utl_line.put_line (gat_defs.k_end_loop, p_lineas);
        utl_line.put_line (gat_defs.k_qwt_proc_close, p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- terminar el codigo del procedimiento
        utl_line.put_line (gat_defs.k_qwt_end || ';', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qwt_proc_body;




    -- Obtiene un cursor via una consulta sin where es decir, todos los
    -- registros
    FUNCTION gen_qal_proc_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qal_proc_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t
                                   := gat_defs.k_qal_proc_name;

    BEGIN
        -- generar funcion de query para todos los registros
        utl_line.put_line (
            REPLACE (gat_defs.k_qal_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.put_line (
            REPLACE (gat_defs.k_qal_proc, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qal_proc_ret,
                gat_defs.k_nombre_package_tipo,
                p_types_package_name),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_tabla_nc,
            SUBSTR (p_table_name, 1, 27),
            p_lineas);
        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qal_proc_spec;


    -- Obtiene un cursor via una consulta sin where es decir, todos los
    -- registros

    PROCEDURE gen_qal_proc_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_expand_cols           IN            BOOLEAN DEFAULT TRUE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qal_proc_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- variables
        v_program_name         fdc_defs.program_name_t;
    BEGIN
        -- Generar especificación procedure existe
        v_program_name :=
            gen_qal_proc_spec (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (' is', p_lineas);
        
        
        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);

        
        -- declarar variable para obtener el record
        utl_line.set_level (1);
        -- declarar variable para obtener el record
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qal_var_cursor1,
                gat_defs.k_tabla_nc_prefix,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_nombre_package_tipo,
            p_types_package_name,
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_tabla_nc,
            SUBSTR (p_table_name, 1, 27),
            p_lineas);
        utl_line.set_level (-1);
        -- iniciar el codigo
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (1);
        -- generar cursor dinámico
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qal_open_cursor,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);

        gat_utl.gen_select_sin_where (
            p_table_owner,
            p_table_name,
            p_expand_cols,
            p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qal_return,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- terminar el codigo del procedimiento
        utl_line.put_line (gat_defs.k_qal_end || ';', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qal_proc_body;



    -- Obtiene un cursor via una consulta con where dinámico
    FUNCTION gen_qwc_proc_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qwc_proc_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t
                                   := gat_defs.k_qwc_proc_name;
    BEGIN
        -- generar funcion de query basada en la pk
        utl_line.put_line (
            REPLACE (gat_defs.k_qwc_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.put_line (
            REPLACE (gat_defs.k_qwc_proc, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qwc_proc_ret,
                gat_defs.k_nombre_package_tipo,
                p_types_package_name),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_tabla_nc,
            SUBSTR (p_table_name, 1, 27),
            p_lineas);
        --      utl_line.put_line (REPLACE (gat_defs.k_qwc_proc_ret,
        --                                  gat_defs.k_tabla_nc,
        --                                  SUBSTR (p_table_name, 1, 27)
        --                                 ),
        --                         p_lineas
        --                        );
        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qwc_proc_spec;

    -- Genera programa que obtiene un cursor con los registros de la tabla %TABLA% con where dinámico
    PROCEDURE gen_qwc_proc_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_expand_cols           IN            BOOLEAN DEFAULT TRUE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qwc_proc_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- variables
        v_program_name         fdc_defs.program_name_t;
    BEGIN
        -- Generar especificación procedure existe
        v_program_name :=
            gen_qwc_proc_spec (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (' is', p_lineas);
        
        
        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);

        
        -- declarar variable para obtener el record
        utl_line.set_level (1);
        -- declarar variable para obtener el record
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qwc_var_cursor1,
                gat_defs.k_tabla_nc_prefix,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_nombre_package_tipo,
            p_types_package_name,
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_tabla_nc,
            SUBSTR (p_table_name, 1, 27),
            p_lineas);
        utl_line.set_level (-1);
        -- iniciar el codigo
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (1);
        -- generar cursor dinámico
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qwc_open_cursor,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        utl_line.put_line ('''', p_lineas);
        gat_utl.gen_select_sin_where (
            p_table_owner,
            p_table_name,
            p_expand_cols,
            p_lineas);
        utl_line.put_line ('WHERE '' || p_where;', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qwc_return,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 28)),
            p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);
        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- terminar el codigo del procedimiento
        utl_line.put_line (gat_defs.k_qwc_end || ';', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qwc_proc_body;

    -- Genera la especificación de la funcion para consultar por la constraint p_fk_name
    -- qcc: Es una (Q)uery generada a partir de una (C)onstraints y retorna un (C)ursor (_qcc_)
    FUNCTION gen_qcc_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_const_name            IN            dba_cons_columns.constraint_name%TYPE,
        p_cons_cols             IN            utl_desc.dba_cons_columns_ct,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
        RETURN fdc_defs.program_name_t
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qcc_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t
                                   := gat_defs.k_qwc_proc_name;
    BEGIN
        -- generar funcion de query basada en la constraint p_const_name
        utl_line.put_line (
            REPLACE (gat_defs.k_qcc_proc_com, gat_defs.k_tabla, p_table_name),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_constraint_puf,
            SUBSTR (p_const_name, 1, 26),
            p_lineas);
        v_program_name :=
            REPLACE (
                gat_defs.k_qcc_proc_name,
                gat_defs.k_constraint_puf_nc,
                SUBSTR (p_const_name, 1, 26));
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qcc_proc,
                gat_defs.k_program_name,
                v_program_name),
            p_lineas);
        gat_utl.gen_param_list (
            p_table_owner,
            p_table_name,
            p_types_package_name,
            p_cons_cols,
            p_lineas);
        -- cerrar la declaracion de la funcion con return tab_<tabla>
        utl_line.put_line (
               ') '
            || REPLACE (
                   gat_defs.k_qcc_proc_ret1,
                   gat_defs.k_nombre_package_tipo,
                   p_types_package_name),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_tabla_nc,
            SUBSTR (p_table_name, 1, 27),
            p_lineas);
        --      utl_line.put_line (   ') '
        --                         || REPLACE (gat_defs.k_qcc_proc_ret,
        --                                     gat_defs.k_tabla_nc,
        --                                     SUBSTR (p_table_name, 1, 27)
        --                                    ),
        --                         p_lineas
        --                        );
        RETURN v_program_name;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qcc_spec;

    PROCEDURE gen_qcc_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_fk_name               IN            VARCHAR2, -- foreing key name
        p_cons_cols             IN            utl_desc.dba_cons_columns_ct,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_expand_cols           IN            BOOLEAN DEFAULT TRUE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t -- lineas
                                                              )
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_qcc_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_program_name         fdc_defs.program_name_t
                                   := gat_defs.k_qwc_proc_name;
    BEGIN
        -- Generar especificación procedure existe
        v_program_name :=
            gen_qcc_spec (
                p_table_owner,
                p_table_name,
                p_fk_name,
                p_cons_cols,
                p_types_package_name,
                p_lineas);
        utl_line.app_line (' is', p_lineas);
        utl_line.set_level (1);
        
        
        -- Generar bloque para identificación
        gat_utl.gen_id_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        
        
        -- declarar variable para obtener el record
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qcc_var_cursor1,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 27)),
            p_lineas);
        utl_line.rep_curr (
            gat_defs.k_nombre_package_tipo,
            p_types_package_name,
            p_lineas);
        utl_line.set_level (-1);
        -- iniciar el codigo
        utl_line.put_line (gat_defs.k_begin, p_lineas);
        utl_line.set_level (1);
        -- generar cursor dinámico
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qcc_open_cursor,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 27)),
            p_lineas);
        gat_utl.gen_select_sin_where (
            p_table_owner,
            p_table_name,
            p_expand_cols,
            p_lineas);
        gat_utl.gen_where_list (p_cons_cols, p_lineas);
        utl_line.app_line (';', p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_qcc_return,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, 27)),
            p_lineas);
        -- Generar bloque when others
        utl_line.set_level (-1);

        gat_utl.gen_exeption_block (
            p_package_name,
            v_program_name,
            p_lineas   => p_lineas);
        -- terminar el codigo del procedimiento
        utl_line.put_line (
               REPLACE (
                   gat_defs.k_qcc_end,
                   gat_defs.k_constraint_puf_nc,
                   SUBSTR (p_fk_name, 1, 26))
            || ';',
            p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qcc_body;

    
    -- Genera una funcion de consulta por cada Primary/Unique/Foreing (puf)
    -- key de la tabla.
    -- Genera el spec
    PROCEDURE gen_qcc_all_cons_by_puf_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_lineas                IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_constraint_type       IN            utl_desc.constraint_type_t DEFAULT utl_desc.k_coty_primary_key,
        p_types_package_name    IN            all_objects.object_name%TYPE)
    IS
        -- Constantes para identificar el package y programa
        k_programa     CONSTANT fdc_defs.program_name_t
                                    := 'gen_qcc_all_cons_by_puf_spec' ;
        k_modulo       CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_cons                  utl_desc.dba_constraints_ct;
        v_cons_cols             utl_desc.dba_cons_columns_ct;
        k                       NUMBER (4) := 0;
        v_dummy_program_name    fdc_defs.program_name_t;
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

                v_dummy_program_name :=
                    gen_qcc_spec (
                        p_table_owner,
                        p_table_name,
                        v_cons (i).constraint_name,
                        v_cons_cols,
                        p_types_package_name,
                        p_lineas);
                utl_line.app_line (';', p_lineas);

                v_cons_cols.delete;
            END LOOP;
        END IF;

        v_cons.delete;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qcc_all_cons_by_puf_spec;

    -- Genera una funcion de consulta por cada Primary/Unique/Foreing (puf)
    -- key de la tabla.
    -- Genera el body
    PROCEDURE gen_qcc_all_cons_by_puf_body (
        p_package_name          IN            dba_objects.object_name%TYPE, -- new
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE, -- tabla
        p_lineas                IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_constraint_type       IN            utl_desc.constraint_type_t DEFAULT utl_desc.k_coty_primary_key,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_expand_cols           IN            BOOLEAN DEFAULT TRUE)
    IS
        -- Constantes para identificar el package y programa
        k_programa     CONSTANT fdc_defs.program_name_t
                                    := 'gen_qcc_all_cons_by_puf_body' ;
        k_modulo       CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_cons                  utl_desc.dba_constraints_ct;
        v_cons_cols             utl_desc.dba_cons_columns_ct;
        k                       NUMBER (4) := 0;
        v_dummy_program_name    fdc_defs.program_name_t;
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

                gen_qcc_body (
                    p_package_name,
                    p_table_owner,
                    p_table_name,
                    v_cons (i).constraint_name,
                    v_cons_cols,
                    p_types_package_name,
                    p_expand_cols,
                    p_lineas);
                v_cons_cols.delete;
            END LOOP;
        END IF;

        v_cons.delete;
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_qcc_all_cons_by_puf_body;

    --   -- Genera una funcion de consulta por cada Primary/Unique/Foreing (puf) key de la tabla
    --   PROCEDURE gen_qcc_all_cons_by_puf (
    --      p_package_name         IN              dba_objects.object_name%TYPE, -- new
    --      p_table_owner          IN              dba_objects.owner%TYPE,
    --      p_table_name           IN              dba_tables.table_name%TYPE,   -- tabla
    --      p_lineas               IN OUT NOCOPY   utl_line.lines_t,   -- lineas
    --      p_spec                 IN              BOOLEAN DEFAULT TRUE,   -- Determina si genera spect o body
    --      p_constraint_type      IN              utl_desc.constraint_type_t
    --            DEFAULT utl_desc.k_coty_primary_key,
    --      p_types_package_name   IN              all_objects.object_name%TYPE,
    --      p_expand_cols          IN              BOOLEAN DEFAULT TRUE
    --   ) IS
    --      -- Constantes para identificar el package y programa
    --      k_programa    CONSTANT fdc_defs.program_name_t      := 'gen_qcc_all_cons_by_puf';
    --      k_modulo      CONSTANT fdc_defs.module_name_t      := gat_tab_gen_qp.k_package || '.' || k_programa;
    --      -- Variables
    --      v_cons                 utl_desc.dba_constraints_ct;
    --      v_cons_cols            utl_desc.dba_cons_columns_ct;
    --      k                      NUMBER (4)                   := 0;
    --      v_dummy_program_name   fdc_defs.program_name_t;
    --   BEGIN
    --      -- Obtiene todas las constraints p_constraint_type de la tabla
    --      k := utl_desc.CONSTRAINTS_puf (p_table_owner, p_table_name, v_cons, p_constraint_type);

    --      IF v_cons.COUNT > 0 THEN
    --         FOR i IN v_cons.FIRST .. v_cons.LAST LOOP
    --            k := utl_desc.constraint_cols (p_table_owner, v_cons (i).constraint_name, v_cons_cols);

    --            IF p_spec THEN
    --               v_dummy_program_name :=
    --                  gen_qcc_spec (p_table_owner,
    --                                p_table_name,
    --                                v_cons (i).constraint_name,
    --                                v_cons_cols,
    --                                p_types_package_name,
    --                                p_lineas
    --                               );
    --               utl_line.app_line (';', p_lineas);
    --            ELSE
    --               gen_qcc_body (NULL,
    --                             p_table_owner,
    --                             p_table_name,
    --                             v_cons (i).constraint_name,
    --                             v_cons_cols,
    --                             p_types_package_name,
    --                             p_expand_cols,
    --                             p_lineas
    --                            );
    --            END IF;

    --            v_cons_cols.DELETE;
    --         END LOOP;
    --      END IF;

    --      v_cons.DELETE;
    --   EXCEPTION
    --      WHEN OTHERS THEN
    --         utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
    --         utl_error.informa (k_modulo);
    --   END gen_qcc_all_cons_by_puf;

    PROCEDURE gen_pkg_query_spec (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t)
    IS
        -- Constantes para identificar el package y el programa
        k_programa     CONSTANT fdc_defs.program_name_t := 'gen_pkg_query_spec';
        k_modulo       CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
        -- Variables
        v_dummy_program_name    fdc_defs.program_name_t;
    BEGIN
        IF utl_desc.constraint_exists (
               p_table_owner,
               p_table_name,
               utl_desc.k_coty_primary_key) THEN
               
            -- EXI: Genera función para verificar la existencia de un registro
            -- vía la PK
            if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_EXI_PK_RET_BOOL) then
                v_dummy_program_name :=
                    gen_exi_func_spec (
                        p_table_owner,
                        p_table_name,
                        p_types_package_name,
                        p_lineas);
                utl_line.app_line (';', p_lineas);
                utl_line.put_line (gat_defs.k_blank, p_lineas);
            end if;                
            
            -- CPK: Genera función para contar registros pos su PK (control)
            if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_CNT_PK_RET_NUM) then
                v_dummy_program_name :=
                    gen_cpk_spec (
                        p_table_owner,
                        p_table_name,
                        p_types_package_name,
                        p_lineas);
                utl_line.app_line (';', p_lineas);
                utl_line.put_line (gat_defs.k_blank, p_lineas);
            end if;
            
            -- QRR:PK Generar procedure qry por su PK, entrega un 
            -- registro por parámetro de salida
            if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QRR_PK_RET_REG) then
                gen_qrr_all_spec (
                    p_table_owner,
                    p_table_name,
                    utl_desc.k_coty_primary_key,
                    p_types_package_name,
                    p_lineas);
            end if;
            
            -- QRY: Genera una función de qry por su pk, retorna un registro
            if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QRY_PK_RET_REG) then
                v_dummy_program_name :=
                    gen_qry_spec (
                        p_table_owner,
                        p_table_name,
                        p_types_package_name,
                        p_lineas);
                utl_line.app_line (';', p_lineas);
                utl_line.put_line (gat_defs.k_blank, p_lineas);
            end if;
            
            -- QCC:PK Genera las consultas sobre la pk y retorna un cursor por referencia
            if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QCC_PK_RET_CUR) then
                gen_qcc_all_cons_by_puf_spec (
                    p_table_owner,
                    p_table_name,
                    p_lineas,
                    p_constraint_type      => utl_desc.k_coty_primary_key,
                    p_types_package_name   => p_types_package_name);
                utl_line.put_line (gat_defs.k_blank, p_lineas);
            end if;
            
        END IF;

        IF utl_desc.constraint_exists (
               p_table_owner,
               p_table_name,
               utl_desc.k_coty_unique_key) THEN
            -- QRR:UK Generar procedure qry por su pk, entrega un registro por parámetro de salida
            if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QRR_UK_OUT_REG) then
                gen_qrr_all_spec (
                    p_table_owner,
                    p_table_name,
                    utl_desc.k_coty_unique_key,
                    p_types_package_name,
                    p_lineas);
            end if;                    
        END IF;

        -- QCC:UK Genera las consultas sobre las uk, retornan un cursor ref
        if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QCC_UK_RET_CUR) then
            gen_qcc_all_cons_by_puf_spec (
                p_table_owner,
                p_table_name,
                p_lineas,
                p_constraint_type      => utl_desc.k_coty_unique_key,
                p_types_package_name   => p_types_package_name);
            utl_line.put_line (gat_defs.k_blank, p_lineas);
        end if;
        
        -- QCC:FK Genera las consultas sobre las fk. Retorna un cursor por referencia
        if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QCC_FK_OUT_CUR) then
            gen_qcc_all_cons_by_puf_spec (
                p_table_owner,
                p_table_name,
                p_lineas,
                p_constraint_type      => utl_desc.k_coty_foreing_key,
                p_types_package_name   => p_types_package_name);
            utl_line.put_line (gat_defs.k_blank, p_lineas);
        end if;

        -- QAL: Genera una funcion para obtener un cursor sin where (todos 
        -- los registros)
        if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QAL____RET_CUR) then
            v_dummy_program_name :=
                gen_qal_proc_spec (
                    p_table_owner,
                    p_table_name,
                    p_types_package_name,
                    p_lineas);
            utl_line.app_line (';', p_lineas);
            utl_line.put_line (gat_defs.k_blank, p_lineas);
        end if;
        
        -- QWC: Genera un procedimiento para obtener una colección en base a un query dinámico
        if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QWC____RET_CUR) then
            v_dummy_program_name :=
                gen_qwc_proc_spec (
                    p_table_owner,
                    p_table_name,
                    p_types_package_name,
                    p_lineas);
            utl_line.app_line (';', p_lineas);
            utl_line.put_line (gat_defs.k_blank, p_lineas);
        end if;

        -- QWT: Generar un procedimiento de query con where dinámico y entrega
        -- una tabla de records
        if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QWT____OUT_TAB) then
            v_dummy_program_name :=
                gen_qwt_proc_spec (
                    p_table_owner,
                    p_table_name,
                    p_types_package_name,
                    p_lineas);
            utl_line.app_line (';', p_lineas);
            utl_line.put_line (gat_defs.k_blank, p_lineas);
        end if;        

    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_pkg_query_spec;

    PROCEDURE gen_pkg_query_body (
        p_package_name          IN            dba_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_expand_cols           IN            BOOLEAN DEFAULT TRUE,
        p_lineas                IN OUT NOCOPY utl_line.lines_t)
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_pkg_query_body';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_gen_qp.k_package || '.' || k_programa ;
    BEGIN
        IF utl_desc.constraint_exists (
               p_table_owner,
               p_table_name,
               utl_desc.k_coty_primary_key) THEN
            
            -- EXI: Generar la funcion existe por pk
            if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_EXI_PK_RET_BOOL) then
                gen_exi_func_body (
                    p_package_name,
                    p_table_owner,
                    p_table_name,
                    p_types_package_name,
                    p_lineas);
                utl_line.put_line (gat_defs.k_blank, p_lineas);
            end if;


            -- CPK: Genera función para contar registros pos su PK (control)
            if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_CNT_PK_RET_NUM) then
                gen_cpk_func_body (
                    p_package_name,
                    p_table_owner,
                    p_table_name,
                    p_types_package_name,
                    p_lineas);
                utl_line.put_line (gat_defs.k_blank, p_lineas);
            end if;

            -- QRR:PK Generar procedure qry por su PK, entrega un 
            -- registro por parámetro de salida
            if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QRR_PK_RET_REG) then
                gen_qrr_all_body (
                    p_package_name,
                    p_table_owner,
                    p_table_name,
                    utl_desc.k_coty_primary_key,
                    p_types_package_name,
                    p_expand_cols,
                    p_lineas);
            end if;
            
            -- QRY: Genera una función de qry por su pk, retorna un registro
            if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QRY_PK_RET_REG) then
                gen_qry_body (
                    p_package_name,
                    p_table_owner,
                    p_table_name,
                    p_types_package_name,
                    p_expand_cols,
                    p_lineas);
                utl_line.put_line (gat_defs.k_blank, p_lineas);
            end if;
            
            -- QCC:PK Genera las consultas sobre la pk y retorna un cursor por referencia
            if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QCC_PK_RET_CUR) then
                gen_qcc_all_cons_by_puf_body (
                    p_package_name,
                    p_table_owner,
                    p_table_name,
                    p_lineas,
                    --p_spec                    => FALSE,
                    p_constraint_type      => utl_desc.k_coty_primary_key,
                    p_types_package_name   => p_types_package_name,
                    p_expand_cols          => p_expand_cols);
                utl_line.put_line (gat_defs.k_blank, p_lineas);
            end if;
        END IF;

        IF utl_desc.constraint_exists (
               p_table_owner,
               p_table_name,
               utl_desc.k_coty_unique_key) THEN
               
            -- QRR:UK Generar procedure qry por su pk, entrega un registro
            -- por parámetro de salida
            if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QRR_UK_OUT_REG) then
                gen_qrr_all_body (
                    p_package_name,
                    p_table_owner,
                    p_table_name,
                    utl_desc.k_coty_unique_key,
                    p_types_package_name,
                    p_expand_cols,
                    p_lineas);
            end if;                
        END IF;

        -- QCC:UK Genera las consultas sobe las UKi. Retorna un cursor por referencia 
        if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QCC_UK_RET_CUR) then
            gen_qcc_all_cons_by_puf_body (
                p_package_name,
                p_table_owner,
                p_table_name,
                p_lineas,
                p_constraint_type      => utl_desc.k_coty_unique_key,
                p_types_package_name   => p_types_package_name,
                p_expand_cols          => p_expand_cols);
            utl_line.put_line (gat_defs.k_blank, p_lineas);
        end if;
        
        -- QCC:FK Genera las consultas sobre las fk. Retorna un cursor por referencia
        if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QCC_FK_OUT_CUR) then
            gen_qcc_all_cons_by_puf_body (
                p_package_name,
                p_table_owner,
                p_table_name,
                p_lineas,
                p_constraint_type      => utl_desc.k_coty_foreing_key,
                p_types_package_name   => p_types_package_name,
                p_expand_cols          => p_expand_cols);
            utl_line.put_line (gat_defs.k_blank, p_lineas);
        end if;

        -- QAL: Obtiene un cursor via una consulta sin where es decir, todos los
        -- registros
        if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QAL____RET_CUR) then
            gen_qal_proc_body (
                p_package_name,
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_expand_cols,
                p_lineas);
            utl_line.put_line (gat_defs.k_blank, p_lineas);
        end if;

        -- QWC: Generar funcion de query con where dinámico y retorna un cursor
        if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QWC____RET_CUR) then
            gen_qwc_proc_body (
                p_package_name,
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_expand_cols,
                p_lineas);
            utl_line.put_line (gat_defs.k_blank, p_lineas);
        end if;
        
        -- QWT: Generar un procedimiento de query con where dinámico y entrega
        -- una tabla de records
        if GAT_SUBPROGRAMS.ACTIVE(GAT_SUBPROGRAMS.K_QWT____OUT_TAB) then
            gen_qwt_proc_body (
                p_package_name,
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_expand_cols,
                p_lineas);
            utl_line.put_line (gat_defs.k_blank, p_lineas);
        end if;            
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_pkg_query_body;
/*
   PROCEDURE gen_pkg_query_body (
      p_package_name   IN              dba_objects.object_name%TYPE,
      p_table_owner          IN              dba_objects.owner%TYPE,
      p_table_name     IN              dba_tables.table_name%TYPE,
      p_lineas         IN OUT NOCOPY   utl_line.lines_t
   )
   IS
      -- Constantes para identificar el package y el programa
      k_programa                CONSTANT fdc_defs.program_name_t := 'gen_pkg_query_body';
      k_modulo                  CONSTANT fdc_defs.module_name_t := gat_tab_gen_qp.k_package || '.' || k_programa;
   BEGIN
      IF utl_desc.constraint_exists (p_table_owner, p_table_name, utl_desc.k_coty_primary_key) THEN
         -- Generar funcion existe por pk
         gen_exi_func_body (p_package_name, p_table_owner, p_table_name, p_lineas);
         utl_line.put_line (gat_defs.k_blank, p_lineas);
         -- Generar funcion cuenta por PK
         gen_cpk_func_body (p_package_name, p_table_owner, p_table_name, p_lineas);
         utl_line.put_line (gat_defs.k_blank, p_lineas);
         -- Generar funcion de query via la pk
         gen_qry_body (p_package_name, p_table_owner, p_table_name, p_lineas);
         utl_line.put_line (gat_defs.k_blank, p_lineas);
         -- Genera las consultas sobe las PK

         gen_qcc_all_cons_by_puf (p_table_owner,
                                  p_table_name,
                                  p_lineas,
                                  p_spec =>                 FALSE,
                                  p_constraint_type =>      utl_desc.k_coty_primary_key
                                 );
         utl_line.put_line (gat_defs.k_blank, p_lineas);
      END IF;

      -- Genera las consultas sobe las AKi

      gen_qcc_all_cons_by_puf (p_table_owner,
                               p_table_name,
                               p_lineas,
                               p_spec =>                 FALSE,
                               p_constraint_type =>      utl_desc.k_coty_unique_key
                              );
      utl_line.put_line (gat_defs.k_blank, p_lineas);
      -- Genera las consultas sobre las fk

      gen_qcc_all_cons_by_puf (p_table_owner,
                               p_table_name,
                               p_lineas,
                               p_spec =>                 FALSE,
                               p_constraint_type =>      utl_desc.k_coty_foreing_key
                              );
      utl_line.put_line (gat_defs.k_blank, p_lineas);
      -- Generar funcion de query con where dinámico y retorna un cursor
      gen_qwc_proc_body (p_package_name, p_table_owner, p_table_name, p_lineas);
      utl_line.put_line (gat_defs.k_blank, p_lineas);
      -- Generar un procedimiento de query con where dinámico y entrega una tabla de records
      gen_qwt_proc_body (p_package_name, p_table_owner, p_table_name, p_lineas);
      utl_line.put_line (gat_defs.k_blank, p_lineas);
   EXCEPTION
      WHEN OTHERS THEN
         utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
         utl_error.informa (k_modulo);
   END gen_pkg_query_body;
*/
END gat_tab_gen_qp;
/
SHOW ERRORS;


