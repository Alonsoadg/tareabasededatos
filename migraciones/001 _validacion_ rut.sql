SET search_path TO cine;

CREATE OR REPLACE FUNCTION revisar_rut()
RETURNS TRIGGER
AS
$BODY$
BEGIN

    IF NEW.rut !~ '^[0-9]{7,8}-[0-9Kk]$' THEN
        RAISE EXCEPTION 'RUT inválido.';
    END IF;

    RETURN NEW;

END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS validar_rut_cliente ON cliente;

CREATE TRIGGER validar_rut_cliente
BEFORE INSERT OR UPDATE
ON cliente
FOR EACH ROW
EXECUTE FUNCTION revisar_rut();

INSERT INTO schema_migrations(version)
VALUES('001-validacion-rut');