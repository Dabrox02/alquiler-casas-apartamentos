INSERT INTO cargo (nombre, descripcion) VALUES
('Gerente', 'Responsable de la gestion general'),
('Recepcionista', 'Encargado de la recepcion y atencion al cliente'),
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
('Apartamento centrico con todas las comodidades', 320000),
('Acogedora habitacion en el corazon de la ciudad', 160000),
('Chalet con piscina privada y jardin', 800000),
('Moderno apartamento con terraza', 360000),
('Casa de campo rodeada de naturaleza', 480000),
('Amplia habitacion con baño privado', 200000),
('Apartamento con vistas panoramicas', 340000),
('Casa antigua restaurada con encanto', 720000),
('Departamento ejecutivo en zona empresarial', 480000),
('Cabaña en la montaña con chimenea', 640000),
('Apartamento moderno con piscina comunitaria', 300000),
('Habitacion con estilo minimalista', 240000),
('Casa colonial con patio interior', 680000),
('Piso luminoso cerca de atracciones turisticas', 380000),
('Casa de playa con acceso directo al mar', 880000),
('Loft en el centro historico', 440000),
('Habitacion tematica para amantes del arte', 220000),
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
(1, 'Antioquia', 'Medellin', 'Calle 123', 'Cerca de la playa'),
(2, 'Bogota D.C.', 'Bogota', 'Avenida Principal 456', 'Zona comercial'),
(3, 'Cundinamarca', 'Chia', 'Carrera 789', 'Barrio residencial'),
(4, 'Valle del Cauca', 'Cali', 'Avenida 987', 'Con vista a la montaña'),
(5, 'Antioquia', 'Medellin', 'Carrera 654', 'Zona tranquila'),
(6, 'Santander', 'Bucaramanga', 'Calle 321', 'Cerca del bosque'),
(7, 'Bogota D.C.', 'Bogota', 'Carrera 234', 'Centro historico'),
(8, 'Valle del Cauca', 'Cali', 'Avenida 876', 'Cerca del transporte publico'),
(9, 'Antioquia', 'Medellin', 'Calle 567', 'Barrio exclusivo'),
(10, 'Bogota D.C.', 'Bogota', 'Avenida Principal 890', 'Zona financiera'),
(11, 'Valle del Cauca', 'Cali', 'Carrera 123', 'Cerca de parques'),
(12, 'Santander', 'Bucaramanga', 'Calle 456', 'Zona comercial'),
(13, 'Cundinamarca', 'Chia', 'Carrera 789', 'Barrio residencial'),
(14, 'Valle del Cauca', 'Cali', 'Avenida 987', 'Con vista a la montaña'),
(15, 'Antioquia', 'Medellin', 'Carrera 654', 'Zona tranquila'),
(16, 'Bogota D.C.', 'Bogota', 'Calle 321', 'Cerca del bosque'),
(17, 'Valle del Cauca', 'Cali', 'Avenida 876', 'Cerca del transporte publico'),
(18, 'Antioquia', 'Medellin', 'Calle 567', 'Barrio exclusivo'),
(19, 'Bogota D.C.', 'Bogota', 'Avenida Principal 890', 'Zona financiera'),
(20, 'Valle del Cauca', 'Cali', 'Carrera 123', 'Cerca de parques');

