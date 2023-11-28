## Descripción del negocio

"Viajemos Juntos" tiene como misión ofrecer experiencias de alojamiento inolvidables, brindando un servicio integral y de calidad en el alquiler de apartamentos, casas y habitaciones en toda Colombia. 

Se requiere la implementación de una base de datos que tiene como objetivo centralizar y optimizar la gestión de los alquileres de propiedades. Esta herramienta permitirá administrar eficientemente la información relacionada con empleados, propiedades, reservas, pagos, reseñas y estados de entrega. Además, facilitará la toma de decisiones estratégicas y mejorará la experiencia tanto para los huéspedes como para los empleados.

Se requiere cubrir las siguientes necesidades:

### Gestión de Empleados:
- Registro detallado de empleados, incluyendo información como nombre, apellido, número de identificación, correo electrónico y número de teléfono.
- Administración de diferentes roles para empleados, como gerente, personal de limpieza, mantenimiento recepcionista, etc.
- Asignación y seguimiento de propiedades a las que están asignados los empleados.

### Gestión de Huéspedes:
- Registro de huéspedes con información relacionada como nombre, apellido, numero de identificación, correo electrónico y número de teléfono.

### Gestión de Propiedades:	
- Registro de nuevas propiedades con detalles como nombre, descripción, ubicación, número de habitaciones, número de baños, capacidad, etc.
- Cada propiedad puede tener varias imágenes.
- Cada propiedad puede tener varios servicios adicionales como Wifi, zona de trabajo, lavadora, secadora, cámara de seguridad, etc.

### Gestión de Reservas:
- Creación de nuevas reservas con información de fechas de inicio y finalización.
- Seguimiento del estado de las reservas (confirmada, pendiente, cancelada, completada).
- Cálculo automático del precio total de la reserva basado en la duración de la estadía y el valor por noche.
  
### Gestión de Pagos:
- Registro de pagos asociados a reservas.
- Cada reserva puede ser cancelada, si se registro un pago de la reserva cancelada, este pago sera reembolsado.

### Gestión de Reseñas:
- Posibilidad para los usuarios huéspedes de dejar comentarios y calificaciones en propiedades después de una estancia.

### Gestión de reportes de entregas:
- Permitir a los empleados registrar el estado de entrega de la propiedad reservada. 

## Restricciones

### Empleados
- El correo electrónico y telefono de cada empleado debe ser único.
- Cada empleado debe poseer un cargo

### Propiedades:
- Si la propiedad es una habitación, el numero de habitaciones de está será 1.
- El número de habitaciones, baños y la capacidad de la propiedad deben ser valores enteros no negativos.
- El valor por noche de la propiedad no puede ser negativo.

### Huéspedes
- Cada huésped debe tener un número de identificación único (dni).
- El correo electrónico de cada huésped debe ser único.

### Imágenes de Propiedades
- Las imágenes deben pertenecer a una propiedad existente.

### Servicios Adicionales:
- Cada servicio adicional debe tener un nombre único.

### Reservas:
- La fecha de inicio de la reserva debe ser anterior a la fecha de finalización.
- El estado de la reserva debe ser uno de los siguientes: "confirmada", "pendiente", "cancelada" o "completada".
- Si una reserva es confirmada, significa que se registro un pago.
- Una reserva en pendiente, no ha sido pagada.
- Si una reserva es completada, significa que el cliente realizo el pago y acudió a la estadia.
- Una reserva completada no podrá ser reembolsada.
- Una reserva cancelada, registrará reembolso, solo si ha sido pagada, es decir se encontraba en estado confirmada.

### Pagos:
- La fecha de pago debe ser igual o posterior a la fecha de reserva.
- El valor del pago no puede ser negativo.

### Reembolsos:
- La fecha de reembolso debe ser igual o posterior a la fecha de pago asociada.
- El valor del reembolso se le descontara un 10% del valor pagado a la reserva que fue cancelada.

### Reseñas:
- La calificación de la reseña debe estar en el rango de 1 a 5.
- Un huésped solo puede hacer una reseña por propiedad.

### Reporte Entrega:
- Solo los empleados recepcionista podran hacer reporte de entrega de la propiedad reservada.


## Diseño 
### Diagrama Entidad - Relación
![](ReadmeAssets/diagrama-entidad-relacion.png)

### Diagrama Relacional
![](ReadmeAssets/diagrama-relacional-db.png)


## Consultas Base de Datos

### CRUD para Tabla Cargo
- Obtener todos los registros:
```sql
  SELECT * FROM cargo;
```

