CREATE OR REPLACE TRIGGER GAT.APPL_BI_TRG
   BEFORE INSERT
   ON gat.app_aplicaciones
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.appl_id := app_aplicaciones_sec.NEXTVAL;
   :new.aud_creado_en := LOCALTIMESTAMP;
   :new.aud_creado_por := USER;
END appl_bi_trg;
/
SHOW ERRORS;


