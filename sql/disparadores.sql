
-- VALIDAR valorxNoche sea positivo.

DROP TRIGGER IF EXISTS bef_ins_check_valorxNoche;
DELIMITER //
CREATE TRIGGER bef_ins_check_valorxNoche 
BEFORE INSERT ON propiedad
FOR EACH ROW
BEGIN
        IF NEW.valorxNoche < 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se permite la inserción de números negativos';
        END IF;
END;//
DELIMITER ;


DROP TRIGGER IF EXISTS bef_upd_propiedad_check_valorxNoche;
DELIMITER //
CREATE TRIGGER bef_upd_propiedad_check_valorxNoche 
BEFORE UPDATE ON propiedad
FOR EACH ROW
BEGIN
    IF NEW.valorxNoche < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permite la actualizacion del campo a números negativos';
    END IF;
END;//
DELIMITER ;


DROP TRIGGER IF EXISTS bef_ins_detallePropiedad_check;
DELIMITER //
CREATE TRIGGER bef_ins_detallePropiedad_check 
BEFORE INSERT ON detallePropiedad
FOR EACH ROW
BEGIN
    IF NEW.capacidadHuespedes < 1 OR NEW.numBanos < 0 OR NEW.numHabitaciones < 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permite la inserción de números negativos';
    ELSE 
		IF NEW.mascotas = "" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No cumple los valores permitidos por ENUM';
		ELSE
			IF NEW.tipoPropiedad = 'habitacion' THEN
				SET NEW.numHabitaciones = 1;
			END IF;
        END IF;
    END IF;
END;//
DELIMITER ;


DROP TRIGGER IF EXISTS bef_upd_detallePropiedad_check;
DELIMITER //
CREATE TRIGGER bef_upd_detallePropiedad_check 
BEFORE UPDATE ON detallePropiedad
FOR EACH ROW
BEGIN
    IF NEW.capacidadHuespedes < 1 OR NEW.numBanos < 0 OR NEW.numHabitaciones < 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permite la inserción de números negativos';
    ELSE 
		IF NEW.mascotas = "" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No cumple los valores permitidos por ENUM';
		ELSE
			IF NEW.tipoPropiedad = 'habitacion' THEN
				SET NEW.numHabitaciones = 1;
			END IF;
        END IF;
    END IF;
END;//
DELIMITER ;


DROP TRIGGER IF EXISTS bef_ins_reserva_check;
DELIMITER //
CREATE TRIGGER bef_ins_reserva_check
BEFORE INSERT ON reserva
FOR EACH ROW
BEGIN
    IF NEW.fechaReserva > NEW.fechaEntrada THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de reserva debe ser menor o igual a la fecha de entrada.';
    END IF;
    IF NEW.diasEstancia <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Los días de estancia deben ser mayores a 0.';
    END IF;
END;
//
DELIMITER ;


DROP TRIGGER IF EXISTS bef_upd_reserva_check;
DELIMITER //
CREATE TRIGGER bef_ins_reserva_check
BEFORE UPDATE ON reserva
FOR EACH ROW
BEGIN
    IF NEW.fechaReserva > NEW.fechaEntrada THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de reserva debe ser menor o igual a la fecha de entrada.';
    END IF;
    IF NEW.diasEstancia <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Los días de estancia deben ser mayores a 0.';
    END IF;
END;
//
DELIMITER ;


DROP TRIGGER IF EXISTS bef_ins_pago_check;
DELIMITER //
CREATE TRIGGER bef_ins_pago_check 
BEFORE INSERT ON pago
FOR EACH ROW
BEGIN
	SET @valorxNochePropiedad = COALESCE((SELECT pro.valorxNoche FROM reserva re, propiedad pro WHERE re.idPropiedad = pro.idPropiedad AND re.idReserva = NEW.idReserva), 0);
    SET @diasEstanciaReserva = COALESCE((SELECT re.diasEstancia FROM reserva re WHERE re.idReserva = NEW.idReserva), 0);
	SET @fechaReserva = (SELECT re.fechaReserva FROM reserva re WHERE re.idReserva = NEW.idReserva);
    SET NEW.valorPago = @valorxNochePropiedad * @diasEstanciaReserva;
		
	IF @fechaReserva > NEW.fechaPago THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede generar un pago antes de una reserva.';
    END IF;
END;//
DELIMITER ;


DROP TRIGGER IF EXISTS bef_upd_pago_check;
DELIMITER //
CREATE TRIGGER bef_upd_pago_check 
BEFORE UPDATE ON pago
FOR EACH ROW
BEGIN
	SET @valorxNochePropiedad = COALESCE((SELECT pro.valorxNoche FROM reserva re, propiedad pro WHERE re.idPropiedad = pro.idPropiedad AND re.idReserva = NEW.idReserva), 0);
    SET @diasEstanciaReserva = COALESCE((SELECT re.diasEstancia FROM reserva re WHERE re.idReserva = NEW.idReserva), 0);
	SET @fechaReserva = (SELECT re.fechaReserva FROM reserva re WHERE re.idReserva = NEW.idReserva);
    SET NEW.valorPago = @valorxNochePropiedad * @diasEstanciaReserva;
		
	IF @fechaReserva > NEW.fechaPago THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede generar un pago con fecha anterior a una reserva.';
    END IF;
END;//
DELIMITER ;


DROP TRIGGER IF EXISTS bef_ins_reporteEntrega_check;
DELIMITER //
CREATE TRIGGER bef_ins_reporteEntrega_check 
BEFORE INSERT  ON reporteEntrega
FOR EACH ROW
BEGIN
	SET @estadoReserva = (SELECT re.estado FROM reserva re WHERE re.idReserva = NEW.idReserva);
	SET @empleadoEntrega = (SELECT car.nombre FROM empleado em, cargo car WHERE em.idCargo = car.idCargo AND em.idEmpleado = NEW.idEmpleado); 
    IF @empleadoEntrega != 'recepcionista' THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo empleado Recepcionista puede hacer reporte de entrega';
	END IF;
	IF @estadoReserva != 'completada' THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se ha completado la reserva';
	END IF;
END;//
DELIMITER ;


DROP TRIGGER IF EXISTS bef_upd_reporteEntrega_check;
DELIMITER //
CREATE TRIGGER bef_upd_reporteEntrega_check 
BEFORE UPDATE ON reporteEntrega
FOR EACH ROW
BEGIN
	SET @estadoReserva = (SELECT re.estado FROM reserva re WHERE re.idReserva = NEW.idReserva);
	SET @empleadoEntrega = (SELECT car.nombre FROM empleado em, cargo car WHERE em.idCargo = car.idCargo AND em.idEmpleado = NEW.idEmpleado); 
    IF @empleadoEntrega != 'recepcionista' THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo empleado Recepcionista puede hacer reporte de entrega';
	END IF;
	IF @estadoReserva != 'completada' THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se ha completado la reserva';
	END IF;
END;//
DELIMITER ;

