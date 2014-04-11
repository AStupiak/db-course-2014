connect sys as sysdba
@?/demo/schema/human_resources/hr_main.sql

SELECT       table_name FROM user_tables;

SELECT * FROM EMPLOYEES
	WHERE DEPARTMENT_ID = 10;