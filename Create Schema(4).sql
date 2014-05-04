/*
    4. Alter table:
        - insert 5 new records into table (should include nulls for some rows)
        - add new column
        - add new column with default value set
        - modify existing column setting default value for it
        - rename the column
        - remove existing column
        - remove default value of the column
        - disable single constraint on the table
        - write script that disables all constraints of the given table ( use sql*plus “pipeline”, spool option)
        - rename table to <table_name>_bak (all data should remain in renamed table), 
          recreate original table using create table as statement.
*/

-- Connected as AM_NiceDay

-- Alter table

INSERT INTO PERSON(ID, USERNAME, PASSWORD)
    VALUES(1, 'AM_NiceDay', 'password');
    
INSERT INTO PERSON(ID, USERNAME, PASSWORD)
    VALUES(2, 'Downey_Jr', 'password');
    
INSERT INTO PERSON(ID, USERNAME, PASSWORD)
    VALUES(3, 'Donald_Duck', NULL);
    
INSERT INTO PERSON(ID, USERNAME, PASSWORD)
    VALUES(4, 'Bax_Bunny', 'password');
    
INSERT INTO PERSON(ID, USERNAME, PASSWORD)
    VALUES(5, 'potter1989', 'password');
    
ALTER TABLE PERSON
  ADD email VARCHAR(30);
  
ALTER TABLE PERSON
  ADD enabled NUMBER(1) DEFAULT 1;
  
ALTER TABLE PERSON
  MODIFY password DEFAULT 'password';
  
ALTER TABLE PERSON
  RENAME COLUMN email TO mail;
  
ALTER TABLE PERSON
  DROP COLUMN mail;
  
ALTER TABLE PERSON
  MODIFY password DEFAULT NULL;

-- Disable single constraint
ALTER TABLE PERSON
  ADD CONSTRAINT check_username CHECK(length(username) BETWEEN 6 AND 20);

ALTER TABLE PERSON
  DISABLE CONSTRAINT check_username;
  
-- Disable all constaints
BEGIN
  FOR constr IN 
  (SELECT CONSTRAINT_NAME, TABLE_NAME FROM USER_CONSTRAINTS
      WHERE TABLE_NAME = 'PERSON')
  LOOP   
    dbms_utility.exec_ddl_statement('alter table "' || constr.table_name || '" disable constraint ' || constr.constraint_name);
  END LOOP;
END;
  
RENAME PERSON TO PERSON_BAK;

CREATE TABLE PERSON AS (SELECT * FROM PERSON_BAK);