CREATE OR REPLACE TRIGGER GAT.OBGE_BI_TRG
   BEFORE INSERT
   ON GAT.GAT_OBJETOS_GENERADOS    REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_creado_en := LOCALTIMESTAMP;
   :new.aud_creado_por := USER;
END obge_bi_trg;
/
SHOW ERRORS;


