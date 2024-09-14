# Database administration
To properly execute the following SQL scripts and prevent errors in the database manager, especially in MySQL Workbench, it is crucial to follow a specific sequence.

- [**Database_admbd.sql**](https://github.com/richardfox528/DatabaseADM/blob/main/Database_admbd.sql) This is the main file, it is in charge of creating the database, establishing the corresponding tables with their foreign keys (FK) and also their primary keys (PK).
It is crucial that the execution is carried out exactly as it is, without state changes, since any modification could cause errors in the foreign keys that depend on one table or another.
- [**Insert_into_admbd.sql**](https://github.com/richardfox528/DatabaseADM/blob/main/Insert_into_admbd.sql) This file is designed to enter information into each of the tables; for example, in this case, five rows are added to each table. It is also crucial to run it without making changes to the code, since some tables depend on external data from other tables.
- [**6_función_almacenada.sql**](https://github.com/richardfox528/DatabaseADM/blob/main/6_función_almacenada.sql) The following file creates a function that returns the value to be paid for a given period for an employee, for which the settlement period must be monthly.
- [**7_función_días_vacaciones.sql**](https://github.com/richardfox528/DatabaseADM/blob/main/7_función_días_vacaciones.sql) The following file creates a function that calculates the total vacation time taken by an employee in a specific year.
- [**8_cursor_empleados.sql**](https://github.com/richardfox528/DatabaseADM/blob/main/8_cursor_empleados.sql) The following file creates a cursor that goes through the employees and calculates the total salary that the company has paid to each employee in a specific year.
- [**9_triggers.sql**](https://github.com/richardfox528/DatabaseADM/blob/main/9_triggers.sql) The following file creates the **Triggers for points 9, 10 and 13**, in which each one fulfills a specific task.
- [**11_optimización_de_consulta.sql**](https://github.com/richardfox528/DatabaseADM/blob/main/11_optimización_de_consulta.sql) The attached file demonstrates how the query was properly corrected, thus achieving the expected result.
- [**12_promedio_desempeño.sql**](https://github.com/richardfox528/DatabaseADM/blob/main/12_promedio_desempeño.sql) The attached file creates a function that returns the average of the performance evaluation scores of all employees in a given year.

## ❗❗ IMPORTANT:

If you want to run the files in Oracle SQL Developer please make use of the following files. [Oracle](https://github.com/richardfox528/DatabaseADM/tree/main/Oracle) These files have been modified specifically for use in this DBMS.

## Examples created and explained

5. In a database create the following tables and then insert at least 5 records in each table:
   
   EMPLEADOS ( ID_EMPLEADO, NOMBRES, CARGO, SALARIO, DEPARTAMENTO, FECHA_INGRESO, FECHA_RETIRO)
   DEPARTAMENTOS ( ID_DEPARTAMENTO, NOMBRE_DEPARTAMENTO)
   SALARIOS_HISTORICOS ( ID_EMPLEADO, FECHA_CAMBIO, NUEVO_SALARIO)
   PERMISOS_VACACIONES (ID_PERMISO, ID_EMPLEADO, FECHA_INICIO, FECHA_FIN, MOTIVO)
   EVALUACIONES_DESEMPEÑO ( ID_EVALUACION, ID_EMPLEADO, PUNTUACIÓN, OBSERVACIONES, FECHA_EVALUACION)
   CONCEPTOS_SALARIO( ID_PERIODO, ID_CONCEPTO, ID_EMPLEADO, MONTO, FECHA_LIQUIDACION)
   CONCEPTOS (ID, NOMBRE, SIGNO)
   PERIODOS (ID, DESCRIPCIÓN, FECHA_INICIAL, FECHA_FINAL, ESTADO)
   EMPLEADOS_VACACIONES (ID_EMPLEADO, PERIODO_ANUAL, SALDO_DIAS, FECHA_ACTUALIZACION).
   [Database_admbd.sql](https://github.com/richardfox528/DatabaseADM/blob/main/Database_admbd.sql)

6. Create a stored function that returns a value to be paid for a given period for an employee. The payout period must be monthly.
   [6_función_almacenada.sql](https://github.com/richardfox528/DatabaseADM/blob/main/6_función_almacenada.sql)
   
7. Create a function that calculates the total vacation time taken by an employee in a specific year.
   [7_función_días_vacaciones.sql](https://github.com/richardfox528/DatabaseADM/blob/main/7_función_días_vacaciones.sql)
   
8. Cursor Exercise: Create a cursor that goes through the employees and calculates the total salary the company has paid to each employee in a specific year.
   [8_cursor_empleados.sql](https://github.com/richardfox528/DatabaseADM/blob/main/8_cursor_empleados.sql)

9. Create a trigger that, when inserting a new record in the HOLIDAY_LEAVE table, automatically updates the vacation balance available for the employee for that year.
    [9_triggers.sql](https://github.com/richardfox528/DatabaseADM/blob/main/9_triggers.sql)

10. Trigger exercise: Create a trigger that, when updating an employee's salary in the EMPLOYEES table, automatically registers the change in the SALARIES_HISTORICAL table.
    [9_triggers.sql](https://github.com/richardfox528/DatabaseADM/blob/main/9_triggers.sql)

11. Query Optimization: fixes the following inefficient query that is affecting system performance. The query should get the list of employees who have received a salary increase in the last year, and shows what is the amount increased.
    [11_optimización_de_consulta.sql](https://github.com/richardfox528/DatabaseADM/blob/main/11_optimización_de_consulta.sql)
    
    ![Captura de pantalla 2024-09-09 104811](https://github.com/user-attachments/assets/dd74c7a2-dcf1-4b5d-8a4b-812a748ab856)
    
12. Functions Exercise: Create a function that returns the average of the performance evaluation scores of all employees in a given year.
    [12_promedio_desempeño.sql](https://github.com/richardfox528/DatabaseADM/blob/main/12_promedio_desempeño.sql)

13. Create a trigger that prevents an employee from logging in or logging out between 8 pm and 7 am.
    [9_triggers.sql](https://github.com/richardfox528/DatabaseADM/blob/main/9_triggers.sql)

## Run Locally

Clone the local repository and view it in your preferred editor.

```bash
  git clone https://github.com/richardfox528/DatabaseADM.git
```

## 🔗 Links
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://github.com/richardfox528)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/ricardo-mu%C3%B1oz-hoyos/)
[![twitter](https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/dmwgj97)


[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](http://www.gnu.org/licenses/agpl-3.0)
