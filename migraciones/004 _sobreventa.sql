SET search_path TO cine;

CREATE OR REPLACE FUNCTION revisar_capacidad()
RETURNS TRIGGER
AS
$$
DECLARE
    capacidad_sala INT;
    entradas_vendidas INT;
BEGIN

    SELECT s.capacidad
    INTO capacidad_sala
    FROM sala s
    JOIN funcion f
    ON s.sala_id = f.sala_id
    WHERE f.funcion_id = NEW.funcion_id;

    SELECT COUNT(*)
    INTO entradas_vendidas
    FROM entrada
    WHERE funcion_id = NEW.funcion_id;

    IF entradas_vendidas >= capacidad_sala THEN
        RAISE EXCEPTION 'No quedan asientos disponibles para esta funcion.';
    END IF;

    RETURN NEW;

END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS controlar_capacidad ON entrada;

CREATE TRIGGER controlar_capacidad
BEFORE INSERT
ON entrada
FOR EACH ROW
EXECUTE FUNCTION revisar_capacidad();

INSERT INTO schema_migrations(version)
VALUES('004-sobreventa');