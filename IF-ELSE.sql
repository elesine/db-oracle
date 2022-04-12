select * from user_tables;
select * from pedidoscabe;
-- cantidad de pedidos
select count(idcliente) from pedidoscabe where idcliente='PARIS' ;
select count(*) from pedidoscabe where idcliente='BERGS';

--si el cliente ha hecho 0 pedidos , 1 pedido y muchos pedidos;
SET SERVEROUTPUT ON
DECLARE 
--declaro varibales
    v_idcliente CHAR(5):='BERGS';
    v_cantidad NUMBER(5);
BEGIN

select count(*) INTO v_cantidad from pedidoscabe where idcliente=v_idcliente ;

IF v_cantidad = 0 THEN
       dbms_output.put_line('EL CLIENTE '||v_idcliente||' NO HA HECHO PEDIDO '||v_cantidad );   

ELSIF v_cantidad = 1 THEN
       dbms_output.put_line('EL CLIENTE '||v_idcliente||' HA HECHO UN PEDIDO' );   
ELSE
       dbms_output.put_line('EL CLIENTE '||v_idcliente||' HA HECHO '||v_cantidad || ' PEDIDOS' );   
END IF;

END;