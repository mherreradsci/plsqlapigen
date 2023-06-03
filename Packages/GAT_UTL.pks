CREATE OR REPLACE PACKAGE GAT.gat_utl
IS
    /*
    Empresa:    Explora-IT
    Proyecto:   Utilidades para desarrolladores PL/SQL
    Objetivo:   Utilidades generales para generar packages de APIs para tablas

    Historia    Quien    Descripción
    ----------- -------- -------------------------------------------------------------
    03-Dic-2004 mherrera Creación
    06-Feb-2012 mherrera Agrega gen_package_name
    10-Feb-2012 mherrera Agrega get_table_short_name
    25-mar-2012 mherrera Agrega is_audit_column
    */

    -- Constantes para identificar el package
    k_package          CONSTANT fdc_defs.package_name_t := 'GAT_UTL';

    -- Procedimientos y funciones

    --* Get Table Short Name
    --* *************************************************************************
    ue_shortname_unavailable    EXCEPTION;
    PRAGMA EXCEPTION_INIT (ue_shortname_unavailable, -20500);

    FUNCTION is_audit_column (
        p_column_name IN dba_tab_columns.column_name%TYPE)
        RETURN BOOLEAN;

    FUNCTION get_table_short_name (
        p_table_owner    IN dba_objects.owner%TYPE,
        p_table_name     IN dba_tables.table_name%TYPE)
        RETURN VARCHAR2; -- raise ue_shortname_unavailable

    --* Gen package name
    --* *************************************************************************
    FUNCTION gen_package_name (
        p_package_prefix    IN VARCHAR2,
        p_table_name        IN VARCHAR2,
        p_package_type      IN VARCHAR2)
        RETURN fdc_defs.package_name_t;

    FUNCTION gen_program_name (
        p_proc_name             IN VARCHAR2,
        p_subtitution_source    IN VARCHAR2,
        p_name                  IN VARCHAR2)
        RETURN fdc_defs.program_name_t;

    PROCEDURE gen_id_block (
        p_package_name      IN            dba_objects.object_name%TYPE,
        p_program_name      IN            dba_objects.object_name%TYPE,
        p_exception_name    IN            VARCHAR2 DEFAULT NULL,
        p_lineas            IN OUT NOCOPY utl_line.lines_t);

    PROCEDURE gen_exeption_block (
        p_package_name      IN            dba_objects.object_name%TYPE,
        p_program_name      IN            dba_objects.object_name%TYPE,
        p_exception_name    IN            VARCHAR2 DEFAULT NULL,
        p_lineas            IN OUT NOCOPY utl_line.lines_t -- lineas
                                                          );

    -- Descripción: Genera parámetros de la forma p_<columna>  <tabla>_TP.<columna>_t
    -- Uso: Se usa para generar una lista de parámetros a partir de una lista de columnas
    -- que pertenecen a algún constraint, lo típico es su uso para genera la lista
    -- de parámetros correspondiente a la pk
    PROCEDURE gen_param_list (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_cons_cols             IN            utl_desc.dba_cons_columns_ct,
        p_lineas                IN OUT NOCOPY utl_line.lines_t,
        p_default_value         IN            gat_defs.default_value_t DEFAULT gat_defs.k_deva_db_default);

    -- Descripción: genera lista de variables/parámetros de la forma
    --    p_<columna>  <tabla>_TP.<columna>_t [DEFAULT NULL], ...
    -- a partir de las columnas que vienen en p_cols
    PROCEDURE gen_param_list (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_colums                IN            utl_desc.dba_tab_columns_ct, -- Lista de columnas.
        p_lineas                IN OUT NOCOPY utl_line.lines_t,
        p_sufijo_tipo           IN            VARCHAR2 DEFAULT gat_defs.k_sufijo_subtype,
        p_default_value         IN            gat_defs.default_value_t DEFAULT gat_defs.k_deva_db_default);

    PROCEDURE gen_param_list_sufijo_ct (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_colums                IN            utl_desc.dba_tab_columns_ct, -- Lista de columnas.
        p_lineas                IN OUT NOCOPY utl_line.lines_t);

    -- Descripción: genera lista de variables de la forma
    --    v_<columna_1>  <tabla>_TP.<columna>_t;
    --    v_<columna_2>  <tabla>_TP.<columna>_t;
    --    ...
    -- a partir de las columnas que vienen en p_cols
    PROCEDURE gen_vars_columns_list (
        p_table_owner           IN            dba_objects.owner%TYPE,
        p_table_name            IN            dba_tables.table_name%TYPE,
        p_types_package_name    IN            all_objects.object_name%TYPE,
        p_cols                  IN            utl_desc.dba_tab_columns_ct, -- Lista de columnas.
        p_lineas                IN OUT NOCOPY utl_line.lines_t,
        p_prefijo               IN            VARCHAR2 DEFAULT gat_defs.k_prefijo_var,
        p_tipo                  IN            VARCHAR2 DEFAULT gat_defs.k_sufijo_subtype);

    -- Genera lista de las columnas de forma [<p_prefijo>_]<columna>, ...
    PROCEDURE gen_col_list (
        p_table_owner     IN            dba_objects.owner%TYPE,
        p_table_name      IN            dba_tables.table_name%TYPE,
        p_lineas          IN OUT NOCOPY utl_line.lines_t,
        p_tipo_prefijo    IN            gat_defs.tipo_prefijo_lista_cols_t DEFAULT NULL,
        p_prefijo         IN            VARCHAR2 DEFAULT NULL,
        p_subindice       IN            VARCHAR2 DEFAULT NULL);

    PROCEDURE gen_where_list (
        p_cons_cols    IN            utl_desc.dba_cons_columns_ct,
        p_lineas       IN OUT NOCOPY utl_line.lines_t);

    PROCEDURE gen_select_sin_where (
        p_table_owner    IN            dba_objects.owner%TYPE,
        p_table_name     IN            dba_tables.table_name%TYPE,
        p_expand_cols    IN            BOOLEAN DEFAULT TRUE,
        p_lineas         IN OUT NOCOPY utl_line.lines_t);

    FUNCTION columns_for_update (
        p_table_owner    IN dba_objects.owner%TYPE,
        p_table_name     IN dba_tables.table_name%TYPE)
        RETURN BOOLEAN;

    PROCEDURE gen_cursor_where_puf (
        p_table_owner        IN            dba_objects.owner%TYPE,
        p_table_name         IN            dba_tables.table_name%TYPE,
        p_constraint_name    IN            dba_constraints.constraint_name%TYPE,
        p_expand_cols        IN            BOOLEAN DEFAULT TRUE,
        p_lineas             IN OUT NOCOPY utl_line.lines_t);

    PROCEDURE gen_create_pkg_header (
        p_package_owner    IN            all_users.username%TYPE,
        p_package_name     IN            VARCHAR2,
        p_lineas           IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_is_body          IN            BOOLEAN);

    PROCEDURE gen_pkg_header (
        p_prod_id          IN            gat_productos.prod_id%TYPE,
        p_quien            IN            VARCHAR2, -- nombre del que genera (iniciales)
        p_package_owner    IN            all_users.username%TYPE,
        p_package_name     IN            VARCHAR2,
        p_table_owner      IN            all_users.username%TYPE,
        p_table_name       IN            dba_tables.table_name%TYPE, -- tabla
        p_lineas           IN OUT NOCOPY utl_line.lines_t, -- lineas
        p_body             IN            VARCHAR2 DEFAULT NULL);
END gat_utl;
/
SHOW ERRORS;