- Obtener registro por id:
```sql
  SELECT * FROM cargo WHERE idCargo = 1;
```

- Insertar registro:
```sql
    INSERT INTO cargo (nombre, descripcion) VALUES ('Gerente', 'Responsable de la gestión general');
```

- Actualizar registro:
```sql
    UPDATE cargo SET nombre = 'Gerente Ejecutivo' WHERE idCargo = 1;
```

- Eliminar registro:
```sql
    DELETE FROM cargo WHERE idCargo = 1;
```

### Consultas para Tabla Cargo

1. Encontrar el cargo con mas empleados.

```sql
DROP PROCEDURE IF EXISTS proc_obt_cargo_mas_empleados;
DELIMITER //
CREATE PROCEDURE proc_obt_cargo_mas_empleados()
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        Cargo VARCHAR(40)
    );
    INSERT INTO temp_resultados (Cargo)
    SELECT nombre AS Cargo
    FROM cargo
    WHERE idCargo = (
        SELECT idCargo
        FROM empleado
        GROUP BY idCargo
        ORDER BY COUNT(idEmpleado) DESC
        LIMIT 1
    );
    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
        SELECT * FROM temp_resultados;
    END IF;
    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_cargo_mas_empleados();
```

2. Obtener cargo y nombre completo de los empleados que trabajan en una alguna propiedad ubicada en la ciudad solicitada.

```sql
DROP PROCEDURE IF EXISTS proc_obt_nombre_cargo_empleado_ciudad;
DELIMITER //
CREATE PROCEDURE proc_obt_nombre_cargo_empleado_ciudad(IN ciudad_solicitada VARCHAR(100))
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        NombreCompleto VARCHAR(255),
        cargo VARCHAR(40)
    );
    INSERT INTO temp_resultados (NombreCompleto, cargo)
    SELECT DISTINCT CONCAT(em.nombres, ' ', em.apellidos) as NombreCompleto, c.nombre
    FROM cargo c, empleado em, trabajaEn tra
    WHERE c.idCargo = em.idCargo
    AND tra.idEmpleado = em.idEmpleado
    AND tra.idPropiedad IN (SELECT idPropiedad FROM ubicacionPropiedad WHERE LOWER(ciudad) = LOWER(ciudad_solicitada));

    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
        SELECT * FROM temp_resultados;
    END IF;
    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_nombre_cargo_empleado_ciudad('medellin');
```

3. Obtener nombre completo y cargo de los empleados trabajan en propiedades con un servicio solicitado.

```sql
DROP PROCEDURE IF EXISTS proc_obt_nombre_cargo_propiedadServicio;
DELIMITER //
CREATE PROCEDURE proc_obt_nombre_cargo_propiedadServicio(IN nombreServicio VARCHAR(50))
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        NombreCompleto VARCHAR(255),
        cargo VARCHAR(40)
    );
    INSERT INTO temp_resultados (NombreCompleto, cargo)
	SELECT DISTINCT CONCAT(em.nombres, ' ', em.apellidos) as NombreCompleto, c.nombre
	FROM cargo c 
	JOIN empleado em ON c.idCargo = em.idCargo
	JOIN trabajaEn tra ON tra.idEmpleado = em.idEmpleado
	WHERE tra.idPropiedad IN (
		SELECT serp.idPropiedad FROM servicioPropiedad serp
		WHERE serp.idServicio IN (SELECT sera.idServicio FROM servicioAdicional  sera WHERE LOWER(sera.nombreServicio) = LOWER(nombreServicio))
	);
    
    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
		SELECT * FROM temp_resultados;
    END IF;
    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_nombre_cargo_propiedadServicio('gimnasio');
```

4. Obtener nombre, telefono y cargo de los empleados que han hecho un reporte de Entrega a una propiedad reservada en el mes de noviembre de cualquier año en la ciudad ingresada.

