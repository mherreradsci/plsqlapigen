CREATE OR REPLACE TRIGGER GAT.TPSO_BU_TRG
   BEFORE UPDATE
   ON gat.gat_tplt_source
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END tpso_bu_trg;
/
SHOW ERRORS;


