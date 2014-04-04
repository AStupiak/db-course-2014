CREATE TABLE test
	    ( id NUMBER PRIMARY KEY
	   	, name VARCHAR2(40)
	   	, date1 DATE
	   	);

COMMENT ON COLUMN test.id
   IS 'primary id';
COMMENT ON COLUMN test.name
   IS 'name max 40 characters';
COMMENT ON COLUMN test.date1
   IS 'date';

CREATE INDEX test_idx1 ON test(name);
CREATE INDEX test_idx2 ON test(id,date1);

ALTER TABLE test
  ADD CONSTRAINT date_check
    CHECK(
    		date1 >= date '1930-01-01'
         );

CREATE TABLE test_ref
	   	( id_ref NUMBER PRIMARY KEY
	   	, test_ref VARCHAR2(40)
	   	);

	

CREATE GLOBAL TEMPORARY TABLE valerius.temp_table
        ( id NUMBER
        , startdate DATE
        , class CHAR(20)
        )
      ON COMMIT DELETE ROWS;