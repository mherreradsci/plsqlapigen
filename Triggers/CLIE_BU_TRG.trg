CREATE OR REPLACE TRIGGER GAT.CLIE_BU_TRG
   BEFORE UPDATE
   ON gat.cli_clientes
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END clie_bu_trg;
/
SHOW ERRORS;


