CREATE OR REPLACE PACKAGE GAT.gat_dbmssql_api
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     GAT_DBMSSQL_API
Proposito:  API para DBMS_SQL

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
07-03-2012 mherrera Creación
*******************************************************************************/
AS
   -- Constantes para identificar el package
   k_package   CONSTANT fdc_defs.package_name_t := 'GAT_DBMSSQL_API';

   --* Subtipos, Tipos, Constantes del package

   --* Procedimientos y funciones
   PROCEDURE desc_rec_to_desc_rec (p_desc_table_from   IN     DBMS_SQL.desc_tab,
                                   p_desc_table_to        OUT utl_desc.desc_table_ct);
END gat_dbmssql_api;
/
SHOW ERRORS;


