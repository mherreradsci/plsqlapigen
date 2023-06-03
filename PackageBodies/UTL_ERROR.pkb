CREATE OR REPLACE PACKAGE BODY GAT.utl_error
IS
   /*
   Package:       pkg_utl_error
   Descripcion:   Maneja los errores de bajo nivel

   MODIFICACIONES (Orden ascendente)
   Persona  Fecha       Comentarios
   -------- ----------- -----------------------------------------------------------
   mherrera 17-Mar-2002 Creación
   mherrert 15-Nov-2004 Agrega parámetro p_rollback
   mherrert 24-Nov-2004 Cambia mensaje de excepcion ug_error_fatal
   mherrert 24-Nov-2004 Cambia mensaje de excepcion ug_error_fatal
   mherrert 17-Jul-2009 Agrega el log de procesos si está en el contexto de este
   mherrert 28-Dec-2011 Agrega insert_commit_at para hacer commit
                        como transacción autonoma.
   mherrert 18-Jan-2012 Agerga manejador de WHEN ug_error_fatal THEN RAISE; así
                        cuando es un error levantado por otro programa, no
                        muestra el mensaje de error del propio utl_error
   mherrert 18-Jan-2012 Modifica el largo del mensaje de error a 4000
   mherrera 21-Mar-2012 Agrega el format_error_backtrace en el mensaje guardado
                        en la tabla de errores
   --------------------------------------------------------------------------------

   */

   PROCEDURE insert_commit_at (p_error uer_errores_tp.uer_errores_rt)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.package_name_t := 'insert_commit';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   BEGIN
      uer_errores_cp.ins (p_error);
      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         DBMS_OUTPUT.put_line (k_modulo || SQLERRM);
         raise_application_error (k_ue_error_fatal, k_modulo || ':' || SQLERRM);
   END insert_commit_at;

   PROCEDURE informa (p_programa   IN uer_errores_tp.programa_t,
                      p_mensaje    IN uer_errores_tp.mensaje_t DEFAULT SQLERRM,
                      p_rollback   IN BOOLEAN DEFAULT FALSE,
                      p_raise      IN BOOLEAN DEFAULT TRUE)
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.package_name_t := 'informa';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
      --*
      r_error               uer_errores_tp.uer_errores_rt;
      v_largo_mensaje       NUMBER (4);
      --v_lopr_id             ulp_log_procesos_tp.lopr_id_t;
      v_buffer              VARCHAR2 (4000);
   BEGIN
      IF p_rollback
      THEN
         ROLLBACK;
      END IF;

      --v_lopr_id := utl_log_procesos.id_proceso_actual ();
      --*
      r_error.programa := p_programa;
      v_buffer := p_mensaje
--         CASE
--            WHEN v_lopr_id IS NULL THEN p_mensaje
--            ELSE '[log id:' || v_lopr_id || ']:' || p_mensaje
--         END
         || CHR (10)
         || DBMS_UTILITY.format_error_backtrace;
      v_largo_mensaje := LENGTHB (v_buffer);

      --*
      r_error.mensaje :=
         SUBSTRB (v_buffer, 1, LEAST (v_largo_mensaje, k_max_largo_mensaje));
      r_error.aud_creado_en := LOCALTIMESTAMP;
      r_error.aud_creado_por := USER;
      --r_error.lopr_id := v_lopr_id;
      insert_commit_at (r_error);

      IF p_raise
      THEN
         raise_application_error (k_ue_error_fatal, NVL (v_buffer, --p_mensaje || CHR (10) || DBMS_UTILITY.format_error_backtrace,
                                                                  'Sin Mensaje'), FALSE);
      END IF;
   EXCEPTION
      WHEN ug_error_fatal
      THEN
         DBMS_OUTPUT.put_line (k_modulo || ':' || SQLERRM);
         DBMS_OUTPUT.put_line (k_modulo || ':' || DBMS_UTILITY.format_error_backtrace);

         RAISE;
      WHEN OTHERS
      THEN
         DBMS_OUTPUT.put_line (k_modulo || ':' || SQLERRM);
         DBMS_OUTPUT.put_line (k_modulo || ':' || DBMS_UTILITY.format_error_backtrace);
         raise_application_error (k_ue_error_fatal, k_modulo || ':' || SQLERRM, TRUE);
   END informa;
END utl_error;
/
SHOW ERRORS;


