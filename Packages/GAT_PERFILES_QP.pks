CREATE OR REPLACE PACKAGE GAT.gat_perfiles_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_PERFILES_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_PERFILES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_PERFILES basado en la PK
   FUNCTION existe (p_perf_id IN gat_perfiles_tp.perf_id_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_PERFILES a partir de la pk
   FUNCTION cuenta_por_pk (p_perf_id IN gat_perfiles_tp.perf_id_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de GAT_PERFILES basado en la constraint PERF_PK
   PROCEDURE sel_perf_pk (p_perf_id        IN            gat_perfiles_tp.perf_id_t,
                          p_gat_perfiles      OUT NOCOPY gat_perfiles_tp.gat_perfiles_rt);

   -- Consulta el registro de GAT_PERFILES basado en la PK
   FUNCTION sel_pk (p_perf_id IN gat_perfiles_tp.perf_id_t)
      RETURN gat_perfiles_tp.gat_perfiles_rt;

   -- Obtiene un cursor via una consulta sobre la constraint PERF_PK de la tabla GAT_PERFILES
   FUNCTION sel_perf_pk (p_perf_id IN gat_perfiles_tp.perf_id_t)
      RETURN gat_perfiles_tp.gat_perfiles_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_PERFILES
   PROCEDURE sel_where (p_where                        VARCHAR2,
                        p_gat_perfiles   IN OUT NOCOPY gat_perfiles_tp.gat_perfiles_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_PERFILES
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_perfiles_tp.gat_perfiles_rc;
END gat_perfiles_qp;
/
SHOW ERRORS;


