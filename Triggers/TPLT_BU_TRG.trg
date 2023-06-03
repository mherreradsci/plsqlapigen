CREATE OR REPLACE TRIGGER GAT.TPLT_BU_TRG
   BEFORE UPDATE
   ON gat.gat_templates
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END tplt_bu_trg;
/
SHOW ERRORS;


