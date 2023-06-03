CREATE OR REPLACE PACKAGE GAT.cli_clientes_qp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     CLI_CLIENTES_QP
   Proposito:  Package para Queries: Implementa las queries para consultar la tabla
               CLI_CLIENTES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   01-ene-2011 mherrera     Creación
   *******************************************************************************/

   -- Consulta la exitencia de un registro de CLI_CLIENTES basado en la PK
   FUNCTION existe (p_clie_id IN cli_clientes_tp.clie_id_t)
      RETURN BOOLEAN;

   -- Funcion para obtener la cantidad de registros de la tabla CLI_CLIENTES a partir de la pk
   FUNCTION cuenta_por_pk (p_clie_id IN cli_clientes_tp.clie_id_t)
      RETURN PLS_INTEGER;

   -- Consulta un registro de CLI_CLIENTES basado en la constraint CLIE_PK
   PROCEDURE sel_clie_pk (p_clie_id        IN            cli_clientes_tp.clie_id_t,
                          p_cli_clientes      OUT NOCOPY cli_clientes_tp.cli_clientes_rt);

   -- Consulta el registro de CLI_CLIENTES basado en la PK
   FUNCTION sel_pk (p_clie_id IN cli_clientes_tp.clie_id_t)
      RETURN cli_clientes_tp.cli_clientes_rt;

   -- Obtiene un cursor via una consulta sobre la constraint CLIE_PK de la tabla CLI_CLIENTES
   FUNCTION sel_clie_pk (p_clie_id IN cli_clientes_tp.clie_id_t)
      RETURN cli_clientes_tp.cli_clientes_rc;

   -- Obtiene una tabla (index by) con los registros de la tabla CLI_CLIENTES
   PROCEDURE sel_where (p_where                        VARCHAR2,
                        p_cli_clientes   IN OUT NOCOPY cli_clientes_tp.cli_clientes_ct);

   -- Obtiene un cursor via una consulta con where dinámico sobre la tabla CLI_CLIENTES
   FUNCTION sel_where (p_where VARCHAR2)
      RETURN cli_clientes_tp.cli_clientes_rc;
END cli_clientes_qp;
/
SHOW ERRORS;


