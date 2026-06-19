SET search_path TO cine;

CREATE OR REPLACE VIEW vista_ventas_funcion AS

SELECT
    f.funcion_id,
    p.titulo AS pelicula,
    s.nombre AS sala,
    f.fecha_hora,

    COALESCE(SUM(e.precio_pagado), 0) AS total_vendido,

    ROUND(
        COALESCE(SUM(e.precio_pagado), 0) * 100.0 /
        NULLIF(
            (
                SELECT SUM(COALESCE(e2.precio_pagado,0))
                FROM funcion f2
                LEFT JOIN entrada e2
                    ON f2.funcion_id = e2.funcion_id
                WHERE DATE(f2.fecha_hora) = DATE(f.fecha_hora)
            ),
            0
        ),
        2
    ) AS porcentaje_dia

FROM funcion f

INNER JOIN pelicula p
    ON f.pelicula_id = p.pelicula_id

INNER JOIN sala s
    ON f.sala_id = s.sala_id

LEFT JOIN entrada e
    ON f.funcion_id = e.funcion_id

GROUP BY
    f.funcion_id,
    p.titulo,
    s.nombre,
    f.fecha_hora;

INSERT INTO schema_migrations(version)
VALUES ('007-vista-ventas-funcion');