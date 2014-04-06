CREATE TABLESPACE labs
   DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\labs.dat'
   SIZE 40M AUTOEXTEND ON;

SELECT tablespace_name, file_name, status, bytes
  FROM dba_data_files
  WHERE tablespace_name LIKE 'LABS'
  ORDER BY tablespace_name, file_name;


/*2*/
CREATE USER valerius
    IDENTIFIED BY admin
    DEFAULT TABLESPACE LABS
    QUOTA 30M ON LABS;

GRANT CREATE SESSION TO valerius;

GRANT CREATE TABLE TO valerius;

GRANT CREATE SEQUENCE TO valerius;

GRANT CREATE CLUSTER TO valerius;


/*3*/
CREATE TABLE test
	( 	id NUMBER PRIMARY KEY
	,	name VARCHAR2(40)
	,	date1 DATE
	);

COMMENT ON COLUMN test.id
   IS 'primary id';
COMMENT ON COLUMN test.name
   IS 'name max 40 characters';
COMMENT ON COLUMN test.date1
   IS 'date';

CREATE INDEX test_idx1 ON test(name);
CREATE INDEX test_idx2 ON test(id,date1);

ALTER TABLE test
  ADD CONSTRAINT date_check
    CHECK(
    		date1 >= date '1930-01-01'
         );

CREATE TABLE test_ref
	(	id_ref NUMBER PRIMARY KEY
	, name VARCHAR2(40)
	);

ALTER TABLE test_ref 
ADD CONSTRAINT fk_ref 
FOREGIN KEY (id_ref) 
REFERENCE test(id);


CREATE GLOBAL TEMPORARY TABLE valerius.temp_table
	( id NUMBER
	, startdate DATE
	, class CHAR(20)
	)
	ON COMMIT DELETE ROWS;

CREATE CLUSTER employee (id NUMBER(5))
TABLESPACE labs
size 800;

CREATE TABLE managers
	( id NUMBER(5) PRIMARY KEY
	, name VARCHAR2(50)
	)
CLUSTER employee(id);


/*4*/
INSERT INTO test (id, name, date1)
VALUES(1, 'roman', TO_DATE('1995-01-01', 'YYYY-MM-DD'));

INSERT INTO test
VALUES(2, NULL, TO_DATE('15/03/1989', 'DD/MM/YYYY'));

INSERT INTO test
VALUES(3, 'pavel', TO_DATE('1995-02-14', 'YYYY-MM-DD'));

ALTER TABLE test
MODIFY (name DEFAULT 'user');

INSERT INTO test (id, date1)
VALUES(4, TO_DATE('1995-02-14', 'YYYY-MM-DD'));

ALTER TABLE test ADD lastname VARCHAR2(50);

ALTER TABLE test ADD position VARCHAR2(20) DEFAULT 'programer';

ALTER TABLE test MODIFY (name DEFAULT 'josh')

ALTER TABLE test DISABLE CONSTRAINT date_check;

ALTER TABLE test DROP COLUMN date1;

ALTER TABLE test RENAME COLUMN lastname to last_name;

ALTER TABLE test MODIFY (name DEFAULT NULL);

select 'alter table '||table_name||' disable constraint '||constraint_name||';' from user_constraints;

INSERT INTO test
VALUES(5, 'ilia', 'grant', 'administrator');

RENAME test TO test_bak;

CREATE TABLE test
	( 	id NUMBER PRIMARY KEY
	,	name VARCHAR2(40)
	,	date1 DATE
	);