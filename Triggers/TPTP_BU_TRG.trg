CREATE OR REPLACE TRIGGER GAT.TPTP_BU_TRG
   BEFORE UPDATE
   ON gat.gat_rel_tplt_tpac
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END tptp_bu_trg;
/
SHOW ERRORS;


