create table MASTER_TABLE (
	id number(10),
	idx number(1),
	name VARCHAR(20),
	age number(10),
	gender VARCHAR(10),
	about VARCHAR(20),
	constraint master_table_pk primary key(id)
);


create table DICTIONARY_TABLE_01 (
	id number(10),
	masterTableID number(10),
	name VARCHAR2(20),
	age number(10),
	gender VARCHAR2(10),
	about VARCHAR2(20),
	constraint dictionary_table_pk primary key(id),
	constraint master_table_fk foreign key(masterTableID) references MASTER_TABLE(id)
);

insert into DICTIONARY_TABLE_01(id, name, age, gender, about) VALUES (1, 'Alice', 20, 'female', 'listens');
insert into DICTIONARY_TABLE_01(id, name, age, gender, about) VALUES (2, 'Bob', 22, 'male', 'writes');
insert into DICTIONARY_TABLE_01(id, name, age, gender, about) VALUES (3, 'Charlie', 28, 'male', 'third participant');
insert into DICTIONARY_TABLE_01(id, name, age, gender, about) VALUES (4, 'Dave', 13, 'male', 'forth particiant');
insert into DICTIONARY_TABLE_01(id, name, age, gender, about) VALUES (5, 'Eve', 24, 'female', 'eavesdropper');
insert into DICTIONARY_TABLE_01(id, name, age, gender, about) VALUES (6, 'Frank', 25, 'male', 'sixth participant');


create sequence my_sequence_01;

create table DICTIONARY_TABLE_02 as select * from DICTIONARY_TABLE_01;
create table DICTIONARY_TABLE_03 as select * from DICTIONARY_TABLE_01;
create table DICTIONARY_TABLE_04 as select * from DICTIONARY_TABLE_01;



insert into MASTER_TABLE(id, idx, name, age, gender, about)
	select
		my_sequence_01.nextval as id,
		trunc(DBMS_RANDOM.VALUE(0,9)) as IDX,
		DICTIONARY_TABLE_01.name,
		DICTIONARY_TABLE_02.age,
		DICTIONARY_TABLE_03.gender,
		DICTIONARY_TABLE_04.about
	from DICTIONARY_TABLE_01, DICTIONARY_TABLE_02, DICTIONARY_TABLE_03, DICTIONARY_TABLE_04;

SELECT COUNT(*) "name" FROM MASTER_TABLE;

CREATE TABLE MASTER_TABLE_log1 as
	SELECT MASTER_TABLE.*,
		   'OPERATION VARCHAR2(30)' as OPERATION
    FROM MASTER_TABLE;

CREATE TABLE MASTER_TABLE_log2 AS SELECT * FROM MASTER_TABLE_log1;

CREATE TABLE OPERATION_TEST_TABLE(
	status VARCHAR2(10)
);


insert into OPERATION_TEST_TABLE(status) VALUES('INSERTED');
insert into OPERATION_TEST_TABLE(status) VALUES('DELETED');
insert into OPERATION_TEST_TABLE(status) VALUES('UPDATED');

insert all
	when mod(idx, 2) = 1 then into MASTER_TABLE_log1
	else into MASTER_TABLE_log2
select MASTER_TABLE.*,
	   (select status from(select status from OPERATION_TEST_TABLE order by DBMS_RANDOM.VALUE) WHERE rownum = 1) as OPERATION
FROM MASTER_TABLE;



select COUNT(*) FROM MASTER_TABLE_log1 WHERE OPERATION = 'UPDATED';
select COUNT(*) FROM MASTER_TABLE_log1 WHERE OPERATION = 'DELETED';
select COUNT(*) FROM MASTER_TABLE_log1 WHERE OPERATION = 'INSERTED';

select COUNT(*) FROM MASTER_TABLE_log2 WHERE OPERATION = 'UPDATED';
select COUNT(*) FROM MASTER_TABLE_log2 WHERE OPERATION = 'DELETED';
select COUNT(*) FROM MASTER_TABLE_log2 WHERE OPERATION = 'INSERTED';

UPDATE MASTER_TABLE_log1 set IDX = IDX - 1 WHERE OPERATION = 'UPDATED' and IDX > 2;
UPDATE MASTER_TABLE_log2 set OPERATION = NULL
		WHERE IDX in (select IDX from MASTER_TABLE_log1)
		and OPERATION in (select OPERATION from MASTER_TABLE_log1);
