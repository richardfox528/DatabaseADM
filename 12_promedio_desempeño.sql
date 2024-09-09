/*
Crea una función que devuelva el 
promedio de las puntuaciones de evaluación de desempeño de todos 
los empleados en un año determinado
*/

DELIMITER //

CREATE FUNCTION PromedioEvaluaciones(p_ANIO INT)
RETURNS DECIMAL(5, 2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(5, 2);

    SELECT IFNULL(AVG(PUNTUACION), 0) INTO promedio
    FROM EVALUACIONES_DESEMPENO
    WHERE YEAR(FECHA_EVALUACION) = p_ANIO;

    -- Devolver el promedio
    RETURN promedio;
END //

DELIMITER ;

-- USO DE LA FUNCIÓN
SELECT PromedioEvaluaciones(2021) AS Promedio_Evaluaciones;
