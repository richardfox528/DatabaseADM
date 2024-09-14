/*
Optimización de Consultas: corrige la siguiente consulta 
ineficiente que está¡ afectando el rendimiento del sistema. La 
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
    "A1"."QCSJ_C000000000400000_0" "ID_EMPLEADO",
    "A1"."NOMBRES_1"               "NOMBRES",
    SUM("A1"."AUMENTO_4")          "AUMENTO_TOTAL"
FROM
    (
        SELECT
            "A3"."ID_EMPLEADO"  "QCSJ_C000000000400000_0",
            "A3"."NOMBRES"      "NOMBRES_1",
            "A2"."ID_EMPLEADO"  "QCSJ_C000000000400001",
            "A2"."FECHA_CAMBIO" "FECHA_CAMBIO",
            "A2"."AUMENTO"      "AUMENTO_4"
        FROM
            "C##ADMBD"."EMPLEADOS" "A3",
            (
                SELECT
                    "A4"."ID_EMPLEADO"  "ID_EMPLEADO",
                    "A4"."FECHA_CAMBIO" "FECHA_CAMBIO",
                    "A4"."NUEVO_SALARIO" - nvl(decode(COUNT(*)
                                                      OVER(PARTITION BY "A4"."ID_EMPLEADO"
                                                           ORDER BY
                                                               "A4"."FECHA_CAMBIO"
                        ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
                                                      ),
                                                      1,
                                                      FIRST_VALUE("A4"."NUEVO_SALARIO")
                                                      OVER(PARTITION BY "A4"."ID_EMPLEADO"
                                                           ORDER BY
                                                                           "A4"."FECHA_CAMBIO"
                                                                       ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
                                                      ),
                                                      NULL),
                                               0)                  "AUMENTO"
                FROM
                    "C##ADMBD"."SALARIOS_HISTORICOS" "A4"
                WHERE
                    "A4"."FECHA_CAMBIO" >= add_months(sysdate,(- 12))
            )                      "A2"
        WHERE
            "A3"."ID_EMPLEADO" = "A2"."ID_EMPLEADO"
    ) "A1"
GROUP BY
    "A1"."QCSJ_C000000000400000_0",
    "A1"."NOMBRES_1"
HAVING
    SUM("A1"."AUMENTO_4") > 0;
