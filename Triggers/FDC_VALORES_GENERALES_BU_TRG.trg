CREATE OR REPLACE TRIGGER GAT.fdc_valores_generales_bu_trg
   BEFORE UPDATE
   ON fdc_valores_generales
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE

BEGIN
   :NEW.aud_creado_por := NVL (:NEW.aud_modif_por, USER);
   :NEW.aud_fec_creac := NVL (:NEW.aud_fec_modif, SYSDATE);
EXCEPTION
   WHEN OTHERS THEN
      -- Consider logging the error and then re-raise
      RAISE;
END fdc_valores_generales_bu_trg;
/
SHOW ERRORS;


