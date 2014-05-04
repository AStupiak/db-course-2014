/*
    1. Create an autoextended tablespace with one data file. Write script that
    prints out the detailed information about this file. bit.ly/1gucEwg.
*/

-- Connected as a SYSTEM

-- Create tablespace
CREATE TABLESPACE USERS
    DATAFILE 'C:\app\ORACLE_DB\oradata\orcl\USERS01.DBF'
    SIZE 20M REUSE AUTOEXTEND ON NEXT 20M MAXSIZE 1000M;

-- Create temporary tablespace
CREATE TEMPORARY TABLESPACE users_temp
   TEMPFILE 'C:\app\ORACLE_DB\oradata\orcl\users_temp01.dbf'
   SIZE 5M REUSE AUTOEXTEND ON NEXT 5M MAXSIZE 100M;

-- Select all tablespaces
SELECT * FROM DBA_TABLESPACES;

-- Select 'C:\APP\ORACLE_DB\ORADATA\ORCL\USERS01.DBF' datafile
SELECT * FROM DBA_DATA_FILES WHERE FILE_NAME = 'C:\APP\ORACLE_DB\ORADATA\ORCL\USERS01.DBF';
