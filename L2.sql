/* 1 */
create table MASTER_TABLE (
	id number(10),
	idx number(1),
	constraint MASTER_TABLE_PK primary key(id)
);

create table CHILD_TABLE_0 (
	id number(10),
	master_id number(10),

	constraint CHILD_TABLE_PK primary key(id),
	constraint MASTER_TABLE_FK foreign key(master_id) references MASTER_TABLE(id)
);

create table CHILD_TABLE_1 as select * from CHILD_TABLE_0;
create table CHILD_TABLE_2 as select * from CHILD_TABLE_0;
create table CHILD_TABLE_3 as select * from CHILD_TABLE_0;
create table CHILD_TABLE_4 as select * from CHILD_TABLE_0;	