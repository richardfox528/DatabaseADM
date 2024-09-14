/*
Crea una funci�n que calcule el tiempo total de vacaciones tomadas 
por un empleado en un a�o espec�fico.
*/

CREATE OR REPLACE FUNCTION TotalVacacionesTomadas (
    p_ID_EMPLEADO IN NUMBER,
    p_ANIO IN NUMBER
) 
RETURN VARCHAR2
IS
    total_dias NUMBER;
    nombre_empleado VARCHAR2(100);
BEGIN
    SELECT NOMBRES
    INTO nombre_empleado
    FROM EMPLEADOS
    WHERE ID_EMPLEADO = p_ID_EMPLEADO;

    -- Calcular los d�as de vacaciones tomando la diferencia entre fechas y sumando 1
    SELECT NVL(SUM((FECHA_FIN - FECHA_INICIO) + 1), 0)
    INTO total_dias
    FROM PERMISOS_VACACIONES
    WHERE ID_EMPLEADO = p_ID_EMPLEADO
    AND EXTRACT(YEAR FROM FECHA_INICIO) = p_ANIO
    AND EXTRACT(YEAR FROM FECHA_FIN) = p_ANIO;

    -- Retornar el resultado
    RETURN 'Empleado: ' || nombre_empleado || ', D�as de vacaciones tomados: ' || total_dias;
END TotalVacacionesTomadas;
/

-- Uso de la funci�n
SELECT
    "C##ADMBD"."TOTALVACACIONESTOMADAS"(10, 2023) "RESULTADO"
FROM
    "SYS"."DUAL" "A1"; -- ID de empleado y a�o
