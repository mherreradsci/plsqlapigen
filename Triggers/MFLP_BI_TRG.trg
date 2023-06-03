CREATE OR REPLACE TRIGGER GAT.mflp_bi_trg
   BEFORE INSERT
   ON cau_mapa_flujos_programas
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
DECLARE
   v_proxy_user   cau_mapa_flujos_programas.aud_creado_por%TYPE;
BEGIN
   :new.nombre_objeto := UPPER (TRIM (:new.nombre_objeto));
   :new.nombre_programa := UPPER (TRIM (:new.nombre_programa));
   --*
   :new.aud_creado_en := LOCALTIMESTAMP;

   IF :new.mflp_id IS NULL
   THEN
      :new.mflp_id := cau_mapa_flujos_programas_sec.NEXTVAL;
   END IF;

   v_proxy_user := SYS_CONTEXT ('USERENV', 'CLIENT_IDENTIFIER');

   IF v_proxy_user IS NOT NULL
   THEN
      :new.aud_creado_por := v_proxy_user;
   ELSE
      :new.aud_creado_por := USER;
   END IF;
END;
/
SHOW ERRORS;


