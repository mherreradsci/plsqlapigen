ALTER TABLE GAT.GAT_TEMPLATE_MAP ADD (
  CONSTRAINT TEMA_TPLT_FK2 
  FOREIGN KEY (PERF_ID, TTEM_CODIGO) 
  REFERENCES GAT.GAT_TEMPLATES (PERF_ID,TTEM_CODIGO)
  ENABLE VALIDATE)
/

ALTER TABLE GAT.GAT_TEMPLATE_MAP ADD (
  CONSTRAINT TEMA_TPAR_FK1 
  FOREIGN KEY (TIPR_CODIGO) 
  REFERENCES GAT.GAT_TIP_PARAMETROS (TIPR_CODIGO)
  ENABLE VALIDATE)
/

