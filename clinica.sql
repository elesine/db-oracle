CREATE SEQUENCE SEC_NUM_VISITA
INCREMENT BY 1
START WITH 1000
NOMAXVALUE
NOCYCLE;

CREATE SEQUENCE COD_DOCTOR
INCREMENT BY 1
START WITH 100
NOMAXVALUE
NOCYCLE;

CREATE SEQUENCE PACIENTE
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE;


 create table USUARIOS(
  nombre varchar2(30),
  clave varchar2(10)
 );
 
CREATE TABLE PACIENTES(
Codigo_paciente NUMBER(8) not null,
Nombre VARCHAR2(20) not null,
Apellidos VARCHAR2(30) not null,
Sexo CHAR(1),
FechaNacimiento DATE,
Edad NUMBER(3),
Dni NUMBER(8) not null,
Direccion VARCHAR2(30),
Poblacion VARCHAR2(20),
Provincia VARCHAR2(10),
Telefono VARCHAR2(20))
Tablespace CLINICA;

DROP TABLE PACIENTES;

CREATE TABLE MEDICO(
Codigo_doctor NUMBER(8) not null,
Nombre VARCHAR2(20) not null,
Apellidos VARCHAR2(30) not null,
FechaNacimiento DATE,
Dni NUMBER(8) not null,
Edad NUMBER(3),
Direccion VARCHAR2(30),
Poblacion VARCHAR2(20),
Provincia VARCHAR2(10),
Telefono VARCHAR2(20),
Especialidad VARCHAR2(10),
Departamento VARCHAR2(10))
Tablespace CLINICA;

DROP TABLE VISITAS;

CREATE TABLE VISITAS(
Numero_visita NUMBER(8) not null,
Codigo_pacientes NUMBER(8) not null,
FechaVisita DATE,
Motivodevisita VARCHAR2(30),
Codigo_doctor NUMBER(8) not null,
Departamento VARCHAR2(20),
Pruebas_realizadas  NUMBER(3),
Diagnostico VARCHAR2(20),
Tratamiento VARCHAR2(20))
Tablespace CLINICA;

ALTER TABLE PACIENTES ADD constraint pk_paciente PRIMARY KEY (Codigo_paciente);
ALTER TABLE VISITAS ADD constraint pk_visitas PRIMARY KEY (Numero_visita);
ALTER TABLE MEDICO ADD constraint pk_medicos PRIMARY KEY (Codigo_doctor);

ALTER TABLE VISITAS ADD FOREIGN KEY (Codigo_paciente) REFERENCES PACIENTES(Codigo_pacientes);
ALTER TABLE VISITAS ADD FOREIGN KEY (Codigo_doctor) REFERENCES MEDICO(Codigo_doctor);

ALTER TABLE PACIENTES MODIFY Sexo DEFAULT 'M';
ALTER TABLE PACIENTES ADD CONSTRAINT SEXO_MF CHECK (SEXO IN ('M','F'));

ALTER TABLE PACIENTES ADD CONSTRAINT DNI_LEN CHECK (LENGTH(Dni)=8);

ALTER TABLE PACIENTES ADD CONSTRAINT EDAD_14 CHECK (EDAD > 14);

CREATE INDEX SEXO_PAC ON PACIENTES(Sexo DESC);

CREATE INDEX P_TAB_PAC ON PACIENTES(Apellidos,Nombre);
CREATE INDEX P_TAB_MED ON MEDICO(Apellidos,Nombre);

CREATE PUBLIC SYNONYM p_TAB_med FOR MEDICOS;