INSERT INTO imgPropiedad (idImgPropiedad, idPropiedad, urlImagen, descripcion) VALUES
(1, 1, 'https://a0.muscache.com/im/pictures/a1399e86-4cba-44fe-9099-80e5a6717f87.jpg?im_w=720', 'Vista frontal casa'),
(2, 1, 'https://a0.muscache.com/im/pictures/53dcc3b1-36bf-407b-aa60-b05f7efd6e0e.jpg?im_w=720', 'Sala de estar'),
(3, 2, 'https://a0.muscache.com/im/pictures/miso/Hosting-51809333/original/0da70267-d9da-4efb-9123-2714b651c9fd.jpeg?im_w=720', 'Sala de estar del apartamento'),
(4, 3, 'https://a0.muscache.com/im/pictures/miso/Hosting-51809333/original/279e191e-784b-405f-9cfd-7ed9ce4010cf.jpeg?im_w=720', 'Vista de la habitacion'),
(5, 4, 'https://a0.muscache.com/im/pictures/fa318921-7a3b-46e0-bfc5-9abe62b06050.jpg?im_w=720', 'Vista exterior chalet'),
(6, 5, 'https://a0.muscache.com/im/pictures/662c5480-04db-4018-8cd5-38db295bd2a3.jpg?im_w=720', 'Terraza del apartamento'),
(7, 6, 'https://a0.muscache.com/im/pictures/miso/Hosting-826134718441577316/original/da0692f3-d54d-4af4-a35e-75e2f6aee135.jpeg?im_w=720', 'Jardin de la casa de campo'),
(8, 7, 'https://a0.muscache.com/im/pictures/miso/Hosting-952914651862658637/original/c3e46666-e4f3-485e-8b06-ca25af238c67.jpeg?im_w=720', 'Vista de la habitacion con baño privado'),
(9, 8, 'https://a0.muscache.com/im/pictures/miso/Hosting-891961128789448188/original/6ee0030e-a10d-43de-9695-57b6c4867206.jpeg?im_w=720', 'Balcon del apartamento con vistas panoramicas'),
(10, 9, 'https://a0.muscache.com/im/pictures/c7fb837b-7d1f-41a6-9a4d-b971b333f4f6.jpg?im_w=720', 'Fachada de la casa antigua restaurada'),
(11, 10, 'https://a0.muscache.com/im/pictures/miso/Hosting-38672594/original/bb8b4880-297d-4ece-a394-65ba268fba8e.jpeg?im_w=720', 'Cabaña en la montaña'),
(12, 11, 'https://a0.muscache.com/im/pictures/miso/Hosting-42625784/original/6ba6979f-0dc8-480a-99a7-0a441451bdb0.jpeg?im_w=720', 'Piscina comunitaria del apartamento moderno'),
(13, 12, 'https://a0.muscache.com/im/pictures/miso/Hosting-53505989/original/52c962d1-fd91-4e22-a25b-53d5faf8be7e.jpeg?im_w=720', 'Habitacion minimalista'),
(14, 13, 'https://a0.muscache.com/im/pictures/612bce07-99e8-49f8-b3eb-103f91df5553.jpg?im_w=720', 'Patio interior de la casa colonial'),
(15, 14, 'https://a0.muscache.com/im/pictures/miso/Hosting-39309503/original/b393132b-c6b7-4c96-bb2e-0276bbef614f.jpeg?im_w=720', 'Atracciones turisticas cerca del piso luminoso'),
(16, 15, 'https://a0.muscache.com/im/pictures/miso/Hosting-748668880966595911/original/3df88898-a20d-4ea0-bf87-835ea470853d.jpeg?im_w=720', 'Playa privada de la casa de playa'),
(17, 16, 'https://a0.muscache.com/im/pictures/63fb94ed-886f-43e0-b0f0-b116bc122212.jpg?im_w=720', 'Centro historico visto desde el loft'),
(18, 17, 'https://a0.muscache.com/im/pictures/miso/Hosting-842447525774130356/original/d398705d-66cf-43fb-83ba-843b9100505d.jpeg?im_w=720', 'Arte en la habitacion tematica'),
(19, 18, 'https://a0.muscache.com/im/pictures/prohost-api/Hosting-666543920439753899/original/1df85b0f-afce-40b3-9a8c-4985d356ead1.jpeg?im_w=720', 'Parque infantil del apartamento familiar'),
(20, 19, 'https://a0.muscache.com/im/pictures/4c8c508e-9830-4872-8a08-f7a0a68bb286.jpg?im_w=720', 'Vista exterior de la villa de lujo');

