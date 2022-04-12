/*1. Liste el nombre del usuario, el estado de cuenta y el privilegio del sistema que tiene
asignado los usuarios “HR” y “SCOTT”. Además ordenar dicho listado por el nombre del
usuario y el privilegio del sistema de forma ascendente. (Usar DBA_USERS y
DBA_SYS_PRIVS).*/
select * from DBA_USERS;
select * from DBA_SYS_PRIVS;

select u.USERNAME,u.ACCOUNT_STATUS,p.PRIVILEGE  from DBA_USERS u inner join DBA_SYS_PRIVS p on p.GRANTEE=u.USERNAME where u.USERNAME='HR' ORDER BY p.PRIVILEGE, u.USERNAME ;

/*2. Liste el nombre del usuario, el estado de cuenta y la cantidad de roles que tiene
asignado los usuarios “SYS”, “SYSTEM”, “HR” y “SCOTT”. Además ordenar dicho listado por
la cantidad de roles de forma descendente. (Usar DBA_USERS y DBA_ROLE_PRIVS).*/
select * from DBA_USERS;
select * from DBA_ROLE_PRIVS;

select usr.USERNAME, usr.ACCOUNT_STATUS, rolprv.granted_role from DBA_USERS usr
inner join DBA_ROLE_PRIVS rolprv on usr.username = rolprv.grantee
where usr.username = 'HR' OR  usr.username = 'SYS' OR usr.username = 'SYSTEM' order by 3 desc;

/*3. Liste el nombre del usuario, el tipo de objeto y la cantidad de objetos de todos los
usuarios. Además deberá filtrar la cantidad de objetos que sea PAR. Y por ultimo ordenar
dicho listado por el nombre del usuario, el tipo de objeto y la cantidad de objetos de
forma ascendente. (Usar DBA_USERS y DBA_OBJECTS).*/



/*4. Liste el nombre de la vista y la columna de la vista de todo el diccionario de datos.
Además deberá filtrar el nombre de la vista que termine con “TABLES” y que la longitud de
columna de la vista sea IMPAR. Y por ultimo ordenar dicho listado por el nombre de la
vista y la columna de la vista de forma descendente. (Usar DICTIONARY y
DICT_COLUMNS).*/


/*5. Muestre el valor en que se encuentra la auditoria “audit_trail”. (Usar V$PARAMETER).*/