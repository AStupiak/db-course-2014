/* 1 */
create table MASTER_TABLE (
	id number(10),
	idx number(1),
	title varchar(20),
	count number(5),
	description varchar(100),
	rate number(10),
	hint varchar(5),
	constraint MASTER_TABLE_PK primary key(id)
);

create table CHILD_TABLE_0 (
	id number(10),
	master_id number(10),
	title varchar(20),
	count number(5),
	description varchar(100),
	rate number(10),
	hint varchar(5),
	constraint CHILD_TABLE_PK primary key(id),
	constraint MASTER_TABLE_FK foreign key(master_id) references MASTER_TABLE(id)
);

create table CHILD_TABLE_1 as select * from CHILD_TABLE_0;
create table CHILD_TABLE_2 as select * from CHILD_TABLE_0;
create table CHILD_TABLE_3 as select * from CHILD_TABLE_0;
create table CHILD_TABLE_4 as select * from CHILD_TABLE_0;	

/* 2 */
insert all 
into CHILD_TABLE_0(id, title, count, description, rate) values(0, 'hal', 10, 'kill la kill', 10)
into CHILD_TABLE_0(id, title, count, description, rate) values(1, 'rubby', 42, 'NOtt', 2)
into CHILD_TABLE_0(id, title, count, description, rate) values(2, 'glados', 34, '34', 42)
into CHILD_TABLE_0(id, title, count, description, rate) values(3, 'eal', 22, 'oslo', 3)
into CHILD_TABLE_0(id, title, count, description, rate) values(4, 'eniac', 1, 'not so fast', 43)
into CHILD_TABLE_1(id, title, count, description, rate) values(0, 'lupan', 45, 'nice', 44)
into CHILD_TABLE_1(id, title, count, description, rate) values(1, 'misaka', 46, 'biribiri', 1467)
into CHILD_TABLE_1(id, title, count, description, rate, hint) values(2, 'ningen', 86, 'turre', 466, 'tree')
into CHILD_TABLE_1(id, title, count) values(3, 'kawamoto', 47)
into CHILD_TABLE_1(id, title, count) values(4, 'minamoto', 865)
into CHILD_TABLE_2(id, title, count) values(0, 'bakemonogatari', 10)
into CHILD_TABLE_2(id, title, count) values(1, 'nisimonogatari', 11)
into CHILD_TABLE_2(id, title, count) values(2, 'monogatari', 3544)
into CHILD_TABLE_2(id, title, count) values(3, 'otomonogatari', 422)
into CHILD_TABLE_2(id, title, count) values(4, 'katanagatari', 143)
into CHILD_TABLE_3(id, title, count) values(0, 'bakemonogatari', 356)
into CHILD_TABLE_3(id, title, count, description, rate) values(1, 'nisimonogatari', 437, 'fake', 435)
into CHILD_TABLE_3(id, title, count, description, rate) values(2, 'sawari', 3554, 'gray', 466)
into CHILD_TABLE_3(id, title, count, description, rate) values(3, 'shiro', 422, 'white', 467)
into CHILD_TABLE_3(id, title, count, description, rate) values(4, 'kuro', 143, 'black', 0)
into CHILD_TABLE_4(id, title, count) values(0, 'KGB', 10)
into CHILD_TABLE_4(id, title, count) values(1, 'nisimonogatari', 11)
into CHILD_TABLE_4(id, title, count) values(2, 'F1', 376)
into CHILD_TABLE_4(id, title, count, hint) values(3, 'M6', 422, 'olol')
into CHILD_TABLE_4(id, title, count) values(4, 'katanagatari', 143)	
select * from dual;

create sequence inc;

insert into MASTER_TABLE(id, idx, title, count, description, rate, hint)
	select
		inc.nextval as id,
		trunc(dbms_random.value(0, 9)) as idx,
		CHILD_TABLE_0.title,
		CHILD_TABLE_1.count,
		CHILD_TABLE_2.description,
		CHILD_TABLE_3.rate,
		CHILD_TABLE_4.hint
	from CHILD_TABLE_0, CHILD_TABLE_1, CHILD_TABLE_2, CHILD_TABLE_3, CHILD_TABLE_4;

select count(id) as COUNT from MASTER_TABLE;

create table MASTER_TABLE_log1 as 
	select 
		MASTER_TABLE.*,
		'operation varchar(10)' as operation 
	from MASTER_TABLE
	where 5 = 4;

create table MASTER_TABLE_log2 as select * from MASTER_TABLE_log1;	

create table STATUS (
	id number(2),
	title varchar(10)
);

insert all
	into STATUS(id, title) values(0, 'INSERTED')
	into STATUS(id, title) values(1, 'DELETED')
	into STATUS(id, title) values(2, 'UPDATED')
select * from dual;

insert all
	when mod(idx, 2) = 1 then
		into MASTER_TABLE_log1
	else
		into MASTER_TABLE_log2
select 
		MASTER_TABLE.*,
	 	(select title from (select title from STATUS order by dbms_random.value) where rownum = 1) as operation
from MASTER_TABLE;

select count(*) from MASTER_TABLE_log1 where operation = 'UPDATED';
select count(*) from MASTER_TABLE_log1 where operation = 'DELETED';
select count(*) from MASTER_TABLE_log1 where operation = 'INSERTED';

select count(*) from MASTER_TABLE_log2 where operation = 'UPDATED';
select count(*) from MASTER_TABLE_log2 where operation = 'DELETED';
select count(*) from MASTER_TABLE_log2 where operation = 'INSERTED';

/* 3 */
update MASTER_TABLE_log1 set idx = idx - 1 where operation = 'UPDATED' and idx > 2;

update MASTER_TABLE_log2 set operation = null where idx in (select idx from MASTER_TABLE_log1) and operation in (select operation from MASTER_TABLE_log1);