```sql
DROP PROCEDURE IF EXISTS proc_obt_nombre_cargo_propiedadServicio;
DELIMITER //
CREATE PROCEDURE proc_obt_nombre_cargo_propiedadServicio(IN nombreCiudad VARCHAR(50))
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        NombreCompleto VARCHAR(255),
        telefono VARCHAR(20),
        cargo VARCHAR(40)
    );
    INSERT INTO temp_resultados (NombreCompleto, telefono, cargo)
	SELECT DISTINCT CONCAT(em.nombres, ' ', em.apellidos) as NombreCompleto, em.telefono, c.nombre
	FROM cargo c 
	JOIN empleado em ON c.idCargo = em.idCargo
	JOIN reporteEntrega rep ON em.idEmpleado = rep.idEmpleado
	JOIN reserva re ON re.idReserva = rep.idReserva
	JOIN ubicacionPropiedad ub ON ub.idPropiedad = re.idPropiedad
	WHERE re.idReserva IN (
		SELECT r.idReserva FROM reserva r WHERE DATE_FORMAT(r.fechaReserva, "%m") = 11)
	AND LOWER(ub.ciudad) = LOWER(nombreCiudad);

    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
		SELECT * FROM temp_resultados;
    END IF;
    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_nombre_cargo_propiedadServicio('bucaramanga');
```

5. Obtener el nombre cargo y propiedad en las que trabajen los empleados cuya descripcion de la propiedad que contenga la palabra ingresada.

```sql
DROP PROCEDURE IF EXISTS proc_obt_nombre_cargo_propiedad_xDescripcion;
DELIMITER //
CREATE PROCEDURE proc_obt_nombre_cargo_propiedad_xDescripcion(IN buscado VARCHAR(50))
BEGIN
    SET @terminoBuscado = buscado;

    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        NombreCompleto VARCHAR(255),
        cargo VARCHAR(40),
        descripcion TEXT
    );  

    PREPARE stmt FROM 
    'INSERT INTO temp_resultados (NombreCompleto, cargo, descripcion)
    SELECT CONCAT(em.nombres, " ", em.apellidos), c.nombre, pro.descripcion FROM cargo c, empleado em, trabajaEn tra, propiedad pro
    WHERE c.idCargo = em.idCargo
    AND em.idEmpleado = tra.idEmpleado
    AND pro.idPropiedad = tra.idPropiedad
    AND pro.descripcion LIKE CONCAT("%", ?, "%")';
    EXECUTE stmt USING @terminoBuscado;

    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
		SELECT * FROM temp_resultados;
    END IF;

    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_nombre_cargo_propiedad_xDescripcion('moderno');
```

## Consultas Base de Datos

### CRUD para Tabla Empleado
- Obtener todos los registros:
```sql
  SELECT * FROM empleado;
```

- Obtener registro por id:
```sql
  SELECT * FROM empleado WHERE idEmpleado = 1;
```

- Insertar registro:
```sql
    INSERT INTO empleado (dni,nombres,apellidos,telefono,email,idCargo) VALUES
  (25379094,'Isaac','Holland','894-9021','nisi.magna.sed@hotmail.couk',2);
```

- Actualizar registro:
```sql
    UPDATE empleado SET nombres = 'Isaac Norman' WHERE idEmpleado = 1;
```

- Eliminar registro:
```sql
    DELETE FROM empleado WHERE idEmpleado = 1;
```

### Consultas para Tabla Empleado
1. Obtener empleados que trabajen en propiedades que tengan al menos una imagen, permita mascotas y el numero de baños sea mayor o igual al ingresado.
   
```sql
DROP PROCEDURE IF EXISTS proc_obt_empleados_x_mascotas_banos;
DELIMITER //
CREATE PROCEDURE proc_obt_empleados_x_mascotas_banos(IN numBanosMinimo INT)
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
		idEmpleado int(11),
		dni varchar(15), 
		nombres varchar(40),
		apellidos varchar(40),
		telefono varchar(20),
		email varchar(60),
		idCargo int(11)
    );  
    INSERT INTO temp_resultados
	SELECT DISTINCT em.* FROM empleado em
	JOIN trabajaEn tra ON em.idEmpleado = tra.idEmpleado
	WHERE tra.idPropiedad IN (
		SELECT DISTINCT det.idPropiedad 
		FROM detallePropiedad det 
		WHERE LOWER(det.mascotas) = 'si' AND det.numBanos >= numBanosMinimo)
	AND tra.idPropiedad IN (
		SELECT DISTINCT img.idPropiedad 
		FROM imgpropiedad img);
        
    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
		SELECT * FROM temp_resultados;
    END IF;

    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_empleados_x_mascotas_banos(4);
```

2. Obtener el nombre de los empleados que realizaron un reporte de entrega, el id de de todas las reservas a las que realizaron el reporte separadas por '-' y el numero de reportes totales realizados por cada uno de ellos que debe ser mayor o igual al ingresado.

