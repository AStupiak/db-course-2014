/* 1 */
create tablespace TEST_TABLE_SPACE
	datafile 'test_table_space'
	size 20M autoextend on;

/* 2 */
create user HALL
	identified by password
	default tablespace TEST_TABLE_SPACE
	quota 10M on TEST_TABLE_SPACE
	password expire;

grant create session to HALL;
grant create table to HALL;
grant create sequence to HALL;
grant create any index to HALL;
grant drop  any table to HALL;
grant alter any table to HALL;
grant create cluster to HALL;

/* 3 */
create table TEST_TABLE (
	id number(10),
	name varchar(100),
	time date default sysdate
);

comment on table TEST_TABLE is 'My comment';
comment on column TEST_TABLE.name is 'Another comment';

create index TEST_TABLE_NAME_INDEX on TEST_TABLE(name);

alter table TEST_TABLE add constraint name_check check(name like 'A%');
/* test */
insert into TEST_TABLE(id, name) values(1, 'qwert)';
insert into TEST_TABLE(id, name) values(1, 'Aqwert)';

delete from TEST_TABLE; /* clear table*/
alter table TEST_TABLE add constraint id_unique UNIQUE(id);
/* test */
insert into TEST_TABLE(id, name) values(1, "Abc");
insert into TEST_TABLE(id, name) values(1, "Abfsdfc");
insert into TEST_TABLE(id, name) values(1, "bc");
insert into TEST_TABLE(id, name) values(2, "Abc");

create table SAMPLE_TABLE_0 (
	id number(10) primary key,
	name varchar(100),
	time date
);

create table SAMPLE_TABLE_1 (
	id number(10),
	name varchar(100),
	r_id number(10)
);

alter table SAMPLE_TABLE_1 add constraint foreign_key_id foreign key(r_id) references TEST_TABLE;

create global temporary table TEST_TEMPORARY_TABLE (
	id number(10)
);

create cluster TEST_CLUSTER (id number(10))
	size 123
	storage (initial 100k next 50k);

create table TABLE_WITH_CLUSTER (
	id number(10),
	title varchar(100)
) cluster TEST_CLUSTER(id);

/* 4 */
create table T_TBL (
	id number(10);
	title varchar(100)
);
alter table T_TBL add constraint title_check check(title like 'A%');

insert into T_TBL(id, title) values(1, 'Abc');
	insert into T_TBL(id, title) values(2, 'Abcd');
		insert into T_TBL(id, title) values(3, 'Abcde');
			insert into T_TBL(id, title) values(4, 'Abcdef');
				insert into T_TBL(id, title) values(5, 'Abcdefg')
					insert into T_TBL(id, title) values(null, 'Abcdefgh')

alter table T_TBL add new_column number(5);
alter table T_TBL add new_column_with_default number(5) default 42;
alter table T_TBL modify title char(100) default 'AAA';
alter table T_TBL rename column new_column to count;
alter table T_TBL drop column new_column_with_default;
alter table T_TBL modify title default null;
alter table T_TBL disable constraint title_check;

rename T_TBL to T_TBL_renamed;

create table T_TBL as (select * from T_TBL_renamed);
