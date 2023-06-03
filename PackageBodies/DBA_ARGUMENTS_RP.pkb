CREATE OR REPLACE PACKAGE BODY GAT.dba_arguments_rp
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Generador de APIs para Tablas
            GAT

Nombre:     DBA_ARGUMENTS_RP
Proposito:  APIs para vista DBA_ARGUMENTS

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
18-Feb-2012 mherrera Creación
*******************************************************************************/
AS
   --* Variables, constantes, tipos y subtipos locales

   --* Procedimientos y funciones
   PROCEDURE print_arguments (p_arguments IN dba_arguments_tp.dba_arguments_ct)
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'print_arguments';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;
   BEGIN
      DBMS_OUTPUT.put_line (k_programa || ':' || 'p_arguments.count:)' || p_arguments.COUNT);
      DBMS_OUTPUT.put_line (k_programa || ':' || 'p_arguments.first:' || p_arguments.first);

      FOR i IN p_arguments.FIRST .. p_arguments.LAST LOOP
         DBMS_OUTPUT.put_line ('OBJECT_NAME:' || p_arguments (i).object_name);
         DBMS_OUTPUT.put_line ('PACKAGE_NAME:' || p_arguments (i).package_name);
         DBMS_OUTPUT.put_line ('OBJECT_ID:' || p_arguments (i).object_id);
         DBMS_OUTPUT.put_line ('OVERLOAD:' || p_arguments (i).overload);
         DBMS_OUTPUT.put_line ('SUBPROGRAM_ID:' || p_arguments (i).subprogram_id);
         DBMS_OUTPUT.put_line ('ARGUMENT_NAME:' || p_arguments (i).argument_name);
         DBMS_OUTPUT.put_line ('POSITION:' || p_arguments (i).position);
         DBMS_OUTPUT.put_line ('SEQUENCE:' || p_arguments (i).sequence);
         DBMS_OUTPUT.put_line ('DATA_TYPE:' || p_arguments (i).data_type);
         DBMS_OUTPUT.put_line (' ');
      END LOOP;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => k_modulo,
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END print_arguments;

   PROCEDURE load (p_owner           IN     dba_arguments_tp.owner_t,
                   p_package_name    IN     dba_arguments_tp.package_name_t,
                   p_object_name     IN     dba_arguments_tp.object_name_t,
                   p_subprogram_id   IN     dba_arguments_tp.subprogram_id_t,
                   p_overload        IN     dba_arguments_tp.overload_t,
                   p_arguments          OUT dba_arguments_tp.dba_arguments_ct)
   IS
      -- Constantes para identificar el package/programa que se está ejecutando
      k_programa   CONSTANT fdc_defs.program_name_t := 'load';
      k_modulo     CONSTANT fdc_defs.module_name_t := k_package || '.' || k_programa;

      -- Variables, constantes, tipos y subtipos locales
      CURSOR c_argu (
         p_owner           IN dba_arguments_tp.owner_t,
         p_package_name    IN dba_arguments_tp.package_name_t,
         p_object_name     IN dba_arguments_tp.object_name_t,
         p_subprogram_id   IN dba_arguments_tp.subprogram_id_t,
         p_overload        IN dba_arguments_tp.overload_t)
      IS -- Solo para ref cursors
         SELECT * 
         FROM dba_arguments usar
         WHERE owner = p_owner
           AND package_name = p_package_name 
           AND object_name = p_object_name 
           AND subprogram_id = p_subprogram_id
           AND NVL (overload, '"###-1###"') = NVL (p_overload, '"###-1###"')
         ORDER BY --overload,
                 subprogram_id,
                  data_level,
                  position,
                  sequence;
   BEGIN
      --*
      --* Implementación.
      --DBMS_OUTPUT.put_line (k_programa || ':p_owner:' || p_owner);
      --DBMS_OUTPUT.put_line (k_programa || ':p_package_name:' || p_package_name);
      --DBMS_OUTPUT.put_line (k_programa || ':p_object_name:' || p_object_name);
      --DBMS_OUTPUT.put_line (k_programa || ':p_subprogram_id:' || p_subprogram_id);
      --DBMS_OUTPUT.put_line (k_programa || ':p_overload:' || p_overload);

      OPEN c_argu (p_owner,
                   p_package_name,
                   p_object_name,
                   p_subprogram_id,
                   p_overload);

      FETCH c_argu
      BULK COLLECT INTO p_arguments;

      CLOSE c_argu;
   --* Fin Implementación
   --*
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => k_modulo,
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END load;
END dba_arguments_rp;
/
SHOW ERRORS;