```sql
DROP PROCEDURE IF EXISTS proc_obt_empleados_y_reportes_x_numTotalReporte;
DELIMITER //
CREATE PROCEDURE proc_obt_empleados_y_reportes_x_numTotalReporte(IN numReportesMinimo INT)
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
		nombreCompleto VARCHAR(255),
        reportesId VARCHAR(255),
        numTotalReportes INTEGER
    );  
	
    INSERT INTO temp_resultados(nombreCompleto, reportesId, numTotalReportes)
	SELECT CONCAT(em.nombres, " ", em.apellidos), 
	GROUP_CONCAT(re.idReporte SEPARATOR ' - '), 
	COUNT(re.idReporte) 
	FROM empleado em, reporteEntrega re
	WHERE em.idEmpleado = re.idEmpleado
	AND em.idEmpleado IN (
		SELECT em.idEmpleado
		FROM empleado em, reporteEntrega re
		WHERE em.idEmpleado = re.idEmpleado
		GROUP BY em.nombres
		HAVING count(re.idReporte) >= numReportesMinimo)
	GROUP BY em.nombres;
        
    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
		SELECT * FROM temp_resultados;
    END IF;

    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_empleados_y_reportes_x_numTotalReporte(2);
```

3. Obtener todos los empleados que trabajen en una propiedad cuyo huesped haya realizado alguna cancelacion de reserva y cuyo nombre del huesped comience por la letra ingresada.

```sql
DROP PROCEDURE IF EXISTS proc_obt_empleados_con_pago_x_letra;
DELIMITER //
CREATE PROCEDURE proc_obt_empleados_con_pago_x_letra(IN letraIngresada CHAR(1))
BEGIN
    SET @letraBuscada = letraIngresada;

    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        idEmpleado INT,
        dni VARCHAR(15),
        nombres VARCHAR(40),
        apellidos VARCHAR(40),
        telefono VARCHAR(20),
        email VARCHAR(60),
        idCargo INT
    );

    PREPARE stmt FROM 
    'INSERT INTO temp_resultados(idEmpleado, dni, nombres, apellidos, telefono, email, idCargo)
    SELECT em.idEmpleado, em.dni, em.nombres, em.apellidos, em.telefono, em.email, em.idCargo
    FROM empleado em, trabajaen tra, propiedad pro, reserva re, huesped hu
    WHERE em.idEmpleado = tra.idEmpleado
    AND tra.idPropiedad = pro.idPropiedad
    AND re.idPropiedad = pro.idPropiedad
    AND re.idHuesped = hu.idHuesped
    AND re.idPropiedad IN (
        SELECT res.idPropiedad 
        FROM reserva res
        WHERE LOWER(res.estado) = "cancelado"
    )
    AND hu.idHuesped IN (
        SELECT hue.idHuesped 
        FROM huesped hue
        WHERE LOWER(LEFT(hue.nombres, 1)) = LOWER(LEFT(@letraBuscada, 1))
    )';
    EXECUTE stmt;
    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
        SELECT * FROM temp_resultados;
    END IF;

    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_empleados_con_pago_x_letra('F');
```

4. Obtener todos los empleados que trabajen en una propiedad que haya sido reseñada mas de 1 vez y tenga almenos una reservacion completada.

```sql
DROP PROCEDURE IF EXISTS proc_obt_empleados_con_reservaCompleta_totalResenas;
DELIMITER //
CREATE PROCEDURE proc_obt_empleados_con_reservaCompleta_totalResenas()
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        idEmpleado INT,
        dni VARCHAR(15),
        nombres VARCHAR(40),
        apellidos VARCHAR(40),
        telefono VARCHAR(20),
        email VARCHAR(60),
        idCargo INT
    );

    PREPARE stmt FROM 
    'INSERT INTO temp_resultados(idEmpleado, dni, nombres, apellidos, telefono, email, idCargo)
	SELECT DISTINCT em.* FROM empleado em, trabajaEn tra
	WHERE em.idEmpleado = tra.idEmpleado
	AND tra.idPropiedad IN (
		SELECT DISTINCT re.idPropiedad FROM reserva re
		WHERE re.estado = "completada")
	AND tra.idPropiedad IN (
		SELECT res.idPropiedad FROM resena res
		GROUP BY res.idPropiedad
		HAVING COUNT(res.idPropiedad) > 1)';
    EXECUTE stmt;
    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
        SELECT * FROM temp_resultados;
    END IF;

    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_empleados_con_reservaCompleta_totalResenas();
```

5. Obtener el nombre y cargo de los empleados que trabajan en propiedades cuyo valor por noche supera el promedio y poseen mas de 2 servicios adicionales.

