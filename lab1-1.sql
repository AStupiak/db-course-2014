/*1. Create an autoextended tablespace with one data file. Write script that prints out the detailed information about this file.*/

CREATE TABLESPACE SCHEDULE_TABLESPACE DATAFILE 'SCHEDULE_TABLESPACE.dat' size 50M autoextend on;
/*DROP TABLESPACE SCHEDULE_TABLESPACE INCLUDING CONTENTS CASCADE CONSTRAINTS;*/

SELECT tablespace_name, file_name, status, bytes
    FROM dba_data_files
    WHERE tablespace_name LIKE 'SCHEDULE_TABLESPACE'
    ORDER BY tablespace_name, file_name;