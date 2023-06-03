CREATE OR REPLACE PACKAGE GAT.gat_tab_gen_kp
   AUTHID CURRENT_USER
AS
   /*******************************************************************************
   Empresa:    Explora IT
   Proyecto:   Genera APIs de Tablas
               GAT

   Nombre:     GAT_TAB_GEN_KP
   Proposito:  Genera un package para definir los valores Konstantes
               para las tablas de tipos estáticas

   Cuando     Quien    Que
   ---------- -------- ------------------------------------------------------------
   02/03/2012 mherrera Creación
   *******************************************************************************/

   -- Constantes para identificar el package
   k_package   CONSTANT fdc_defs.package_name_t := 'GAT_TAB_GEN_KP';

   --* Subtipos, Tipos, Constantes del package

   PROCEDURE gencod (p_prod_id         IN gat_productos.prod_id%TYPE,
                     p_author          IN all_users.username%TYPE,
                     p_table_owner     IN all_objects.owner%TYPE,
                     p_table_name      IN all_tables.table_name%TYPE,
                     p_package_owner   IN all_users.username%TYPE,
                     p_compile         IN BOOLEAN DEFAULT FALSE);
END gat_tab_gen_kp;
/
SHOW ERRORS;


