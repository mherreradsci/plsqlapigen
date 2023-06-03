CREATE OR REPLACE PACKAGE BODY GAT.utl_write
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     UTL_WRITE
Proposito:  Utilidades para encapsular la escritura de archivos

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
26-Feb-2012 mherrera Creación
13-Jul-2012 mherrera Agrega parametro p_location a write_file
*******************************************************************************/
AS
   --* Variables, constantes, tipos y subtipos locales

   --* Procedimientos y funciones

   PROCEDURE write_file (p_location         IN VARCHAR2,
                         p_file_name        IN VARCHAR2,
                         p_file_extension   IN VARCHAR2,
                         p_lines            IN utl_line.lines_t)
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'write_file';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
      -- Variables, constantes, tipos y subtipos locales

      v_ft                  UTL_FILE.file_type;
   BEGIN
      --*
      --* Implementación.
      IF p_location IS NULL
      THEN
         raise_application_error (-20330, 'No existe locacion en los valores generales');
      END IF;

      --*
      v_ft :=
         UTL_FILE.fopen (location  => p_location,
                         filename  => p_file_name || '.' || p_file_extension,
                         open_mode => 'w');

      IF p_lines.COUNT = 0.0
      THEN
         RETURN;
      END IF;

      FOR i IN p_lines.FIRST .. p_lines.LAST LOOP
         UTL_FILE.put_line (v_ft, p_lines (i));
      END LOOP;

      IF UTL_FILE.is_open (v_ft)
      THEN
         UTL_FILE.fclose (v_ft);
      END IF;
   --* Fin Implementación
   --*
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa => k_modulo,
                            p_mensaje  => SQLERRM,
                            p_rollback => FALSE,
                            p_raise    => TRUE);
   END write_file;
END utl_write;
/
SHOW ERRORS;