INSERT INTO servicioAdicional (nombreServicio, descripcion) VALUES
('Wi-Fi', 'Conexion de alta velocidad'),
('Estacionamiento', 'Espacio seguro para estacionar vehiculos'),
('Desayuno incluido', 'Variedad de opciones para el desayuno'),
('Piscina', 'Piscina disponible para los huespedes'),
('Gimnasio', 'area equipada para ejercicios fisicos'),
('Servicio de limpieza diario', 'Limpieza regular de la propiedad'),
('Aire acondicionado', 'Control de temperatura en todas las habitaciones'),
('Transporte al aeropuerto', 'Servicio de traslado desde/hacia el aeropuerto'),
('Recepcion 24/7', 'Asistencia y atencion las 24 horas'),
('Restaurante en el lugar', 'Opciones gastronomicas dentro del establecimiento'),
('Spa y bienestar', 'Servicios de spa y bienestar'),
('Mascotas permitidas', 'Aceptamos mascotas en la propiedad'),
('Servicio de lavanderia', 'Lavanderia disponible para los huespedes'),
('area de juegos para niños', 'Espacio dedicado para actividades infantiles'),
('Terraza panoramica', 'Vistas impresionantes desde la terraza'),
('Servicio de habitaciones', 'Comodidades entregadas directamente en la habitacion'),
('Salon de eventos', 'Espacio para eventos y reuniones'),
('Servicio de conserjeria', 'Asistencia personalizada durante la estancia'),
('Sauna', 'Sauna disponible para los huespedes'),
('Centro de negocios', 'Instalaciones para actividades empresariales');

INSERT INTO huesped (dni,nombres,apellidos,telefono,email) VALUES
  (33612670,'Mercedes','Hooper','496-1746','morbi@yahoo.edu'),
  (73862276,'Clio','Whitaker','875-2092','congue@google.org'),
  (3685096,'Rhiannon','Savage','738-4655','diam@outlook.couk'),
  (81736554,'Emily','Humphrey','991-2595','sit@yahoo.edu'),
  (41655507,'Kasimir','Harper','425-5551','fringilla.est.mauris@hotmail.net'),
  (46309914,'Kiara','Horton','371-4573','quam@yahoo.edu'),
  (12213443,'Jarrod','Hopper','787-4315','quis@google.org'),
  (43958279,'Raja','Kelly','588-5324','eu@hotmail.org'),
  (3123453,'Brynne','Porter','625-6263','tristique.senectus@aol.net'),
  (95667471,'Felix','Espinoza','954-0771','lacus@aol.ca'),
  (39525623,'Orla','Christensen','542-5340','proin@protonmail.org'),
  (50288467,'Craig','Clark','642-1646','lorem.ipsum@outlook.couk'),
  (49545945,'Imani','Browning','982-1743','ullamcorper.nisl@yahoo.net'),
  (89995126,'Melinda','Patton','357-5683','dapibus.id@outlook.org'),
  (84005321,'Ulysses','Hancock','660-5018','donec.non@yahoo.edu'),
  (29960429,'Danielle','Warren','660-5445','tempus.scelerisque.lorem@yahoo.couk'),
  (61313561,'Luke','Steele','208-3653','eget.massa@outlook.ca'),
  (31011306,'Bert','Griffin','792-5584','urna.et@icloud.org'),
  (72864861,'Deacon','Workman','668-3713','donec.est@aol.net'),
  (84449904,'Fletcher','Yang','672-5333','facilisis.eget.ipsum@aol.org');

INSERT INTO resena (idHuesped, idPropiedad, calificacion, comentario) VALUES
(1, 5, 5, 'Una estancia increible, la vista al mar es impresionante.'),
(2, 10, 4, 'El apartamento centrico es comodo y bien ubicado.'),
(3, 15, 4, 'La habitacion en el corazon de la ciudad es acogedora.'),
(4, 1, 5, 'El chalet con piscina es perfecto para vacaciones en familia.'),
(5, 6, 3, 'El apartamento moderno con terraza tiene buenas vistas.'),
(6, 11, 4, 'La casa de campo es ideal para desconectar de la ciudad.'),
(7, 16, 4, 'La habitacion con baño privado es amplia y confortable.'),
(8, 2, 5, 'El apartamento con vistas panoramicas ofrece una experiencia unica.'),
(9, 8, 5, 'La casa antigua restaurada tiene un encanto especial.'),
(10, 13, 4, 'El departamento ejecutivo en zona empresarial es muy conveniente.'),
(11, 18, 5, 'La cabaña en la montaña es perfecta para relajarse junto a la chimenea.'),
(12, 3, 4, 'El apartamento moderno con piscina comunitaria es genial.'),
(13, 14, 3, 'La habitacion minimalista es sencilla pero comoda.'),
(14, 12, 5, 'La casa colonial con patio interior es una joya arquitectonica.'),
(15, 7, 4, 'El piso luminoso cerca de atracciones turisticas es conveniente.'),
(16, 20, 5, 'La casa de playa con acceso directo al mar es un paraiso.'),
(17, 17, 4, 'El loft en el centro historico tiene un ambiente encantador.'),
(18, 19, 3, 'La habitacion tematica es interesante para amantes del arte.'),
(19, 4, 4, 'El apartamento familiar con parque infantil es perfecto para niños.'),
(20, 9, 5, 'La villa de lujo con servicio de conserje es simplemente impresionante.');

