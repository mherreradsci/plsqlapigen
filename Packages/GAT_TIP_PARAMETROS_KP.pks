CREATE OR REPLACE PACKAGE GAT.gat_tip_parametros_kp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_PARAMETROS_KP
   Proposito:  Package con definiciones de Konstantes para tabla de tipos
               GAT_TIP_PARAMETROS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   22-mar-2012 mherrera     Creación
   *******************************************************************************/
   SUBTYPE tipr_codigo_st IS gat_tip_parametros.tipr_codigo%TYPE;

   k_valores_x_contexto   CONSTANT tipr_codigo_st := 'CNTXT'; -- Valores X Contexto
   k_ejecucion            CONSTANT tipr_codigo_st := 'EJEC'; -- Ejecución
   k_hard                 CONSTANT tipr_codigo_st := 'HARD'; -- Hard
   k_funcion_primitiva    CONSTANT tipr_codigo_st := 'PRIM'; -- Función Primitiva
   k_definido_por_tabla   CONSTANT tipr_codigo_st := 'TABLA'; -- Definido Por Tabla
   k_valores_generales    CONSTANT tipr_codigo_st := 'VAGE'; -- Valores Generales
END gat_tip_parametros_kp;
/
SHOW ERRORS;


