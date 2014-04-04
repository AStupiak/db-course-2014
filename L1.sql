CREATE TABLESPACE labs
   DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\labs.dat'
   SIZE 40M AUTOEXTEND ON;

SELECT tablespace_name, file_name, status, bytes
  FROM dba_data_files
  WHERE tablespace_name LIKE 'LABS'
  ORDER BY tablespace_name, file_name;