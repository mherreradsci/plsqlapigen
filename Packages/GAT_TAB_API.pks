CREATE OR REPLACE PACKAGE GAT.gat_tab_api --AUTHID CURRENT_USER
IS
   /*-----------------------------------------------------------------------------
   --
   --  Explora IT
   --  Proyecto: Utilidades para desarrolladores
   --  Objetivo: Procedimientos para generar un package de API de una tabla
   --
   -- Historia:
   -- Cuando      Quien    Comantario
   -- ----------- -------- -------------------------------------------------------
   -- 10-Feb-2003 mherrera Creación
   -- 14-Jul-2004 mherrert Se agrega funcionalidades y se normalza los nombres
   --                      para concordar con la nomenclatura de nombres de la
   --                      nomenclatura de nombres usado en Habitat.
   -- 08-Oct-2004 mherrera Modifica largo de identificadores a un máximo de 30
   --                      caracteres (Si el nombre de una columna o tabla está
   --                      definida con un largo mayor a 27 caracteres (27,28,29,30)
   --                      el proceso genera la API, pero no se lograba compilar
   --                      en forma exitosa ya que los nombres, en Oracle (default),
   --                      tienen un largo máximo de 30 caracteres. Esto implicó
   --                      modificar gran parte del código y muestra que el método
   --                      para generar los nombres de cualquier identificador es
   --                      bastante precario. Para una versión posterior se debe
   --                      modificar la forma de obtener los nombres vía una
   --                      función genérica.
   -- 13-Oct-2004 mherrera Se agrega el generador deun bulk insert via colecciones.
   -- 11-Nov-2004 mherrera Agrega p_table_owner a gen_pks y gen_pkb para un futuro uso
   --                      de dba_tables an vez de user_tables
   -----------------------------------------------------------------------------*/
   k_package   CONSTANT fdc_defs.package_name_t := 'GAT_TAB_API';

   /* retorna un arreglo de strings (lineas) con el codigo para el TAB_API de una tabla */
   PROCEDURE gen_pks (p_prod_id              IN            gat_productos.prod_id%TYPE,
                      --p_proy                 IN            VARCHAR2, -- nombre del proyecto
                      p_autor                IN            dba_users.username%TYPE,
                      p_package_owner        IN            all_users.username%TYPE,
                      p_package_type         IN            GAT_TIP_PACKAGES_TP.TPAC_CODIGO_T , -- tipo de package a generar
                      p_package_name         IN            all_objects.object_name%TYPE,
                      p_table_owner          IN            dba_objects.owner%TYPE,
                      p_table_name           IN            dba_tables.table_name%TYPE,
                      p_types_package_name   IN            all_objects.object_name%TYPE,
                      p_lineas                  OUT NOCOPY utl_line.lines_t);

   PROCEDURE gen_pkb (p_prod_id              IN            gat_productos.prod_id%TYPE,
                      --p_proy                 IN            VARCHAR2, -- nombre del proyecto
                      p_autor                IN            dba_users.username%TYPE,
                      p_package_owner        IN            all_users.username%TYPE,
                      p_package_type         IN            GAT_TIP_PACKAGES_TP.TPAC_CODIGO_T, -- tipo de package a generar
                      p_package_name         IN            all_objects.object_name%TYPE,
                      p_table_owner          IN            dba_objects.owner%TYPE,
                      p_table_name           IN            dba_tables.table_name%TYPE,
                      p_types_package_name   IN            all_objects.object_name%TYPE,
                      p_expand_cols          IN            BOOLEAN DEFAULT TRUE,
                      p_lineas                  OUT NOCOPY utl_line.lines_t);
END gat_tab_api;
/
SHOW ERRORS;


