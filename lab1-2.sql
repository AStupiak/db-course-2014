/*Create an autoextended tablespace with one data file*/
create tablespace TEST_TABLESPACE datafile 'test_tablespace' size 10M autoextend on;

/*Create user that uses tablespace created on step 1*/
create user TEST_USER identified by TEST_PASSWORD default tablespace TEST_TABLESPACE QUOTA 10M ON TEST_TABLESPACE password expire;

/*Grand him an ability to open session and operate with objects in his schema*/
grant create session to TEST_USER;
grant create table to TEST_USER;
grant create sequence to TEST_USER;
grant create any index to TEST_USER;
grant drop  any table to TEST_USER;
grant alter any table to TEST_USER;

/*Create table. Table should contain numeric, string, datetime columns*/
create table TEST_TABLE( primary_key number(10), name varchar(45), time date default sysdate);

/*create script that adds comments to table and each column*/
comment on table test_table is 'this is test table';
comment on column TEST_TABLE.time is 'this is date';

/*create index over one column, several columns*/
create index primary_key_index on test_table(primary_key);

/*create script what adds constraints, both reference and check constraints*/
alter table test_table 
	add constraint primary_unique unique (primary_key);
	
/*create temporary table*/
create global temporary table temp_table( id number(10));

/*create cluster based table*/
create cluster test_cluster
	(cluster_id number(10))
	size 512;

/*insert 5 new records into table (should include nulls for some rows)*/
insert into TEST_TABLE
	values(1, 'first', default);

/*add new column*/
alter table TEST_TABLE
	add name2 varchar(45);

/*modify existing column setting default value for it*/
alter table TEST_TABLE
	modify name varchar(10)
	modify name2 varchar(10);

/*remove existing column*/
alter table test_table
	drop column name2;

/*rename the column*/
alter table TEST_TABLE
	rename column name to renamed;
	
/*disable single constraint on the table*/
alter table test_table
	disable constraint primary_unique;

/*rename table*/
rename test_table to renamed_table;