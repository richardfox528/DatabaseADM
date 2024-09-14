/*
Crea una funci�n que devuelva el 
promedio de las puntuaciones de evaluaci�n de desempe�o de todos 
los empleados en un a�o determinado
*/

CREATE OR REPLACE FUNCTION PromedioEvaluaciones (
    p_ANIO IN NUMBER
) 
RETURN NUMBER
IS
    promedio NUMBER(5, 2);
BEGIN
    -- promedio
    SELECT NVL(AVG(PUNTUACION), 0)
    INTO promedio
    FROM EVALUACIONES_DESEMPENO
    WHERE EXTRACT(YEAR FROM FECHA_EVALUACION) = p_ANIO;

    RETURN promedio;
END PromedioEvaluaciones;
/


-- USO DE LA FUNCI�N
SELECT
    "C##ADMBD"."PROMEDIOEVALUACIONES"(2021) "PROMEDIO_EVALUACIONES"
FROM
    "SYS"."DUAL" "A1";

-- O

SELECT promedioevaluaciones(2021) AS "PROMEDIO_EVALUACIONES" FROM DUAL;
