CREATE OR REPLACE PACKAGE BODY GAT.gat_proyecto_ctx
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     gat_proyecto_ctx
Proposito:  <Defina brevemente el objetivo del package>

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
21-03-2012 mherrera Creación
*******************************************************************************/
AS
   --* Variables, constantes, tipos y subtipos locales

   --* Procedimientos y funciones
   PROCEDURE set_parameter (p_name IN VARCHAR2, p_value IN VARCHAR2)
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'set_parameter';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   -- Variables, constantes, tipos y subtipos locales

   BEGIN
      --*
      --* Implementación.

      DBMS_SESSION.set_context ('PROYECTO_CTX', p_name, p_value);
   --* Fin Implementación
   --*

   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => k_modulo,
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END set_parameter;

   PROCEDURE initialize (p_prod_id IN gat_productos.prod_id%TYPE)
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'initialize';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
      -- Variables, constantes, tipos y subtipos locales
      v_clie_id             cli_clientes.clie_id%TYPE;
      v_clie_nombre_corto   cli_clientes.nombre_corto%TYPE;
      v_clie_nombre         cli_clientes.nombre%TYPE;
      v_appl_id             app_aplicaciones.appl_id%TYPE;
      v_appl_nombre_corto   app_aplicaciones.nombre_corto%TYPE;
      v_appl_nombre         app_aplicaciones.nombre%TYPE;
   BEGIN
      SELECT prod.clie_id,
             clie.nombre_corto clie_nombre_corto,
             clie.nombre clie_nombre,
             prod.appl_id,
             appl.nombre_corto appl_nombre_corto,
             appl.nombre appl_nombre
      INTO v_clie_id,
           v_clie_nombre_corto,
           v_clie_nombre,
           v_appl_id,
           v_appl_nombre_corto,
           v_appl_nombre
      FROM gat_productos prod,
           app_aplicaciones appl,
           cli_clientes clie,
           gat_perfiles perf
      WHERE prod.clie_id = clie.clie_id
        AND prod.appl_id = appl.appl_id
        AND prod.perf_id = perf.perf_id
        AND prod.prod_id = p_prod_id;

      set_parameter ('clie_id', v_clie_id);
      set_parameter ('clie_nombre_corto', v_clie_nombre_corto);
      set_parameter ('clie_nombre', v_clie_nombre);

      set_parameter ('appl_id', v_appl_id);
      set_parameter ('appl_nombre_corto', v_appl_nombre_corto);
      set_parameter ('appl_nombre', v_appl_nombre);
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => k_modulo,
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END initialize;
END gat_proyecto_ctx;
/
SHOW ERRORS;


