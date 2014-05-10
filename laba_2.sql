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

