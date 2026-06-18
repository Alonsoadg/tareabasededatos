SET search_path TO cine;

SELECT
    p.titulo,
    SUM(e.precio_pagado) AS recaudacion
FROM pelicula p
JOIN funcion f USING (pelicula_id)
JOIN entrada e USING (funcion_id)
GROUP BY p.titulo
ORDER BY recaudacion DESC
LIMIT 3;


SELECT
    f.funcion_id,
    p.titulo,
    s.nombre,
    COUNT(e.entrada_id) * 100.0 / s.capacidad AS porcentaje_ocupacion
FROM funcion f
JOIN pelicula p USING (pelicula_id)
JOIN sala s USING (sala_id)
LEFT JOIN entrada e USING (funcion_id)
GROUP BY
    f.funcion_id,
    p.titulo,
    s.nombre,
    s.capacidad
ORDER BY porcentaje_ocupacion DESC
LIMIT 1;

SELECT
    c.nombre,
    COUNT(DISTINCT e.funcion_id) AS funciones
FROM cliente c
JOIN entrada e USING (cliente_id)
GROUP BY c.cliente_id, c.nombre
HAVING COUNT(DISTINCT e.funcion_id) >= 3;


SELECT
    s.nombre,
    DATE(f.fecha_hora) AS fecha,
    SUM(e.precio_pagado) AS recaudacion
FROM sala s
JOIN funcion f USING (sala_id)
JOIN entrada e USING (funcion_id)
GROUP BY
    s.nombre,
    DATE(f.fecha_hora)
ORDER BY
    fecha,
    s.nombre;

SELECT
    p.titulo
FROM pelicula p
LEFT JOIN funcion f USING (pelicula_id)
LEFT JOIN entrada e USING (funcion_id)
GROUP BY
    p.pelicula_id,
    p.titulo
HAVING COUNT(e.entrada_id) = 0;


SELECT
    TO_CHAR(f.fecha_hora,'HH24:MI') AS horario,
    COUNT(e.entrada_id) AS entradas_vendidas
FROM funcion f
JOIN entrada e USING (funcion_id)
GROUP BY
    TO_CHAR(f.fecha_hora,'HH24:MI')
ORDER BY
    entradas_vendidas DESC
LIMIT 1;