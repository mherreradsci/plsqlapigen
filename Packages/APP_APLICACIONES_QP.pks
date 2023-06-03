CREATE OR REPLACE PACKAGE GAT.app_aplicaciones_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     APP_APLICACIONES_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               APP_APLICACIONES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de APP_APLICACIONES basado en la PK
   FUNCTION existe (p_appl_id IN app_aplicaciones_tp.appl_id_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla APP_APLICACIONES a partir de la pk
   FUNCTION cuenta_por_pk (p_appl_id IN app_aplicaciones_tp.appl_id_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de APP_APLICACIONES basado en la constraint APPL_PK
   PROCEDURE sel_appl_pk (
      p_appl_id            IN            app_aplicaciones_tp.appl_id_t,
      p_app_aplicaciones      OUT NOCOPY app_aplicaciones_tp.app_aplicaciones_rt);

   -- Consulta el registro de APP_APLICACIONES basado en la PK
   FUNCTION sel_pk (p_appl_id IN app_aplicaciones_tp.appl_id_t)
      RETURN app_aplicaciones_tp.app_aplicaciones_rt;

   -- Obtiene un cursor via una consulta sobre la constraint APPL_PK de la tabla APP_APLICACIONES
   FUNCTION sel_appl_pk (p_appl_id IN app_aplicaciones_tp.appl_id_t)
      RETURN app_aplicaciones_tp.app_aplicaciones_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla APP_APLICACIONES
   PROCEDURE sel_where (
      p_where                            VARCHAR2,
      p_app_aplicaciones   IN OUT NOCOPY app_aplicaciones_tp.app_aplicaciones_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla APP_APLICACIONES
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN app_aplicaciones_tp.app_aplicaciones_rc;
END app_aplicaciones_qp;
/
SHOW ERRORS;


