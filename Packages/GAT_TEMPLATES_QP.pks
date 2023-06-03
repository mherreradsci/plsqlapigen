CREATE OR REPLACE PACKAGE GAT.gat_templates_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TEMPLATES_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_TEMPLATES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_TEMPLATES basado en la PK
   FUNCTION existe (p_perf_id       IN gat_templates_tp.perf_id_t,
                    p_ttem_codigo   IN gat_templates_tp.ttem_codigo_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_TEMPLATES a partir de la pk
   FUNCTION cuenta_por_pk (p_perf_id       IN gat_templates_tp.perf_id_t,
                           p_ttem_codigo   IN gat_templates_tp.ttem_codigo_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de GAT_TEMPLATES basado en la constraint TPLT_PK
   PROCEDURE sel_tplt_pk (
      p_perf_id         IN            gat_templates_tp.perf_id_t,
      p_ttem_codigo     IN            gat_templates_tp.ttem_codigo_t,
      p_gat_templates      OUT NOCOPY gat_templates_tp.gat_templates_rt);

   -- Consulta el registro de GAT_TEMPLATES basado en la PK
   FUNCTION sel_pk (p_perf_id       IN gat_templates_tp.perf_id_t,
                    p_ttem_codigo   IN gat_templates_tp.ttem_codigo_t)
      RETURN gat_templates_tp.gat_templates_rt;

   -- Obtiene un cursor via una consulta sobre la constraint TPLT_PK de la tabla GAT_TEMPLATES
   FUNCTION sel_tplt_pk (p_perf_id       IN gat_templates_tp.perf_id_t,
                         p_ttem_codigo   IN gat_templates_tp.ttem_codigo_t)
      RETURN gat_templates_tp.gat_templates_rc;

   -- Obtiene un cursor via una consulta sobre la constraint TPLT_PERF_FK1 de la tabla GAT_TEMPLATES
   FUNCTION sel_tplt_perf_fk1 (p_perf_id IN gat_templates_tp.perf_id_t)
      RETURN gat_templates_tp.gat_templates_rc;

   -- Obtiene un cursor via una consulta sobre la constraint TPLT_TTEM_FK2 de la tabla GAT_TEMPLATES
   FUNCTION sel_tplt_ttem_fk2 (p_ttem_codigo IN gat_templates_tp.ttem_codigo_t)
      RETURN gat_templates_tp.gat_templates_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_TEMPLATES
   PROCEDURE sel_where (
      p_where                         VARCHAR2,
      p_gat_templates   IN OUT NOCOPY gat_templates_tp.gat_templates_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_TEMPLATES
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_templates_tp.gat_templates_rc;
END gat_templates_qp;
/
SHOW ERRORS;


