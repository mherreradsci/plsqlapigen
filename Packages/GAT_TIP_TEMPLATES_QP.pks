CREATE OR REPLACE PACKAGE GAT.gat_tip_templates_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_TEMPLATES_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_TIP_TEMPLATES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_TIP_TEMPLATES basado en la PK
   FUNCTION existe (p_ttem_codigo IN gat_tip_templates_tp.ttem_codigo_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_TIP_TEMPLATES a partir de la pk
   FUNCTION cuenta_por_pk (p_ttem_codigo IN gat_tip_templates_tp.ttem_codigo_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de GAT_TIP_TEMPLATES basado en la constraint TTEM_PK
   PROCEDURE sel_ttem_pk (
      p_ttem_codigo         IN            gat_tip_templates_tp.ttem_codigo_t,
      p_gat_tip_templates      OUT NOCOPY gat_tip_templates_tp.gat_tip_templates_rt);

   -- Consulta el registro de GAT_TIP_TEMPLATES basado en la PK
   FUNCTION sel_pk (p_ttem_codigo IN gat_tip_templates_tp.ttem_codigo_t)
      RETURN gat_tip_templates_tp.gat_tip_templates_rt;

   -- Obtiene un cursor via una consulta sobre la constraint TTEM_PK de la tabla GAT_TIP_TEMPLATES
   FUNCTION sel_ttem_pk (p_ttem_codigo IN gat_tip_templates_tp.ttem_codigo_t)
      RETURN gat_tip_templates_tp.gat_tip_templates_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_TIP_TEMPLATES
   PROCEDURE sel_where (
      p_where                             VARCHAR2,
      p_gat_tip_templates   IN OUT NOCOPY gat_tip_templates_tp.gat_tip_templates_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_TIP_TEMPLATES
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_tip_templates_tp.gat_tip_templates_rc;
END gat_tip_templates_qp;
/
SHOW ERRORS;


