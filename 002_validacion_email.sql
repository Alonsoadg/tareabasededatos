SET search_path TO cine;

CREATE OR REPLACE FUNCTION revisar_email()
RETURNS TRIGGER
AS
$$
BEGIN

    IF NEW.email !~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
        RAISE EXCEPTION 'El email ingresado no es valido.';
    END IF;

    RETURN NEW;

END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS validar_email_cliente ON cliente;

CREATE TRIGGER validar_email_cliente
BEFORE INSERT OR UPDATE
ON cliente
FOR EACH ROW
EXECUTE FUNCTION revisar_email();

INSERT INTO schema_migrations(version)
VALUES('002-validacion-email');