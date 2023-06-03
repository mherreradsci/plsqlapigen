ALTER TABLE GAT.GAT_TIP_PACKAGES ADD (
  CONSTRAINT TPAC_GENERADO_CCC
  CHECK ( GENERADO IN ('N', 'S'))
  ENABLE VALIDATE)
/

ALTER TABLE GAT.GAT_TIP_PACKAGES ADD (
  CONSTRAINT TPAC_PK
  PRIMARY KEY
  (TPAC_CODIGO)
  USING INDEX GAT.TPAC_PK
  ENABLE VALIDATE)
/

