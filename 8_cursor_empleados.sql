/*
Ejercicio de Cursores: Crea un cursor que recorra los empleados y 
calcule el salario total que la empresa ha pagado a cada empleado 
en un año específico.
*/

DELIMITER //

CREATE PROCEDURE CalcularSalarioAnualPorEmpleado(p_ANIO INT)
BEGIN
    -- variables
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_ID_EMPLEADO INT;
    DECLARE v_NOMBRE_EMPLEADO VARCHAR(100);
    DECLARE v_SALARIO_TOTAL DECIMAL(10, 2);
    DECLARE conceptos_total DECIMAL(10, 2);

    DECLARE cursor_empleados CURSOR FOR
    SELECT ID_EMPLEADO, NOMBRES
    FROM EMPLEADOS;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    CREATE TEMPORARY TABLE IF NOT EXISTS SalariosAnuales (
        Empleado VARCHAR(100),
        Salario_Total_Anual DECIMAL(10, 2)
    );

    OPEN cursor_empleados;

    empleado_loop: LOOP
        FETCH cursor_empleados INTO v_ID_EMPLEADO, v_NOMBRE_EMPLEADO;

        IF done THEN
            LEAVE empleado_loop;
        END IF;

        SELECT IFNULL(SUM(SALARIO), 0) * 12 INTO v_SALARIO_TOTAL
        FROM EMPLEADOS
        WHERE ID_EMPLEADO = v_ID_EMPLEADO;

        SELECT IFNULL(SUM(MONTO), 0) INTO conceptos_total
        FROM CONCEPTOS_SALARIO
        WHERE ID_EMPLEADO = v_ID_EMPLEADO
        AND YEAR(FECHA_LIQUIDACION) = p_ANIO;

        SET v_SALARIO_TOTAL = v_SALARIO_TOTAL + conceptos_total;

        -- tabla temporal
        INSERT INTO SalariosAnuales (Empleado, Salario_Total_Anual)
        VALUES (v_NOMBRE_EMPLEADO, v_SALARIO_TOTAL);

    END LOOP;

    CLOSE cursor_empleados;

    SELECT * FROM SalariosAnuales;

    DROP TEMPORARY TABLE IF EXISTS SalariosAnuales;
END //

DELIMITER ;

-- USO DE LA FUNCIÓN
CALL CalcularSalarioAnualPorEmpleado(2023);

