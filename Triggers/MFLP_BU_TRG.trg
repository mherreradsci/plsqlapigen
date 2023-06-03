CREATE OR REPLACE TRIGGER GAT.mflp_bu_trg
   BEFORE UPDATE
   ON cau_mapa_flujos_programas
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
DECLARE
   v_proxy_user   cau_mapa_flujos_programas.aud_modificado_por%TYPE;
BEGIN
   IF :new.aud_modificado_en IS NULL
   THEN
      :new.aud_modificado_en := SYSDATE;
   END IF;

   v_proxy_user := SYS_CONTEXT ('USERENV', 'CLIENT_IDENTIFIER'); -- SYS_CONTEXT ('USERENV', 'PROXY_USER');

   IF v_proxy_user IS NOT NULL
   THEN
      :new.aud_modificado_por := v_proxy_user;
   ELSE
      :new.aud_modificado_por := USER;
   END IF;
END;
/
SHOW ERRORS;


