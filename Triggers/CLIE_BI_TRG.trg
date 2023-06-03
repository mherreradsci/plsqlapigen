CREATE OR REPLACE TRIGGER GAT.CLIE_BI_TRG
   BEFORE INSERT
   ON gat.cli_clientes
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   :new.clie_id := cli_clientes_sec.NEXTVAL;
   :new.aud_creado_en := LOCALTIMESTAMP;
   :new.aud_creado_por := USER;
END clie_bi_trg;
/
SHOW ERRORS;


