CREATE TABLE GAT.CAU_MAPA_FLUJOS_PROGRAMAS
(
  MFLP_ID             NUMBER(10),
  CAU_ID              NUMBER(10)                NOT NULL,
  FLUJO               VARCHAR2(60 BYTE)         NOT NULL,
  OWNER               VARCHAR2(30 BYTE)         NOT NULL,
  NOMBRE_OBJETO       VARCHAR2(60 BYTE)         NOT NULL,
  NOMBRE_PROGRAMA     VARCHAR2(60 BYTE)         NOT NULL,
  AUD_CREADO_POR      VARCHAR2(45 BYTE)         DEFAULT USER                  NOT NULL,
  AUD_CREADO_EN       TIMESTAMP(6)              DEFAULT LOCALTIMESTAMP        NOT NULL,
  AUD_MODIFICADO_POR  VARCHAR2(45 BYTE),
  AUD_MODIFICADO_EN   TIMESTAMP(6)
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
/


