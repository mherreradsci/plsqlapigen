CREATE OR REPLACE TRIGGER GAT.OBGE_BU_TRG
   BEFORE UPDATE
   ON GAT.GAT_OBJETOS_GENERADOS    REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END obge_bu_trg;
/
SHOW ERRORS;


