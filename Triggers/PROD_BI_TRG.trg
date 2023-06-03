CREATE OR REPLACE TRIGGER GAT.PROD_BI_TRG
   BEFORE INSERT
   ON gat.gat_productos
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.prod_id := gat_productos_sec.NEXTVAL;
   :new.aud_creado_en := LOCALTIMESTAMP;
   :new.aud_creado_por := USER;
END prod_bi_trg;
/
SHOW ERRORS;


