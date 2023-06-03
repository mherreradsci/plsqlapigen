CREATE OR REPLACE PACKAGE GAT.gat_compila
   AUTHID CURRENT_USER
IS
   /*
   Empresa:    Explora IT
   Proyecto:   Utiles
   Objetivo:   Compila código en el esquema donde se ejecuta esta utilidad

   Historia    Quien    Descripción
   ----------- -------- -----------------------------------------------------------
   15-Feb-2009 mherrert Creación
   07-Feb-2012 mherrert Agrega AUTHID CURRENT_USER para que los packages se 
                        puedan compilar en el mismo esquema que el usuario
                        que está ejecutando el generador
   */
   k_package   CONSTANT VARCHAR2 (30) := 'GAT_COMPILA';

   --*
   PROCEDURE compila_codigo (p_lineas utl_line.lines_t);
END gat_compila;
/
SHOW ERRORS;


