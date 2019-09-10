Drop table staff;
Drop table student;
Drop table module;
Drop table Staff_Backup;
Drop table Student_Backup;
Drop table Module_Backup;
Drop table test_01;

CREATE TABLE student (
  Student_id Char(5) PRIMARY KEY,
  Student_name Varchar2(40),
  Sex Char(1) check (sex in ('M', 'F')),
  Address Varchar2(30)
);

CREATE TABLE module (
  Module_code Char(5) PRIMARY KEY,
  Module_name Varchar2(40) NOT NULL,
  Credits Number(2) NOT NULL
);

CREATE TABLE staff (
  Staff_id CHAR(5) PRIMARY KEY, 
  Name VARCHAR2(30) NOT NULL, 
  Title Varchar2(20),
  Month_Salary Number(8) check(Month_Salary >= 0),
  Hour_salary Number(5) check(Hour_salary > 0),
  Extra_hour Number(3) check(Extra_hour >= 0)
);

INSERT INTO student values ('S001', 'Mary Wong', 'F','Central');
INSERT INTO student values ('S002', 'Peter Tse', 'M','Tin Hau');
INSERT INTO student values ('S003', 'Sue Chan', 'F','CWB');
INSERT INTO student values ('S004', 'John Wo', 'M','CWB');
--Check duplicate primary key
--INSERT INTO student values ('S004', 'Susan Tai', 'F', 'Central');
--Check lowercase on sex
--INSERT INTO student values ('S006', 'Susan Tai', 'f', 'Central');

INSERT INTO module values ('M001', 'Database System and Design', 10);
INSERT INTO module values ('M002', 'System Methodolgoies', 20);
INSERT INTO module values ('M003', 'Data Structure and Algorithm', 30);
INSERT INTO module values ('M004', 'Web Programing', 40);
--Check NOT NULL on module name : ''
--INSERT INTO module values ('M006', '', 10);
--Check NOT NULL on module name : NULL
--INSERT INTO module values ('M006', NULL, 10);

INSERT INTO staff values ('F001', 'John', 'Teacher', 10000, 100, 1);
INSERT INTO staff values ('F002', 'May', 'Teacher', 20000, 200, 2);
INSERT INTO staff values ('F003', 'Cathy', 'Admin', 30000, 300, 3);
INSERT INTO staff values ('F004', 'Ken', 'Account', 40000, 400, 4);
INSERT INTO staff values ('F005', 'Tom', 'HR', 50000, 500, 5);
INSERT INTO staff values ('F006', 'Betty', 'Teacher', 60000, 600, 6);
INSERT INTO staff values ('F007', 'Anson', 'Teacher', 70000, 700, 7);
--INSERT INTO staff values ('F007', 'Cathy', 'Tutor', 10000, 100, -1);

CREATE table Student_Backup as SELECT * FROM student;
CREATE table Module_Backup as SELECT * FROM module;
CREATE table Staff_Backup as SELECT * FROM staff;

ALTER TABLE student
  ADD (Tel Char(8));

ALTER TABLE staff
  ADD (Room Char(10));

ALTER TABLE student
  DROP (Tel);

--ALTER TABLE staff
--  MODIFY (Month_Salary NUMBER(6));

--ALTER TABLE student 
--  RENAME COLUMN tel to telephone;

DELETE FROM staff
  WHERE Staff_id = 'F005';
 
--DELETE FROM staff;

UPDATE module 
  Set Credits = 45
  Where Module_code = 'M004';

DESCRIBE staff;

SELECT * FROM staff;
SELECT * FROM student;
SELECT * FROM module;
SELECT * FROM Staff_Backup;
SELECT * FROM Student_Backup;
SELECT * FROM Module_Backup;

CREATE TABLE test_01 (
  std_name char(20) check (substr(std_name,1,1) = UPPER(substr(std_name,1,1)))
);
INSERT INTO test_01 values ('AAA');--OK
INSERT INTO test_01 values ('Aaa');--OK
INSERT INTO test_01 values ('aAA');--Error

SELECT * FROM test_01;
