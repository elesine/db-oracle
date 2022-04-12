SET SERVEROUTPUT on
select * from empleados;
//suma de dos variables 
DECLARE 
    V_VAR1 NUMBER(6):=100;
    V_VAR2 NUMBER(6);
    V_SUMA NUMBER(10);
BEGIN
    V_VAR2:=520;
    dbms_output.put_line('BIENVENIDOS');
    dbms_output.put_line('var1: ' || V_VAR1);
    dbms_output.put_line('var2: ' || V_VAR2);
    dbms_output.put_line('SUMA: ' || V_SUMA);
    V_SUMA:= V_VAR1+V_VAR2;
    dbms_output.put_line('TOTAL SUMA: ' || V_SUMA);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('NO HAY DATOS');  
END;

//procedimiento que me devuelva cuantos empleados tienen en el carg numero 4 
DECLARE 
    cantidad NUMBER(6);
BEGIN
    select count(*) into cantidad from empleados where idcargo=4;
    dbms_output.put_line('TOTAL CANTIDAD ' || cantidad);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('NO HAY DATOS');  
END;+

//procedimiento que me devuelva codigo ,nombre apellido de mi empleados
