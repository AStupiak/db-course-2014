/*2. Create user that uses tablespace created on step 1. Grand him an ability to open session and operate with objects in his schema.*/

CREATE USER SCHEDULE_ADMIN
	identified by SCHEDULE_ADMIN
	default tablespace SCHEDULE_TABLESPACE
	quota 10M on SCHEDULE_TABLESPACE
	password EXPIRE;

GRANT
     CREATE SESSION,
     CREATE TABLE,
     CREATE PROCEDURE,
     CREATE TRIGGER,
     CREATE VIEW,
     CREATE SEQUENCE,
     ALTER ANY TABLE,
     ALTER ANY PROCEDURE,
     ALTER ANY TRIGGER,
     ALTER PROFILE,
     DELETE ANY TABLE,
     DROP ANY TABLE,
     DROP ANY PROCEDURE,
     DROP ANY TRIGGER,
     DROP ANY VIEW,
     DROP PROFILE
   TO SCHEDULE_ADMIN
   WITH ADMIN OPTION;