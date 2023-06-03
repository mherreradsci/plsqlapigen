CREATE OR REPLACE PACKAGE GAT.utl_error
IS
   /*
   Package:       pkg_utl_error
   Descripcion:   Maneja los errores de bajo nivel

   MODIFICACIONES (Orden ascendente)
   Persona  Fecha       Comentarios
   MODIFICACIONES (Orden descendente)

   Persona     Fecha        Comentarios
   ---------   ------      -----------------------------------------------------
   mherrert    17-Mar-2002 Creación
   mherrert    15-Nov-2004 Agrega parámetro p_rollback
   mherrert    28-Dec-2011 Agrega k_package debido a que se crea un procedimiento
                           en el body para hacer transacciones autónomas
   mherrert    18-Jan-2012 Modifica el largo del mensaje de error a 4000
   mherrera    21-Mar-2012 Cambia el p_rollback con valor DEFAULT a FALSE, de
                           esta manera, en forma explícita, la applicacion
                           siempre tiene el control de la transacción
   --------------------------------------------------------------------------------

   */

   -- Constantes para identificar el package
   k_package    CONSTANT fdc_defs.package_name_t := 'UTL_ERROR';

   SUBTYPE ue_codigo_error_t IS NUMBER (6);

   k_ue_error_fatal      ue_codigo_error_t := -20200;
   ug_error_fatal        EXCEPTION;
   PRAGMA EXCEPTION_INIT (ug_error_fatal, -20200);
   k_max_largo_mensaje   NUMBER (4) := 4000;

   PROCEDURE informa (p_programa   IN uer_errores_tp.programa_t,
                      p_mensaje    IN uer_errores_tp.mensaje_t DEFAULT SQLERRM,
                      p_rollback   IN BOOLEAN DEFAULT FALSE,
                      p_raise      IN BOOLEAN DEFAULT TRUE);
END utl_error;
/
SHOW ERRORS;


