CREATE OR REPLACE PACKAGE GAT.dba_arguments_rp
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     DBA_ARGUMENTS_RP
Proposito:  APIs para vista DBA_ARGUMENTS

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
18-Feb-2012 mherrera Creación
*******************************************************************************/
AS
   -- Constantes para identificar el package
   k_package   CONSTANT fdc_defs.package_name_t := 'DBA_ARGUMENTS_RP';

   --* Subtipos, Tipos, Constantes del package

   --* Procedimientos y funciones

   PROCEDURE print_arguments (p_arguments IN dba_arguments_tp.dba_arguments_ct);

   PROCEDURE load (p_owner           IN     dba_arguments_tp.owner_t,
                   p_package_name    IN     dba_arguments_tp.package_name_t,
                   p_object_name     IN     dba_arguments_tp.object_name_t,
                   p_subprogram_id   IN     dba_arguments_tp.subprogram_id_t,
                   p_overload        IN     dba_arguments_tp.overload_t,
                   p_arguments          OUT dba_arguments_tp.dba_arguments_ct);
END dba_arguments_rp;
/
SHOW ERRORS;