INSERT INTO trabajaEn (idPropiedad, idEmpleado) VALUES
(1, 5),
(2, 8),
(3, 3),
(4, 10),
(5, 1),
(6, 1),
(7, 9),
(8, 2),
(9, 6),
(10, 2),
(11, 4),
(12, 7),
(13, 2),
(14, 5),
(15, 4),
(16, 3),
(17, 9),
(18, 7),
(19, 5),
(20, 9),
(1, 3),
(2, 3),
(3, 5),
(4, 1),
(5, 2),
(6, 8),
(7, 9),
(8, 1),
(9, 4),
(10, 6),
(11, 3),
(12, 3),
(13, 5),
(14, 7),
(15, 7),
(16, 4),
(17, 8),
(18, 9),
(19, 10),
(20, 2);

INSERT INTO reserva (idPropiedad, idHuesped, fechaReserva, fechaEntrada, diasEstancia, estado) VALUES
(1, 5, '2023-11-25', '2023-12-01', 6, 'confirmado'),
(2, 8, '2023-11-26', '2023-12-03', 7, 'pendiente'),
(3, 13, '2023-11-27', '2023-12-05', 8, 'completada'),
(4, 10, '2023-11-28', '2023-12-07', 5, 'cancelado'),
(5, 15, '2023-11-29', '2023-12-09', 4, 'confirmado'),
(6, 1, '2023-11-30', '2023-12-11', 3, 'completada'),
(7, 18, '2023-12-01', '2023-12-13', 2, 'pendiente'),
(8, 2, '2023-12-02', '2023-12-15', 5, 'confirmado'),
(9, 6, '2023-12-03', '2023-12-17', 6, 'pendiente'),
(10, 12, '2023-12-04', '2023-12-19', 7, 'completada'),
(11, 4, '2023-12-05', '2023-12-21', 3, 'cancelado'),
(12, 7, '2023-12-06', '2023-12-23', 4, 'confirmado'),
(13, 20, '2023-12-07', '2023-12-25', 2, 'completada'),
(14, 11, '2023-12-08', '2023-12-27', 8, 'pendiente'),
(15, 14, '2023-12-09', '2023-12-29', 6, 'confirmado'),
(16, 3, '2023-12-10', '2023-12-31', 5, 'pendiente'),
(17, 9, '2023-12-11', '2024-01-02', 7, 'completada'),
(18, 16, '2023-12-12', '2024-01-04', 3, 'confirmado'),
(19, 19, '2023-12-13', '2024-01-06', 4, 'pendiente'),
(20, 17, '2023-12-14', '2024-01-08', 5, 'completada');


-- EL VALOR DEL PAGO ES OMITIDO, YA QUE ES VERIFICADO Y CALCULADO POR UN TRIGGER
INSERT INTO pago (idReserva, fechaPago, valorPago, medioPago) VALUES
(1, '2023-11-25', 500000, 'tarjeta'), 
(3, '2023-11-27', 140000, 'cheque'), 
(5, '2023-11-29', 310000, 'efectivo'),
(6, '2023-11-30', 400000, 'tarjeta'),
(8, '2023-12-02', 250000, 'tarjeta'),
(10, '2023-12-04', 360000, 'tarjeta'),
(11, '2023-12-05', 480000, 'cheque'), 
(13, '2023-12-07', 550000, 'efectivo'),
(15, '2023-12-09', 420000, 'efectivo'),
(17, '2023-12-11', 390000, 'cheque'), 
(18, '2023-12-12', 280000, 'tarjeta'),
(20, '2023-12-14', 290000, 'tarjeta');


