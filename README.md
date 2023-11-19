## Descripción del negocio

Se busca implementar una base de datos destinada a la gestión integral de los alquileres de apartamentos, casas y habitaciones de la empresa "Viajemos Juntos" en Colombia. La base de datos deberá posibilitar las siguientes funcionalidades:

### Gestión de Empleados:
- Registro detallado de empleados, incluyendo información como nombre, apellido, número de identificación, correo electrónico y número de teléfono.
- Administración de diferentes roles para empleados, como administrador, personal de limpieza y mantenimiento.
- Asignación y seguimiento de propiedades a las que están asignados los empleados.

### Gestión de Huéspedes:
- Registro de huéspedes con información relacionada como nombre, apellido, numero de identificación, correo electrónico y número de teléfono.

### Gestión de Propiedades:	
- Registro de nuevas propiedades con detalles como nombre, descripción, ubicación, número de habitaciones, número de baños, capacidad, etc.
- Cada propiedad puede tener varias imágenes.
- Cada propiedad puede tener varios servicios adicionales como Wifi, zona de trabajo, lavadora, secadora, camara de seguridad, etc.

### Gestión de Reservas:
- Creación de nuevas reservas con información de fechas de inicio y finalización, número de huéspedes.
- Seguimiento del estado de las reservas (confirmada, pendiente, cancelada, completada).
- Cálculo automatico del precio total de la reserva basado en la duración de la estadía y el valor por noche.
  
### Gestión de Pagos:
- Registro de pagos asociados a reservas.
- Cada reserva puede ser cancelada, si se registro un pago de la reserva cancelada, este pago sera reembolsado.

### Gestión de Reseñas:
- Posibilidad para los usuarios huéspedes de dejar comentarios y calificaciones en propiedades después de una estancia.

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
- 
### Imágenes de Propiedades
- Las imágenes deben pertenecer a una propiedad existente.

### Servicios Adicionales:
- Cada servicio adicional debe tener un nombre único.

### Reservas:
- La fecha de inicio de la reserva debe ser anterior a la fecha de finalización.
- El estado de la reserva debe ser uno de los siguientes: "confirmada", "pendiente", "cancelada" o "completada".
- Si una reserva es confirmada, significa que se registro un pago.
- Una reserva en pendiente, no ha sido pagada.
- Si una reserva es completada, significa que el cliente realizo el pago y acudio a la estadia.
- Una reserva completada no podra ser reembolsada.
- Una reserva cancelada, registrará reembolso, solo si ha sido pagada, es decir se encontraba en estado confirmada.

### Pagos:
- La fecha de pago debe ser igual o anterior a la fecha actual.
- El valor del pago no puede ser negativo.

### Reembolsos:
- La fecha de reembolso debe ser igual o posterior a la fecha de pago asociada.
- El valor del reembolso sera igual al valor del pago de la reserva cancelada.

### Reseñas:
- La calificación de la reseña debe estar en el rango de 1 a 5.
- Un huésped solo puede hacer una reseña por propiedad.