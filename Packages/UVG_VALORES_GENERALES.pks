CREATE OR REPLACE PACKAGE GAT.uvg_valores_generales
IS
   /*******************************************************************************
   Empresa:    Explora-IT
   Proyecto:   Genera APIs de Tablas

   Nombre:     UVG_VALORES_GENERALES
   Proposito:  Package con las funciones para obtener los valores generales del
               proyecto GAT
   Observación:
               Este package es generado por el programa UVG_GENERA_PACKAGE_VAGE en
               función de los datos de la tabla fdc_valores_generales


   Cuando     Quien    Que
   ---------- -------- ------------------------------------------------------------
   20-03-2012 mherrert Creación de este package.
   *******************************************************************************/

   --* Funciones

   --*--------------------------------------------------------------------------
   -- Nombre:       NOMBRE_PROYECTO
   -- Descripción (1):
   --     Nombre del proyecto
   --*--------------------------------------------------------------------------
   FUNCTION nombre_proyecto (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2;

   --*--------------------------------------------------------------------------
   -- Nombre:       VERSION
   -- Descripción (1):
   --     Versión del sistema
   --*--------------------------------------------------------------------------
   FUNCTION version (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2;

   --*--------------------------------------------------------------------------
   -- Nombre:       GAT_AUTHOR
   -- Descripción (1):
   --     Autor del generador de Código
   --*--------------------------------------------------------------------------
   FUNCTION gat_author (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2;

   --*--------------------------------------------------------------------------
   -- Nombre:       GAT_GENFILES_DIR
   -- Descripción (1):
   --     Directorio Oracle donde dejar los archivos generados por GAT
   --*--------------------------------------------------------------------------
   FUNCTION gat_genfiles_dir (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2;

   --*--------------------------------------------------------------------------
   -- Nombre:       GFS_GENFILES_TO_DIR
   -- Descripción (1):
   --     Directorio Oracle donde generar los archivos TO
   --*--------------------------------------------------------------------------
   FUNCTION gfs_genfiles_to_dir (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2;

   --*--------------------------------------------------------------------------
   -- Nombre:       GFS_GENFILES_DAO_DIR
   -- Descripción (1):
   --     Directorio Oracle donde generar los archivos DAO
   --*--------------------------------------------------------------------------
   FUNCTION gfs_genfiles_dao_dir (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2;

   --*--------------------------------------------------------------------------
   -- Nombre:       GFS_GENFILES_DAO_IMPL_DIR
   -- Descripción (2):
   --     Directorio Oracle donde generar los archivos DAO Implementat
   --     ion
   --*--------------------------------------------------------------------------
   FUNCTION gfs_genfiles_dao_impl_dir (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2;

   --*--------------------------------------------------------------------------
   -- Nombre:       Java_package_path_TO
   -- Descripción (2):
   --     Java package path de los archivos TO (MHT: Esto debe estar en
   --     la configuración de cada Proyecto y no en los Generales)
   --*--------------------------------------------------------------------------
   FUNCTION java_package_path_to (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2;

   --*--------------------------------------------------------------------------
   -- Nombre:       Java_package_path_DAO
   -- Descripción (2):
   --     Java package path de los archivos DAO (MHT: Esto debe estar
   --     en la configuración de cada Proyecto y no en los Generales)
   --*--------------------------------------------------------------------------
   FUNCTION java_package_path_dao (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2;

   --*--------------------------------------------------------------------------
   -- Nombre:       Java_package_path_DAO_Impl
   -- Descripción (3):
   --     Java package path de la implementación de los archivos DAO (MHT:
   --     Esto debe estar en la configuración de cada Proyecto y no en
   --     los Generales)
   --*--------------------------------------------------------------------------
   FUNCTION java_package_path_dao_impl (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2;

   --*--------------------------------------------------------------------------
   -- Nombre:       OPCION_ROLLBACK
   -- Descripción (2):
   --     Indica si los generadores de código generan el bloque de exception
   --     con utl_error en Rollback
   --*--------------------------------------------------------------------------
   FUNCTION opcion_rollback (p_fecha_vigencia IN DATE)
      RETURN BOOLEAN;

   --*--------------------------------------------------------------------------
   -- Nombre:       OPCION_FIRMA
   -- Descripción (2):
   --     Indica si los generadores de código pone la firma en el código
   --     generado
   --*--------------------------------------------------------------------------
   FUNCTION opcion_firma (p_fecha_vigencia IN DATE)
      RETURN BOOLEAN;
END uvg_valores_generales;
/
SHOW ERRORS;


