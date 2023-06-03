CREATE OR REPLACE PACKAGE GAT.gat_productos_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_PRODUCTOS_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_PRODUCTOS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_PRODUCTOS basado en la PK
   FUNCTION existe (p_prod_id IN gat_productos_tp.prod_id_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_PRODUCTOS a partir de la pk
   FUNCTION cuenta_por_pk (p_prod_id IN gat_productos_tp.prod_id_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de GAT_PRODUCTOS basado en la constraint PROD_PK
   PROCEDURE sel_prod_pk (
      p_prod_id         IN            gat_productos_tp.prod_id_t,
      p_gat_productos      OUT NOCOPY gat_productos_tp.gat_productos_rt);

   -- Consulta el registro de GAT_PRODUCTOS basado en la PK
   FUNCTION sel_pk (p_prod_id IN gat_productos_tp.prod_id_t)
      RETURN gat_productos_tp.gat_productos_rt;

   -- Obtiene un cursor via una consulta sobre la constraint PROD_PK de la tabla GAT_PRODUCTOS
   FUNCTION sel_prod_pk (p_prod_id IN gat_productos_tp.prod_id_t)
      RETURN gat_productos_tp.gat_productos_rc;

   -- Obtiene un cursor via una consulta sobre la constraint PROD_PERF_FK3 de la tabla GAT_PRODUCTOS
   FUNCTION sel_prod_perf_fk3 (p_perf_id IN gat_productos_tp.perf_id_t)
      RETURN gat_productos_tp.gat_productos_rc;

   -- Obtiene un cursor via una consulta sobre la constraint PROD_APPL_FK1 de la tabla GAT_PRODUCTOS
   FUNCTION sel_prod_appl_fk1 (p_appl_id IN gat_productos_tp.appl_id_t)
      RETURN gat_productos_tp.gat_productos_rc;

   -- Obtiene un cursor via una consulta sobre la constraint PROD_CLIE_FK2 de la tabla GAT_PRODUCTOS
   FUNCTION sel_prod_clie_fk2 (p_clie_id IN gat_productos_tp.clie_id_t)
      RETURN gat_productos_tp.gat_productos_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_PRODUCTOS
   PROCEDURE sel_where (
      p_where                         VARCHAR2,
      p_gat_productos   IN OUT NOCOPY gat_productos_tp.gat_productos_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_PRODUCTOS
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_productos_tp.gat_productos_rc;
END gat_productos_qp;
/
SHOW ERRORS;


