/*
    3. Create table, sequence and index in your schema.
        - table should contain numeric, string, datetime columns (what is difference 
          between char, nchar, varchar2 types? Difference between datetime and timestamp types)
        - create script that adds comments to table and each column
        - create index over one column, several columns
        - create script what adds constraints, both reference and check constraints
        - create temporary table
        - create cluster based table
*/

-- Connected as AM_NiceDay

-- Create new table
CREATE TABLE story_descriptor
(
    id NUMERIC PRIMARY KEY NOT NULL,
    title VARCHAR2(30),
    dateCreated DATE,
    author VARCHAR(20)
);

-- Create new sequence
CREATE SEQUENCE sequence START WITH 1 INCREMENT BY 1;

/*
  Difference between char, nchar, varchar2 types:
     CHAR is used to store fix length character strings.
     VARCHAR2 is used to store variable length character strings.
     NCHAR is used to store fix length Unicode character strings.

  Difference between datetime and timestamp types:
     DATE and TIMESTAMP have the same size (7 bytes).
     Those bytes are used to store century, decade, year, month, day, hour, minute and seconds.
     But TIMESTAMP allows to store additional info such as fractional seconds (11 bytes)
     and fractional seconds with timezone (13 bytes).
*/

-- Create comments
COMMENT ON TABLE story_descriptor IS 'Stories Descriptors table';

COMMENT ON COLUMN story_descriptor.id IS 'Story id';
COMMENT ON COLUMN story_descriptor.title IS 'Story title';
COMMENT ON COLUMN story_descriptor.dateCreated IS 'Story date created';
COMMENT ON COLUMN story_descriptor.author IS 'Story author';

-- Create indexes
CREATE INDEX title_index ON story_descriptor(title)
    TABLESPACE users;

CREATE INDEX author_title_index ON story_descriptor(author, title)
    TABLESPACE users;

-- Create constraints
ALTER TABLE story_descriptor
    ADD CONSTRAINT check_title CHECK(length(title) BETWEEN 6 AND 30)

CREATE TABLE person
(
    id NUMERIC PRIMARY KEY NOT NULL,
    username VARCHAR(20),
    password VARCHAR(20)
);

ALTER TABLE person
  ADD CONSTRAINT unique_username UNIQUE (username);

ALTER TABLE story_descriptor
    ADD CONSTRAINT author_fk FOREIGN KEY(author)
        REFERENCES person(username);


-- Create temporary table
CREATE GLOBAL TEMPORARY TABLE credentials
(
    username VARCHAR2(20) PRIMARY KEY,
    password VARCHAR2(20)
)
    TABLESPACE USERS_TEMP;
    
-- Create cluster
CREATE CLUSTER user_profile_cluster
  (id NUMBER) TABLESPACE users SIZE 512;

CREATE INDEX index_user_profile_cluster ON CLUSTER user_profile_cluster;

CREATE TABLE USER_TABLE (
    id NUMBER PRIMARY KEY,
    username VARCHAR2(20),
    password VARCHAR2(20)
  ) CLUSTER user_profile_cluster(id);    

CREATE TABLE PROFILE (
    user_id NUMBER PRIMARY KEY,
    firstName VARCHAR2(20),
    secondName VARCHAR2(20),
    bio VARCHAR(1000)
  ) CLUSTER user_profile_cluster(user_id);