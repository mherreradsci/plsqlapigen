CREATE OR REPLACE PACKAGE GAT.utl_line
/*------------------------------------------------------------------------------
Empresa: Explora IT
Proyecto: Utilidades para desarrolladores
Objetivo: Procedimientos para generar lineas indentadas

Historia:
Cuando      Quien    Comantario
----------- -------- -----------------------------------------------------------
10-Feb-2003 mherrera Ingreso a control de configuración
05-Feb-2009 mherrera Agrega put_line de colección a colección
05-Feb-2009 mherrera Modifica rep_curr para reemplazar en un
                     rango desde .. hasta
03-Feb-2012 mherrera agrega constante k_package y spool_out
08-feb-2012 mherrera agrega put_wraped y replace_and_embed
02-Mar-2012 mherrera agrega reset_level
------------------------------------------------------------------------------*/
IS
    k_package    CONSTANT VARCHAR2 (30) := UPPER ('UTL_LINE');

    -- subtypes
    SUBTYPE line_t IS VARCHAR2 (2000);

    TYPE lines_t IS TABLE OF line_t
        INDEX BY BINARY_INTEGER;

    TYPE static_lines_t IS TABLE OF line_t;

    PROCEDURE set_level ( -- incrementa la indentación en p_num
                         p_num IN NUMBER DEFAULT 1);

    FUNCTION get_level
        RETURN NUMBER;

    PROCEDURE reset_level (p_level IN NUMBER DEFAULT 0);

    FUNCTION curr_line (p_lines IN OUT NOCOPY lines_t)
        RETURN NUMBER;

    PROCEDURE put_line (p_line IN line_t, p_lines IN OUT NOCOPY lines_t);

    PROCEDURE put_line (p_lines_from IN lines_t, p_lines IN OUT NOCOPY lines_t);

    PROCEDURE put_line (
        p_line     IN            static_lines_t,
        p_lines    IN OUT NOCOPY lines_t);

    PROCEDURE app_line (p_line IN line_t, p_lines IN OUT NOCOPY lines_t);

    FUNCTION inline (
        p_string_to_search    IN VARCHAR2,
        p_lines               IN lines_t,
        p_from_line           IN NUMBER DEFAULT 1,
        p_to_line             IN NUMBER DEFAULT NULL)
        RETURN PLS_INTEGER;

    /*
    *  Reemplaza un comodin en un conjunto de lineas
    *  definidas por p_from_line .. p_to_line
    */
    PROCEDURE rep_curr (
        p_name         IN            VARCHAR2,
        p_val          IN            VARCHAR2,
        p_lines        IN OUT NOCOPY lines_t,
        p_from_line    IN            NUMBER DEFAULT NULL,
        p_to_line      IN            NUMBER DEFAULT NULL);

    PROCEDURE put_wraped (
        p_string      IN            VARCHAR2,
        p_lineas      IN OUT NOCOPY utl_line.lines_t,
        p_line_len    IN            NUMBER DEFAULT 80,
        p_compress    IN            BOOLEAN DEFAULT TRUE,
        p_line_prefix IN            varchar2);

    PROCEDURE replace_and_embed (
        p_name          IN            VARCHAR2,
        p_lines_from    IN            lines_t,
        p_lines         IN OUT NOCOPY lines_t,
        p_from_line     IN            NUMBER DEFAULT NULL);

    PROCEDURE spool_out (p_lines IN OUT NOCOPY lines_t);

    -- Solo temporal
    -- MHT: Mejor un procedure ?
    FUNCTION extract_lines (
        p_lines    IN lines_t,
        p_from     IN PLS_INTEGER,
        p_to       IN PLS_INTEGER)
        RETURN lines_t;

    PROCEDURE append_lines (
        p_from_lines    IN            lines_t,
        p_lines         IN OUT NOCOPY lines_t);        
END utl_line;
/
SHOW ERRORS;


