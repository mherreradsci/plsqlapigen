CREATE OR REPLACE PACKAGE GAT.gat_rel_tplt_tpac_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_REL_TPLT_TPAC_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_REL_TPLT_TPAC
   Descipción de la tabla:
   Relación entre los Templates y Tipos de packages

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_REL_TPLT_TPAC basado en la PK
   FUNCTION existe (p_perf_id       IN gat_rel_tplt_tpac_tp.perf_id_t,
                    p_ttem_codigo   IN gat_rel_tplt_tpac_tp.ttem_codigo_t,
                    p_tpac_codigo   IN gat_rel_tplt_tpac_tp.tpac_codigo_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_REL_TPLT_TPAC a partir de la pk
   FUNCTION cuenta_por_pk (p_perf_id       IN gat_rel_tplt_tpac_tp.perf_id_t,
                           p_ttem_codigo   IN gat_rel_tplt_tpac_tp.ttem_codigo_t,
                           p_tpac_codigo   IN gat_rel_tplt_tpac_tp.tpac_codigo_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de GAT_REL_TPLT_TPAC basado en la constraint TPTP_PK
   PROCEDURE sel_tptp_pk (
      p_perf_id             IN            gat_rel_tplt_tpac_tp.perf_id_t,
      p_ttem_codigo         IN            gat_rel_tplt_tpac_tp.ttem_codigo_t,
      p_tpac_codigo         IN            gat_rel_tplt_tpac_tp.tpac_codigo_t,
      p_gat_rel_tplt_tpac      OUT NOCOPY gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rt);

   -- Consulta el registro de GAT_REL_TPLT_TPAC basado en la PK
   FUNCTION sel_pk (p_perf_id       IN gat_rel_tplt_tpac_tp.perf_id_t,
                    p_ttem_codigo   IN gat_rel_tplt_tpac_tp.ttem_codigo_t,
                    p_tpac_codigo   IN gat_rel_tplt_tpac_tp.tpac_codigo_t)
      RETURN gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rt;

   -- Obtiene un cursor via una consulta sobre la constraint TPTP_PK de la tabla GAT_REL_TPLT_TPAC
   FUNCTION sel_tptp_pk (p_perf_id       IN gat_rel_tplt_tpac_tp.perf_id_t,
                         p_ttem_codigo   IN gat_rel_tplt_tpac_tp.ttem_codigo_t,
                         p_tpac_codigo   IN gat_rel_tplt_tpac_tp.tpac_codigo_t)
      RETURN gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rc;

   -- Obtiene un cursor via una consulta sobre la constraint TPTP_TPLT_FK2 de la tabla GAT_REL_TPLT_TPAC
   FUNCTION sel_tptp_tplt_fk2 (p_perf_id       IN gat_rel_tplt_tpac_tp.perf_id_t,
                               p_ttem_codigo   IN gat_rel_tplt_tpac_tp.ttem_codigo_t)
      RETURN gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rc;

   -- Obtiene un cursor via una consulta sobre la constraint TPTP_TPAC_FK1 de la tabla GAT_REL_TPLT_TPAC
   FUNCTION sel_tptp_tpac_fk1 (p_tpac_codigo IN gat_rel_tplt_tpac_tp.tpac_codigo_t)
      RETURN gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_REL_TPLT_TPAC
   PROCEDURE sel_where (
      p_where                             VARCHAR2,
      p_gat_rel_tplt_tpac   IN OUT NOCOPY gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_REL_TPLT_TPAC
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_rel_tplt_tpac_tp.gat_rel_tplt_tpac_rc;
END gat_rel_tplt_tpac_qp;
/
SHOW ERRORS;


