CREATE OR REPLACE TRIGGER GAT.TOCA_BU_TRG
   BEFORE UPDATE
   ON gat.GJC_TO_CATALOG_OLD
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END toca_bu_trg;
/
SHOW ERRORS;


