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
DROP PROCEDURE IF EXISTS proc_get_cargo_mas_empleados;
DELIMITER //
CREATE PROCEDURE proc_get_cargo_mas_empleados()
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
CALL proc_get_cargo_mas_empleados();
```

2. Obtener cargo y nombre completo de los empleados que trabajan en una alguna propiedad ubicada en la ciudad solicitada.

```sql
DROP PROCEDURE IF EXISTS proc_get_nombre_cargo_empleado_ciudad;
DELIMITER //
CREATE PROCEDURE proc_get_nombre_cargo_empleado_ciudad(IN ciudad_solicitada VARCHAR(100))
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
CALL proc_get_nombre_cargo_empleado_ciudad('medellin');
```

3. Obtener nombre completo y cargo de los empleados trabajan en propiedades con un servicio solicitado.

```sql
DROP PROCEDURE IF EXISTS proc_get_nombre_cargo_propiedadServicio;
DELIMITER //
CREATE PROCEDURE proc_get_nombre_cargo_propiedadServicio(IN nombreServicio VARCHAR(50))
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
CALL proc_get_nombre_cargo_propiedadServicio('gimnasio');
```

4. Obtener nombre, telefono y cargo de los empleados que han hecho un reporte de Entrega a una propiedad reservada en el mes de noviembre de cualquier año en la ciudad ingresada.

```sql
DROP PROCEDURE IF EXISTS proc_get_nombre_cargo_propiedadServicio;
DELIMITER //
CREATE PROCEDURE proc_get_nombre_cargo_propiedadServicio(IN nombreServicio VARCHAR(50))
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
	AND LOWER(ub.ciudad) = LOWER(nombreServicio);

    IF (SELECT COUNT(*) FROM temp_resultados) = 0 THEN
        SELECT 'No hay resultados coincidentes' AS Mensaje;
    ELSE
		SELECT * FROM temp_resultados;
    END IF;
    DROP TEMPORARY TABLE IF EXISTS temp_resultados;
END //
DELIMITER ;
CALL proc_get_nombre_cargo_propiedadServicio('bucaramanga');
```
