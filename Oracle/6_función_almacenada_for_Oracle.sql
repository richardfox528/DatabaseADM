/*
Función almacenada que devuelva el valor a pagar para un
periodo determinado de un empleado. el periodo de liquidación debe 
ser mensual.
*/

CREATE OR REPLACE FUNCTION ValorAPagar (
    p_ID_EMPLEADO IN NUMBER,
    p_ID_PERIODO IN NUMBER
) 
RETURN NUMBER
IS
    salario_base NUMBER(10, 2);
    total_conceptos NUMBER(10, 2);
    valor_total NUMBER(10, 2);
BEGIN
    -- salario del empleado
    SELECT SALARIO
    INTO salario_base
    FROM EMPLEADOS
    WHERE ID_EMPLEADO = p_ID_EMPLEADO;

    -- monto
    SELECT NVL(SUM(MONTO), 0)
    INTO total_conceptos
    FROM CONCEPTOS_SALARIO
    WHERE ID_EMPLEADO = p_ID_EMPLEADO AND ID_PERIODO = p_ID_PERIODO;

    -- Calcular el valor total
    valor_total := salario_base + total_conceptos;

    RETURN valor_total;
END ValorAPagar;
/

SELECT
    "C##ADMBD"."VALORAPAGAR"(7, 32) "VALOR_A_PAGAR"
FROM
    "SYS"."DUAL" "A1"; -- id empleado y id de periodo
