CREATE OR REPLACE PACKAGE GAT.fdc_defs
IS
   /*
   Proyecto:   FunDaCiones proyectos PL/SQL
   Objetivo:   Package de definiciones generals para proyectos PL/SQL

   Historia    Quien    Descripción
   ----------- -------- -------------------------------------------------------------
   29-Abr-2009 mherrera Creación
   */

   -- Subtipos para identificar Packages y Programas, utilizado por el framework PL/SQL
   SUBTYPE package_name_t IS VARCHAR2 (30);

   SUBTYPE program_name_t IS VARCHAR2 (30);

   k_max_module_name_len   NUMBER (2) := 61;

   SUBTYPE module_name_t IS VARCHAR2 (61);

   -- nombre_package_t ||'.'||nombre_programa_t

   -- Constantes para identificar el package
   k_package      CONSTANT package_name_t := 'fdc_defs';
--* Para declarar variables que almacenan el resultado de la
--* función sqlerrm
--SUBTYPE sqlerrm_t IS VARCHAR2 (600);
END fdc_defs;
/
SHOW ERRORS;


