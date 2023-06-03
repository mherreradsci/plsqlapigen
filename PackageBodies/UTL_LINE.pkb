CREATE OR REPLACE PACKAGE BODY GAT.utl_line
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
27-May-2009 mherrera modifica put_line para el caso en que p_linea es null
02-Mar-2012 mherrera agrega reset_level
------------------------------------------------------------------------------*/

IS
    k_indent    CONSTANT NUMBER (1) := 3; -- indentacion de 3 blancos
    vg_level             NUMBER (3) := 0; -- nivel de indentacion

    PROCEDURE set_level ( -- incrementa la indentación en p_num
                         p_num IN NUMBER DEFAULT 1)
    IS
    BEGIN
        vg_level := vg_level + p_num;
    END set_level;

    FUNCTION get_level
        RETURN NUMBER
    IS
    BEGIN
        RETURN vg_level;
    END get_level;

    PROCEDURE reset_level (p_level IN NUMBER DEFAULT 0)
    IS
    BEGIN
        vg_level := p_level;
    END reset_level;

    FUNCTION indent ( -- retorna un string con v_indent * k_indent blancos
                     p_level IN NUMBER)
        RETURN line_t
    IS
        v_line    line_t;
    BEGIN
        v_line := RPAD (' ', k_indent * p_level);
        RETURN v_line;
    END indent;

    PROCEDURE put_line (p_line IN line_t, p_lines IN OUT NOCOPY lines_t)
    IS
    BEGIN
        -- MHT: 27-May-2009:
        -- En Oracle 10g R2 (Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - Prod)
        -- sobre Centos 5.3 si p_line es null
        -- la sentencia "p_lines (p_lines.COUNT + 1.0) := indent (vg_level) || p_line;"
        -- causa un error repitiendo la penúltima línea, así que se implementa
        -- nvl(p_line, ' ');
        p_lines (p_lines.COUNT + 1.0) := indent (vg_level) || NVL (p_line, ' ');
    END put_line;

    PROCEDURE put_line (p_lines_from IN lines_t, p_lines IN OUT NOCOPY lines_t)
    IS
    BEGIN
        IF p_lines_from IS NOT NULL THEN
            FOR i IN p_lines_from.FIRST .. p_lines_from.LAST LOOP
                put_line (p_lines_from (i), p_lines);
            END LOOP;
        END IF;
    END put_line;

    PROCEDURE put_line (
        p_line     IN            static_lines_t,
        p_lines    IN OUT NOCOPY lines_t)
    IS
    BEGIN
        IF p_line IS NOT NULL THEN
            FOR i IN p_line.FIRST .. p_line.LAST LOOP
                put_line (p_line (i), p_lines);
            END LOOP;
        END IF;
    END put_line;

    PROCEDURE app_line (p_line line_t, p_lines IN OUT NOCOPY lines_t)
    IS
    BEGIN
        p_lines (p_lines.COUNT) := p_lines (p_lines.COUNT) || p_line;
    END app_line;

    FUNCTION curr_line (p_lines IN OUT NOCOPY lines_t)
        RETURN NUMBER
    IS
    BEGIN
        RETURN p_lines.COUNT;
    END curr_line;

    PROCEDURE rep_curr (
        p_name         IN            VARCHAR2,
        p_val          IN            VARCHAR2,
        p_lines        IN OUT NOCOPY lines_t,
        p_from_line    IN            NUMBER DEFAULT NULL,
        p_to_line      IN            NUMBER DEFAULT NULL)
    IS
    BEGIN
        IF p_from_line IS NULL THEN -- last line
            p_lines (p_lines.LAST) :=
                REPLACE (p_lines (p_lines.LAST), p_name, p_val);
        ELSE
            FOR i IN p_from_line .. p_to_line LOOP
                p_lines (i) := REPLACE (p_lines (i), p_name, p_val);
            END LOOP;
        END IF;
    END rep_curr;

    -- Retorna el número de linea donde es encontrado 
    -- el string p_string_to_search. Equivalente al INSTR pero en 
    -- vez de posición, es la línea 
    FUNCTION inline (
        p_string_to_search    IN VARCHAR2,
        p_lines               IN lines_t,
        p_from_line           IN NUMBER DEFAULT 1,
        p_to_line             IN NUMBER DEFAULT NULL)
        RETURN PLS_INTEGER
    IS
        v_last_white_space    PLS_INTEGER;
    BEGIN
        IF p_lines.COUNT = 0 THEN
            RETURN 0;
        END IF;

        FOR i IN p_from_line .. (CASE WHEN p_to_line IS NULL THEN p_lines.LAST ELSE p_to_line END) LOOP
            IF INSTR (p_lines (i), p_string_to_search) > 0 THEN
                RETURN i;
            END IF;
        END LOOP;

        RETURN 0.0;
    END inline;

    PROCEDURE replace_insert (
        p_name          IN            VARCHAR2,
        p_lines_from    IN            lines_t,
        p_lines         IN OUT NOCOPY lines_t)
    IS
        v_line_no    PLS_INTEGER;
        v_line       line_t;
    BEGIN
        IF p_lines_from.COUNT = 0 THEN
            RETURN;
        END IF;

        v_line_no := p_lines.LAST;

        IF INSTR (p_lines (v_line_no), p_name) = 0 THEN
            RETURN;
        END IF;

        v_line := p_lines (v_line_no);

        FOR i IN p_lines_from.FIRST .. p_lines_from.LAST LOOP
            p_lines (v_line_no) := REPLACE (v_line, p_name, p_lines_from (i));
            v_line_no := v_line_no + 1.0;
        END LOOP;
    END replace_insert;

    FUNCTION extract_lines (
        p_lines    IN lines_t,
        p_from     IN PLS_INTEGER,
        p_to       IN PLS_INTEGER) -- MHT: Mejor un procedure ?
        RETURN lines_t
    IS
        v_lines    lines_t;
    BEGIN
        IF p_from > p_lines.COUNT THEN
            RETURN v_lines;
        END IF;

        FOR i IN p_from .. p_to LOOP
            v_lines (i) := p_lines (i);
        END LOOP;

        RETURN v_lines;
    END extract_lines;

    PROCEDURE append_lines (
        p_from_lines    IN            lines_t,
        p_lines         IN OUT NOCOPY lines_t)
    IS
    BEGIN
        IF p_from_lines.COUNT > 0 THEN
            FOR i IN p_from_lines.FIRST .. p_from_lines.LAST LOOP
                p_lines (p_lines.LAST + 1) := p_from_lines (i);
            END LOOP;
        END IF;
    END append_lines;

    PROCEDURE put_wraped (
        p_string      IN            VARCHAR2,
        p_lineas      IN OUT NOCOPY utl_line.lines_t,
        p_line_len    IN            NUMBER DEFAULT 80,
        p_compress    IN            BOOLEAN DEFAULT TRUE,
        p_line_prefix IN            varchar2)
    -------------------------------------------------------------------------
    -- Output procedure that inserts line breaks into lines
    -------------------------------------------------------------------------
    IS
        v_curr_pos            INTEGER;
        v_length              INTEGER;
        v_printed_to          INTEGER;
        v_last_white_space    INTEGER;
        skipping_ws           BOOLEAN;
        c_len        CONSTANT INTEGER := p_line_len;
        ------------------------------------------------------
        -- All 3 variables must be modified at the same time.
        c_max_len    CONSTANT INTEGER := 10000;
        v_string              VARCHAR2 (10002);
        ------------------------------------------------------
        nl           CONSTANT VARCHAR2 (3) := CHR (10);
        cr           CONSTANT VARCHAR2 (3) := CHR (13);
        v_len_total           INTEGER;
    BEGIN
        -------------------------------------------------------------------------
        -- Case 1: Null string.
        -------------------------------------------------------------------------
        IF (p_string IS NULL) THEN
            p_lineas (p_lineas.LAST + 1) := NULL;
            RETURN;
        END IF;

        -------------------------------------------------------------------------
        -- Case 2: Recursive calls for very long strings! (hard line breaks)
        -------------------------------------------------------------------------
        v_len_total := LENGTH (p_string);

        IF (v_len_total > c_max_len) THEN
            put_wraped (
                SUBSTR (p_string, 1, c_max_len),
                p_lineas,
                p_line_len,
                p_compress,
                p_line_prefix);
            put_wraped (
                SUBSTR (p_string, c_max_len + 1, v_len_total - c_max_len),
                p_lineas,
                p_line_len,
                p_compress,
                p_line_prefix);
            RETURN;
        END IF;

        -------------------------------------------------------------------------
        -- Case 3: Regular start here.
        -------------------------------------------------------------------------
        v_string := p_string;

        -------------------------------------------------------------------------
        -- Remove EOL characters!
        -------------------------------------------------------------------------
        IF (p_compress) --compressed mode
                       THEN
            --
            -- Strip all linefeed characters
            --
            v_string := REPLACE (v_string, CHR (10), ' '); --New Line
            v_string := REPLACE (v_string, CHR (13), ' '); --Carriage Return
        ELSE
            --
            -- Strip only last linefeed characters
            --
            v_string := RTRIM (v_string, CHR (10)); --New Line
            v_string := RTRIM (v_string, CHR (13)); --Carriage Return
        END IF;

        --------------------------------------------------------------------------
        -- Main algorithm
        --------------------------------------------------------------------------
        v_length := LENGTH (v_string);
        v_curr_pos := 1; -- current position (Start with 1.ch.)
        v_printed_to := 0; -- string was printed to this mark
        v_last_white_space := 0; -- position of last blank
        skipping_ws := TRUE; -- remember if blanks may be skipped

        WHILE v_curr_pos <= v_length LOOP
            IF SUBSTR (v_string, v_curr_pos, 1) = ' ' -- blank found
                                                     THEN
                v_last_white_space := v_curr_pos;

                ----------------------------------------
                -- if in compress mode, skip any blanks
                ----------------------------------------
                IF (    p_compress
                    AND skipping_ws) THEN
                    v_printed_to := v_curr_pos;
                END IF;
            ELSE
                skipping_ws := FALSE;
            END IF;

            IF (v_curr_pos >= (v_printed_to + c_len)) THEN
                IF (   (v_last_white_space <= v_printed_to) -- 1) no blank found
                    OR -- 2) next char is blank
                       --    (ignore last blank)
                     (    (v_curr_pos < v_length)
                      AND (SUBSTR (v_string, v_curr_pos + 1, 1) = ' '))
                    OR (v_curr_pos = v_length) -- 3) end of string
                                              ) THEN
                    -------------------------------------
                    -- Hard break (no blank found)
                    -------------------------------------

                    put_line (
                        p_line_prefix || SUBSTR (
                            v_string,
                            v_printed_to + 1,
                            v_curr_pos - v_printed_to),
                        p_lineas);
                    v_printed_to := v_curr_pos;
                    skipping_ws := TRUE;
                ELSE
                    ----------------------------------
                    -- Line Break on last blank
                    ----------------------------------
                    put_line (
                        p_line_prefix || SUBSTR (
                            v_string,
                            v_printed_to + 1,
                            v_last_white_space - v_printed_to),
                        p_lineas);

                    v_printed_to := v_last_white_space;

                    IF (v_last_white_space = v_curr_pos) THEN
                        skipping_ws := TRUE;
                    END IF;
                END IF;
            END IF;

            v_curr_pos := v_curr_pos + 1;
        END LOOP;
        
        if length(p_line_prefix) = 0 then
            utl_line.put_line (SUBSTR (v_string, v_printed_to + 1), p_lineas);
        else
            utl_line.put_line (p_line_prefix || SUBSTR (v_string, v_printed_to + 1), p_lineas);
        end if;
    END put_wraped;

    -- Reemplaza un valor en una posición intermedia de p_lines con las
    -- líneas que vienen en p_lines_from
    PROCEDURE replace_and_embed (
        p_name          IN            VARCHAR2,
        p_lines_from    IN            lines_t,
        p_lines         IN OUT NOCOPY lines_t,
        p_from_line     IN            NUMBER DEFAULT NULL)
    IS
        v_line_no        PLS_INTEGER;
        v_from           PLS_INTEGER;
        v_to             PLS_INTEGER;
        v_line           line_t;
        v_lines_aux      lines_t;
        --
        v_secure_loop    NUMBER (10);
    BEGIN
        IF p_from_line IS NULL THEN -- last line
            replace_insert (
                p_name         => p_name,
                p_lines_from   => p_lines_from,
                p_lines        => p_lines);
        ELSE -- Inserta entremedio de una posición
            v_from := p_from_line;
            v_to := p_lines.LAST;

            v_secure_loop := 0;

           <<ll_loop>>
            WHILE TRUE LOOP
                v_secure_loop := v_secure_loop + 1.0;

                v_line_no :=
                    inline (
                        p_name,
                        p_lines,
                        v_from,
                        v_to);

                EXIT ll_loop WHEN    v_line_no = 0
                                  OR v_secure_loop > 20000;

                v_lines_aux :=
                    extract_lines (p_lines, v_line_no + 1, p_lines.LAST);

                p_lines.delete (v_line_no + 1, p_lines.LAST);

                replace_insert (
                    p_name         => p_name,
                    p_lines_from   => p_lines_from,
                    p_lines        => p_lines);

                append_lines (v_lines_aux, p_lines);

                v_from := v_line_no + p_lines_from.COUNT;
                v_to := p_lines.LAST;
            END LOOP ll_loop;
        --*

        END IF;
    END replace_and_embed;

    PROCEDURE spool_out (p_lines IN OUT NOCOPY lines_t)
    IS
        k_programa    CONSTANT VARCHAR2 (30) := UPPER ('spool_out');
        k_modulo      CONSTANT VARCHAR2 (61)
            := SUBSTR (k_package || '.' || k_programa, 1, 61) ;
    BEGIN
        IF p_lines IS NOT NULL THEN
            IF p_lines.COUNT > 0 THEN
                FOR i IN p_lines.FIRST .. p_lines.LAST LOOP
                    utl_output.put_line (p_lines (i));
                END LOOP;
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            utl_error.informa (
                p_programa   => k_modulo,
                p_mensaje    => SQLERRM,
                p_rollback   => FALSE,
                p_raise      => TRUE);
    END spool_out;
END utl_line;
/
SHOW ERRORS;


