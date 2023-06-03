CREATE OR REPLACE PACKAGE BODY GAT.gat_compila
IS
   /*
   Empresa:    Explora IT
   Proyecto:   Utiles
   Objetivo:   Compila código en el esquema donde se ejecuta esta utilidad

   Historia    Quien    Descripción
   ----------- -------- -----------------------------------------------------------
   15-Feb-2009 mherrert Creación
   07-Feb-2012 mherrert Comenta la line "DBMS_OUTPUT.put_line ('--###---:' || v_lineas (i));"
   */
   PROCEDURE compila_codigo (p_lineas utl_line.lines_t)
   IS
      k_programa   CONSTANT VARCHAR2 (30) := UPPER ('compila_codigo');
      k_modulo     CONSTANT VARCHAR2 (61)
                               := SUBSTR (k_package || '.' || k_programa, 1, 61) ;
      --*
      v_lineas              DBMS_SQL.varchar2s;
      cur                   BINARY_INTEGER := DBMS_SQL.open_cursor;
   BEGIN
      IF p_lineas IS NOT NULL
      THEN
         --v_lineas := p_lineas;
         FOR i IN p_lineas.FIRST .. p_lineas.LAST LOOP
            --v_lineas (i) := SUBSTR (p_lineas (i), 1, 255);
            v_lineas (i) := p_lineas (i);
            --DBMS_OUTPUT.put_line ('--###---:' || v_lineas (i));
         END LOOP;

         DBMS_SQL.parse (c               => cur,
                         statement       => v_lineas,
                         lb              => v_lineas.FIRST,
                         ub              => v_lineas.LAST - 1,
                         lfflg           => TRUE,
                         language_flag   => DBMS_SQL.native);
         DBMS_SQL.close_cursor (cur);
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
         DBMS_SQL.close_cursor (cur);
         utl_error.informa (k_modulo);
   END compila_codigo;
END gat_compila;
/
SHOW ERRORS;


