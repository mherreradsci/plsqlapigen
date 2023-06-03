CREATE OR REPLACE TRIGGER GAT.TOBJ_BU_TRG
   BEFORE UPDATE
   ON gat.GAT_TIP_OBJETOS
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END tobj_bu_trg;
/
SHOW ERRORS;


