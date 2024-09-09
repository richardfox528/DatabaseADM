/*
Optimización de Consultas: corrige la siguiente consulta 
ineficiente que está afectando el rendimiento del sistema. La 
consulta debe obtener la lista de empleados que han recibido un 
aumento salarial en el último año, y muestra cual es la cantidad 
aumentada.

""
drop table temporal_aumentos_ultimo_anio;
CREATE TABLE temporal_aumentos_ultimo_anio AS SELECT * FROM
    empleados
WHERE
    EXISTS( SELECT 
            *
        FROM
            salarios_historicos
        WHERE
            id_empleado = empleados.id_empleado
                AND MONTHS_BETWEEN(SYSDATE, FECHA_CAMBIO) <= 36
                AND 1 = 1);
SELECT 
    tm.ID_EMPLEADO, nombres, SUM(salario - nuevo_salario)
FROM
    temporal_aumentos_ultimo_anio tm,
    salarios_historicos sh
WHERE
    tm.id_empleado = sh.id_empleado
GROUP BY tm.id_empleado , nombres;
""
*/

SELECT 
    e.ID_EMPLEADO,
    e.NOMBRES,
    SUM(diff.AUMENTO) AS AUMENTO_TOTAL
FROM
    EMPLEADOS e
JOIN
    (SELECT 
        sh.ID_EMPLEADO,
        sh.FECHA_CAMBIO,
        (sh.NUEVO_SALARIO - IFNULL(LAG(sh.NUEVO_SALARIO) OVER (PARTITION BY sh.ID_EMPLEADO ORDER BY sh.FECHA_CAMBIO), 0)) AS AUMENTO
     FROM 
        SALARIOS_HISTORICOS sh
     WHERE
        sh.FECHA_CAMBIO >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    ) AS diff
ON e.ID_EMPLEADO = diff.ID_EMPLEADO
GROUP BY 
    e.ID_EMPLEADO, e.NOMBRES
HAVING
    AUMENTO_TOTAL > 0;

