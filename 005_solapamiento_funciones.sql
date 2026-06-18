-- Evita que existan funciones a la misma vez en una sala.
SET search_path TO cine;

CREATE OR REPLACE FUNCTION revisar_horario()
RETURNS TRIGGER
AS
$$
DECLARE
    duracion_nueva INT;
    inicio_nuevo TIMESTAMP;
    fin_nuevo TIMESTAMP;
    conflicto INT;
BEGIN

    SELECT duracion_minutos
    INTO duracion_nueva
    FROM pelicula
    WHERE pelicula_id = NEW.pelicula_id;

    inicio_nuevo := NEW.fecha_hora;
    fin_nuevo := NEW.fecha_hora +
                 (duracion_nueva || ' minutes')::INTERVAL;

    SELECT COUNT(*)
    INTO conflicto
    FROM funcion f
    JOIN pelicula p
    ON f.pelicula_id = p.pelicula_id
    WHERE f.sala_id = NEW.sala_id
    AND f.funcion_id <> NEW.funcion_id
    AND (
        inicio_nuevo <
        f.fecha_hora + (p.duracion_minutos || ' minutes')::INTERVAL
    )
    AND (
        fin_nuevo >
        f.fecha_hora
    );

    IF conflicto > 0 THEN
        RAISE EXCEPTION
        'Ya existe una funcion en ese horario.';
    END IF;

    RETURN NEW;

END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS controlar_horario ON funcion;

CREATE TRIGGER controlar_horario
BEFORE INSERT OR UPDATE
ON funcion
FOR EACH ROW
EXECUTE FUNCTION revisar_horario();

INSERT INTO schema_migrations(version)
VALUES('005-solapamiento-funciones');