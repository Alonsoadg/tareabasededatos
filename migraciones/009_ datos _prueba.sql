SET search_path TO cine;

INSERT INTO pelicula (titulo, duracion_minutos, clasificacion)
VALUES
('El Hombre Araña', 125, 'TE'),
('Los Simpsons La Pelicula', 87, 'TE'),
('Los Croods', 98, 'TE'),
('Son Como Niños', 102, '14'),
('Iron Man', 126, 'TE');


INSERT INTO sala (nombre, capacidad)
VALUES
('Sala 1A', 67),
('Sala 2B', 75),
('Sala 3C', 50);


INSERT INTO asiento (sala_id, fila, numero, identificador)
VALUES
(1,'A',1,'A1'),
(1,'A',2,'A2'),
(1,'A',3,'A3'),

(2,'A',1,'A1'),
(2,'A',2,'A2'),
(2,'A',3,'A3'),

(3,'A',1,'A1'),
(3,'A',2,'A2'),
(3,'A',3,'A3');


INSERT INTO cliente (nombre, rut, email)
VALUES
('Juan Perez','12345678-5','juan@gmail.com'),
('Rene Puente','11111111-1','rene@gmail.com'),
('Alexis Sanchez','22222222-2','alexis@gmail.com'),
('Eduardo Vargas','33333333-3','eduardo@gmail.com'),
('Chupete Suazo','44444444-4','chupete@gmail.com'),
('Kalule Melendez','55555555-5','kalule@gmail.com'),
('Cristiano Messi','66666666-6','cristiano@gmail.com');

INSERT INTO funcion (pelicula_id, sala_id, fecha_hora, precio)
VALUES
(1,1,'2026-06-20 18:00:00',8000),
(2,2,'2026-06-20 18:00:00',7000),
(3,3,'2026-06-20 20:00:00',6500),
(4,1,'2026-06-21 18:00:00',6000),
(5,2,'2026-06-21 20:00:00',7500);


INSERT INTO entrada (funcion_id, cliente_id, asiento_id, precio_pagado)
VALUES

-- El Hombre Araña
(1,1,1,8000),
(1,2,2,8000),
(1,3,3,8000),

-- Los Simpsons
(2,1,4,7000),
(2,4,5,7000),
(2,5,6,7000),

-- Los Croods
(3,1,7,6500),
(3,6,8,6500),

-- Son Como Niños
(4,7,9,6000);

INSERT INTO schema_migrations(version)
VALUES ('009-datos-prueba');