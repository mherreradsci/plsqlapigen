CREATE OR REPLACE TRIGGER GAT.TEMA_BI_TRG
   BEFORE INSERT
   ON gat.gat_template_map
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_creado_en := LOCALTIMESTAMP;
   :new.aud_creado_por := USER;
END tema_bi_trg;
/
SHOW ERRORS;


