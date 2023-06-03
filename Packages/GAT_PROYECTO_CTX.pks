CREATE OR REPLACE PACKAGE GAT.gat_proyecto_ctx
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     gat_proyecto_ctx
Proposito:  <Defina brevemente el objetivo del package>

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
21-03-2012 mherrera Creación
*******************************************************************************/
AS
   -- Constantes para identificar el package
   k_package   CONSTANT fdc_defs.package_name_t := 'gat_proyecto_ctx';

   --* Subtipos, Tipos, Constantes del package

   --* Procedimientos y funciones
   PROCEDURE initialize (p_prod_id IN gat_productos.prod_id%TYPE);
END gat_proyecto_ctx;
/
SHOW ERRORS;


