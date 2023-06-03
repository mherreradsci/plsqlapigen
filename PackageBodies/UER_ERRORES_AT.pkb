CREATE OR REPLACE PACKAGE BODY GAT.uer_errores_at
AS
   /*******************************************************************************
   Empresa:    Adexus
   Proyecto:   Sistema Nacional Inversión Pública
               SNIP

   Nombre:     UER_ERRORES_AT
   Proposito:  <Defina brevemente el objetivo del package>

   Cuando     Quien    Que
   ---------- -------- ------------------------------------------------------------
   12/28/2011 mherrera Creación
   *******************************************************************************/

   PROCEDURE insert_commit_at (p_error uer_errores_tp.uer_errores_rt)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'insert_commit';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   BEGIN
      uer_errores_cp.ins (p_error);
      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         DBMS_OUTPUT.put_line (k_modulo || SQLERRM);
         RAISE;
   END insert_commit_at;
END uer_errores_at;
/
SHOW ERRORS;


