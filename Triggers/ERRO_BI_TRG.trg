CREATE OR REPLACE TRIGGER GAT.erro_bi_trg
   BEFORE INSERT
   ON uer_errores
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
DECLARE
   v_proxy_user   uer_errores.aud_creado_por%TYPE;
BEGIN
   IF :new.erro_id IS NULL
   THEN
      SELECT uer_errores_sec.NEXTVAL
      INTO :new.erro_id
      FROM DUAL;
   END IF;

   :new.aud_creado_en := SYSDATE;

   v_proxy_user := SYS_CONTEXT ('USERENV', 'PROXY_USER');

   IF v_proxy_user IS NOT NULL
   THEN
      :new.aud_creado_por := v_proxy_user;
   ELSE
      :new.aud_creado_por := USER;
   END IF;
END;
/
SHOW ERRORS;


