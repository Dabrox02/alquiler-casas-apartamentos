DROP PROCEDURE IF EXISTS proc_trans_generarPago;
DELIMITER //
CREATE PROCEDURE proc_trans_generarPago(
    IN id_reserva_pago INT,
    IN fecha_pago DATE,
    IN medio_pago VARCHAR(10)
)
BEGIN
    DECLARE estado_actual_reserva VARCHAR(20);    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error en la operación. Se ha realizado un rollback.';
    END;
    
	SELECT estado INTO estado_actual_reserva FROM reserva WHERE idReserva = id_reserva_pago;
    
	IF estado_actual_reserva = 'pendiente' THEN
		START TRANSACTION;
        UPDATE reserva SET reserva.estado = 'confirmado' WHERE idReserva = id_reserva_pago;
        INSERT INTO pago (idReserva, fechaPago, medioPago) VALUES (id_reserva_pago, fecha_pago, medio_pago);
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La reserva no está en estado pendiente. No se realizaron operaciones.';
    END IF;
    
END //
DELIMITER ;
-- CALL proc_trans_generarPago(2, '2023-11-26', 'tarjeta');



DROP PROCEDURE IF EXISTS proc_trans_cancelarReserva;
DELIMITER //
CREATE PROCEDURE proc_trans_cancelarReserva(
    IN id_reserva_cancelar INT,
    IN motivo_cancelar VARCHAR(255)
)
BEGIN
    DECLARE estado_actual_reserva VARCHAR(20); 
    DECLARE id_pago INT;
    DECLARE valor_reembolso DOUBLE;
    DECLARE msg_error VARCHAR(255) ;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = msg_error;
    END;
    
	SELECT estado INTO estado_actual_reserva FROM reserva WHERE idReserva = id_reserva_cancelar;
    
	IF estado_actual_reserva = 'cancelado' THEN
		SET msg_error = 'La reserva ya fue cancelada. No se realizaron operaciones.';
		SIGNAL SQLSTATE '45000';
    ELSEIF estado_actual_reserva = 'pendiente' THEN
		 UPDATE reserva SET reserva.estado = 'cancelado' WHERE idReserva = id_reserva_cancelar;   
	ELSEIF estado_actual_reserva = 'completada' THEN
		SET msg_error = 'Ya se completo la reserva. No es posible cancelar. No se relaizaron operaciones';
		SIGNAL SQLSTATE '45000';
	ELSEIF estado_actual_reserva = 'confirmado' THEN
		SELECT idPago, valorPago INTO id_pago, valor_reembolso FROM pago WHERE pago.idReserva = id_reserva_cancelar;
		SET valor_reembolso = valor_reembolso - (valor_reembolso * 0.1);
        
        IF id_pago IS NOT NULL AND valor_reembolso IS NOT NULL THEN
			START TRANSACTION;
			UPDATE reserva SET reserva.estado = 'cancelado' WHERE idReserva = id_reserva_cancelar;
			INSERT INTO reembolso (idPago, fechaReembolso, valorReembolso, motivo) VALUES (id_pago, CURDATE(), valor_reembolso, motivo_cancelar);
			COMMIT;
		ELSE 
			SET msg_error = 'No se encontro pago.';
			SIGNAL SQLSTATE '45000';
        END IF;
    END IF;
END //
DELIMITER ;
CALL proc_trans_cancelarReserva(12, "No puedo asistir a la fecha reservada");