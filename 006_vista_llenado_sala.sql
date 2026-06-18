SET search_path TO cine;

CREATE OR REPLACE VIEW vista_llenado_sala AS

SELECT
    s.sala_id,
    s.nombre,
    s.capacidad,

    CASE
        WHEN COUNT(DISTINCT f.funcion_id) = 0 THEN 0
        ELSE ROUND(
            COUNT(e.entrada_id) * 100.0 /
            (s.capacidad * COUNT(DISTINCT f.funcion_id)),
            2
        )
    END AS porcentaje_llenado

FROM sala s

LEFT JOIN funcion f
ON s.sala_id = f.sala_id

LEFT JOIN entrada e
ON f.funcion_id = e.funcion_id

GROUP BY
    s.sala_id,
    s.nombre,
    s.capacidad;

INSERT INTO schema_migrations(version)
VALUES('006-vista-llenado-sala');