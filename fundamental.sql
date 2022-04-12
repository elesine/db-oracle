-- **** SYS ****

-- Cree el espacio de tablas DATOS01
CREATE TABLESPACE DATOS01 DATAFILE 'C:\app\Leydibea\oradata\df_data01.dbf' SIZE 100M EXTENT 
MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
--Borra tablespace
DROP TABLESPACE DATOS01 INCLUDING CONTENTS AND DATAFILES;
--
SELECT tablespace_name FROM dba_tablespaces;
/*únicamente estamos obteniendo el nombre de los tablespaces, pero podemos obtener más --información de ellos usando el operador *, por ejemplo:
*/
select * from USER_TABLESPACES;

-- Crear el usuario o esquema Desarrollo, especificando qué tablespace va a utilizar y cuánta información podrá almacenar. 

CREATE USER US_DESARROLLO
IDENTIFIED BY DESARROLLO --contrasena
DEFAULT TABLESPACE DATOS01
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON DATOS01;

--Recien hacer nueva coneccion(+)
--Nombre conexion CN_DATOS01, usuario US_DESARROLLO, contraseña DESARROLLO 

/* Otorgue los privilegios necesarios para que el usuario Desarrollo pueda conectarse y pueda crear tablas en su esquema o en otros.*/

GRANT CONNECT TO US_DESARROLLO;
GRANT CREATE ANY TABLE TO US_DESARROLLO;
--

--------------------SECUENCIAS SYSTEM

GRANT CREATE SEQUENCE TO DESARROLLO;
GRANT CREATE ANY SEQUENCE TO US_DESARROLLO;  --(otro esquema)
GRANT DROP ANY SEQUENCE TO Scott;  --(elimina)

-------------------- SINONIMOS SYSTEM 

GRANT CREATE SYNONYM TO Scott; 		-- (privado en su esquema)
GRANT CREATE PUBLIC SYNONYM TO Scott;	-- (public, tener privilegio de Sistema)
GRANT DROP ANY SYNONYM TO Scott; 		--(privado en su esquema)
GRANT DROP PUBLIC SYNONYM TO Scott;	-- (public, tener privilegio de Sistema)

----------------------Manejo de INDICES basados en funciones
-- Otorgando Privilegios con SYSTEM
GRANT query rewrite TO Scott;
GRANT global query rewrite TO Scott; -- para crear en dif tablespac
GRANT DROP ANY INDEX TO Scott;  -- para eliminar


-- ****Conéctese con el USUARIO Desarrollo.****

-- Cree las tablas Emp para el esquema Desarrollo.
CREATE TABLE Emp (
Empno NUMBER(4) not null,
Ename VARCHAR2(20) not null,
Job VARCHAR2(15),
juu CHAR(20),
Mgr NUMBER(4),
Hiredate DATE default sysdate not Null,
Sal NUMBER(7,2),
Comm NUMBER(7,2),
Deptno NUMBER(2) not null)
Tablespace DATOS01;

-- Consultar la información de las tablas 
select * from USER_TABLES
-- Comentando Tablas y Columnas
COMMENT ON TABLE Emp IS ‘Tabla de Empleados’;
--los siguientes comandos comentan algunas columnas de la tabla EMP:
COMMENT ON COLUMN Emp.Hiredate IS ‘Fecha de Ingreso’;
--Para borrar un comentario hay que ponerle la cadena vacia ''.
SQL> COMMENT ON TABLE Emp IS '';
SQL> COMMENT ON COLUMN Emp.Empno IS '';

--*Alterando Tablas*
--A.  Adicionando Columnas
SQL> ALTER TABLE Emp ADD Bonus NUMBER(12,2) CHECK (Bonus>=0);
--El siguiente ejemplo adiciona más de una columna:
SQL> ALTER TABLE Emp ADD (Dirección Date, Telefono Char(9));
--B. Modificando Columnas
/*Por ejemplo, el siguiente comando disminuye la longitud de la columna Bonus de la tabla EMP: */
SQL> ALTER TABLE Emp MODIFY Bonus NUMBER(9,2);
--C. Renombrando Columnas
--Por ejemplo, el siguiente comando renombra la columna Bonus de la tabla EMP:
SQL> ALTER TABLE Emp RENAME COLUMN Bonus TO Bono_Emp;
--El comando puede ser cancelado si la columna tiene objetos dependientes.
--D. Eliminando Columnas
--Por ejemplo, el siguiente comando elimina la columna Teléfono de la tabla EMP:
SQL> ALTER TABLE Emp DROP COLUMN Telefono;
--Eliminando Tablas
SQL> DROP TABLE Emp;
/*Por ejemplo, el siguiente comando elimina la tabla EMP del esquema SCOTT junto
con la llave primaria y las foráneas que hacen referencia (constraints).*/
/*un esquema de base de datos indica cómo las entidades que conforman la base de datos se relacionan entre sí, incluidas las tablas, las vistas, los procedimientos almacenados y mucho más.*/
SQL> DROP TABLE scott.Emp CASCADE CONSTRAINTS;

