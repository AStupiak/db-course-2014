create table employee (
	example_number_1 number(10),
	example_number_2 number(10)
);

insert into employee(example_number_1, example_number_2) VALUES(1, 2);

/*----------------Dirty-Reads in Read Uncommitted level-------------------*/

/*Transaction A*/
update employee SET example_number_2=example_number_2+1 WHERE example_number_1=1;

/*Transaction B*/
select example_number_2 from employee WHERE example_number_1=1;

rollback work;
/*In transaction A modifies the value of the transaction field example_number_2,
and then in transaction B value of this fields is selected.
Thereafter, transaction A is rolled back. Resulting in a value
obtained by the transaction B that is different from the value
stored in the database.*/

/*----------------Non-Repeatable Reads in Read Committer level-------------------*/

/*Transaction A*/
select example_number_2 from employee WHERE example_number_1=1;

/*Transaction B*/
select example_number_2 from employee WHERE example_number_1=1;

/*Transaction A*/
update employee SET example_number_2=example_number_2+1 WHERE example_number_1=1;
commit;

/*Transaction B*/
select example_number_2 from employee WHERE example_number_1=1;
/*When the transaction tries to get the value
of it will be different from the initial value in this
transaction*/