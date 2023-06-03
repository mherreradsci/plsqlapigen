CREATE OR REPLACE TRIGGER GAT.fdc_valores_generales_bi_trg
   BEFORE INSERT
   ON fdc_valores_generales
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_id   NUMBER := 0.0;
BEGIN
   IF :NEW.id_valores_generales IS NULL THEN
      SELECT fdc_valores_generales_sec.NEXTVAL
      INTO   v_id
      FROM   DUAL;

      :NEW.id_valores_generales := v_id;
   END IF;

   :NEW.aud_creado_por := NVL (:NEW.aud_creado_por, USER);
   :NEW.aud_fec_creac := NVL (:NEW.aud_fec_creac, SYSDATE);
EXCEPTION
   WHEN OTHERS THEN
      -- Consider logging the error and then re-raise
      RAISE;
END fdc_valores_generales_bi_trg;
/
SHOW ERRORS;


