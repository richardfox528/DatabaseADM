########################################################################################################################################################

/* 9
Crea un trigger que, al insertar un nuevo registro en la tabla 
PERMISOS_VACACIONES, por disfrute de vacaciones, actualice 
automáticamente el saldo de vacaciones disponible para el 
empleado para ese año.
*/

CREATE OR REPLACE TRIGGER ActualizarSaldoVacaciones
AFTER INSERT ON PERMISOS_VACACIONES
FOR EACH ROW
DECLARE
    dias_disfrutados NUMBER;
BEGIN
    IF :NEW.MOTIVO = 'Disfrute de Vacaciones' THEN
        dias_disfrutados := (:NEW.FECHA_FIN - :NEW.FECHA_INICIO) + 1;

        UPDATE EMPLEADOS_VACACIONES
        SET SALDO_DIAS = SALDO_DIAS - dias_disfrutados,
            FECHA_ACTUALIZACION = SYSDATE
        WHERE ID_EMPLEADO = :NEW.ID_EMPLEADO
        AND EXTRACT(YEAR FROM PERIODO_ANUAL) = EXTRACT(YEAR FROM :NEW.FECHA_INICIO);
    END IF;
END;
/

########################################################################################################################################################

/* 10
Ejercicio de Trigger: Crea un trigger que, al actualizar el salario 
de un empleado en la tabla EMPLEADOS, registre automáticamente 
el cambio en la tabla SALARIOS_HISTORICOS.
*/

CREATE OR REPLACE TRIGGER RegistrarCambioSalario
AFTER UPDATE ON EMPLEADOS
FOR EACH ROW
BEGIN
    IF :NEW.SALARIO != :OLD.SALARIO THEN
        INSERT INTO SALARIOS_HISTORICOS (ID_EMPLEADO, FECHA_CAMBIO, NUEVO_SALARIO)
        VALUES (:NEW.ID_EMPLEADO, SYSDATE, :NEW.SALARIO);
    END IF;
END;
/

UPDATE EMPLEADOS 
SET 
    SALARIO = 4000
WHERE
    ID_EMPLEADO = 6;
    
########################################################################################################################################################
    
/* 13
Crea un trigger que evite que se registre o ingrese un empleado 
entre las 8 pm y las 7 am.
*/

CREATE OR REPLACE TRIGGER RestriccionInsertarEmpleado
BEFORE INSERT ON EMPLEADOS
FOR EACH ROW
DECLARE
    hora_actual TIMESTAMP;
BEGIN
    -- Obtener la hora actual
    hora_actual := SYSTIMESTAMP;

    -- Condicional de rango (8 PM - 7 AM)
    IF TO_CHAR(hora_actual, 'HH24:MI:SS') >= '20:00:00' OR TO_CHAR(hora_actual, 'HH24:MI:SS') < '07:00:00' THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'No se pueden registrar empleados entre las 8 PM y las 7 AM'
        );
    END IF;
END;
/

-- Prueba
--DROP TRIGGER RestriccionInsertarEmpleado;

INSERT INTO EMPLEADOS (NOMBRES, CARGO, SALARIO, DEPARTAMENTO, FECHA_INGRESO)
VALUES ('Juan Perez', 'Desarrollador', 3000, 1, TO_DATE('2024-09-05', 'YYYY-MM-DD'));

