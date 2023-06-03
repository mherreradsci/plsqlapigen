CREATE OR REPLACE PACKAGE GAT.gat_tip_templates_kp
IS
   /*******************************************************************************
   Empresa:    Explora Information Technologies
   Proyecto:   Generador de APIs de tablas
               GAT
   Nombre:     GAT_TIP_TEMPLATES_KP
   Proposito:  Package con definiciones de Konstantes para tabla de tipos
               GAT_TIP_TEMPLATES
   Descipción de la tabla:
   --** No disponible **--

   Cuando      Quien        Que
   ----------- ------------ -------------------------------------------------------
   22-mar-2012 mherrera     Creación
   *******************************************************************************/
   SUBTYPE ttem_codigo_st IS gat_tip_templates.ttem_codigo%TYPE;

   k_com_header_pkg   CONSTANT ttem_codigo_st := 'HCPK'; -- Com_Header_Pkg
   k_firma_app        CONSTANT ttem_codigo_st := 'HFPK'; -- Firma_App
END gat_tip_templates_kp;
/
SHOW ERRORS;


