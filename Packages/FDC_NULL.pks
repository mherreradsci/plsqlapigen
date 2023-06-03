CREATE OR REPLACE PACKAGE GAT.fdc_null
/*******************************************************************************
Empresa:    Explora IT
Proyecto:   Fundaciones

Nombre:     FDC_NULL
Proposito:  Para implementar manejo de parametros y valores por omisión

Cuando      Quien    Que
----------- -------- -----------------------------------------------------------
17-04-2012  mherrera Creación
*******************************************************************************/
AS
   FUNCTION nldate (p_name VARCHAR2)
      RETURN DATE;

   FUNCTION nlvc2 (p_name VARCHAR2)
      RETURN VARCHAR2;

   FUNCTION nlnum (p_name VARCHAR2)
      RETURN NUMBER;

   FUNCTION nlclob (p_name VARCHAR2)
      RETURN CLOB;

   FUNCTION nlblob (p_name VARCHAR2)
      RETURN BLOB;

   FUNCTION nlts (p_name VARCHAR2)
      RETURN TIMESTAMP;

   FUNCTION nlraw (p_name VARCHAR2)
      RETURN RAW;
END fdc_null;
/
SHOW ERRORS;


