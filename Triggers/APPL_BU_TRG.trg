CREATE OR REPLACE TRIGGER GAT.APPL_BU_TRG
   BEFORE UPDATE
   ON gat.app_aplicaciones
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END appl_bu_trg;
/
SHOW ERRORS;


