CREATE OR REPLACE PACKAGE GAT.gat_tip_objetos_kp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_OBJETOS_KP
   Proposito:  Package con definiciones de Konstantes para tabla de tipos
               GAT_TIP_OBJETOS
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   22-mar-2012 mherrera     Creación
   *******************************************************************************/
   SUBTYPE tobj_codigo_st IS gat_tip_objetos.tobj_codigo%TYPE;

   k_implementacion   CONSTANT tobj_codigo_st := 'IMPL'; -- Implementación
   k_especificacion   CONSTANT tobj_codigo_st := 'SPEC'; -- Especificación
END gat_tip_objetos_kp;
/
SHOW ERRORS;


