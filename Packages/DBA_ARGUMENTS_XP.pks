CREATE OR REPLACE PACKAGE GAT.dba_arguments_xp
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     DBA_ARGUMENTS_XP
Proposito:  eXtensiones para dba_arguments

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
02-Mar-2012 mherrera Creación
*******************************************************************************/
AS
   -- Constantes para identificar el package
   k_package   CONSTANT fdc_defs.package_name_t := 'DBA_ARGUMENTS_XP';

   --* Subtipos, Tipos, Constantes del package

   --* Procedimientos y funciones
   FUNCTION has_a_paramter (p_arguments IN dba_arguments_tp.dba_arguments_ct)
      RETURN BOOLEAN;

   FUNCTION is_fnc (p_arguments IN dba_arguments_tp.dba_arguments_ct)
      RETURN BOOLEAN;

   FUNCTION is_fnc_with_ref_cursor (p_arguments IN dba_arguments_tp.dba_arguments_ct)
      RETURN BOOLEAN;
     
END dba_arguments_xp;
/
SHOW ERRORS;


