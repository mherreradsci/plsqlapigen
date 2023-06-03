CREATE OR REPLACE PACKAGE GAT.uer_errores_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     UER_ERRORES_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               UER_ERRORES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de UER_ERRORES basado en la PK
   FUNCTION existe (p_erro_id IN uer_errores_tp.erro_id_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla UER_ERRORES a partir de la pk
   FUNCTION cuenta_por_pk (p_erro_id IN uer_errores_tp.erro_id_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de UER_ERRORES basado en la constraint ERRO_PK
   PROCEDURE sel_erro_pk (p_erro_id       IN            uer_errores_tp.erro_id_t,
                          p_uer_errores      OUT NOCOPY uer_errores_tp.uer_errores_rt);

   -- Consulta el registro de UER_ERRORES basado en la PK
   FUNCTION sel_pk (p_erro_id IN uer_errores_tp.erro_id_t)
      RETURN uer_errores_tp.uer_errores_rt;

   -- Obtiene un cursor via una consulta sobre la constraint ERRO_PK de la tabla UER_ERRORES
   FUNCTION sel_erro_pk (p_erro_id IN uer_errores_tp.erro_id_t)
      RETURN uer_errores_tp.uer_errores_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla UER_ERRORES
   PROCEDURE sel_where (p_where                       VARCHAR2,
                        p_uer_errores   IN OUT NOCOPY uer_errores_tp.uer_errores_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla UER_ERRORES
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN uer_errores_tp.uer_errores_rc;
END uer_errores_qp;
/
SHOW ERRORS;


