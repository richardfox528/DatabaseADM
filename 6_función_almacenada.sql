/*
Función almacenada que devuelva el valor a pagar para un
periodo determinado de un empleado. el periodo de liquidación debe 
ser mensual.
*/

DELIMITER //

CREATE FUNCTION ValorAPagar (p_ID_EMPLEADO INT, p_ID_PERIODO INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE salario_base DECIMAL(10, 2);
    DECLARE total_conceptos DECIMAL(10, 2);
    DECLARE valor_total DECIMAL(10, 2);

    -- Obtener el salario base del empleado
    SELECT SALARIO INTO salario_base
    FROM EMPLEADOS
    WHERE ID_EMPLEADO = p_ID_EMPLEADO;

    SELECT IFNULL(SUM(MONTO), 0) INTO total_conceptos
    FROM CONCEPTOS_SALARIO
    WHERE ID_EMPLEADO = p_ID_EMPLEADO AND ID_PERIODO = p_ID_PERIODO;

    -- Calcular el valor total a pagar (salario base + total conceptos)
    SET valor_total = salario_base + total_conceptos;

    RETURN valor_total;
END //

DELIMITER ;

-- USO DE LA FUNCIÓN
SELECT ValorAPagar(5, 3) AS Valor_A_Pagar; # Id de empñeado y Id de periodo
