CREATE SCHEMA IF NOT EXISTS cine;

SET search_path TO cine;jkiu

CREATE TABLE IF NOT EXISTS schema_migrations(
    version TEXT PRIMARY KEY,
    applied_at TIMESTAMP DEFAULT now()
);

CREATE TABLE IF NOT EXISTS pelicula(
    pelicula_id SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    duracion_minutos INT NOT NULL,
    clasificacion VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS sala(
    sala_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL
);

CREATE TABLE IF NOT EXISTS asiento(
    asiento_id SERIAL PRIMARY KEY,
    sala_id INT REFERENCES sala(sala_id),
    fila CHAR(1),
    numero INT,
    identificador VARCHAR(5)
);

CREATE TABLE IF NOT EXISTS cliente(
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    rut VARCHAR(12),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS funcion(
    funcion_id SERIAL PRIMARY KEY,
    pelicula_id INT REFERENCES pelicula(pelicula_id),
    sala_id INT REFERENCES sala(sala_id),
    fecha_hora TIMESTAMP,
    precio NUMERIC(10,2)
);

CREATE TABLE IF NOT EXISTS entrada(
    entrada_id SERIAL PRIMARY KEY,
    funcion_id INT REFERENCES funcion(funcion_id),
    cliente_id INT REFERENCES cliente(cliente_id),
    asiento_id INT REFERENCES asiento(asiento_id),
    fecha_compra TIMESTAMP DEFAULT now(),
    precio_pagado NUMERIC(10,2)
);

INSERT INTO schema_migrations(version)
VALUES('000-modelo-inicial');