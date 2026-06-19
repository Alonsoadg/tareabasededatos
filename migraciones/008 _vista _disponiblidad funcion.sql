SET search_path TO cine;

CREATE OR REPLACE VIEW vista_disponibilidad_funcion AS

SELECT
    f.funcion_id,
    p.titulo AS pelicula,
    s.nombre AS sala,
    f.fecha_hora,

    s.capacidad AS capacidad_total,

    COUNT(e.entrada_id) AS entradas_vendidas,

    s.capacidad - COUNT(e.entrada_id) AS asientos_disponibles,

    COALESCE(SUM(e.precio_pagado),0) AS recaudacion

FROM funcion f

JOIN pelicula p
ON f.pelicula_id = p.pelicula_id

JOIN sala s
ON f.sala_id = s.sala_id

LEFT JOIN entrada e
ON f.funcion_id = e.funcion_id

GROUP BY
    f.funcion_id,
    p.titulo,
    s.nombre,
    f.fecha_hora,
    s.capacidad;

INSERT INTO schema_migrations(version)
VALUES('008-vista-disponibilidad-funcion');