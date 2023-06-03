CREATE OR REPLACE PACKAGE GAT.gat_tplt_source_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TPLT_SOURCE_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_TPLT_SOURCE
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_TPLT_SOURCE basado en la PK
   FUNCTION existe (p_perf_id       IN gat_tplt_source_tp.perf_id_t,
                    p_ttem_codigo   IN gat_tplt_source_tp.ttem_codigo_t,
                    p_tpso_id       IN gat_tplt_source_tp.tpso_id_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_TPLT_SOURCE a partir de la pk
   FUNCTION cuenta_por_pk (p_perf_id       IN gat_tplt_source_tp.perf_id_t,
                           p_ttem_codigo   IN gat_tplt_source_tp.ttem_codigo_t,
                           p_tpso_id       IN gat_tplt_source_tp.tpso_id_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de GAT_TPLT_SOURCE basado en la constraint TPSO_PK
   PROCEDURE sel_tpso_pk (
      p_perf_id           IN            gat_tplt_source_tp.perf_id_t,
      p_ttem_codigo       IN            gat_tplt_source_tp.ttem_codigo_t,
      p_tpso_id           IN            gat_tplt_source_tp.tpso_id_t,
      p_gat_tplt_source      OUT NOCOPY gat_tplt_source_tp.gat_tplt_source_rt);

   -- Consulta el registro de GAT_TPLT_SOURCE basado en la PK
   FUNCTION sel_pk (p_perf_id       IN gat_tplt_source_tp.perf_id_t,
                    p_ttem_codigo   IN gat_tplt_source_tp.ttem_codigo_t,
                    p_tpso_id       IN gat_tplt_source_tp.tpso_id_t)
      RETURN gat_tplt_source_tp.gat_tplt_source_rt;

   -- Obtiene un cursor via una consulta sobre la constraint TPSO_PK de la tabla GAT_TPLT_SOURCE
   FUNCTION sel_tpso_pk (p_perf_id       IN gat_tplt_source_tp.perf_id_t,
                         p_ttem_codigo   IN gat_tplt_source_tp.ttem_codigo_t,
                         p_tpso_id       IN gat_tplt_source_tp.tpso_id_t)
      RETURN gat_tplt_source_tp.gat_tplt_source_rc;

   -- Obtiene un cursor via una consulta sobre la constraint TPSO_TPLT_FK1 de la tabla GAT_TPLT_SOURCE
   FUNCTION sel_tpso_tplt_fk1 (p_perf_id       IN gat_tplt_source_tp.perf_id_t,
                               p_ttem_codigo   IN gat_tplt_source_tp.ttem_codigo_t)
      RETURN gat_tplt_source_tp.gat_tplt_source_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_TPLT_SOURCE
   PROCEDURE sel_where (
      p_where                           VARCHAR2,
      p_gat_tplt_source   IN OUT NOCOPY gat_tplt_source_tp.gat_tplt_source_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_TPLT_SOURCE
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_tplt_source_tp.gat_tplt_source_rc;
END gat_tplt_source_qp;
/
SHOW ERRORS;


