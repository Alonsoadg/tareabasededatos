SET search_path TO cine;

ALTER TABLE entrada
DROP CONSTRAINT IF EXISTS asiento_funcion_unico;

ALTER TABLE entrada
ADD CONSTRAINT asiento_funcion_unico
UNIQUE(funcion_id, asiento_id);

INSERT INTO schema_migrations(version)
VALUES('003-asiento-unico');