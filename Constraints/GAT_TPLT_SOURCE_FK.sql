ALTER TABLE GAT.GAT_TPLT_SOURCE ADD (
  CONSTRAINT TPSO_TPLT_FK1 
  FOREIGN KEY (PERF_ID, TTEM_CODIGO) 
  REFERENCES GAT.GAT_TEMPLATES (PERF_ID,TTEM_CODIGO)
  ENABLE VALIDATE)
/

