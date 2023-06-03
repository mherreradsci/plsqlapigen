CREATE OR REPLACE TRIGGER GAT.TPLT_BI_TRG
   BEFORE INSERT
   ON gat.gat_templates
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_creado_en := LOCALTIMESTAMP;
   :new.aud_creado_por := USER;
END tplt_bi_trg;
/
SHOW ERRORS;


