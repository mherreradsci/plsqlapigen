CREATE TABLE GAT.GJC_TO_CATALOG_OLD
(
  PERF_ID             NUMBER(10)                NOT NULL,
  TOCA_CODIGO         VARCHAR2(63 BYTE)         NOT NULL,
  SERIAL_VERSION_UID  NUMBER(20)                NOT NULL,
  ULTIMA_GENERACION   TIMESTAMP(6),
  AUD_CREADO_EN       TIMESTAMP(6)              DEFAULT LOCALTIMESTAMP        NOT NULL,
  AUD_CREADO_POR      VARCHAR2(45 BYTE)         DEFAULT USER                  NOT NULL,
  AUD_MODIFICADO_EN   TIMESTAMP(6),
  AUD_MODIFICADO_POR  VARCHAR2(45 BYTE)
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
/

COMMENT ON COLUMN GAT.GJC_TO_CATALOG_OLD.ULTIMA_GENERACION IS 'Última vez que el Generador de Java generó el código'
/



