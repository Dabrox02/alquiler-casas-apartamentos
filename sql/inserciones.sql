INSERT INTO cargo (nombre, descripcion) VALUES
('Gerente', 'Responsable de la gestión general'),
('Recepcionista', 'Encargado de la recepción y atención al cliente'),
('Limpieza', 'Encargado de la limpieza y mantenimiento');

INSERT INTO empleado (dni,nombres,apellidos,telefono,email,idCargo)
VALUES
  (25379094,'Isaac','Holland','894-9021','nisi.magna.sed@hotmail.couk',2),
  (8092780,'Eugenia','Clarke','741-4355','auctor.odio@yahoo.ca',1),
  (73532066,'Mark','Holland','447-1086','nisl.arcu@protonmail.couk',1),
  (50694116,'Ferdinand','Kramer','516-4111','vestibulum@icloud.com',1),
  (81802508,'Hakeem','Wiggins','335-1290','mi.lorem@outlook.ca',3),
  (43132557,'Brooke','Brooks','688-2185','vel.pede@protonmail.edu',2),
  (55532341,'Ivor','Kelly','343-4870','nec.tellus@outlook.com',3),
  (82296556,'Hyacinth','Carney','246-6434','vel@google.edu',2),
  (89463279,'Dante','Lara','675-5889','libero@hotmail.couk',1),
  (62244936,'Maia','Pickett','901-7426','molestie.sed@hotmail.couk',1);


INSERT INTO propiedad (descripcion, valorxNoche) VALUES
('Hermosa casa con vista al mar', 600000),
('Apartamento céntrico con todas las comodidades', 320000),
('Acogedora habitación en el corazón de la ciudad', 160000),
('Chalet con piscina privada y jardín', 800000),
('Moderno apartamento con terraza', 360000),
('Casa de campo rodeada de naturaleza', 480000),
('Amplia habitación con baño privado', 200000),
('Apartamento con vistas panorámicas', 340000),
('Casa antigua restaurada con encanto', 720000),
('Departamento ejecutivo en zona empresarial', 480000),
('Cabaña en la montaña con chimenea', 640000),
('Apartamento moderno con piscina comunitaria', 300000),
('Habitación con estilo minimalista', 240000),
('Casa colonial con patio interior', 680000),
('Piso luminoso cerca de atracciones turísticas', 380000),
('Casa de playa con acceso directo al mar', 880000),
('Loft en el centro histórico', 440000),
('Habitación temática para amantes del arte', 220000),
('Apartamento familiar con parque infantil', 400000),
('Villa de lujo con servicio de conserje', 1000000);


INSERT INTO detallePropiedad (idPropiedad, capacidadHuespedes, numHabitaciones, mascotas, numBanos, tipoPropiedad) VALUES
(1, 8, 4, 'si', 3, 'casa'),
(2, 4, 2, 'no', 1, 'apartamento'),
(3, 2, 1, 'si', 1, 'habitacion'),
(4, 10, 5, 'si', 4, 'casa'),
(5, 6, 3, 'no', 2, 'apartamento'),
(6, 4, 2, 'si', 1, 'casa'),
(7, 2, 1, 'no', 1, 'habitacion'),
(8, 4, 2, 'si', 1, 'apartamento'),
(9, 12, 6, 'si', 5, 'casa'),
(10, 4, 2, 'no', 1, 'apartamento'),
(11, 8, 4, 'si', 3, 'casa'),
(12, 6, 3, 'no', 2, 'apartamento'),
(13, 2, 1, 'si', 1, 'habitacion'),
(14, 10, 5, 'si', 4, 'casa'),
(15, 4, 2, 'no', 1, 'apartamento'),
(16, 8, 4, 'si', 3, 'casa'),
(17, 4, 2, 'no', 1, 'apartamento'),
(18, 2, 1, 'si', 1, 'habitacion'),
(19, 6, 3, 'no', 2, 'apartamento'),
(20, 10, 5, 'si', 4, 'casa');


INSERT INTO ubicacionPropiedad (idPropiedad, departamento, ciudad, direccion, detalle) VALUES
(1, 'Antioquia', 'Medellín', 'Calle 123', 'Cerca de la playa'),
(2, 'Bogotá D.C.', 'Bogotá', 'Avenida Principal 456', 'Zona comercial'),
(3, 'Cundinamarca', 'Chía', 'Carrera 789', 'Barrio residencial'),
(4, 'Valle del Cauca', 'Cali', 'Avenida 987', 'Con vista a la montaña'),
(5, 'Antioquia', 'Medellín', 'Carrera 654', 'Zona tranquila'),
(6, 'Santander', 'Bucaramanga', 'Calle 321', 'Cerca del bosque'),
(7, 'Bogotá D.C.', 'Bogotá', 'Carrera 234', 'Centro histórico'),
(8, 'Valle del Cauca', 'Cali', 'Avenida 876', 'Cerca del transporte público'),
(9, 'Antioquia', 'Medellín', 'Calle 567', 'Barrio exclusivo'),
(10, 'Bogotá D.C.', 'Bogotá', 'Avenida Principal 890', 'Zona financiera'),
(11, 'Valle del Cauca', 'Cali', 'Carrera 123', 'Cerca de parques'),
(12, 'Santander', 'Bucaramanga', 'Calle 456', 'Zona comercial'),
(13, 'Cundinamarca', 'Chía', 'Carrera 789', 'Barrio residencial'),
(14, 'Valle del Cauca', 'Cali', 'Avenida 987', 'Con vista a la montaña'),
(15, 'Antioquia', 'Medellín', 'Carrera 654', 'Zona tranquila'),
(16, 'Bogotá D.C.', 'Bogotá', 'Calle 321', 'Cerca del bosque'),
(17, 'Valle del Cauca', 'Cali', 'Avenida 876', 'Cerca del transporte público'),
(18, 'Antioquia', 'Medellín', 'Calle 567', 'Barrio exclusivo'),
(19, 'Bogotá D.C.', 'Bogotá', 'Avenida Principal 890', 'Zona financiera'),
(20, 'Valle del Cauca', 'Cali', 'Carrera 123', 'Cerca de parques');

