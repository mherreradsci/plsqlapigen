CREATE OR REPLACE TRIGGER GAT.TPTP_BI_TRG
   BEFORE INSERT
   ON gat.gat_rel_tplt_tpac
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_creado_en := LOCALTIMESTAMP;
   :new.aud_creado_por := USER;
END tptp_bi_trg;
/
SHOW ERRORS;


