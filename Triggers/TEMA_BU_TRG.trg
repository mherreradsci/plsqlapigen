CREATE OR REPLACE TRIGGER GAT.TEMA_BU_TRG
   BEFORE UPDATE
   ON gat.gat_template_map
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END tema_bu_trg;
/
SHOW ERRORS;


