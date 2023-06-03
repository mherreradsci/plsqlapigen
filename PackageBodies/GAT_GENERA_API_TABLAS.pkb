CREATE OR REPLACE PACKAGE BODY GAT.gat_genera_api_tablas
/*
Empresa:    Explora IT
Proyecto:   Utiles
Objetivo:   GENERA API TABLAS para un esquema determinado, la tabla debe estar en
            el esquema donde se ejecuta esta utilidad

Historia    Quien    Descripción
----------- -------- -------------------------------------------------------------
21-Jul-2004 mherrert Creación
10-Nov-2004 mherrera Agrega p_table_owner y p_solo_spec, deja pendiente el manejo de los
                     parámetros.
15-Feb-2009 mherrera Agrega modulo para compilar el código generado
25-May-2009 mherrera Agrega el Package Owner para cuando el package se debe
                     compilar en un esquema distinto al dueño de las tablas
26-Feb-2012 mherrera Agrega la generación de archivo con UTL_WRITE

*/
IS
   FUNCTION btos (p_value IN BOOLEAN)
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN CASE p_value
                WHEN TRUE THEN 'TRUE'
                WHEN FALSE THEN 'FALSE'
                ELSE TO_CHAR (NULL)
             END;
   END btos;

   PROCEDURE gencod (p_prod_id         IN gat_productos.prod_id%TYPE,
                     p_autor           IN all_users.username%TYPE,
                     p_table_owner     IN all_objects.owner%TYPE,
                     p_table_name      IN all_tables.table_name%TYPE,
                     p_package_owner   IN all_users.username%TYPE,
                     p_genera_body     IN BOOLEAN DEFAULT TRUE,
                     p_expand_cols     IN BOOLEAN DEFAULT TRUE,
                     p_spool_out       IN BOOLEAN DEFAULT FALSE,
                     p_write_files     IN BOOLEAN DEFAULT TRUE,
                     p_compile         IN BOOLEAN DEFAULT FALSE)
   IS
      k_programa    CONSTANT fdc_defs.program_name_t := UPPER ('gencod');
      k_modulo      CONSTANT fdc_defs.module_name_t
                                := SUBSTR (k_package || '.' || k_programa, 1, 61) ;

      --*
      TYPE tipos_packages_t IS VARRAY (3) OF VARCHAR2 (2);

      v_tipos_packages       tipos_packages_t
         := tipos_packages_t (GAT_TIP_PACKAGES_KP.K_PACKAGE_QUERIES,
                              GAT_TIP_PACKAGES_KP.K_PACKAGE_CHANGES );
      v_lineas               utl_line.lines_t;
      v_package_name_types   gat_defs.id_name_t;
      v_package_name         gat_defs.id_name_t;
   BEGIN
      -- Valida que la tabla exista en el esquema
      IF NOT utl_desc.table_exists (UPPER (p_table_owner), UPPER (p_table_name))
      THEN
         raise_application_error (
            -20100,
               'La tabla ('
            || p_table_name
            || ') no existe en el esquema del usuario:'
            || p_table_owner,
            FALSE);
      END IF;


      --* Set Context
      gat_proyecto_ctx.initialize(p_prod_id);
      --
      gat_table_ctx.initialize;
      gat_table_ctx.set_table_context (
         p_table_owner        => p_table_owner,
         p_table_name         => p_table_name,
         p_table_short_name   => gat_utl.get_table_short_name (p_table_owner,
                                                               p_table_name));
      -- Genera package de tipos
      --* ----------------------------------------------------------------------
      v_package_name_types :=
         gat_utl.gen_package_name (gat_defs.k_package_perfix,
                                   p_table_name,
                                   GAT_TIP_PACKAGES_KP.K_PACKAGE_TYPES );

      --   dbms_output.put_line ('v_package_name_types:' || v_package_name_types);
      gat_tab_api.gen_pks (p_prod_id,
                           p_autor,
                           UPPER (p_package_owner),
                           GAT_TIP_PACKAGES_KP.K_PACKAGE_TYPES,
                           UPPER (v_package_name_types),
                           UPPER (p_table_owner),
                           UPPER (p_table_name),
                           UPPER (v_package_name_types),
                           v_lineas);

      IF p_write_files
      THEN
         utl_write.write_file (uvg_valores_generales.gat_genfiles_dir (SYSDATE), v_package_name_types, 'pks', v_lineas);
      END IF;

      IF p_spool_out
      THEN
         utl_line.spool_out (v_lineas);
      END IF;

      IF p_compile
      THEN
         gat_compila.compila_codigo (v_lineas);
      END IF;

      v_lineas.delete;

      gat_objetos_generados_rp.obge_merge_catalogo (
         p_prod_id         => p_prod_id,
         p_nombre_objeto   => v_package_name_types,
         p_tobj_codigo     => gat_tip_objetos_kp.k_especificacion,
         p_compilado       => btos (p_compile));

      -- Genera packages para Queries y Changes (%QP y %CP)
      --* ----------------------------------------------------------------------
      FOR i IN v_tipos_packages.FIRST .. v_tipos_packages.LAST LOOP
         v_package_name :=
            gat_utl.gen_package_name (gat_defs.k_package_perfix,
                                      p_table_name,
                                      v_tipos_packages (i));

         gat_tab_api.gen_pks (p_prod_id,
                              p_autor,
                              UPPER (p_package_owner),
                              v_tipos_packages (i),
                              UPPER (v_package_name),
                              UPPER (p_table_owner),
                              UPPER (p_table_name),
                              UPPER (v_package_name_types),
                              v_lineas);

         IF p_write_files
         THEN
            utl_write.write_file (uvg_valores_generales.gat_genfiles_dir (SYSDATE), v_package_name, 'pks', v_lineas);
         END IF;

         IF p_spool_out
         THEN
            utl_line.spool_out (v_lineas);
         END IF;

         IF p_compile
         THEN
            gat_compila.compila_codigo (v_lineas);
         END IF;

         v_lineas.delete;

         gat_objetos_generados_rp.obge_merge_catalogo (
            p_prod_id         => p_prod_id,
            p_nombre_objeto   => v_package_name,
            p_tobj_codigo     => gat_tip_objetos_kp.k_especificacion,
            p_compilado       => btos (p_compile));

         IF p_genera_body
         THEN
            gat_tab_api.gen_pkb (p_prod_id,
                                 p_autor,
                                 UPPER (p_package_owner),
                                 v_tipos_packages (i),
                                 UPPER (v_package_name),
                                 UPPER (p_table_owner),
                                 UPPER (p_table_name),
                                 UPPER (v_package_name_types),
                                 p_expand_cols,
                                 v_lineas);

            IF p_write_files
            THEN
               utl_write.write_file (uvg_valores_generales.gat_genfiles_dir (SYSDATE), v_package_name, 'pkb', v_lineas);
            END IF;

            IF p_spool_out
            THEN
               utl_line.spool_out (v_lineas);
            END IF;

            IF p_compile
            THEN
               gat_compila.compila_codigo (v_lineas);
            END IF;

            v_lineas.delete;

            gat_objetos_generados_rp.obge_merge_catalogo (
               p_prod_id         => p_prod_id,
               p_nombre_objeto   => v_package_name,
               p_tobj_codigo     => gat_tip_objetos_kp.k_implementacion,
               p_compilado       => btos (p_compile));
         END IF;
      END LOOP;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_output.put_line (k_modulo || ':ERROR:' || SQLERRM);
         utl_error.informa (k_modulo);
   END gencod;
END gat_genera_api_tablas;
/
SHOW ERRORS;


