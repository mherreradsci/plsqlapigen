CREATE OR REPLACE TRIGGER GAT.PERF_BU_TRG
   BEFORE UPDATE
   ON GAT.GAT_PERFILES    REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.aud_modificado_en := LOCALTIMESTAMP;
   :new.aud_modificado_por := USER;
END perf_bu_trg;
/
SHOW ERRORS;


