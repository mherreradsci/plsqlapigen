CREATE OR REPLACE TRIGGER GAT.PROD_BU_TRG
   BEFORE UPDATE
   ON gat.gat_productos
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END prod_bu_trg;
/
SHOW ERRORS;


