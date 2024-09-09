/*
Crea una función que calcule el tiempo total de vacaciones tomadas 
por un empleado en un año específico.
*/

DELIMITER //

CREATE FUNCTION TotalVacacionesTomadas (p_ID_EMPLEADO INT, p_ANIO INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE total_dias INT;
    DECLARE nombre_empleado VARCHAR(100);

    SELECT NOMBRES INTO nombre_empleado
    FROM EMPLEADOS
    WHERE ID_EMPLEADO = p_ID_EMPLEADO;

    SELECT IFNULL(SUM(DATEDIFF(FECHA_FIN, FECHA_INICIO) + 1), 0) INTO total_dias
    FROM PERMISOS_VACACIONES
    WHERE ID_EMPLEADO = p_ID_EMPLEADO
    AND YEAR(FECHA_INICIO) = p_ANIO
    AND YEAR(FECHA_FIN) = p_ANIO;

    RETURN CONCAT('Empleado: ', nombre_empleado, ', Días de vacaciones tomados: ', total_dias);
END //

DELIMITER ;

-- USO DE LA FUNCIÓN
SELECT TotalVacacionesTomadas(5, 2023) AS Resultado; # Id empleado y año
