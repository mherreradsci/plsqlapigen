CREATE TABLE GAT.CLI_CLIENTES
(
  CLIE_ID             NUMBER(10)                NOT NULL,
  NOMBRE_CORTO        VARCHAR2(25 BYTE),
  NOMBRE              VARCHAR2(120 BYTE)        NOT NULL,
  AUD_CREADO_EN       TIMESTAMP(6)              DEFAULT LOCALTIMESTAMP        NOT NULL,
  AUD_CREADO_POR      VARCHAR2(45 BYTE)         DEFAULT USER                  NOT NULL,
  AUD_MODIFICADO_EN   TIMESTAMP(6),
  AUD_MODIFICADO_POR  VARCHAR2(45 BYTE)
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
/


