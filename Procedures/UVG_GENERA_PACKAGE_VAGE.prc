CREATE OR REPLACE PROCEDURE GAT.uvg_genera_package_vage (
   p_opcion_rollback BOOLEAN DEFAULT FALSE)
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   FunDaCiones proyectos PL/SQL

Nombre:     UVG_GENERA_PACKAGE_VAGE
Clase:      Utilidades de Soporte
Proposito:  Procedimiento para construir el package UVG_VALORES_GENERALES

Cuando      Quien    Que
----------  -------- -----------------------------------------------------------
15-06-2009  mherrert Creación
20-mar-2012 mherrera Implementa que los valores de retorno sean BOOLEAN
*******************************************************************************/
IS
   -- Constantes para identificar el package/programa que se está ejecutando
   k_programa   CONSTANT fdc_defs.program_name_t := 'UVG_GENERA_PACKAGE_VAGE';
   k_modulo     CONSTANT fdc_defs.module_name_t := k_programa;
   --*
   v_usuario             VARCHAR2 (40) := 'mherrert';
   v_fecha               VARCHAR2 (40) := TO_CHAR (SYSDATE, 'dd-mm-yyyy');

   CURSOR c_vage
   IS
      SELECT *
      FROM fdc_valores_generales
      ORDER BY id_valores_generales;

   v_command             VARCHAR2 (4000);
