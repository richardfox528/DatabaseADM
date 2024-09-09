-- Inserción de valores a las tablas creadas

USE admbd;

INSERT INTO DEPARTAMENTOS (NOMBRE_DEPARTAMENTO) 
VALUES 
('Recursos Humanos'),
('Tecnología'),
('Marketing'),
('Ventas'),
('Finanzas');

INSERT INTO EMPLEADOS (NOMBRES, CARGO, SALARIO, DEPARTAMENTO, FECHA_INGRESO, FECHA_RETIRO) 
VALUES 
('Juan Pérez', 'Gerente', 3500.50, 1, '2020-01-15', NULL),
('Ana Gómez', 'Desarrolladora', 2500.00, 2, '2021-03-10', NULL),
('Luis Torres', 'Vendedor', 1500.00, 4, '2019-08-01', '2023-02-10'),
('María López', 'Analista Financiera', 2800.00, 5, '2018-06-20', NULL),
('Pedro Sánchez', 'Especialista en Marketing', 2200.00, 3, '2020-11-05', NULL);

INSERT INTO SALARIOS_HISTORICOS (ID_EMPLEADO, FECHA_CAMBIO, NUEVO_SALARIO)
VALUES 
(1, '2021-01-01', 3600.00),
(2, '2022-04-15', 2600.00),
(3, '2020-12-01', 1600.00),
(4, '2019-07-01', 2900.00),
(5, '2021-11-01', 2300.00);

INSERT INTO PERMISOS_VACACIONES (ID_EMPLEADO, FECHA_INICIO, FECHA_FIN, MOTIVO)
VALUES 
(1, '2022-12-01', '2022-12-15', 'Vacaciones anuales'),
(2, '2023-06-01', '2023-06-07', 'Asuntos personales'),
(3, '2021-05-15', '2021-05-30', 'Licencia médica'),
(4, '2020-09-20', '2020-09-25', 'Viaje familiar'),
(5, '2023-02-01', '2023-02-10', 'Vacaciones anuales');

INSERT INTO EVALUACIONES_DESEMPENO (ID_EMPLEADO, PUNTUACION, OBSERVACIONES, FECHA_EVALUACION)
VALUES 
(1, 4.5, 'Excelente desempeño', '2022-01-15'),
(2, 4.0, 'Buen desempeño', '2023-03-10'),
(3, 3.0, 'Mejorable', '2020-08-01'),
(4, 4.8, 'Desempeño destacado', '2021-06-20'),
(5, 3.5, 'Satisfactorio', '2022-11-05');

INSERT INTO CONCEPTOS (NOMBRE, SIGNO)
VALUES 
('Bono', '+'),
('Descuento', '-'),
('Comisión', '+'),
('Ajuste Salarial', '+'),
('Impuesto', '-');

INSERT INTO PERIODOS (DESCRIPCION, FECHA_INICIAL, FECHA_FINAL, ESTADO)
VALUES 
('Primer trimestre 2022', '2022-01-01', '2022-03-31', 'Cerrado'),
('Segundo trimestre 2022', '2022-04-01', '2022-06-30', 'Cerrado'),
('Tercer trimestre 2022', '2022-07-01', '2022-09-30', 'Cerrado'),
('Cuarto trimestre 2022', '2022-10-01', '2022-12-31', 'Cerrado'),
('Primer trimestre 2023', '2023-01-01', '2023-03-31', 'Abierto');

INSERT INTO CONCEPTOS_SALARIO (ID_PERIODO, ID_CONCEPTO, ID_EMPLEADO, MONTO, FECHA_LIQUIDACION)
VALUES 
(1, 1, 1, 500.00, '2022-01-31'),
(2, 2, 2, 200.00, '2022-06-30'),
(3, 3, 3, 150.00, '2022-09-30'),
(4, 4, 4, 300.00, '2022-12-31'),
(5, 5, 5, 100.00, '2023-03-31');

INSERT INTO EMPLEADOS_VACACIONES (ID_EMPLEADO, PERIODO_ANUAL, SALDO_DIAS, FECHA_ACTUALIZACION)
VALUES 
(1, '2022-01-01', 15, '2022-12-31'),
(2, '2023-01-01', 10, '2023-06-01'),
(3, '2021-01-01', 20, '2021-05-30'),
(4, '2020-01-01', 5, '2020-09-25'),
(5, '2023-01-01', 12, '2023-02-10');

