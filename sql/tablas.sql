DROP DATABASE IF EXISTS db_alquiler_propiedades;

CREATE DATABASE IF NOT EXISTS db_alquiler_propiedades;

USE db_alquiler_propiedades;

CREATE TABLE cargo (
  idCargo int PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(40) NOT NULL,
  descripcion varchar(255)
);

CREATE TABLE empleado (
  idEmpleado int PRIMARY KEY AUTO_INCREMENT,
  dni varchar(15) UNIQUE NOT NULL,
  nombres varchar(40) NOT NULL,
  apellidos varchar(40) NOT NULL,
  telefono varchar(20) UNIQUE NOT NULL,
  email varchar(60) UNIQUE NOT NULL,
  idCargo int NOT NULL
);

CREATE TABLE propiedad (
  idPropiedad int PRIMARY KEY AUTO_INCREMENT,
  descripcion TEXT,
  valorxNoche double NOT NULL
);

CREATE TABLE detallePropiedad (
  idPropiedad int NOT NULL,
  capacidadHuespedes int NOT NULL,
  numHabitaciones int NOT NULL,
  mascotas enum("si", "no") NOT NULL,
  numBanos int NOT NULL,
  tipoPropiedad enum('casa', 'apartamento', 'habitacion') NOT NULL
);

CREATE TABLE imgPropiedad (
  idImgPropiedad int PRIMARY KEY,
  idPropiedad int NOT NULL,
  urlImagen varchar(255) NOT NULL,
  descripcion varchar(255) NOT NULL
);

CREATE TABLE ubicacionPropiedad (
  idPropiedad int NOT NULL,
  departamento varchar(100) NOT NULL,
  ciudad varchar(100),
  direccion varchar(100) NOT NULL,
  detalle varchar(255)
);

CREATE TABLE servicioAdicional (
  idServicio int PRIMARY KEY AUTO_INCREMENT,
  nombreServicio varchar(50) NOT NULL,
  descripcion varchar(255)
);

CREATE TABLE trabajaEn (
  idPropiedad int NOT NULL,
  idEmpleado int NOT NULL
);

CREATE TABLE huesped (
  idHuesped int PRIMARY KEY AUTO_INCREMENT,
  dni varchar(15) UNIQUE NOT NULL,
  nombres varchar(60) NOT NULL,
  apellidos varchar(60) NOT NULL,
  telefono varchar(20) UNIQUE NOT NULL,
  email varchar(60) UNIQUE NOT NULL
);

CREATE TABLE reserva (
  idReserva int PRIMARY KEY AUTO_INCREMENT,
  idPropiedad int NOT NULL,
  idHuesped int NOT NULL,
  fechaReserva date NOT NULL,
  fechaEntrada date NOT NULL,
  diasEstancia int NOT NULL,
  estado enum('cancelado', 'confirmado', 'pendiente', 'completada') NOT NULL
);

CREATE TABLE pago (
  idPago int PRIMARY KEY AUTO_INCREMENT,
  idReserva int NOT NULL,
  fechaPago date NOT NULL,
  valorPago double NOT NULL,
  medioPago enum('efectivo', 'tarjeta', 'cheque') NOT NULL
);

CREATE TABLE reembolso (
  idPago int NOT NULL,
  fechaReembolso int NOT NULL,
  valorReembolso double NOT NULL,
  motivo varchar(255) NOT NULL
);

CREATE TABLE servicioPropiedad (
  idPropiedad int NOT NULL,
  idServicio int NOT NULL
);

CREATE TABLE resena (
  idHuesped int NOT NULL,
  idPropiedad int NOT NULL,
  calificacion int NOT NULL,
  comentario varchar(255)
);

ALTER TABLE trabajaEn ADD CONSTRAINT fk_empleado_trabaja FOREIGN KEY (idEmpleado) REFERENCES empleado (idEmpleado);

ALTER TABLE trabajaEn ADD CONSTRAINT fk_propiedad_trabaja FOREIGN KEY (idPropiedad) REFERENCES propiedad (idPropiedad);

ALTER TABLE empleado ADD CONSTRAINT fk_cargo_empleado FOREIGN KEY (idCargo) REFERENCES cargo (idCargo);

ALTER TABLE detallePropiedad ADD CONSTRAINT fk_detallePropiedad_propiedad FOREIGN KEY (idPropiedad) REFERENCES propiedad (idPropiedad);

ALTER TABLE imgPropiedad ADD CONSTRAINT fk_imgPropiedad_propiedad FOREIGN KEY (idPropiedad) REFERENCES propiedad (idPropiedad);

ALTER TABLE ubicacionPropiedad ADD CONSTRAINT fk_ubicacionPropiedad_propiedad FOREIGN KEY (idPropiedad) REFERENCES propiedad (idPropiedad);

ALTER TABLE servicioPropiedad ADD CONSTRAINT fk_servicioAdicional_servicioPropiedad FOREIGN KEY (idServicio) REFERENCES servicioAdicional (idServicio);

ALTER TABLE servicioPropiedad ADD CONSTRAINT fk_propiedad_servicioPropiedad FOREIGN KEY (idPropiedad) REFERENCES propiedad (idPropiedad);

ALTER TABLE reserva ADD CONSTRAINT fk_propiedad_reserva FOREIGN KEY (idPropiedad) REFERENCES propiedad (idPropiedad);

ALTER TABLE reserva ADD CONSTRAINT fk_huesped_reserva FOREIGN KEY (idHuesped) REFERENCES huesped (idHuesped);

ALTER TABLE pago ADD CONSTRAINT fk_reserva_pago FOREIGN KEY (idReserva) REFERENCES reserva (idReserva);

ALTER TABLE reembolso ADD CONSTRAINT fk_pago_reembolso FOREIGN KEY (idPago) REFERENCES pago (idPago);

ALTER TABLE resena ADD CONSTRAINT fk_huesped_resena FOREIGN KEY (idHuesped) REFERENCES huesped (idHuesped);

ALTER TABLE resena ADD CONSTRAINT fk_propiedad_resena FOREIGN KEY (idPropiedad) REFERENCES propiedad (idPropiedad);