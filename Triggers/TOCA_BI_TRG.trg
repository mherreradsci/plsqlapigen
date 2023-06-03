CREATE OR REPLACE TRIGGER GAT.TOCA_BI_TRG
   BEFORE INSERT
   ON gat.GJC_TO_CATALOG_OLD
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_creado_en := LOCALTIMESTAMP;
   :new.aud_creado_por := USER;
END toca_bi_trg;
/
SHOW ERRORS;


