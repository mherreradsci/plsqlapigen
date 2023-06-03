CREATE OR REPLACE PACKAGE BODY GAT.uvg_valores_generales
IS
   FUNCTION nombre_proyecto (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2
   IS
      v_valor   VARCHAR2 (3);
   BEGIN
      SELECT valor
      INTO v_valor
      FROM fdc_valores_generales
      WHERE nombre = 'Nombre del Proyecto'
        AND p_fecha_vigencia BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

      RETURN v_valor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UVG_VALORES_GENERALES.NOMBRE_PROYECTO',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END nombre_proyecto;

   FUNCTION version (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2
   IS
      v_valor   VARCHAR2 (30);
   BEGIN
      SELECT valor
      INTO v_valor
      FROM fdc_valores_generales
      WHERE nombre = 'Versión Producción'
        AND p_fecha_vigencia BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

      RETURN v_valor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UVG_VALORES_GENERALES.VERSION',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END version;

   FUNCTION gat_author (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2
   IS
      v_valor   VARCHAR2 (45);
   BEGIN
      SELECT valor
      INTO v_valor
      FROM fdc_valores_generales
      WHERE nombre = 'GAT Autor'
        AND p_fecha_vigencia BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

      RETURN v_valor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UVG_VALORES_GENERALES.GAT_AUTHOR',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END gat_author;

   FUNCTION gat_genfiles_dir (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2
   IS
      v_valor   VARCHAR2 (30);
   BEGIN
      SELECT valor
      INTO v_valor
      FROM fdc_valores_generales
      WHERE nombre = 'Directorio GenFiles'
        AND p_fecha_vigencia BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

      RETURN v_valor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UVG_VALORES_GENERALES.GAT_GENFILES_DIR',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END gat_genfiles_dir;

   FUNCTION gfs_genfiles_to_dir (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2
   IS
      v_valor   VARCHAR2 (30);
   BEGIN
      SELECT valor
      INTO v_valor
      FROM fdc_valores_generales
      WHERE nombre = 'GenFiles Java TO'
        AND p_fecha_vigencia BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

      RETURN v_valor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UVG_VALORES_GENERALES.GFS_GENFILES_TO_DIR',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END gfs_genfiles_to_dir;

   FUNCTION gfs_genfiles_dao_dir (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2
   IS
      v_valor   VARCHAR2 (30);
   BEGIN
      SELECT valor
      INTO v_valor
      FROM fdc_valores_generales
      WHERE nombre = 'GenFiles Java DAO'
        AND p_fecha_vigencia BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

      RETURN v_valor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UVG_VALORES_GENERALES.GFS_GENFILES_DAO_DIR',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END gfs_genfiles_dao_dir;

   FUNCTION gfs_genfiles_dao_impl_dir (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2
   IS
      v_valor   VARCHAR2 (30);
   BEGIN
      SELECT valor
      INTO v_valor
      FROM fdc_valores_generales
      WHERE nombre = 'GenFiles Java DAO Imp'
        AND p_fecha_vigencia BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

      RETURN v_valor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (
            p_programa   => 'UVG_VALORES_GENERALES.GFS_GENFILES_DAO_IMPL_DIR',
            p_mensaje    => SQLERRM,
            p_rollback   => FALSE,
            p_raise      => TRUE);
   END gfs_genfiles_dao_impl_dir;

   FUNCTION java_package_path_to (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2
   IS
      v_valor   VARCHAR2 (256);
   BEGIN
      SELECT valor
      INTO v_valor
      FROM fdc_valores_generales
      WHERE nombre = 'Java package path TO'
        AND p_fecha_vigencia BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

      RETURN v_valor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UVG_VALORES_GENERALES.Java_package_path_TO',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END java_package_path_to;

   FUNCTION java_package_path_dao (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2
   IS
      v_valor   VARCHAR2 (256);
   BEGIN
      SELECT valor
      INTO v_valor
      FROM fdc_valores_generales
      WHERE nombre = 'Java package path DAO'
        AND p_fecha_vigencia BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

      RETURN v_valor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UVG_VALORES_GENERALES.Java_package_path_DAO',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END java_package_path_dao;

   FUNCTION java_package_path_dao_impl (p_fecha_vigencia IN DATE)
      RETURN VARCHAR2
   IS
      v_valor   VARCHAR2 (256);
   BEGIN
      SELECT valor
      INTO v_valor
      FROM fdc_valores_generales
      WHERE nombre = 'Java package path DAO Impl'
        AND p_fecha_vigencia BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

      RETURN v_valor;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (
            p_programa   => 'UVG_VALORES_GENERALES.Java_package_path_DAO_Impl',
            p_mensaje    => SQLERRM,
            p_rollback   => FALSE,
            p_raise      => TRUE);
   END java_package_path_dao_impl;

   FUNCTION opcion_rollback (p_fecha_vigencia IN DATE)
      RETURN BOOLEAN
   IS
      v_valor   VARCHAR2 (10);
   BEGIN
      SELECT valor
      INTO v_valor
      FROM fdc_valores_generales
      WHERE nombre = 'Genera Código Rollback'
        AND p_fecha_vigencia BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

      RETURN CASE v_valor WHEN 'TRUE' THEN TRUE WHEN 'FALSE' THEN FALSE ELSE NULL END;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UVG_VALORES_GENERALES.OPCION_ROLLBACK',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END opcion_rollback;

   FUNCTION opcion_firma (p_fecha_vigencia IN DATE)
      RETURN BOOLEAN
   IS
      v_valor   VARCHAR2 (10);
   BEGIN
      SELECT valor
      INTO v_valor
      FROM fdc_valores_generales
      WHERE nombre = 'Firma el código generado'
        AND p_fecha_vigencia BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

      RETURN CASE v_valor WHEN 'TRUE' THEN TRUE WHEN 'FALSE' THEN FALSE ELSE NULL END;
   EXCEPTION
      WHEN OTHERS
      THEN
         utl_error.informa (p_programa   => 'UVG_VALORES_GENERALES.OPCION_FIRMA',
                            p_mensaje    => SQLERRM,
                            p_rollback   => FALSE,
                            p_raise      => TRUE);
   END opcion_firma;
END uvg_valores_generales;
/
SHOW ERRORS;


