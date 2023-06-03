CREATE OR REPLACE PACKAGE GAT.UER_ERRORES_AT AS
/*******************************************************************************
Empresa:    Adexus
Proyecto:   Sistema Nacional Inversión Pública
            SNIP

Nombre:     UER_ERRORES_AT
Proposito:  Transacciones independientes poara el manejador de errores

Cuando     Quien    Que
---------- -------- ------------------------------------------------------------
12/28/2011 mherrera Creación
*******************************************************************************/

   -- Constantes para identificar el package
   k_package       CONSTANT fdc_defs.package_name_t := 'UER_ERRORES_AT';

   procedure insert_commit_at(p_error                UER_ERRORES_TP.uer_errores_rt);

END UER_ERRORES_AT;
/
SHOW ERRORS;


