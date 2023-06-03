CREATE OR REPLACE PACKAGE GAT.gat_tip_parametros_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_PARAMETROS_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_TIP_PARAMETROS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_TIP_PARAMETROS basado en la PK
   FUNCTION existe (p_tipr_codigo IN gat_tip_parametros_tp.tipr_codigo_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_TIP_PARAMETROS a partir de la pk
   FUNCTION cuenta_por_pk (p_tipr_codigo IN gat_tip_parametros_tp.tipr_codigo_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de GAT_TIP_PARAMETROS basado en la constraint TPAR_PK
   PROCEDURE sel_tpar_pk (
      p_tipr_codigo          IN            gat_tip_parametros_tp.tipr_codigo_t,
      p_gat_tip_parametros      OUT NOCOPY gat_tip_parametros_tp.gat_tip_parametros_rt);

   -- Consulta el registro de GAT_TIP_PARAMETROS basado en la PK
   FUNCTION sel_pk (p_tipr_codigo IN gat_tip_parametros_tp.tipr_codigo_t)
      RETURN gat_tip_parametros_tp.gat_tip_parametros_rt;

   -- Obtiene un cursor via una consulta sobre la constraint TPAR_PK de la tabla GAT_TIP_PARAMETROS
   FUNCTION sel_tpar_pk (p_tipr_codigo IN gat_tip_parametros_tp.tipr_codigo_t)
      RETURN gat_tip_parametros_tp.gat_tip_parametros_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_TIP_PARAMETROS
   PROCEDURE sel_where (
      p_where                              VARCHAR2,
      p_gat_tip_parametros   IN OUT NOCOPY gat_tip_parametros_tp.gat_tip_parametros_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_TIP_PARAMETROS
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_tip_parametros_tp.gat_tip_parametros_rc;
END gat_tip_parametros_qp;
/
SHOW ERRORS;


