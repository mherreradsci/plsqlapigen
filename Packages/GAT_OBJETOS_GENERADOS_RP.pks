CREATE OR REPLACE PACKAGE GAT.gat_objetos_generados_rp
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     GAT_OBJETOS_GENERADOS_RP
Proposito:  Reglas ad-hoc para tabla GAT_OBJETOS_GENERADOS

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
21-03-2012 mherrera Creación
*******************************************************************************/
AS
   -- Constantes para identificar el package
   k_package   CONSTANT fdc_defs.package_name_t := 'GAT_OBJETOS_GENERADOS_RP';

   --* Subtipos, Tipos, Constantes del package

   --* Procedimientos y funciones
   PROCEDURE obge_merge_catalogo (
      p_prod_id         IN gat_objetos_generados_tp.prod_id_t,
      p_nombre_objeto   IN gat_objetos_generados_tp.nombre_objeto_t,
      p_tobj_codigo     IN gat_objetos_generados_tp.tobj_codigo_t,
      p_compilado       IN gat_objetos_generados_tp.compilado_t);
END gat_objetos_generados_rp;
/
SHOW ERRORS;


