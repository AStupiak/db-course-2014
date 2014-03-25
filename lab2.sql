/*lab2*/
insert into NEW_TABLE values(1, 'new record', default);
alter table NEW_TABLE add new_coloumn varchar(45);
alter table NEW_TABLE modify name varchar(100)
alter table NEW_TABLE drop column new_coloumn;
alter table NEW_TABLE rename column name to new_name;
alter table NEW_TABLE disable constraint primary_unique;
rename NEW_TABLE to NEW_TABLE_RENAMED;