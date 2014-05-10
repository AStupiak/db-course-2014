create table MASTER_TABLE (
	id number(10),
	idx number(1),
	name VARCHAR2(20),
	age number(10),
	sex VARCHAR2(10),
	about VARCHAR2(20),
	constraint master_table_pk primary key(id)
);

create table DICTIONARY_TABLE_1 (
	id number(10),
	master_table_id number(10),
	name VARCHAR2(20),
	age number(10),
	sex VARCHAR2(10),
	about VARCHAR2(20),
	constraint dictionary_table_pk primary key(id),
	constraint master_table_fk foreign key(master_table_id) references MASTER_TABLE(id)
);

insert into DICTIONARY_TABLE_1(id, name, age, sex, about) VALUES(1, 'Anton', 20, 'male', 'designer');
insert into DICTIONARY_TABLE_1(id, name, age, sex, about) VALUES(2, 'Bob', 19, 'male', 'front-end dev.');
insert into DICTIONARY_TABLE_1(id, name, age, sex, about) VALUES(3, 'Alex', 21, 'male', 'front-end dev.');
insert into DICTIONARY_TABLE_1(id, name, age, sex, about) VALUES(4, 'Nastya', 18, 'female', 'beautiful girl');
insert into DICTIONARY_TABLE_1(id, name, age, sex, about) VALUES(5, 'Alice', 24, 'female', 'manager');



create sequence my_sequence;

create table DICTIONARY_TABLE_2 as select * from DICTIONARY_TABLE_1;
	create table DICTIONARY_TABLE_3 as select * from DICTIONARY_TABLE_1;
		create table DICTIONARY_TABLE_4 as select * from DICTIONARY_TABLE_1;

insert into MASTER_TABLE(id, idx, name, age, sex, about)
	select
		my_sequence.nextval as id,
		trunc(DBMS_RANDOM.VALUE(0,9)) as IDX,
		DICTIONARY_TABLE_1.name,
		DICTIONARY_TABLE_2.age,
		DICTIONARY_TABLE_3.sex,
		DICTIONARY_TABLE_4.about
	from DICTIONARY_TABLE_1, DICTIONARY_TABLE_2, DICTIONARY_TABLE_3, DICTIONARY_TABLE_4;

SELECT COUNT(*) "name" FROM MASTER_TABLE;

CREATE TABLE MASTER_TABLE_log1 as
	SELECT MASTER_TABLE.*,
		   'OPERATION VARCHAR2(30)' as OPERATION
    FROM MASTER_TABLE
/

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