```sql
DROP PROCEDURE IF EXISTS proc_obt_empleados_x_masServicio_masValor;
DELIMITER //
CREATE PROCEDURE proc_obt_empleados_x_masServicio_masValor()
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        nombreCompleto VARCHAR(40),
        cargo VARCHAR(40)
    );

	INSERT INTO temp_resultados(nombreCompleto, cargo)
	SELECT CONCAT(em.nombres, " ", em.apellidos), c.nombre FROM empleado em, cargo c, trabajaen tra, propiedad pro
	WHERE em.idCargo = c.idCargo
	AND tra.idEmpleado = em.idEmpleado
	AND tra.idPropiedad = pro.idPropiedad
	AND tra.idPropiedad IN (
		SELECT sp.idPropiedad 
		FROM servicioPropiedad sp 
		GROUP BY sp.idPropiedad 
		HAVING count(sp.idServicio) > 2)
	AND pro.valorxNoche > (
		SELECT AVG(pro.valorxNoche) 
		FROM propiedad pro);

    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
        SELECT * FROM temp_resultados;
    END IF;

    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_empleados_x_masServicio_masValor();
```

## Consultas Base de Datos

### CRUD para Tabla TrabajaEn
- Obtener todos los registros:
```sql
  SELECT * FROM trabajaEn;
```

- Obtener registro por idEmpleado o por idPropiedad:
```sql
  SELECT * FROM trabajaEn WHERE idEmpleado = 1;
  SELECT * FROM trabajaEn WHERE idPropiedad = 1;
```

- Insertar registro:
```sql
    INSERT INTO trabajaEn (idPropiedad, idEmpleado) VALUES (1, 5);
```

- Actualizar registro:
```sql
    UPDATE trabajaEn SET idPropiedad = 1 WHERE idEmpleado = 2;
```

- Eliminar registro por idEmpleado o idPropiedad:
```sql
    DELETE FROM trabajaEn WHERE idEmpleado = 1;
    DELETE FROM trabajaEn WHERE idPropiedad = 1;
```

### Consultas para Tabla TrabajaEn

1. Obtener descripcion de la propiedad y email de los empleados que trabajan en dicha propiedad, de las propiedades que tengan un numero de habitaciones inferior al promedio y esten ubicados en el departamento ingresado.

```sql
DROP PROCEDURE IF EXISTS proc_obt_trab_mayorPromedioHab_departamento;
DELIMITER //
CREATE PROCEDURE proc_obt_trab_mayorPromedioHab_departamento(IN nombre_departamento VARCHAR(100))
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        descripcion TEXT,
        emailEmpleado VARCHAR(60)
    );

	INSERT INTO temp_resultados(descripcion, emailEmpleado)
	SELECT DISTINCT pro.descripcion, em.email FROM trabajaEn tra, propiedad pro, empleado em
	WHERE tra.idEmpleado = em.idEmpleado
	AND tra.idPropiedad = pro.idPropiedad
	AND tra.idPropiedad IN (
		SELECT det.idPropiedad 
		FROM detallePropiedad det
		WHERE det.numHabitaciones > (
			SELECT AVG(numHabitaciones) 
			FROM detallePropiedad
		))
	AND tra.idPropiedad IN (
		SELECT ub.idPropiedad 
		FROM ubicacionPropiedad ub
		WHERE LOWER(ub.departamento) = nombre_departamento
	);

    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
        SELECT * FROM temp_resultados;
    END IF;

    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_trab_mayorPromedioHab_departamento('antioquia');
```

2. Obtener los empleados que trabajan en propiedades que no tenga servicios adicionales y no tienen reservas en estado pendiente.

```sql
DROP PROCEDURE IF EXISTS proc_obt_noServicios_noReservaPendiente;
DELIMITER //
CREATE PROCEDURE proc_obt_noServicios_noReservaPendiente()
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        idEmpleado INT,
        dni VARCHAR(15),
        nombres VARCHAR(40),
        apellidos VARCHAR(40),
        telefono VARCHAR(20),
        email VARCHAR(60),
        idCargo INT
    );

	INSERT INTO temp_resultados
	SELECT DISTINCT em.* FROM trabajaen tra
	JOIN empleado em ON em.idEmpleado = tra.idEmpleado
	JOIN propiedad pro ON pro.idPropiedad = tra.idPropiedad
	LEFT JOIN serviciopropiedad sep ON pro.idPropiedad = sep.idPropiedad
	WHERE sep.idPropiedad IS NULL
	AND tra.idPropiedad IN (
		SELECT propiedad.idPropiedad
		FROM propiedad
		LEFT JOIN reserva ON propiedad.idPropiedad = reserva.idPropiedad
		WHERE reserva.estado IS NULL OR reserva.estado != 'pendiente'
	);

    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
        SELECT * FROM temp_resultados;
    END IF;

    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_noServicios_noReservaPendiente();
```

