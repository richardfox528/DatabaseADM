/*
Ejercicio de Cursores: Crea un cursor que recorra los empleados y 
calcule el salario total que la empresa ha pagado a cada empleado 
en un año específico.
*/

CREATE OR REPLACE PROCEDURE CalcularSalarioAnualPorEmpleado(p_ANIO IN NUMBER)
IS
    -- Variables
    v_ID_EMPLEADO EMPLEADOS.ID_EMPLEADO%TYPE;
    v_NOMBRE_EMPLEADO EMPLEADOS.NOMBRES%TYPE;
    v_SALARIO_TOTAL NUMBER(10, 2);
    conceptos_total NUMBER(10, 2);

    -- Cursor para recorrer los empleados
    CURSOR cursor_empleados IS
        SELECT ID_EMPLEADO, NOMBRES
        FROM EMPLEADOS;

BEGIN
    -- Abrir el cursor de empleados
    OPEN cursor_empleados;

    -- Bucle para recorrer los empleados
    LOOP
        -- Obtener el próximo empleado
        FETCH cursor_empleados INTO v_ID_EMPLEADO, v_NOMBRE_EMPLEADO;
        EXIT WHEN cursor_empleados%NOTFOUND;  -- Salir del bucle si no hay más empleados

        -- Obtener el salario base multiplicado por 12
        SELECT NVL(SUM(SALARIO), 0) * 12
        INTO v_SALARIO_TOTAL
        FROM EMPLEADOS
        WHERE ID_EMPLEADO = v_ID_EMPLEADO;

        -- Sumar los conceptos adicionales para el año específico
        SELECT NVL(SUM(MONTO), 0)
        INTO conceptos_total
        FROM CONCEPTOS_SALARIO
        WHERE ID_EMPLEADO = v_ID_EMPLEADO
        AND EXTRACT(YEAR FROM FECHA_LIQUIDACION) = p_ANIO;

        -- Sumar el salario base y los conceptos adicionales
        v_SALARIO_TOTAL := v_SALARIO_TOTAL + conceptos_total;

        -- Mostrar resultados
        dbms_output.put_line('Empleado: ' || v_NOMBRE_EMPLEADO || ', Salario Anual: ' || v_SALARIO_TOTAL);
    END LOOP;

    -- Cerrar el cursor
    CLOSE cursor_empleados;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Ocurrió un error: ' || SQLERRM);
        ROLLBACK;
END CalcularSalarioAnualPorEmpleado;
/

-- USO
SET SERVEROUTPUT ON;
BEGIN
    CalcularSalarioAnualPorEmpleado(2023);
END;
/
