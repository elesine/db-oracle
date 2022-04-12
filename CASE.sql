SET SERVEROUTPUT ON
DECLARE 
    v_idproducto NUMBER(10):=22 ;
    v_nomproducto productos.nomproducto%type  ;
    v_preciounidad productos.preciounidad%type ;
    v_stock productos.unidadesenexistencia%type ;
    ESTADO VARCHAR2(50);
    stock NUMBER(5);
BEGIN
        stock:=90;
        select nomproducto, preciounidad, unidadesenexistencia INTO v_nomproducto,v_preciounidad,v_stock from productos WHERE idproducto=v_idproducto;
        ESTADO:=CASE
        WHEN v_stock>stock THEN     'Stockeado'
        WHEN v_stock=stock THEN     'Limite'
        WHEN v_stock<stock THEN     'Haga una Solicitud'
        END;     
        dbms_output.put_line('Producto:'||v_nomproducto||' precio:'||v_preciounidad||' stock:'||v_stock||' estado:'||ESTADO);   
END;
--****************************************compilacion por separado
DECLARE
    v_idproducto NUMBER(10):=22 ;
    v_nomproducto productos.nomproducto%type  ;
    v_preciounidad productos.preciounidad%type ;
    v_stock productos.unidadesenexistencia%type ;
    ESTADO VARCHAR2(50);
    stock NUMBER(5);
BEGIN
    stock:=90;
    select nomproducto, preciounidad, unidadesenexistencia,
    CASE
        WHEN unidadesenexistencia>stock THEN     'Stockeado'
        WHEN unidadesenexistencia=stock THEN     'Limite'
        WHEN unidadesenexistencia<stock THEN     'Haga una Solicitud'
        END as ESTADO         
    INTO v_nomproducto,v_preciounidad,v_stock,ESTADO from productos WHERE idproducto=v_idproducto;
    BEGIN
        dbms_output.put_line('Producto:'||v_nomproducto||' precio:'||v_preciounidad||' stock:'||v_stock||' estado:'||ESTADO);   
    END;
END;
