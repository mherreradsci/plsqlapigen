CREATE OR REPLACE PACKAGE BODY GAT.gat_objetos_generados_rp
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
   --* Variables, constantes, tipos y subtipos locales

   --* Procedimientos y funciones
   PROCEDURE obge_merge_catalogo (
      p_prod_id         IN gat_objetos_generados_tp.prod_id_t,
      p_nombre_objeto   IN gat_objetos_generados_tp.nombre_objeto_t,
      p_tobj_codigo     IN gat_objetos_generados_tp.tobj_codigo_t,
      p_compilado       IN gat_objetos_generados_tp.compilado_t)
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'obge_merge_catalogo';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   -- Variables, constantes, tipos y subtipos locales
   BEGIN
      --*
      --* Implementación.
      MERGE INTO gat_objetos_generados obge
      USING (SELECT p_prod_id prod_id,
                    UPPER (p_nombre_objeto) nombre_objeto,
                    p_tobj_codigo tobj_codigo,
                    TRUNC (SYSDATE) primera_generacion,
                    SYSDATE ultima_generacion,
                    1 total_generaciones,
                    CASE p_compilado WHEN 'TRUE' THEN 'S' ELSE 'N' END compilado
             FROM DUAL) new_og
      ON (obge.prod_id = new_og.prod_id
      AND obge.nombre_objeto = new_og.nombre_objeto
      AND obge.tobj_codigo = new_og.tobj_codigo)
      WHEN MATCHED
      THEN
         UPDATE SET
            obge.ultima_generacion = new_og.ultima_generacion,
            obge.version_generador = uvg_valores_generales.version (SYSDATE),
            obge.total_generaciones = obge.total_generaciones + 1.0
      WHEN NOT MATCHED
      THEN
         INSERT (obge.prod_id,
                 obge.nombre_objeto,
                 obge.tobj_codigo,
                 obge.primera_generacion,
                 obge.ultima_generacion,
                 version_generador,
                 obge.total_generaciones,
                 obge.compilado)
         VALUES (new_og.prod_id,
                 new_og.nombre_objeto,
                 new_og.tobj_codigo,
                 TRUNC (SYSDATE),
                 new_og.ultima_generacion,
                 uvg_valores_generales.version (SYSDATE),
                 new_og.total_generaciones,
                 new_og.compilado);
   --* Fin Implementación
   --*
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => k_modulo,
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END obge_merge_catalogo;
END gat_objetos_generados_rp;
/
SHOW ERRORS;


