-- 1 EN HR 
SET serveroutput ON;
DECLARE
    err_num NUMBER;
    err_msg VARCHAR2(255);
  
    CURSOR cur(c_idemployee NUMBER) Is select * from EMPLOYEES; 
    v_reg EMPLOYEES%ROWTYPE;
BEGIN
 --CURSOR
    OPEN cur(205);
        FETCH cur INTO v_reg;
        IF v_reg.commission_pct is null THEN         
            dbms_output.put_line(v_reg.first_name||' no tiene  premio: Para la proxima será'  );
        ELSIF v_reg.salary*v_reg.commission_pct < 1000 THEN 
            dbms_output.put_line(v_reg.first_name||' tiene un premio: REFRIGERADORA'  );
        ELSIF v_reg.salary*v_reg.commission_pct < 2000 THEN  
            dbms_output.put_line(v_reg.first_name||' tiene un premio: EQUIPO DE SONIDO'  );
        END IF;
    CLOSE cur; 

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.put_line('Codigo del Empleado No Existe!!!!');

    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.put_line(' Hay varios campos ');
     
    WHEN OTHERS THEN
    err_num := SQLCODE;
    err_msg := SQLERRM;
    DBMS_OUTPUT.put_line('Error:'||TO_CHAR(err_num));
    DBMS_OUTPUT.put_line(err_msg);
END;






/*Mediante un cursor mostrar un REPORTE con la siguiente información:
el nombre del cliente, la dirección, nombre del país, el monto total ORDENANDO LISTANDO por categoría de
producto, para cada cliente y el tipo de clasificación según los siguientes criterios para el monto total
vendido por cliente:/*/
select * from empleados;
select * from user_tables;
select* from clientes; 
select * from paises;
select * from categorias;
select * from pedidoscabe
select * from productos;
--precio , cantidad y descuento
calculo del monto  este valor lo meto al if 
-- clasificacion = segun valor de monto total calculado 
select * from pedidoscabe pc
inner join clientes cli ON cli.idcliente=pc.idcliente
inner join pedidosdeta pd ON pc.idpedido=pd.idpedido 
inner join productos pr ON pd.idproducto=pr.idproducto
inner join categorias c ON pr.idcategoria=c.idcategoria
inner join paises p ON p.idpais =cli.idpais order by c.idcategoria;
--clientes ordenados por categoria


--EJERCICIOS 2 EN NEGOCIOS

SET serveroutput ON;
DECLARE
    err_num NUMBER;
    err_msg VARCHAR2(255);
    
    CURSOR cur Is select * from pedidoscabe pc
    inner join clientes cli ON cli.idcliente=pc.idcliente
    inner join pedidosdeta pd ON pc.idpedido=pd.idpedido 
    inner join productos pr ON pd.idproducto=pr.idproducto
    inner join categorias c ON pr.idcategoria=c.idcategoria
    inner join paises p ON p.idpais =cli.idpais order by c.idcategoria;

    monto_total number(7,2);  
    clasif VARCHAR2(255);
BEGIN
 --CURSOR
    monto_total:=0;
    for v_reg in cur loop 
        monto_total:=(v_reg.preciounidad*v_reg.cantidad)-(v_reg.preciounidad*v_reg.cantidad*v_reg.descuento);
        IF monto_total<1000 THEN 
            clasif:='GRUPO AAA'
        ELSIF monto_total=1000 and monto_total<2000 THEN
            clasif:='GRUPO BBB'
        ELSIF monto_total>2000 THEN 
            clasif:='GRUPO CCC'
        END IF 
        
        dbms_output.put_line('Categoria: '||v_reg.nombrecategoria||'Name: '|| v_reg.NOMCLIENTE||' DIRECCION: '||v_reg.DIRCLIENTE||
        'PAIS: '||v_reg.NOMBREPAIS||' monto : '||monto_total||
        'clasificacion: '||clasif );
    END LOOP;
  --  CLOSE cur; 

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.put_line('Codigo del Empleado No Existe!!!!');

    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.put_line(' Hay varios campos ');
     
    WHEN OTHERS THEN
    err_num := SQLCODE;
    err_msg := SQLERRM;
    DBMS_OUTPUT.put_line('Error:'||TO_CHAR(err_num));
    DBMS_OUTPUT.put_line(err_msg);
END;
