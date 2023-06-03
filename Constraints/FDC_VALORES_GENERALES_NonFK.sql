ALTER TABLE GAT.FDC_VALORES_GENERALES ADD (
  CONSTRAINT VAGE_IND_ESTADO_CCC
  CHECK ( IND_ESTADO IN (0, 1))
  ENABLE VALIDATE)
/

ALTER TABLE GAT.FDC_VALORES_GENERALES ADD (
  CONSTRAINT VAGE_PK
  PRIMARY KEY
  (ID_VALORES_GENERALES)
  USING INDEX GAT.VAGE_PK
  ENABLE VALIDATE)
/

ALTER TABLE GAT.FDC_VALORES_GENERALES ADD (
  CONSTRAINT VAGE_UK2
  UNIQUE (IDENTIFICADOR)
  USING INDEX GAT.VAGE_UK2
  ENABLE VALIDATE)
/

ALTER TABLE GAT.FDC_VALORES_GENERALES ADD (
  CONSTRAINT VAGE_UK1
  UNIQUE (NOMBRE)
  USING INDEX GAT.VAGE_UK1
  ENABLE VALIDATE)
/
