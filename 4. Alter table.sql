/*- insert 5 new records into table (should include nulls for some rows)
	- add new column
	- add new column with default value set
	- modify existing column setting default value for it
  - rename the column
	- remove existing column
	- remove default value of the column
	- disable single constraint on the table
	- write script that disables all constraints of the given table ( use sql*plus “pipeline”, spool option)
	- rename table to <table_name>_bak (all data should remain in renamed table), recreate original table using create table as statement*/

create table laba4_table(
  id numeric(6),
  text varchar2(250),
  test varchar2(100)
);

insert into laba4_table(id, text, test)
values(200, 'text text text', 'comment');

insert into laba4_table(id, text, test)
values(201, 'text text text1', 'comment1');

insert into laba4_table(id, text, test)
values(202, 'text text text2', 'comment2');

insert into laba4_table(id, text, test)
values(203, 'text text text3', null);

insert into laba4_table(id, text, test)
values(204, 'text text text4', 'comment4');

alter table laba4_table
add new_col char(25);

alter table laba4_table
add col_with_defvalue char(25) default 'this is def value' not null;

alter table laba4_table
modify new_col char(25) not null;

alter table laba4_table
rename COLUMN new_col TO sales;

alter table laba4_table
DROP COLUMN sales;

alter table laba4_table
modify col_with_defvalue default null;

alter table laba4_table
disable constraint string_unique;

rename laba4_table to laba4_test_table;

create table test_table as (select * from test_table_bak)