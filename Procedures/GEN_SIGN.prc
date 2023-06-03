CREATE OR REPLACE PROCEDURE GAT.gen_sign (
   p_perf_id   IN            gat_productos.prod_id%TYPE,
   p_lineas    IN OUT NOCOPY utl_line.lines_t)
IS
   CURSOR c_tpso (p_perf_id gat_perfiles.perf_id%TYPE)
   IS
      SELECT tpso.linea
      FROM gat_tplt_source tpso
      WHERE tpso.perf_id = p_perf_id AND tpso.ttem_codigo = GAT_TIP_TEMPLATES_KP.K_FIRMA_APP
      ORDER BY tpso.tpso_id;

   v_lineas        utl_line.lines_t;

   SUBTYPE r_tema IS gat_template_map%ROWTYPE;

   TYPE tema_ct IS TABLE OF r_tema;

   v_tema          tema_ct;
   --*
   v_sql_command   VARCHAR2 (4000);
   v_valor         VARCHAR2 (4000);

   TYPE valores_t IS TABLE OF v_valor%TYPE
                        INDEX BY BINARY_INTEGER;

   v_valores       valores_t;
BEGIN
   --* Carga el template
   OPEN c_tpso (p_perf_id);

   FETCH c_tpso
   BULK COLLECT INTO v_lineas;

   CLOSE c_tpso;

   --*****************************
   -- Carga de parametros
   SELECT *
   BULK COLLECT INTO v_tema
   FROM gat_template_map tema
   WHERE tema.perf_id = p_perf_id;

   IF SQL%ROWCOUNT = 0
   THEN
      raise_application_error (-20100, 'No hay registros en gat_template_map');
   END IF;

   -- reemplaza los parametros que son de tabla
   FOR i IN v_tema.FIRST .. v_tema.LAST LOOP
      v_sql_command :=
         CASE v_tema (i).tipr_codigo
            WHEN GAT_TIP_PARAMETROS_KP.K_VALORES_GENERALES
            THEN
               'SELECT ' || v_tema (i).component || '.' || v_tema (i).subcomponent
            --|| '(sysdate)'
            WHEN GAT_TIP_PARAMETROS_KP.K_FUNCION_PRIMITIVA
            THEN
               'SELECT ' || v_tema (i).component
            WHEN GAT_TIP_PARAMETROS_KP.K_VALORES_X_CONTEXTO
            THEN
               'SELECT ' || v_tema (i).component               
         END
         || ' from dual';

      --DBMS_OUTPUT.put_line ('v_sql_command:' || v_sql_command);

      EXECUTE IMMEDIATE v_sql_command INTO v_valores (i);

      utl_line.rep_curr (v_tema (i).para_code,
                         v_valores (i),
                         v_lineas,
                         v_lineas.FIRST,
                         v_lineas.LAST);
   END LOOP;

   v_tema.delete;

   --* Reemplaza los parametros de tiempo de ejecución
   --* *************************************************************************

   /*
      DECLARE
         v_glosa      tip_packages.glosa%TYPE;
         v_comments   VARCHAR2 (2000); --DBA_TAB_COMMENTS.COMMENTS%type;
      BEGIN
         utl_line.rep_curr ('%TIMESTAMP%',
                            TO_CHAR (LOCALTIMESTAMP, 'YYYYMMDDHH24MISS'),
                            v_lineas,
                            v_lineas.FIRST,
                            v_lineas.LAST);
      END;
   */
   --* Asigna el parámetro de salida
   utl_line.put_line (p_lines_from => v_lineas, p_lines => p_lineas);
   v_lineas.delete;
END gen_sign;
/
SHOW ERRORS;


