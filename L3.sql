/* 2 */
select 
	a0.first_name||' '||a0.last_name as FULL_NAME,
	a0.phone_number, a0.email, 
	a1.first_name||' '||a1.last_name as MANAGER_FULL_NAME 
from EMPLOYEES a0 
left join EMPLOYEES a1 
	on a0.manager_id = a1.manager_id 
left join DEPARTMENTS d 
	on a0.DEPARTMENT_ID = d.DEPARTMENT_ID 
	where upper(d.DEPARTMENT_NAME) like upper('it');

/* 3 */
select 
  a0.first_name||' '||a0.last_name as FULL_NAME, 
  a0.phone_number ,
  d.DEPARTMENT_NAME,
  j.MAX_SALARY
from EMPLOYEES a0 
left join DEPARTMENTS d 
  on a0.DEPARTMENT_ID = d.DEPARTMENT_ID
left join JOBS j
  on j.JOB_ID = a0.JOB_ID;

/* 4 */
/* 5 */
/* 6 */
