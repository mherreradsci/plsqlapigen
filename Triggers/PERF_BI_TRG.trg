CREATE OR REPLACE TRIGGER GAT.PERF_BI_TRG
   BEFORE INSERT
   ON GAT.GAT_PERFILES    REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.perf_id := gat_perfiles_sec.NEXTVAL;
   :new.aud_creado_en := LOCALTIMESTAMP;
   :new.aud_creado_por := USER;
END perf_bi_trg;
/
SHOW ERRORS;


