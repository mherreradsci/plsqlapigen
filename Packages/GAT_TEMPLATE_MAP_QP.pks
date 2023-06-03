CREATE OR REPLACE PACKAGE GAT.gat_template_map_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TEMPLATE_MAP_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_TEMPLATE_MAP
   Descipción de la tabla:
   Mapa de template

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_TEMPLATE_MAP basado en la PK
   FUNCTION existe (p_perf_id       IN gat_template_map_tp.perf_id_t,
                    p_ttem_codigo   IN gat_template_map_tp.ttem_codigo_t,
                    p_para_code     IN gat_template_map_tp.para_code_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_TEMPLATE_MAP a partir de la pk
   FUNCTION cuenta_por_pk (p_perf_id       IN gat_template_map_tp.perf_id_t,
                           p_ttem_codigo   IN gat_template_map_tp.ttem_codigo_t,
                           p_para_code     IN gat_template_map_tp.para_code_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de GAT_TEMPLATE_MAP basado en la constraint TEMA_PK
   PROCEDURE sel_tema_pk (
      p_perf_id            IN            gat_template_map_tp.perf_id_t,
      p_ttem_codigo        IN            gat_template_map_tp.ttem_codigo_t,
      p_para_code          IN            gat_template_map_tp.para_code_t,
      p_gat_template_map      OUT NOCOPY gat_template_map_tp.gat_template_map_rt);

   -- Consulta el registro de GAT_TEMPLATE_MAP basado en la PK
   FUNCTION sel_pk (p_perf_id       IN gat_template_map_tp.perf_id_t,
                    p_ttem_codigo   IN gat_template_map_tp.ttem_codigo_t,
                    p_para_code     IN gat_template_map_tp.para_code_t)
      RETURN gat_template_map_tp.gat_template_map_rt;

   -- Obtiene un cursor via una consulta sobre la constraint TEMA_PK de la tabla GAT_TEMPLATE_MAP
   FUNCTION sel_tema_pk (p_perf_id       IN gat_template_map_tp.perf_id_t,
                         p_ttem_codigo   IN gat_template_map_tp.ttem_codigo_t,
                         p_para_code     IN gat_template_map_tp.para_code_t)
      RETURN gat_template_map_tp.gat_template_map_rc;

   -- Obtiene un cursor via una consulta sobre la constraint TEMA_TPLT_FK2 de la tabla GAT_TEMPLATE_MAP
   FUNCTION sel_tema_tplt_fk2 (p_perf_id       IN gat_template_map_tp.perf_id_t,
                               p_ttem_codigo   IN gat_template_map_tp.ttem_codigo_t)
      RETURN gat_template_map_tp.gat_template_map_rc;

   -- Obtiene un cursor via una consulta sobre la constraint TEMA_TPAR_FK1 de la tabla GAT_TEMPLATE_MAP
   FUNCTION sel_tema_tpar_fk1 (p_tipr_codigo IN gat_template_map_tp.tipr_codigo_t)
      RETURN gat_template_map_tp.gat_template_map_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_TEMPLATE_MAP
   PROCEDURE sel_where (
      p_where                            VARCHAR2,
      p_gat_template_map   IN OUT NOCOPY gat_template_map_tp.gat_template_map_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_TEMPLATE_MAP
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_template_map_tp.gat_template_map_rc;
END gat_template_map_qp;
/
SHOW ERRORS;


