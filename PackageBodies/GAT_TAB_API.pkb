CREATE OR REPLACE PACKAGE BODY GAT.gat_tab_api
IS
    /*-----------------------------------------------------------------------------
    --
    --  Explora IT
    --  Proyecto: Utilidades para desarrolladores
    --  Objetivo: Procedimientos para generar un package de API de una tabla
    --
    -- Historia:
    -- Cuando      Quien    Comantario
    -- ----------- -------- -------------------------------------------------------
    -- 10-Feb-2003 mherrera Creación
    -- 14-Jul-2004 mherrert Se agrega funcionalidades y se normalza los nombres
    --                      para concordar con la nomenclatura de nombres de la
    --                      nomenclatura de nombres usado en Habitat.
    -- 08-Oct-2004 mherrera Modifica largo de identificadores a un máximo de 30
    --                      caracteres (Si el nombre de una columna o tabla está
    --                      definida con un largo mayor a 27 caracteres (27,28,29,30)
    --                      el proceso genera la API, pero no se lograba compilar
    --                      en forma exitosa ya que los nombres, en Oracle (default),
    --                      tienen un largo máximo de 30 caracteres. Esto implicó
    --                      modificar gran parte del código y muestra que el método
    --                      para generar los nombres de cualquier identificador es
    --                      bastante precario. Para una versión posterior se debe
    --                      modificar la forma de obtener los nombres vía una
    --                      función genérica.
    -- 11-Nov-2004 mherrera Agrega p_table_owner a gen_pks y gen_pkb para un futuro uso
    --                      de dba_tables an vez de user_tables
    -- 18-Nov-2004 mherrera Implementa el uso de las tablas dba_% en vez de las
                            all_% para permitir que un usuario genere las APIs de
                            otro esquema
    -- 23-Nov-2004 mherrera Modifica gen_qcc_spec para que el comentario este bien
                            formado
    -- 03-Dic-2004 mherrera 1) Agrega When others y utl_error a los programas
                            2) Agrega las intrucciones para generar el when others
                               y el handler de la excepcion vie el UTL_ERROR
                            3) Agrega con_<Constraints> para la PK y UK que
                               devuelven un Record Type, hasta antes de esta
                               modificación solo existia la consulta por la UK que
                               retorna un cursor, además, este nuevo procedimiento
                               deja obsoleta a la función Consulta_pk
    -----------------------------------------------------------------------------*/
    PROCEDURE gen_types_spec (
        p_table_owner      IN            dba_objects.owner%TYPE,
        p_table_name       IN            dba_tables.table_name%TYPE,
        p_package_owner    IN            all_users.username%TYPE,
        p_lineas           IN OUT NOCOPY utl_line.lines_t -- lineas
                                                         )
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_types_spec';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_api.k_package || '.' || k_programa ;
        -- Variables
        v_indx                 NUMBER (4);
        v_columns              utl_desc.dba_tab_columns_ct;
        n_cols                 NUMBER (3);
        v_column_name          dba_tab_columns.column_name%TYPE;
    BEGIN
        n_cols := utl_desc.table_cols (p_table_owner, p_table_name, v_columns);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Crea subtipo para cada columna de la tabla
        v_indx := v_columns.FIRST;

        WHILE v_indx IS NOT NULL LOOP
            v_column_name := LOWER (v_columns (v_indx).column_name);
            utl_line.put_line (
                REPLACE (
                    gat_defs.k_columna_subtype_def,
                    gat_defs.k_tabla,
                    p_table_name),
                p_lineas);
            utl_line.rep_curr (
                gat_defs.k_columna_nc,
                SUBSTR (v_column_name, 1, 28),
                p_lineas);
            utl_line.rep_curr (gat_defs.k_columna, v_column_name, p_lineas);
            v_indx := v_columns.NEXT (v_indx);
        END LOOP;

        utl_line.put_line (gat_defs.k_blank, p_lineas);
        -- Crea los tipos para tipo coleccion de cada columna
        v_indx := v_columns.FIRST;

        WHILE v_indx IS NOT NULL LOOP
            utl_line.put_line (
                REPLACE (
                    gat_defs.k_column_collection,
                    gat_defs.k_columna_nc,
                    SUBSTR (LOWER (v_columns (v_indx).column_name), 1, 27)),
                p_lineas);
            utl_line.rep_curr (
                gat_defs.k_columna_nc_sufix,
                SUBSTR (LOWER (v_columns (v_indx).column_name), 1, 28),
                p_lineas);
            v_indx := v_columns.NEXT (v_indx);
        END LOOP;

        v_columns.delete;
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_rec_type,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_sufix)),
            p_lineas);
        utl_line.rep_curr (gat_defs.k_tabla, p_table_name, p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_tab_type,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_sufix)),
            p_lineas);
        utl_line.rep_curr (gat_defs.k_tabla, p_table_name, p_lineas);
        utl_line.put_line (
            REPLACE (
                gat_defs.k_cur_type,
                gat_defs.k_tabla_nc,
                SUBSTR (p_table_name, 1, gat_defs.k_max_name_len_sufix)),
            p_lineas);
        utl_line.rep_curr (gat_defs.k_tabla, p_table_name, p_lineas);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_error.informa (k_modulo);
    END gen_types_spec;

    ----------------------------------------------------------------------------
    --                         Programas principaes                           --
    ----------------------------------------------------------------------------
    PROCEDURE gen_pks (
        p_prod_id               IN            gat_productos.prod_id%TYPE,
        p_autor                 IN            dba_users.username%TYPE,
        p_package_owner         IN            all_users.username%TYPE,
        p_package_type          IN            gat_tip_packages_tp.tpac_codigo_t, -- tipo de package a generar
        p_package_name          IN            all_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_lineas                   OUT NOCOPY utl_line.lines_t)
    IS
        -- Constantes para identificar el package y el programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_pks';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_api.k_package || '.' || k_programa ;
    -- Variables
    BEGIN
        utl_line.reset_level ();
        gat_utl.gen_pkg_header (
            p_prod_id,
            p_autor,
            p_package_owner,
            p_package_name,
            p_table_owner,
            p_table_name,
            p_lineas);
        utl_line.set_level (+1);

        utl_line.put_line (
            '-- Constantes para identificar el package',
            p_lineas);
        utl_line.put_line (
               q'<K_PACKAGE CONSTANT UTL_DEFS.NOMBRE_PACKAGE_T := '>'
            || p_package_name
            || q'<';>',
            p_lineas);

        --x := q'<K_PACKAGE CONSTANT UTL_DEFS.NOMBRE_PACKAGE_T := '>' || p_package_name || q'<';>';

        IF p_package_type = gat_tip_packages_kp.k_package_types THEN
            -- generar subtipos, record y tabla de registros de la tabla
            gen_types_spec (
                p_table_owner,
                p_table_name,
                p_package_owner,
                p_lineas);
        ELSIF p_package_type = gat_tip_packages_kp.k_package_queries THEN
            gat_tab_gen_qp.gen_pkg_query_spec (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        ELSIF p_package_type = gat_tip_packages_kp.k_package_changes THEN
            gat_tab_gen_cp.gen_pkg_change_spec (
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        END IF;

        utl_line.set_level (-1);
        /* cerrar el package */
        utl_line.put_line (
            REPLACE (
                gat_defs.k_package_end,
                gat_defs.k_nombre_package,
                p_package_name),
            p_lineas);
        utl_line.put_line ('/', p_lineas);
    --merge into GAT_OBJECTS_CATALOG PACO using (select

    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_pks;

    PROCEDURE gen_pkb (
        p_prod_id               IN            gat_productos.prod_id%TYPE,
        --p_proy                 IN            VARCHAR2, -- nombre del proyecto
        p_autor                 IN            dba_users.username%TYPE,
        p_package_owner         IN            all_users.username%TYPE,
        p_package_type          IN            gat_tip_packages_tp.tpac_codigo_t, -- tipo de package a generar
        p_package_name          IN            all_objects.object_name%TYPE,
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_expand_cols           IN            BOOLEAN DEFAULT TRUE,
        p_lineas                   OUT NOCOPY utl_line.lines_t)
    IS
        -- Constantes para identificar el package y programa
        k_programa    CONSTANT fdc_defs.program_name_t := 'gen_pkb';
        k_modulo      CONSTANT fdc_defs.module_name_t
            := gat_tab_api.k_package || '.' || k_programa ;
    -- Variables

    BEGIN
        utl_line.set_level (-utl_line.get_level);
        gat_utl.gen_pkg_header (
            p_prod_id,
            p_autor,
            p_package_owner,
            p_package_name,
            p_table_owner,
            p_table_name,
            p_lineas,
            'body');
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        utl_line.set_level (1);

        IF p_package_type = gat_tip_packages_kp.k_package_types THEN
            NULL; -- no hace nada ya que el type package no tiene body
        ELSIF p_package_type = gat_tip_packages_kp.k_package_queries THEN
            gat_tab_gen_qp.gen_pkg_query_body (
                p_package_name,
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_expand_cols,
                p_lineas);
        ELSIF p_package_type = gat_tip_packages_kp.k_package_changes THEN
            gat_tab_gen_cp.gen_pkg_change_body (
                p_package_name,
                p_table_owner,
                p_table_name,
                p_types_package_name,
                p_lineas);
        END IF;

        utl_line.set_level (-1);
        utl_line.put_line (gat_defs.k_blank, p_lineas);
        /* cerrar el package */
        utl_line.put_line (
            REPLACE (
                gat_defs.k_package_end,
                gat_defs.k_nombre_package,
                p_package_name),
            p_lineas);
        utl_line.put_line ('/', p_lineas);
    EXCEPTION
        WHEN OTHERS THEN
            utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
            utl_error.informa (k_modulo);
    END gen_pkb;
END gat_tab_api;
/
SHOW ERRORS;


