SET SERVEROUTPUT ON
DECLARE
    i NUMBER:= 0;
BEGIN
    while i<=10 LOOP
        dbms_output.put_line('number'||i);   
        i:=i+1;
    END loop;
    --***********************************************
    FOR loop_counter IN 0..10 LOOP
    DBMS_OUTPUT.PUT_LINE('Number:------------ ' || TO_CHAR(loop_counter) );
    END LOOP;
    --***********************************************
    FOR loop_counter IN reverse 0..10 LOOP
    DBMS_OUTPUT.PUT_LINE('Number:------------ ' || TO_CHAR(loop_counter) );
    END LOOP;
    --***********************************************
    i := 0;
    LOOP
        dbms_output.put_line('number'||i);   
        i:=i+1;
        EXIT WHEN i=11;
    END LOOP;
END;