SET SERVEROUTPUT ON
DECLARE
    i NUMBER:= 100;
    resultado NUMBER:= 0;
BEGIN
    while i<=1000 LOOP
        resultado:= i+resultado;
        i:=i+1;
    END loop;
    dbms_output.put_line('WHILE Number: '||resultado);   

    resultado:=0;    
    FOR loop_counter IN 100..1000 LOOP
            resultado:= loop_counter+resultado;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('FOR Number: ' || TO_CHAR(resultado) );
        
    i := 100;
    resultado:=0;
    LOOP
        resultado:= i+resultado;
        i:=i+1;
        EXIT WHEN i=1001;
    END LOOP;
    dbms_output.put_line('LOOP Number: '||resultado);   

END;