
-- VALIDAR valorxNoche sea positivo.

DROP TRIGGER IF EXISTS ins_propiedad_check_valorxNoche;
DELIMITER //
CREATE TRIGGER ins_check_valorxNoche 
BEFORE INSERT ON propiedad
FOR EACH ROW
BEGIN
        IF NEW.valorxNoche < 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se permite la inserción de números negativos';
        END IF;
END;//
DELIMITER ;


DROP TRIGGER IF EXISTS upd_propiedad_check_valorxNoche;
DELIMITER //
CREATE TRIGGER upd_propiedad_check_valorxNoche 
BEFORE UPDATE ON propiedad
FOR EACH ROW
BEGIN
    IF NEW.valorxNoche < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permite la actualizacion del campo a números negativos';
    END IF;
END;//
DELIMITER ;


DROP TRIGGER IF EXISTS ins_detallePropiedad_check;
DELIMITER //
CREATE TRIGGER ins_detallePropiedad_check 
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



DELIMITER //
CREATE TRIGGER upd_detallePropiedad_check 
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