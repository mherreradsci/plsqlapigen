CREATE OR REPLACE TRIGGER GAT.TTEM_BU_TRG
   BEFORE UPDATE
   ON gat.gat_tip_templates
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END ttem_bu_trg;
/
SHOW ERRORS;


