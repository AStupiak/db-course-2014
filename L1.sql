create tablespace TEST_TABLE_SPACE
	datafile 'test_table_space'
	size 20M autoextend on;

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


