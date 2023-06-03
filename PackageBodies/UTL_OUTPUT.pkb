CREATE OR REPLACE PACKAGE BODY GAT.utl_output IS
   PROCEDURE put_line (
      p_linea         IN   VARCHAR2,
      p_largo_linea   IN   NUMBER DEFAULT k_max_line_length
   ) IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT VARCHAR2 (30)   := UPPER ('put_line');
      k_modulo     CONSTANT VARCHAR2 (61)   := SUBSTR (k_package || '.' || k_programa, 1, 61);
      -- Variables
      v_len                 PLS_INTEGER     := LEAST (p_largo_linea, k_max_line_length);
      v_len2                PLS_INTEGER;
      v_chr10               PLS_INTEGER;
      v_str                 VARCHAR2 (2000);
   BEGIN
      IF LENGTH (p_linea) > v_len THEN
         v_chr10 := INSTR (p_linea, CHR (10));

         IF v_chr10 > 0 AND v_len >= v_chr10 THEN
            v_len := v_chr10 - 1;
            v_len2 := v_chr10 + 1;
         ELSE
            v_len := v_len - 1;
            v_len2 := v_len;
         END IF;

         v_str := SUBSTR (p_linea, 1, v_len);
         DBMS_OUTPUT.put_line (v_str);
         put_line (SUBSTR (p_linea, v_len2), p_largo_linea);
      ELSE
         DBMS_OUTPUT.put_line (p_linea);
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.ENABLE (1000000);
         DBMS_OUTPUT.put_line (v_str);
   END put_line;
END utl_output;
/
SHOW ERRORS;


