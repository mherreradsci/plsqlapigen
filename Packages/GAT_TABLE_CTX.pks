CREATE OR REPLACE PACKAGE GAT.gat_table_ctx
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     GAT_TABLE_CTX
Proposito:  Manager del contexto TABLE_CTX

Cuando     Quien    Que
---------- -------- ------------------------------------------------------------
02/10/2012 mherrera Creación
*******************************************************************************/
AS
   -- Constantes para identificar el package
   k_package   CONSTANT fdc_defs.package_name_t := 'GAT_TABLE_CTX';

   --*
   PROCEDURE initialize;

   PROCEDURE set_table_context (p_table_owner   IN all_tables.owner%TYPE,
                                p_table_name    IN all_tables.table_name%TYPE,
                                p_table_short_name in varchar2
                                );

   PROCEDURE set_parameter (p_name IN VARCHAR2, p_value IN VARCHAR2);
END gat_table_ctx;
/
SHOW ERRORS;


