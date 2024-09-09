########################################################################################################################################################

/* 9
Crea un trigger que, al insertar un nuevo registro en la tabla 
PERMISOS_VACACIONES, por disfrute de vacaciones, actualice 
automáticamente el saldo de vacaciones disponible para el 
empleado para ese año.
*/

DELIMITER //

CREATE TRIGGER ActualizarSaldoVacaciones
AFTER INSERT ON PERMISOS_VACACIONES
FOR EACH ROW
BEGIN
    DECLARE dias_disfrutados INT;

    IF NEW.MOTIVO = 'Disfrute de Vacaciones' THEN
        SET dias_disfrutados = DATEDIFF(NEW.FECHA_FIN, NEW.FECHA_INICIO) + 1;

        UPDATE EMPLEADOS_VACACIONES
        SET SALDO_DIAS = SALDO_DIAS - dias_disfrutados,
            FECHA_ACTUALIZACION = NOW()
        WHERE ID_EMPLEADO = NEW.ID_EMPLEADO
        AND YEAR(PERIODO_ANUAL) = YEAR(NEW.FECHA_INICIO);
    END IF;
END //

DELIMITER ;

########################################################################################################################################################

/* 10
Ejercicio de Trigger: Crea un trigger que, al actualizar el salario 
de un empleado en la tabla EMPLEADOS, registre automáticamente 
el cambio en la tabla SALARIOS_HISTORICOS.
*/

DELIMITER //

CREATE TRIGGER RegistrarCambioSalario
AFTER UPDATE ON EMPLEADOS
FOR EACH ROW
BEGIN
    IF NEW.SALARIO != OLD.SALARIO THEN
        INSERT INTO SALARIOS_HISTORICOS (ID_EMPLEADO, FECHA_CAMBIO, NUEVO_SALARIO)
        VALUES (NEW.ID_EMPLEADO, NOW(), NEW.SALARIO);
    END IF;
END //

DELIMITER ;

UPDATE EMPLEADOS 
SET 
    SALARIO = 4000
WHERE
    ID_EMPLEADO = 1;
    
########################################################################################################################################################
    
/* 13
Crea un trigger que evite que se registre o ingrese un empleado 
entre las 8 pm y las 7 am.
*/

DELIMITER //

CREATE TRIGGER RestriccionInsertarEmpleado
BEFORE INSERT ON EMPLEADOS
FOR EACH ROW
BEGIN
    -- condicional de rango (8 PM - 7 AM)
    IF TIME(NOW()) >= '20:00:00' OR TIME(NOW()) < '07:00:00' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se pueden registrar empleados entre las 8 PM y las 7 AM';
    END IF;
END //

DELIMITER ;

-- Prueba
#DROP TRIGGER IF EXISTS RestriccionInsertarEmpleado;

INSERT INTO EMPLEADOS (NOMBRES, CARGO, SALARIO, DEPARTAMENTO, FECHA_INGRESO)
VALUES ('Juan Perez', 'Desarrollador', 3000, 1, '2024-09-05');

Show triggers;