3. Listar el/los empleados que trabajan en mas propiedades y que la descripcion de la propiedad posea mas de 45 caracteres, ordenarlos por nombre ascendentemente.

```sql
DROP PROCEDURE IF EXISTS proc_obt_trabajaMas_descripcionMayor;
DELIMITER //
CREATE PROCEDURE proc_obt_trabajaMas_descripcionMayor()
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        idEmpleado INT,
        dni VARCHAR(15),
        nombres VARCHAR(40),
        apellidos VARCHAR(40),
        telefono VARCHAR(20),
        email VARCHAR(60),
        idCargo INT,
        totalPropiedadesTrabaja INTEGER
    );

	INSERT INTO temp_resultados
	SELECT em.*, COUNT(tra.idPropiedad)
	FROM empleado em
	JOIN trabajaEn tra ON em.idEmpleado = tra.idEmpleado
	JOIN propiedad pro ON tra.idPropiedad = pro.idPropiedad
	WHERE LENGTH(pro.descripcion) > 45
	GROUP BY em.idEmpleado, em.nombres, em.apellidos
	ORDER BY em.nombres ASC;

    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
        SELECT * FROM temp_resultados;
    END IF;
    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_trabajaMas_descripcionMayor();
```

4. Lista el nombre del empleado y nombre de los servicios por propiedad ordenarlos descentenmente por el nombre del servicio, ten en cuenta que pueden existir propiedades sin servicios adicionales.

```sql
DROP PROCEDURE IF EXISTS proc_obt_agrupacion_EmpleadoServicios;
DELIMITER //
CREATE PROCEDURE proc_obt_agrupacion_EmpleadoServicios()
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        idPropiedad INT,
        nombres VARCHAR(100),
        totalPropiedadesTrabaja TEXT
    );

	INSERT INTO temp_resultados
	SELECT pro.idPropiedad, CONCAT(em.nombres, " ", em.apellidos),
		(
			SELECT GROUP_CONCAT(
				servicioAdicional.nombreServicio 
				ORDER BY servicioAdicional.nombreServicio DESC)
			FROM servicioPropiedad
			LEFT JOIN servicioAdicional ON servicioPropiedad.idServicio = servicioAdicional.idServicio
			WHERE servicioPropiedad.idPropiedad = pro.idPropiedad
		) AS servicios
	FROM empleado em
	JOIN trabajaEn tra ON em.idEmpleado = tra.idEmpleado
	JOIN propiedad pro ON tra.idPropiedad = pro.idPropiedad
	ORDER BY servicios DESC;

    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
        SELECT * FROM temp_resultados;
    END IF;
    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_agrupacion_EmpleadoServicios();
```

5. Encontrar las 5 propiedades con el mayor número de reservas canceladas en el segundo semestre del año 2023 y mayor numero de empleados que trabajan en dichas propiedades.

```sql
DROP PROCEDURE IF EXISTS proc_obt_propiedadesEmpleados_masCanceladas_masEmpleados;
DELIMITER //
CREATE PROCEDURE proc_obt_propiedadesEmpleados_masCanceladas_masEmpleados()
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        idPropiedad INT,
        descripcion TEXT,
        totalReservasCanceladas INTEGER,
        totalEmpleados INTEGER
    );

	INSERT INTO temp_resultados
	SELECT pro.idPropiedad, pro.descripcion,
		(
			SELECT COUNT(DISTINCT re.idReserva)
			FROM reserva re
			WHERE pro.idPropiedad = re.idPropiedad
				AND re.estado = 'cancelado'
				AND YEAR(re.fechaReserva) = 2023
				AND MONTH(re.fechaReserva) BETWEEN 7 AND 12
		) AS totalReservasCanceladas,
		(
			SELECT COUNT(DISTINCT tra.idEmpleado)
			FROM trabajaEn tra
			WHERE pro.idPropiedad = tra.idPropiedad
		) AS totalEmpleados
	FROM propiedad pro
	ORDER BY totalReservasCanceladas DESC, totalEmpleados DESC
	LIMIT 5;

    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
        SELECT * FROM temp_resultados;
    END IF;
    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_obt_propiedadesEmpleados_masCanceladas_masEmpleados();
```

