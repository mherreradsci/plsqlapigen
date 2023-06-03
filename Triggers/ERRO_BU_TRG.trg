CREATE OR REPLACE TRIGGER GAT.erro_bu_trg
   BEFORE UPDATE OF erro_id, programa, mensaje, aud_creado_por, aud_creado_en
   ON UER_ERRORES    REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   IF :new.aud_modificado_en IS NULL
   THEN
      :new.aud_modificado_en := SYSDATE;
   END IF;

   IF :new.aud_modificado_por IS NULL
   THEN
      :new.aud_modificado_por := USER;
   END IF;
END;
/
SHOW ERRORS;