INSERT INTO servicioPropiedad (idPropiedad, idServicio)
VALUES
  (1, 5),
  (1, 19),
  (1, 10),
  (2, 6),
  (2, 8),
  (3, 5),
  (4, 7),
  (4, 9),
  (5, 6),
  (6, 8),
  (6, 10),
  (7, 5),
  (8, 7),
  (8, 9),
  (9, 6),
  (10, 8),
  (10, 10),
  (11, 5),
  (12, 7),
  (12, 9),
  (13, 6),
  (14, 8),
  (15, 1),
  (15, 7);


INSERT INTO resena (idHuesped, idPropiedad, calificacion, comentario)
VALUES
  (5, 1, 4, 'Buena experiencia, lugar acogedor'),
  (14, 1, 5, 'Increible, definitivamente regresare'),
  (3, 2, 3, 'Buena ubicacion pero podria mejorar en algunos aspectos'),
  (8, 3, 4, 'Personal amable y servicial'),
  (12, 4, 5, 'Vistas impresionantes desde la terraza'),
  (17, 5, 2, 'No cumplio con las expectativas, servicios insatisfactorios'),
  (2, 6, 4, 'Perfecto para viajes de negocios'),
  (20, 7, 5, 'Servicio de habitaciones rapido y eficiente'),
  (11, 8, 3, 'Desayuno podria ser mejor'),
  (7, 9, 4, 'Ambiente tranquilo y relajado'),
  (6, 10, 5, 'Aceptan mascotas, ¡fantastico!'),
  (9, 11, 3, 'Buena relacion calidad-precio'),
  (16, 12, 4, 'Muy limpio y bien mantenido'),
  (4, 13, 5, 'Personal atento y servicial'),
  (19, 14, 2, 'Problemas con la conexion Wi-Fi'),
  (1, 15, 4, 'Buenas instalaciones para eventos'),
  (10, 16, 5, 'Sauna disponible, una gran ventaja'),
  (18, 17, 3, 'Inconvenientes con el estacionamiento'),
  (15, 18, 4, 'Recepcion 24/7, muy util'),
  (13, 19, 5, 'Muy recomendado, volvere pronto'),
  (9, 2, 4, 'Buena ubicacion y servicio'),
  (18, 3, 5, 'Increible experiencia, vistas impresionantes'),
  (7, 4, 3, 'Podria mejorar en la limpieza'),
  (15, 5, 4, 'Personal atento y amable'),
  (5, 6, 5, 'Excelente para estancias cortas'),
  (11, 7, 2, 'No cumplio con las expectativas'),
  (20, 8, 4, 'Servicio de habitaciones eficiente'),
  (14, 9, 5, 'Desayuno variado y delicioso'),
  (8, 10, 3, 'Ambiente tranquilo pero instalaciones antiguas'),
  (1, 11, 4, 'Aceptan mascotas, un gran plus'),
  (12, 12, 5, 'Buena relacion calidad-precio'),
  (13, 13, 3, 'Necesita mejoras en la atencion al cliente'),
  (6, 14, 4, 'Limpieza impecable y personal amigable'),
  (16, 15, 5, 'Vistas panoramicas desde la terraza'),
  (3, 16, 2, 'Problemas con la conexion Wi-Fi'),
  (10, 17, 4, 'Instalaciones para eventos bien equipadas'),
  (17, 18, 5, 'Sauna y spa de calidad'),
  (19, 19, 3, 'Estacionamiento dificil de encontrar'),
  (4, 20, 4, 'Atencion 24/7, muy util'),
  (2, 1, 5, 'Una estancia inolvidable');


INSERT INTO reporteEntrega (idEmpleado, idReserva, fechaReporte, detalle)
VALUES
  (1, 3, '2023-01-15', 'Entrega de llaves y detalles adicionales registrados'),
  (6, 6, '2023-02-10', 'Check-in realizado con exito, sin problemas reportados'),
  (8, 10, '2023-03-05', 'Revision completa de la propiedad, todo en orden'),
  (1, 13, '2023-04-01', 'Se realizaron las entregas segun lo planeado'),
  (8, 17, '2023-05-18', 'Check-in y entrega de documentacion completados');