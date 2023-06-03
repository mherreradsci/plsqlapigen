CREATE OR REPLACE PACKAGE GAT.utl_write
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     UTL_WRITE
Proposito:  <Defina brevemente el objetivo del package>

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
26-Feb-2012 mherrera Creación
13-Jul-2012 mherrera Agrega parametro p_location a write_file
*******************************************************************************/
AS
   -- Constantes para identificar el package
   k_package   CONSTANT fdc_defs.package_name_t := 'UTL_WRITE';

   --* Subtipos, Tipos, Constantes del package

   --* Procedimientos y funciones

   PROCEDURE write_file (p_location         IN VARCHAR2,
                         p_file_name        IN VARCHAR2,
                         p_file_extension   IN VARCHAR2,
                         p_lines            IN utl_line.lines_t);
END utl_write;
/
SHOW ERRORS;


