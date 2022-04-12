--FUNCIONES
select * from user_tables;
/* 1. Mostrar concatenado el Apellido (LastName) y Nombre (FirstName) de todos los Empleados (Employees). */
SELECT CONCAT(CONCAT(CONCAT(CONCAT(FIRST_NAME,', '), LAST_NAME),'-'),SALARY) FROM EMPLOYEES;
/*2. Mostrar el segundo car�cter y pen�ltimo car�cter del Correo (Email) de todos los Empleados (Employees). */
select * from employees;
select email, SUBSTR(email, 2,1) segundocaracter, SUBSTR(email, LENGTH(email)-1,1) penultimocaracter from employees;
/*3.Mostrar la longitud del Nombre de Pa�s (Country_Name) de todos los Pa�ses (Countries).*/
select * from countries;
select country_name, LENGTH(country_name)from countries;
/*4. Mostrar el �ltimo car�cter del Apellido (LastName) y luego en base al �ltimo car�cter obtener la posici�n de dicho
car�cter en el Apellido (LastName) de todos los Empleados (Employees).
SELECT INSTR('PEPE PEREZ','PE',-1) FROM DUAL; */
select last_name, substr( last_name, length(last_name), 1 ) ultimaletra , instr(last_name,substr( last_name, length(last_name), 1 ),-1) posicion from Employees;
/*5. Mostrar el Nombre de Empleado (FirstName) rellenado con 4 asteriscos a la izquierda de todos los Empleados(Employees). */
select  concat('****',first_name)  from employees;
/*6. Mostrar el Apellido de Empleado (LastName) rellenado con 8 asteriscos a la derecha de todos los Empleados(Employees).*/
select lpad(last_name,'********') from employees;
/*7. Mostrar el Correo de Empleado (Email) rellenado con 2 asteriscos a la izquierda y 2 a la derecha de todos los
Empleados (Employees).*/
select concat('**',concat(email,'**')) from employees;
/*8. Mostrar el Titulo del Trabajo (Job_Title) limpiando los espacios en blanco de los extremos de todos los Trabajos
(Jobs).*/
select TRIM(JOB_TITLE) from jobs;
SELECT trim('     PEPE PEREZ      ') FROM DUAL; 
/*9. Mostrar el Correo de Empleado (Email) convirtiendo todas las letras en min�sculas de todos los Empleados
(Employees).*/
select LOWER(email) from employees;
/*10. Mostrar el Apellido de Empleado (LastName) convirtiendo todas las letras en may�sculas de todos los Empleados
(Employees).*/
select UPPER(email) from employees;
/*11. Mostrar el Nombre de Pa�s (Country_Name) convirtiendo la primera letra de cada palabra en may�sculas y todas
las dem�s letras en min�sculas de todos los Pa�ses (Countries).*/
select INITCAP(country_name) from countries;
/*12. Mostrar el Salario del Empleado (Salary) redondeado a 2 decimales de todos los Empleados (Employees).*/
select round(salary/1.15,2) from employees;
/*13. Mostrar el Salario del Empleado (Salary) truncado a 2 decimales de todos los Empleados (Employees).*/
select trunc(salary/1.15,2) from employees;
/*14. Mostrar el resto de la divisi�n entre el Salario (Salary) y el Id (Employee_Id) de todos los Empleados (Employees).*/
select  MOD(salary,employee_id)  from employees;
/*15. Mostrar el n�mero de meses entre la Fecha del Sistema y la Fecha de Contrataci�n (Hire_Date) de todos los
Empleados (Employees).*/
select MONTHS_BETWEEN(Sysdate,hire_date) from employees;
/*16. Mostrar la Fecha de Contrataci�n (Hire_Date) aumentado en 6 meses m�s de todos los Empleados (Employees).*/
select hire_date , add_months(hire_date,6) from employees;
/*17. Mostrar el siguiente viernes despu�s de la Fecha de Contrataci�n (Hire_Date) de todos los Empleados(Employees).*/
select hire_date ,next_day(hire_date,'VIERNES') from employees;
/*18. Mostrar la Fecha de Contrataci�n (Hire_Date) de todos los Empleados (Employees). Aplicando el siguiente
formato: NOMBRE_DIA, DIA_MES de NOMBRE_MES de A�O (Martes, 28 de MARZO de 2017).*/
SELECT TO_CHAR(sysdate, 'DAY , DD "de" MONTH "de" YYYY ') FROM DUAL;
SELECT TO_CHAR(hire_date, 'DAY , DD "de" MONTH "de" YYYY ') FROM employees;
/*19. Mostrar la Fecha de Contrataci�n (Hire_Date) de todos los Empleados (Employees). Aplicando el siguiente
formato: DIA_MES/MES/A�O (28/03/2017).*/
SELECT TO_CHAR(sysdate, 'dd/mm/yyyy') FROM DUAL;
select to_char(hire_date,'dd/mm/yyyy') from employees; 
/*20. Mostrar el Salario (Salary) de todos los Empleados (Employees). Aplicando el siguiente formato: L999,999,999.99
(S/24,461.17).*/
select to_char(salary,'L999,999,999.99') from employees;
-- exttraigo el mes de la fecha actual 
 select extract(month from sysdate) from dual;
-- Ejemplo MAY MIN PRIMERO MAYUSCULA
SELECT last_name, UPPER(last_name), job_id, LOWER(job_id), INITCAP(job_id) FROM employees;

/*
SYSDATE: retorna la fecha y hora actual de la Base de Datos
MONTHS_BETWEEN: obtiene la diferencia en meses entre las dos fechas. El resultado puede ser positivo o negativo. Si fecha1 es posterior a fecha2, el resultado es positivo, si fecha1 es anterior a fecha2, el resultado es negativo. La parte no entera del resultado representa una porci�n de la mes.
ADD_MONTHS: a�ade a la fecha el n�mero de meses indicado por n. El valor de n debe ser un n�mero entero y puede ser negativo.
NEXT_DAY: retorna la fecha del d�a de la semana del argumento busca y que es posterior a la fecha entregada. El d�a puede ser el nombre del d�a (ingl�s o espa�ol seg�n como est� configurada la Base de Datos) � el n�mero del d�a de la semana 1=Lunes, 2=Martes etc.
LAST_DAY: obtiene el �ltimo d�a del mes de la fecha especificada.
ROUND: redondea la fecha al formato indicado. El formato puede ser:
- YEAR: redondea la fecha al a�o.
- MONTH: redondea la fecha al mes.
TRUNC: trunca la fecha al formato indicado. El formato es el mismo al usado por ROUND.

*/