BEGIN
   v_command := 'CREATE OR REPLACE PACKAGE UVG_VALORES_GENERALES IS';
   DBMS_OUTPUT.put_line (v_command);
   v_command :=
      '/*******************************************************************************
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
<dd-mm-yyyy> <usuario> Creación de este package.
*******************************************************************************/';
   v_command := REPLACE (v_command, '<dd-mm-yyyy>', v_fecha);
   v_command := REPLACE (v_command, '<usuario>', v_usuario);
   DBMS_OUTPUT.put_line (v_command);
   DBMS_OUTPUT.put (CHR (10));
   DBMS_OUTPUT.put_line ('   --* Funciones');
   DBMS_OUTPUT.put (CHR (10));

   --* Genera el spec
   --* *************************************************************************
   FOR r_vage IN c_vage LOOP
      DECLARE -- * Comentario de la función
         k_max_line_len   CONSTANT NUMBER (3) := 60.0;
         v_line                    VARCHAR2 (255);
         v_len                     NUMBER (6) := LENGTHB (r_vage.descripcion);
         --v_largo_frase             NUMBER (6);
         v_ciclos         CONSTANT NUMBER (10) := CEIL (v_len / k_max_line_len);
         v_pos_ini                 NUMBER (6);
         v_pos_fin                 NUMBER (6);
         v_pos_siguente_espacio    NUMBER (6);
      BEGIN
         v_command :=
            '   --*--------------------------------------------------------------------------';
         DBMS_OUTPUT.put_line (v_command);
         v_command := '   -- Nombre:       ' || r_vage.identificador;
         DBMS_OUTPUT.put_line (v_command);
         v_command := '   -- Descripción (' || v_ciclos || '):';
         DBMS_OUTPUT.put_line (v_command);
         v_pos_ini := 1.0;
         v_pos_fin :=
            CASE
               WHEN v_pos_ini + k_max_line_len - 1.0 < v_len
               THEN
                  v_pos_ini + k_max_line_len - 1.0
               ELSE
                  v_len
            END;

         --xxxDBMS_OUTPUT.put_line ('r_vage.descripcion:' || r_vage.descripcion);
         FOR i IN 1 .. v_ciclos LOOP
            --xxx DBMS_OUTPUT.put_line ('v_pos_ini:(' || v_pos_ini || ')- v_pos_fin(' || v_pos_fin || ')');
            --v_largo_frase := v_pos_fin - v_pos_ini + 1.0;
            IF SUBSTR (r_vage.descripcion, v_pos_fin, 1.0) = ' '
            THEN
               v_pos_siguente_espacio := 0.0;
            ELSE
               v_pos_siguente_espacio :=
                  NVL (INSTRB (SUBSTRB (r_vage.descripcion, v_pos_fin + 1.0), ' '), 0.0);
            END IF;

            --xxxDBMS_OUTPUT.put_line ('v_pos_siguente_espacio:' || v_pos_siguente_espacio);
            v_pos_fin := v_pos_fin + v_pos_siguente_espacio;
            --xxxDBMS_OUTPUT.put_line ('v_pos_ini:(' || v_pos_ini || ')- v_pos_fin(' || v_pos_fin || ')');
            v_line := SUBSTRB (r_vage.descripcion, v_pos_ini, v_pos_fin - v_pos_ini + 1.0);
            v_command := v_line;
            DBMS_OUTPUT.put_line ('   --     ' || v_command);
            v_pos_ini := v_pos_fin + 1.0;
            v_pos_fin := v_pos_ini + k_max_line_len - 1.0;
         END LOOP;

         v_command :=
            '   --*--------------------------------------------------------------------------';
         DBMS_OUTPUT.put_line (v_command);
      END; -- local scope

      DBMS_OUTPUT.put_line ('');
      -- * Function
      v_command :=
            '   FUNCTION '
         || r_vage.identificador
         || '(P_FECHA_VIGENCIA IN DATE) RETURN '
         || r_vage.tipo_valor_retorno
         || ';';
      DBMS_OUTPUT.put_line (v_command);
   END LOOP;

   v_command := 'END UVG_VALORES_GENERALES;';
   DBMS_OUTPUT.put_line (v_command);
   v_command := '/';

   --* Genera el body
   --* *************************************************************************
   DBMS_OUTPUT.put_line (v_command);
   v_command := 'CREATE OR REPLACE PACKAGE BODY UVG_VALORES_GENERALES IS';
   DBMS_OUTPUT.put_line (v_command);

   FOR r_vage IN c_vage LOOP
      v_command :=
            '   FUNCTION '
         || r_vage.identificador
         || '(P_FECHA_VIGENCIA IN DATE) RETURN '
         || r_vage.tipo_valor_retorno
         || ' IS';
      DBMS_OUTPUT.put_line (v_command);
      --* Body
      v_command := '      v_valor ' || r_vage.tipo_valor || ';';
      DBMS_OUTPUT.put_line (v_command);
      v_command := '   begin';
      DBMS_OUTPUT.put_line (v_command);

      --* Select
      DECLARE
         v_pos_final    NUMBER (10) := INSTR (r_vage.tipo_valor, '(');
         v_tipo_dato    VARCHAR2 (200);
         v_conversion   VARCHAR2 (200);
      BEGIN
         IF v_pos_final > 0
         THEN -- hay parentesis
            v_tipo_dato := SUBSTR (r_vage.tipo_valor, 1, v_pos_final - 1.0);
         ELSE
            v_tipo_dato := r_vage.tipo_valor;
         END IF;

         IF v_tipo_dato = 'NUMBER'
         THEN
            IF r_vage.formato_valor IS NOT NULL
            THEN
               v_conversion :=
                  'TO_NUMBER(VALOR,' || '''' || r_vage.formato_valor || '''' || ')';
            ELSE
               v_conversion := 'TO_NUMBER(VALOR)';
            END IF;
         ELSIF v_tipo_dato = 'DATE'
         THEN
            IF r_vage.formato_valor IS NOT NULL
            THEN
               v_conversion :=
                  'TO_DATE(VALOR,' || '''' || r_vage.formato_valor || '''' || ')';
            ELSE
               v_conversion := 'TO_NUMBER(VALOR)';
            END IF;
         ELSE
            v_conversion := 'VALOR';
         END IF;

         v_command :=
               '      SELECT '
            || v_conversion
            || CHR (10)
            || '      INTO V_VALOR '
            || CHR (10)
            || '      FROM fdc_valores_generales '
            || CHR (10)
            || '      WHERE NOMBRE='
            || ''''
            || r_vage.nombre
            || '''';

         DBMS_OUTPUT.put_line (v_command);
         v_command :=
            '      and P_FECHA_VIGENCIA BETWEEN FEC_INI_VIGENCIA AND FEC_FIN_VIGENCIA'
            || ';';
         DBMS_OUTPUT.put_line (v_command);

         IF r_vage.tipo_valor_retorno = 'BOOLEAN'
         THEN
            v_command :=
               '      return case v_valor when  ''TRUE'' then TRUE when ''FALSE'' then FALSE else null end;';
         ELSE
            v_command := '      return v_valor;';
         END IF;

         DBMS_OUTPUT.put_line (v_command);
      END; -- local scope

      --* exception
      v_command :=
            '  EXCEPTION'
         || CHR (10)
         || '      WHEN OTHERS THEN'
         || CHR (10)
         || '         utl_error.informa (p_programa =>'
         || ''''
         || 'UVG_VALORES_GENERALES.'
         || r_vage.identificador
         || ''','
         || CHR (10)
         || '                                p_mensaje =>       SQLERRM,'
         || CHR (10)
         || '                                p_rollback =>      '
         || CASE WHEN p_opcion_rollback THEN 'TRUE' ELSE 'FALSE' END
         || ','
         || CHR (10)
         || '                                p_raise =>         TRUE'
         || CHR (10)
         || '         );';
      DBMS_OUTPUT.put_line (v_command);
      --* end
      v_command := '   end ' || r_vage.identificador || ';';
      DBMS_OUTPUT.put_line (v_command);
      DBMS_OUTPUT.new_line;
   END LOOP;

   v_command := 'END UVG_VALORES_GENERALES;';
   DBMS_OUTPUT.put_line (v_command);
   v_command := '/';
   DBMS_OUTPUT.put_line (v_command);
EXCEPTION
   WHEN OTHERS
   THEN
      utl_error.informa (p_programa   => k_modulo,
                         p_mensaje    => SQLERRM,
                         p_rollback   => TRUE,
                         p_raise      => TRUE);
END uvg_genera_package_vage;
/
SHOW ERRORS;


