CREATE OR REPLACE PACKAGE GAT.dba_arguments_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     DBA_ARGUMENTS_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               DBA_ARGUMENTS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   22-mar-2012 mherrera     Creación
   *******************************************************************************/

   -- Consulta un registro de DBA_ARGUMENTS basado en la constraint ARGU_UK1
   PROCEDURE sel_argu_uk1 (
      p_owner           IN            dba_arguments_tp.owner_t,
      p_object_name     IN            dba_arguments_tp.object_name_t DEFAULT NULL,
      p_package_name    IN            dba_arguments_tp.package_name_t DEFAULT NULL,
      p_subprogram_id   IN            dba_arguments_tp.subprogram_id_t DEFAULT NULL,
      p_sequence        IN            dba_arguments_tp.sequence_t,
      p_dba_arguments      OUT NOCOPY dba_arguments_tp.dba_arguments_rt);

   -- Obtiene un cursor via una consulta sobre la constraint ARGU_UK1 de la tabla DBA_ARGUMENTS
   FUNCTION sel_argu_uk1 (
      p_owner           IN dba_arguments_tp.owner_t,
      p_object_name     IN dba_arguments_tp.object_name_t DEFAULT NULL,
      p_package_name    IN dba_arguments_tp.package_name_t DEFAULT NULL,
      p_subprogram_id   IN dba_arguments_tp.subprogram_id_t DEFAULT NULL,
      p_sequence        IN dba_arguments_tp.sequence_t)
      RETURN dba_arguments_tp.dba_arguments_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla DBA_ARGUMENTS
   PROCEDURE sel_where (
      p_where                         VARCHAR2,
      p_dba_arguments   IN OUT NOCOPY dba_arguments_tp.dba_arguments_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla DBA_ARGUMENTS
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN dba_arguments_tp.dba_arguments_rc;
END dba_arguments_qp;
/
SHOW ERRORS;


