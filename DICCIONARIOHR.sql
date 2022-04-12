--Elaborar las siguientes consultas con el usuario HR:
/*1. Liste el nombre de todas las tablas con su respectivo nombre de columna y tipo de
dato. Además ordenar dicho listado por el nombre de la tabla y el nombre de la columna
de forma ascendente. (Usar USER_TABLES y USER_TAB_COLUMNS).*/
select * from USER_TABLES;
select * from USER_TAB_COLUMNS;

select T.TABLE_NAME, C.COLUMN_NAME , C.DATA_TYPE from USER_TABLES T INNER JOIN USER_TAB_COLUMNS C ON T.TABLE_NAME=C.TABLE_NAME ORDER BY C.COLUMN_NAME,T.TABLE_NAME ASC;

/*2. Liste el nombre de la tabla, el nombre del índice y el nombre de la columna indexada de
las tablas “EMPLOYEES” y “DEPARTMENTS”. Además ordenar dicho listado por el nombre
de la tabla, el nombre del índice y el nombre de la columna indexada de forma
descendente. (Usar USER_TABLES, USER_INDEXES y USER_IND_COLUMNS).*/
SELECT * FROM USER_TABLES;
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_IND_COLUMNS;
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

SELECT T.TABLE_NAME,I.INDEX_NAME,C.INDEX_NAME FROM USER_TABLES T INNER JOIN USER_INDEXES I  ON T.TABLE_NAME=I.TABLE_NAME INNER JOIN USER_IND_COLUMNS C ON C.TABLE_NAME= T.TABLE_NAME WHERE  T.TABLE_NAME='DEPARTMENTS' OR T.TABLE_NAME='EMPLOYEES'  ORDER BY  T.TABLE_NAME,I.INDEX_NAME,C.INDEX_NAME ASC;

/*3. Liste la cantidad de objetos por cada tipo de objeto. Además deberá filtrar la cantidad
de objetos que sea IMPAR. Y por ultimo ordenar dicho listado por la cantidad de objetos
de forma descendente. (Usar USER_OBJECTS).*/
SELECT * FROM USER_OBJECTS ;

SELECT  O.OBJECT_TYPE, COUNT(*) FROM USER_OBJECTS O GROUP BY O.OBJECT_TYPE HAVING MOD(COUNT(*), 2)=1 ORDER BY COUNT(*) ASC;
/*4. Liste la cantidad de restricciones por cada nombre de tabla. Además deberá filtrar la
cantidad de restricciones que se PAR. Y por ultimo ordenar dicho listado por la cantidad de
restricciones de forma ascendentes. (Usar USER_TABLES y USER_CONSTRAINTS).*/
select * from USER_TABLES;
SELECT * FROM USER_CONSTRAINTS;
--select*  from USER_TABLES T INNER JOIN  USER_CONSTRAINTS C ON T.TABLE_NAME=C.TABLE_NAME ORDER BY  t.table_name ASC;
select T.TABLE_NAME, COUNT(*)  from USER_TABLES T INNER JOIN  USER_CONSTRAINTS C ON T.TABLE_NAME=C.TABLE_NAME 
GROUP BY T.TABLE_NAME HAVING MOD(COUNT(*), 2)=0
ORDER BY  t.table_name ASC;


/*5. Muestre el código fuente del procedimiento almacenado “ADD_JOB_HISTORY”. (Usar
USER_SOURCE).*/
SELECT * FROM USER_SOURCE;

SELECT u.text FROM USER_SOURCE U where U.NAME='ADD_JOB_HISTORY' ;
