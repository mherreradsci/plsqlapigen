CREATE OR REPLACE TRIGGER GAT.TOBJ_BI_TRG
   BEFORE INSERT
   ON gat.GAT_TIP_OBJETOS
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_creado_en := LOCALTIMESTAMP;
   :new.aud_creado_por := USER;
END tobj_bi_trg;
/
SHOW ERRORS;


