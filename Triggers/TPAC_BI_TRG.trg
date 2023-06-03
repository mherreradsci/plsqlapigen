CREATE OR REPLACE TRIGGER GAT.TPAC_BI_TRG
   BEFORE INSERT
   ON gat.gat_tip_packages
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_creado_en := LOCALTIMESTAMP;
   :new.aud_creado_por := USER;
END tpac_bi_trg;
/
SHOW ERRORS;


