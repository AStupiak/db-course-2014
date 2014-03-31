CREATE TABLESPACE YOUR_HOME
  DATAFILE 'yourhome.dat' SIZE 50M AUTOEXTEND ON;

SELECT tablespace_name, file_name, status, bytes
  FROM dba_data_files
  WHERE tablespace_name LIKE 'YOUR_HOME'
  ORDER BY tablespace_name, file_name;