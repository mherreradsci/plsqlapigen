CREATE OR REPLACE PACKAGE GAT.gat_tip_objetos_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_OBJETOS_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_TIP_OBJETOS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_TIP_OBJETOS basado en la PK
   FUNCTION existe (p_tobj_codigo IN gat_tip_objetos_tp.tobj_codigo_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_TIP_OBJETOS a partir de la pk
   FUNCTION cuenta_por_pk (p_tobj_codigo IN gat_tip_objetos_tp.tobj_codigo_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de GAT_TIP_OBJETOS basado en la constraint TOBJ_PK
   PROCEDURE sel_tobj_pk (
      p_tobj_codigo       IN            gat_tip_objetos_tp.tobj_codigo_t,
      p_gat_tip_objetos      OUT NOCOPY gat_tip_objetos_tp.gat_tip_objetos_rt);

   -- Consulta el registro de GAT_TIP_OBJETOS basado en la PK
   FUNCTION sel_pk (p_tobj_codigo IN gat_tip_objetos_tp.tobj_codigo_t)
      RETURN gat_tip_objetos_tp.gat_tip_objetos_rt;

   -- Obtiene un cursor via una consulta sobre la constraint TOBJ_PK de la tabla GAT_TIP_OBJETOS
   FUNCTION sel_tobj_pk (p_tobj_codigo IN gat_tip_objetos_tp.tobj_codigo_t)
      RETURN gat_tip_objetos_tp.gat_tip_objetos_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_TIP_OBJETOS
   PROCEDURE sel_where (
      p_where                           VARCHAR2,
      p_gat_tip_objetos   IN OUT NOCOPY gat_tip_objetos_tp.gat_tip_objetos_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_TIP_OBJETOS
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_tip_objetos_tp.gat_tip_objetos_rc;
END gat_tip_objetos_qp;
/
SHOW ERRORS;