--Creación de RESTRICCIONES
/*Los constraints de integridad son reglas que restringen los valores de uno o más columnas en una tabla. La cláusula CONSTRAINTS puede utilizarse en los comandos CREATE TABLE o ALTER TABLE.*/
--Creando LLAVES PRIMARIAS a través del comando CREATE TABLE:

-- Ejemplo 1:Compuesta de una columna y sin indicar el nombre explícitamente.
SQL> CREATE TABLE Ord (
Ordid NUMBER(4) primary key,
Orderdate DATE,
Commplan CHAR(1),
Custid NUMBER(6) not null,
Shipdate DATE,
Total NUMBER(8,2))
Tablespace DATOS01;
-- Ejemplo 2: Compuesta de una columna e indicando el nombre explícitamente.
SQL> CREATE TABLE Ord (
Ordid NUMBER(4) constraints pk_ord primary key,
Orderdate DATE,
Commplan CHAR(1),
Custid NUMBER(6) not null,
Shipdate DATE,
Total NUMBER(8,2))
Tablespace DATOS01;

-- Creando LLAVES PRIMARIAS a través del comando ALTER TABLE:

-- Ejemplo 1: Compuesta de una columna sin nombre explícito.
SQL> ALTER TABLE ORD ADD PRIMARY KEY (ordid);
-- Ejemplo 2: Compuesta de una columna con nombre explícito.
SQL> ALTER TABLE ORD ADD constraint pk_ord PRIMARY KEY (ordid);
-- Ejemplo 3: Compuesta por más de una columna con nombre explícito.
SQL> ALTER TABLE ITEM ADD constraint pk_item PRIMARY KEY (ordid, itemid);

--  Creando LLAVES FORANEAS
/*Puede crear llaves foráneas haciendo referencia a las tablas de su esquema. Para poder referenciar tablas de otros esquemas de usuarios, 
debe contar con el privilegio REFERENCES sobre la tabla a referenciar. */

-- Crean una llave foránea a través del comando CREATE TABLE:
-- Ejemplo 1: Sin nombre explícito.
SQL> CREATE TABLE Item (
Ordid NUMBER(4) REFERENCES Ord,
Itemid NUMBER(4) not null,
Prodid NUMBER(6),
Actualprice NUMBER(8,2),
Cantidad NUMBER(8),
Itemtot NUMBER(8,2),
CONSTRAINTS pk_item primary key (ordid, itemid))
Tablespace DATOS01;

-- Ejemplo 2: Con nombre explícito.
SQL> CREATE TABLE Item (
Ordid NUMBER(4),
Itemid NUMBER(4) not null,
Prodid NUMBER(6),
Actualprice NUMBER(8,2),
Cantidad NUMBER(8),
Itemtot NUMBER(8,2),
CONSTRAINTS pk_item primary key (ordid, itemid),
CONSTRAINTS fk_item foreign key (ordid) references ord(ordid))
Tablespace DATOS01;

-- Crean una llave foránea a través del comando ALTER TABLE:
-- Ejemplo 1: Sin nombre explicito.
SQL> ALTER TABLE ITEM ADD FOREIGN KEY (ordid) REFERENCES Ord(ordid);
-- Ejemplo 2: Con nombre explícito.
SQL> ALTER TABLE ITEM 
ADD CONSTRAINTS fk_item 
FOREIGN KEY (ordid) REFERENCES Ord(ordid);


--  ***  Creando Check  ***

-- Crean una restricción CHECK a través del comando CREATE TABLE:
SQL> CREATE TABLE Item (
Ordid NUMBER(4),
Itemid NUMBER(4) not null,
Prodid NUMBER(6),
Actualprice NUMBER(8,2) CONSTRAINTS ck_item_01
CHECK (actualprice >= 0),
Cantidad NUMBER(8) CONSTRAINTS ck_item_02
CHECK (cantidad >= 0),
Itemtot NUMBER(8,2) CONSTRAINTS ck_item_02
CHECK (itemtot >= 0),
CONSTRAINTS pk_item primary key (ordid, itemid),
CONSTRAINTS fk_item foreign key (ordid) references ord(ordid))
Tablespace DATOS01;

-- Crean una restricción CHECK a través del comando ALTER TABLE:
-- Ejemplo 1:
SQL> ALTER TABLE ITEM
ADD CONSTRAINTS ck_item_01 CHECK (actualprice >=0);
-- Ejemplo 2:
SQL> ALTER TABLE ITEM
ADD (CONSTRAINTS ck_item_02 CHECK (cantidad >=0),
CONSTRAINTS ck_item_03 CHECK (itemtot >=0));


--  *** Estableciendo VALORES POR DEFECTO
-- Crean esta restricción a través del comando CREATE TABLE:
-- Ejemplo 1:
SQL> CREATE TABLE Errores (
Id_error NUMBER(4),
Descrip VARCHAR2(50),
Usuario CHAR(10) DEFAULT user,
Fecha DATE DEFAULT sysdate,
Hora CHAR(8) DEFAULT to_char(sysdate,hh24:mi:ss),
Estacion VARCHAR2(20) DEFAULT USERENV(‘terminal’))
Tablespace DATOS01;

