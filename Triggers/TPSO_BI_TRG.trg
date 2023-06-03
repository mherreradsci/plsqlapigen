CREATE OR REPLACE TRIGGER GAT.TPSO_BI_TRG
   BEFORE INSERT
   ON gat.gat_tplt_source
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_creado_en := LOCALTIMESTAMP;
   :new.aud_creado_por := USER;
END tpso_bi_trg;
/
SHOW ERRORS;


