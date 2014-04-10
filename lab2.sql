create table MASTER_TABLE (
	id number(10),
	idx number(1),
	constraint master_table_pk primary key(id)
);

create table STORY (
	id number(10),
	master_table_id number(10),
	Title VARCHAR2(50),
	Author VARCHAR2(20),
	constraint dictionary_table_pk primary key(id),
	constraint master_table_fk foreign key(master_table_id) references MASTER_TABLE(id)
);

insert into DICTIONARY_TABLE_1(id, name, age) VALUES(1, 'Alise in Wonderland', 'Lewis Carroll');
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(2, 'Star Wars', 'George Lucas');
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(3, 'Lord of The Rings', 'J. R. R. Tolkien');
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(4, 'Sherlock Holms', 'Conan Doyle');
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(5, 'The Seven Habits of Highly Effective People', 'Stephen Covey');


create table USER (
	id number(10),
	master_table_id number(10),
	Username VARCHAR2(20),
	Password VARCHAR2(20),
	constraint dictionary_table_pk primary key(id),
	constraint master_table_fk foreign key(master_table_id) references MASTER_TABLE(id)
);

insert into DICTIONARY_TABLE_1(id, name, age) VALUES(1, 'AM_NiceDay', 'nasdnsd');
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(2, 'Chuck_Norris', 's5sad2');
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(3, 'kotik_1996', '123456');
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(4, 'Sherlock_Holms', '123');
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(5, 'Roland', 'qwerty');

create table COMPANY (
	id number(10),
	master_table_id number(10),
	Name VARCHAR2(20),
	Tagline VARCHAR2(40),
	constraint dictionary_table_pk primary key(id),
	constraint master_table_fk foreign key(master_table_id) references MASTER_TABLE(id)
);

insert into DICTIONARY_TABLE_1(id, name, age) VALUES(1, 'Coca-cola', 'Enjoy');
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(2, 'Nike', 'Just do it');
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(3, 'Macdonalds', 'I'm lovin' it');
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(4, 'Apple', 'Think different');
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(5, 'Microsoft', 'Your potential. Our passion.');

create table FILM (
	id number(10),
	master_table_id number(10),
	Name VARCHAR2(50),
	Year number(10),
	constraint dictionary_table_pk primary key(id),
	constraint master_table_fk foreign key(master_table_id) references MASTER_TABLE(id)
);

insert into DICTIONARY_TABLE_1(id, name, age) VALUES(1, 'Now you see me', 2013);
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(2, 'The Shawshank Redemption', 1994);
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(3, 'The Green Mile ', 1999);
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(4, 'Intouchables', '2011');
insert into DICTIONARY_TABLE_1(id, name, age) VALUES(5, 'The Lion King ', 1994);
