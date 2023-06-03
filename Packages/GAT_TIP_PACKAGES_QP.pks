CREATE OR REPLACE PACKAGE GAT.gat_tip_packages_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_PACKAGES_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_TIP_PACKAGES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_TIP_PACKAGES basado en la PK
   FUNCTION existe (p_tpac_codigo IN gat_tip_packages_tp.tpac_codigo_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_TIP_PACKAGES a partir de la pk
   FUNCTION cuenta_por_pk (p_tpac_codigo IN gat_tip_packages_tp.tpac_codigo_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de GAT_TIP_PACKAGES basado en la constraint TPAC_PK
   PROCEDURE sel_tpac_pk (
      p_tpac_codigo        IN            gat_tip_packages_tp.tpac_codigo_t,
      p_gat_tip_packages      OUT NOCOPY gat_tip_packages_tp.gat_tip_packages_rt);

   -- Consulta el registro de GAT_TIP_PACKAGES basado en la PK
   FUNCTION sel_pk (p_tpac_codigo IN gat_tip_packages_tp.tpac_codigo_t)
      RETURN gat_tip_packages_tp.gat_tip_packages_rt;

   -- Obtiene un cursor via una consulta sobre la constraint TPAC_PK de la tabla GAT_TIP_PACKAGES
   FUNCTION sel_tpac_pk (p_tpac_codigo IN gat_tip_packages_tp.tpac_codigo_t)
      RETURN gat_tip_packages_tp.gat_tip_packages_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_TIP_PACKAGES
   PROCEDURE sel_where (
      p_where                            VARCHAR2,
      p_gat_tip_packages   IN OUT NOCOPY gat_tip_packages_tp.gat_tip_packages_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_TIP_PACKAGES
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_tip_packages_tp.gat_tip_packages_rc;
END gat_tip_packages_qp;
/
SHOW ERRORS;


