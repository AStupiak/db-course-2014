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

alter table TEST_TABLE add constraint name_check CHECK(name like 'A%');
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

create cluster TEST_CLUSTER (id number(10))
	size 123
	storage (initial 100k next 50k);

create table TABLE_WITH_CLUSTER (
	id number(10),
	title varchar(100)
) cluster TEST_CLUSTER(id);