ALTER TABLE GAT.CAU_MAPA_FLUJOS_PROGRAMAS ADD (
  CONSTRAINT MFLP_PK
  PRIMARY KEY
  (MFLP_ID)
  USING INDEX GAT.MFLP_PK
  ENABLE VALIDATE)
/

