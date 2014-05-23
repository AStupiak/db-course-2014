create table MASTER_TABLE (
	id number,
	idx number(1),
	name varchar2(50),
	age number(3),
	gender varchar2(7),
	about varchar2(50),
	constraint MASTER_TABLE_PK primary key(id)
);

create table CHILD_TABLE_0 (
	id number,
	master_id number(10),
	name varchar2(50),
	age number(3),
	gender varchar2(7),
	about varchar2(50),
	constraint CHILD_TABLE_PK primary key(id),
	constraint MASTER_TABLE_FK foreign key(master_id) references MASTER_TABLE(id)
);

create table CHILD_TABLE_1 as select * from CHILD_TABLE_0;
create table CHILD_TABLE_2 as select * from CHILD_TABLE_0;
create table CHILD_TABLE_3 as select * from CHILD_TABLE_0;
create table CHILD_TABLE_4 as select * from CHILD_TABLE_0;


insert all 
into CHILD_TABLE_0(id, name, age, gender, about) values(0, 'Oleg', 15, 'male', 'adfl')
into CHILD_TABLE_0(id, name, age, gender, about) values(1, 'Alexandra', 23, 'female', 'adf')
into CHILD_TABLE_0(id, name, age, gender, about) values(2, 'Alexey', 23, 'male', 'arg')
into CHILD_TABLE_0(id, name, age, gender, about) values(3, 'John', 45, 'male', 'thn')
into CHILD_TABLE_0(id, name, age, gender, about) values(4, 'Pavel', 25, 'male', 'argt')
into CHILD_TABLE_1(id, name, age, gender, about) values(0, 'Andrey', 43, 'male', 'qf')
into CHILD_TABLE_1(id, name, age, gender, about) values(1, 'Victoria', 34, 'female', 'cex')
into CHILD_TABLE_1(id, name, age, gender, about) values(2, 'Maria', 25, 'female', 'ukbg')
into CHILD_TABLE_1(id, name, age, gender, about) values(3, 'Sasha', 29, 'female', 'tun')
into CHILD_TABLE_1(id, name, age, gender, about) values(4, 'Dima', 16, 'male', 'cxv')
into CHILD_TABLE_2(id, name, age, gender, about) values(0, 'Piotr', 19, 'male', 'yko,')
into CHILD_TABLE_2(id, name, age, gender, about) values(1, 'Vasia', 27, 'male', 'cbgj')
into CHILD_TABLE_2(id, name, age, gender, about) values(2, 'Katia', 35, 'female', 'ukm')
into CHILD_TABLE_2(id, name, age, gender, about) values(3, 'Olia', 24, 'female', 'arhbb')
into CHILD_TABLE_2(id, name, age, gender, about) values(4, 'Oleg', 42, 'male', 'opmkj')
into CHILD_TABLE_3(id, name, age, gender, about) values(0, 'Marina', 44, 'female', 'adfbb')
into CHILD_TABLE_3(id, name, age, gender, about) values(1, 'Vincent', 52, 'male', 'h5t')
into CHILD_TABLE_3(id, name, age, gender, about) values(2, 'Jenia', 21, 'male', 'rvv')
into CHILD_TABLE_3(id, name, age, gender, about) values(3, 'Maxim', 24, 'male', 'atrt')
into CHILD_TABLE_3(id, name, age, gender, about) values(4, 'Roma', 66, 'male', 'adfa')
into CHILD_TABLE_4(id, name, age, gender, about) values(0, 'Anton', 14, 'male', 'egr')
into CHILD_TABLE_4(id, name, age, gender, about) values(1, 'Samson', 40, 'male', 'aetg')
into CHILD_TABLE_4(id, name, age, gender, about) values(2, 'Vladimir', 20, 'male', 'adet')
into CHILD_TABLE_4(id, name, age, gender, about) values(3, 'Svitoslav', 28, 'male', 'ewr')
into CHILD_TABLE_4(id, name, age, gender, about) values(4, 'Gragina', 20, 'female', 'att')
select * from dual;

create sequence inc;

insert into MASTER_TABLE(id, idx, name, age, gender, about)
	select
		inc.nextval as id,
		trunc(dbms_random.value(0, 9)) as idx,
		CHILD_TABLE_0.name,
		CHILD_TABLE_1.age,
		CHILD_TABLE_2.gender,
		CHILD_TABLE_3.about
	from CHILD_TABLE_0, CHILD_TABLE_1, CHILD_TABLE_2, CHILD_TABLE_3;

select count(id) as count from MASTER_TABLE;

create table master_table_log1
	as select
	MASTER_TABLE.*,
	'operation varchar2(8)' as operation
	from MASTER_TABLE
	WHERE 1=2;

create table master_table_log2 as select * from master_table_log1;

create table status
(
	operation varchar2(8)
);

insert into STATUS(operation) values('INSERTED');
insert into STATUS(operation) values('DELETED');
insert into STATUS(operation) values('UPDATED');


insert all
	when mod(idx, 2) = 1 then
		into master_table_log1
	else
		into master_table_log2
select 
		MASTER_TABLE.*,
	 	(select operation from (select operation from STATUS order by dbms_random.value) where rownum = 1)
from MASTER_TABLE;
???

select count(*) from MASTER_TABLE_log1 where operation = 'UPDATED';
select count(*) from MASTER_TABLE_log1 where operation = 'DELETED';
select count(*) from MASTER_TABLE_log1 where operation = 'INSERTED';

select count(*) from MASTER_TABLE_log2 where operation = 'UPDATED';
select count(*) from MASTER_TABLE_log2 where operation = 'DELETED';
select count(*) from MASTER_TABLE_log2 where operation = 'INSERTED';


update MASTER_TABLE_log1 set idx = idx - 1 where operation = 'UPDATED' and idx > 2;
update MASTER_TABLE_log2 set operation = null where idx in (select idx from MASTER_TABLE_log1) and operation in (select operation from MASTER_TABLE_log1);