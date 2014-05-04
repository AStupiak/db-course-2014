/*
    2. Create user that uses tablespace created on step 1. Grand him an ability
    to open session and operate with objects in his schema. bit.ly/O8a2NO.
*/

-- Connected as a SYSTEM

-- Create new user
CREATE USER AM_NICEDAY IDENTIFIED BY admin
    DEFAULT TABLESPACE USERS;

ALTER USER AM_NICEDAY TEMPORARY TABLESPACE users_temp;

-- Select all users
SELECT * FROM DBA_USERS WHERE USERNAME = 'AM_NICEDAY';

-- Grant AM_NiceDay
GRANT CREATE SESSION TO AM_NICEDAY;

GRANT CREATE TABLE TO AM_NiceDay;
GRANT CREATE SEQUENCE TO AM_NiceDay;
GRANT CREATE CLUSTER TO AM_NiceDay;

GRANT UNLIMITED TABLESPACE TO AM_NiceDay;