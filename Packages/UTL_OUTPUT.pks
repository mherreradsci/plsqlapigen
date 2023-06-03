CREATE OR REPLACE PACKAGE GAT.utl_output IS
/*
Empresa:    A.F.P. Habitat S.A.
Proyecto:   Utilitarios Generales
Objetivo:   Implementa un put_line equivalente al dbms_outut.put_line sin la
            restricción de 255 bytes

Historia    Quien    Descripción
----------- -------- -------------------------------------------------------------
29-Nov-2004 mherrert Creación
*/

   -- Constantes para identificar el package
   k_package    CONSTANT VARCHAR2 (30) := UPPER ('utl_output');
   -- Constantes
   k_blank_ch   CONSTANT VARCHAR2 (1)  := CHR (32);
   k_max_line_length     NUMBER (3)    := 255;

   PROCEDURE put_line (
      p_linea         IN   VARCHAR2,
      p_largo_linea   IN   NUMBER DEFAULT k_max_line_length
   );
END utl_output;
/
SHOW ERRORS;


