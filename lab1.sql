/*lab1*/
create tablespace NEW_TABLESPACE datafile 'new_tablespace' size 15M autoextend on;
create user NEW_USER identified by NEW_PASSWORD default tablespace NEW_TABLESPACE QUOTA 15M ON NEW_TABLESPACE password expire;

grant create session to NEW_USER;
grant create table to NEW_USER;
grant create sequence to NEW_USER;
grant create any index to NEW_USER;
grant drop  any table to NEW_USER;
grant alter any table to NEW_USER;

create table NEW_TABLE(new_number number(10), name varchar(45), time date default sysdate);

comment on table NEW_TABLE is 'this is a new table';
comment on column NEW_TABLE.name is 'this is a string variable';
create index new_number_index on NEW_TABLE(new_number);
alter table NEW_TABLE add constraint primary_unique unique (new_number);
create global temporary table temp_table(id number(10));
