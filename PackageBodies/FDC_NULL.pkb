CREATE OR REPLACE PACKAGE BODY GAT.fdc_null
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
   PROCEDURE append_info (p_info VARCHAR2)
   IS
      v_current_info   VARCHAR2 (2000);
   BEGIN
      --dbms_output.put_line('fdc_null.append_info:p_info:'|| p_info);
      
      app_nulls_params_context.read_client_info (v_current_info);
      --dbms_output.put_line('fdc_null.append_info:v_current_info:'|| v_current_info);
      app_nulls_params_context.set_client_info (NVL (v_current_info, '#') || p_info || '#');
   END append_info;

   FUNCTION nldate (p_name VARCHAR2)
      RETURN DATE
   IS
   BEGIN
      append_info (p_name);
      RETURN NULL;
   END nldate;

   FUNCTION nlvc2 (p_name VARCHAR2)
      RETURN VARCHAR2
   IS
   BEGIN
      append_info (p_name);
      RETURN NULL;
   END nlvc2;

   FUNCTION nlnum (p_name VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      append_info (p_name);
      RETURN NULL;
   END nlnum;

   FUNCTION nlclob (p_name VARCHAR2)
      RETURN CLOB
   IS
   BEGIN
      append_info (p_name);
      RETURN NULL;
   END nlclob;

   FUNCTION nlblob (p_name VARCHAR2)
      RETURN BLOB
   IS
   BEGIN
      append_info (p_name);
      RETURN NULL;
   END nlblob;

   FUNCTION nlts (p_name VARCHAR2)
      RETURN TIMESTAMP
   IS
   BEGIN
      append_info (p_name);
      RETURN NULL;
   END nlts;

   FUNCTION nlraw (p_name VARCHAR2)
      RETURN RAW
   IS
   BEGIN
      append_info (p_name);
      RETURN NULL;
   END nlraw;
END fdc_null;
/
SHOW ERRORS;


