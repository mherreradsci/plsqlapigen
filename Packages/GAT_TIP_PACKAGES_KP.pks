CREATE OR REPLACE PACKAGE GAT.gat_tip_packages_kp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_PACKAGES_KP
   Proposito:  Package con definiciones de Konstantes para tabla de tipos
               GAT_TIP_PACKAGES
   Descipción de la tabla:
   Tipos de packages del framework generados o adhoc

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   12-jul-2012 mherrera     Creación
   *******************************************************************************/
   SUBTYPE tpac_codigo_st IS gat_tip_packages.tpac_codigo%TYPE;

   k_package_changes      CONSTANT tpac_codigo_st := 'CP'; -- Package Changes
   k_package_deletes      CONSTANT tpac_codigo_st := 'DP'; -- Package Deletes
   k_package_inserts      CONSTANT tpac_codigo_st := 'IP'; -- Package Inserts
   k_package_konstants    CONSTANT tpac_codigo_st := 'KP'; -- Package Konstants
   k_package_queries      CONSTANT tpac_codigo_st := 'QP'; -- Package Queries
   k_package_rules        CONSTANT tpac_codigo_st := 'RP'; -- Package Rules
   k_package_types        CONSTANT tpac_codigo_st := 'TP'; -- Package Types
   k_package_updates      CONSTANT tpac_codigo_st := 'UP'; -- Package Updates
   k_package_extra        CONSTANT tpac_codigo_st := 'XP'; -- Package eXtra
END gat_tip_packages_kp;
/
SHOW ERRORS;


