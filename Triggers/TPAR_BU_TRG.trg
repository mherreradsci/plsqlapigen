CREATE OR REPLACE TRIGGER GAT.TPAR_BU_TRG
   BEFORE UPDATE
   ON gat.gat_tip_parametros
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END tpar_bu_trg;
/
SHOW ERRORS;


