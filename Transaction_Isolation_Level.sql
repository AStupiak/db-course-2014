/*----------------Dirty-Reads for Read Uncommitted-------------------*/
create table employee (
	f1 number(10),
	f2 number(10)
);

insert into employee(f1, f2) VALUES(1, 2);

/*Transaction A*/
update employee SET f2=f2+1 WHERE f1=1;

/*Transaction B*/
select f2 from employee WHERE f1=1;

rollback work;
/*In transaction A modifies the value of the transaction field f2,
and then in transaction B value of this fields is selected.
Thereafter, transaction A is rolled back. Resulting in a value
obtained by the transaction B that is different from the value
stored in the database.*/