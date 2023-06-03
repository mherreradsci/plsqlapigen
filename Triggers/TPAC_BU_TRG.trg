CREATE OR REPLACE TRIGGER GAT.TPAC_BU_TRG
   BEFORE UPDATE
   ON gat.gat_tip_packages
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END tpac_bu_trg;
/
SHOW ERRORS;