-- Crean esta restricción a través del comando ALTER TABLE:
-- Ejemplo 1:
SQL> ALTER TABLE errores MODIFY (Usuario DEFAULT user);
-- Ejemplo 2:
SQL> ALTER TABLE errores MODIFY (Fecha DEFAULT sysdate,
Hora DEFAULT to_char(sysdate,hh24:mi:ss),
estacion DEFAULT USERENV(‘terminal’));

-- Habilitando y Deshabilitando Constraints
/*Usted puede habilitar o deshabilitar cualquier constraint de su esquema. Para modificar un constraint 
de otro esquema de usuario debe tener el privilegio ALTER sobre el objeto tabla. */

-- Comando para deshabilitar la llave primaria de la tabla ORD:
-- Ejemplo 1:
SQL> ALTER TABLE Scott.Ord DISABLE PRIMARY KEY;
-- Ejemplo 2:
SQL> ALTER TABLE Scott.Ord ENABLE CONSTRAINTS pk_ord;

--Comando deshabilita la llave foránea de la tabla ITEM:
-- Ejemplo 1:
SQL> ALTER TABLE Desarrollo.Item DISABLE FOREIGN KEY;
-- Ejemplo 2:
SQL> ALTER TABLE Desarrollo.Item DISABLE CONSTRAINTS fk_item;

-- Eliminando Constraints
DROP PRIMARY KEY
DROP UNIQUE
DROP CONSTRAINT

-- Por ejemplo, los siguientes dos comandos eliminan un constraint de integridad:
-- Ejemplo 1:
SQL> ALTER TABLE Dept DROP PRIMARY KEY;
-- Ejemplo 2:
SQL> ALTER TABLE Item DROP CONSTRAINTS fk_item;


--______***INDICES SECUENCIAS Y SINONIMOS ****
/*Un índice es una estructura diseñada para obtener un acceso más rápido a los datos contenidos dentro de una tabla.*/

--------------------------------- SECUENCIAS USUARIOS***********************
--Ejemplo1, generar números para la columna empno de la tabla Emp

CREATE SEQUENCE seq_empleado
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE;

select * from user_sequences

-- Uso de la secuencia creada mediante:
--NEXTVAL: genera un nuevo número diferente a los anteriormente generados
SELECT seq_empleado.NEXTVAL FROM DUAL;
--CURRVAL: devuelve el último número generado
SELECT seq_empleado.CURRVAL FROM DUAL;

-- modifica una secuencia:
ALTER SEQUENCE seq_empleado
INCREMENT BY 10
MAXVALUE 10000
CYCLE;

SELECT seq_empleado.NEXTVAL FROM DUAL;


--Eliminando Secuencias
DROP SEQUENCE seq_empleado;

------------------------------SINONIMOS***********************
-- crear Sinónimos con SCOTT
-- Ejemplo 1: Sinónimo privado
CREATE SYNONYM priv_dept FOR Scott.Dept;
-- Ejemplo 2: Sinónimo público
CREATE PUBLIC SYNONYM public_emp FOR Scott.Emp;

-- Eliminando Sinónimos
-- Ejemplo 1: Sinónimo privado
DROP SYNONYM priv_dept;
-- Ejemplo 2: Sinónimo público
DROP PUBLIC SYNONYM public_emp;
--ejemplo
CREATE PUBLIC SYNONYM public_emp FOR EMP;
select * from public_emp;


-------------------------INDICEEES*******************************
/*Un índice es una estructura diseñada para obtener un acceso más rápido a los datos contenidos dentro de una tabla*/


-- Ejemplo 1, considere la expresión en la cláusula WHERE de abajo:
CREATE INDEX idx ON SCOTT.EMP (comm + sal);
SELECT * FROM EMP WHERE (comm + sal) < 5000;

select* from user_indexes
--Ejemplo, considere la función en la cláusula WHERE de abajo:
CREATE INDEX idx_emp_name ON SCOTT.emp (Upper(ename));
SELECT * FROM emp WHERE Upper(ename) = 'JONES';  -- indistingue MAYUSCULA y minuscula

-- Eliminando índices
DROP INDEX idx_emp_name;

/*Otra consideración importante a tomar en cuenta es que los índices deben residir en un tablespace diferente de donde residen las tablas.
Por ejemplo, los siguientes dos comandos crean un índice:*/
--Ejemplo 1:
SQL> CREATE INDEX emp_ename ON Emp(ename) TABLESPACE indx;
/*Los Índices también pueden ser únicos o no únicos. Un índice único garantiza que dos filas de una tabla no tengan valores duplicados en la columna o columnas que conforman el índice.
Ejemplo 2:*/
SQL> CREATE UNIQUE INDEX dept_unique_index ON Dept(dname) TABLESPACE indx;


CREATE INDEX sales_dt_pr
    ON sales (sale_date ASC, product_id DESC)


