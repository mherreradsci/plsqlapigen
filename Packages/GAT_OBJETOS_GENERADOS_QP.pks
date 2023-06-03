CREATE OR REPLACE PACKAGE GAT.gat_objetos_generados_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_OBJETOS_GENERADOS_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               GAT_OBJETOS_GENERADOS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de GAT_OBJETOS_GENERADOS basado en la PK
   FUNCTION existe (p_prod_id         IN gat_objetos_generados_tp.prod_id_t,
                    p_nombre_objeto   IN gat_objetos_generados_tp.nombre_objeto_t,
                    p_tobj_codigo     IN gat_objetos_generados_tp.tobj_codigo_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla GAT_OBJETOS_GENERADOS a partir de la pk
   FUNCTION cuenta_por_pk (p_prod_id         IN gat_objetos_generados_tp.prod_id_t,
                           p_nombre_objeto   IN gat_objetos_generados_tp.nombre_objeto_t,
                           p_tobj_codigo     IN gat_objetos_generados_tp.tobj_codigo_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de GAT_OBJETOS_GENERADOS basado en la constraint OBGE_PK
   PROCEDURE sel_obge_pk (
      p_prod_id                 IN            gat_objetos_generados_tp.prod_id_t,
      p_nombre_objeto           IN            gat_objetos_generados_tp.nombre_objeto_t,
      p_tobj_codigo             IN            gat_objetos_generados_tp.tobj_codigo_t,
      p_gat_objetos_generados      OUT NOCOPY gat_objetos_generados_tp.gat_objetos_generados_rt);

   -- Consulta el registro de GAT_OBJETOS_GENERADOS basado en la PK
   FUNCTION sel_pk (p_prod_id         IN gat_objetos_generados_tp.prod_id_t,
                    p_nombre_objeto   IN gat_objetos_generados_tp.nombre_objeto_t,
                    p_tobj_codigo     IN gat_objetos_generados_tp.tobj_codigo_t)
      RETURN gat_objetos_generados_tp.gat_objetos_generados_rt;

   -- Obtiene un cursor via una consulta sobre la constraint OBGE_PK de la tabla GAT_OBJETOS_GENERADOS
   FUNCTION sel_obge_pk (p_prod_id         IN gat_objetos_generados_tp.prod_id_t,
                         p_nombre_objeto   IN gat_objetos_generados_tp.nombre_objeto_t,
                         p_tobj_codigo     IN gat_objetos_generados_tp.tobj_codigo_t)
      RETURN gat_objetos_generados_tp.gat_objetos_generados_rc;

   -- Obtiene un cursor via una consulta sobre la constraint OBGE_PROD_FK1 de la tabla GAT_OBJETOS_GENERADOS
   FUNCTION sel_obge_prod_fk1 (p_prod_id IN gat_objetos_generados_tp.prod_id_t)
      RETURN gat_objetos_generados_tp.gat_objetos_generados_rc;

   -- Obtiene un cursor via una consulta sobre la constraint OBGE_TOBJ_FK2 de la tabla GAT_OBJETOS_GENERADOS
   FUNCTION sel_obge_tobj_fk2 (p_tobj_codigo IN gat_objetos_generados_tp.tobj_codigo_t)
      RETURN gat_objetos_generados_tp.gat_objetos_generados_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla GAT_OBJETOS_GENERADOS
   PROCEDURE sel_where (
      p_where                                 VARCHAR2,
      p_gat_objetos_generados   IN OUT NOCOPY gat_objetos_generados_tp.gat_objetos_generados_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla GAT_OBJETOS_GENERADOS
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN gat_objetos_generados_tp.gat_objetos_generados_rc;
END gat_objetos_generados_qp;
/
SHOW ERRORS;


