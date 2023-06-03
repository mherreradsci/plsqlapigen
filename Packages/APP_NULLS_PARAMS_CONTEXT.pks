CREATE OR REPLACE PACKAGE GAT.app_nulls_params_context
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Fundaciones

Nombre:     APP_NULLS_PARAMS_CONTEXT
Proposito:  Para implementar manejo de parametros y valores por omisión a nivel
            de contexto Oracle

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
25-04-2012  mherrera Creación
*******************************************************************************/
AS
   -- Constantes para identificar el package
   k_package   CONSTANT FDC_DEFS.PACKAGE_NAME_T := 'APP_NULLS_PARAMS_CONTEXT';

   --* Subtipos, Tipos, Constantes del package

   -- Procedimientos y funciones
   PROCEDURE set_client_info (p_info IN VARCHAR2);

   PROCEDURE read_client_info (p_info OUT VARCHAR2);
END app_nulls_params_context;
/
SHOW ERRORS;


