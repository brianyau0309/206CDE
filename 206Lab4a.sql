DROP TABLE study;
--  Table study
CREATE TABLE study (
    student_id CHAR(4) NOT NULL,
    module_code CHAR(4) NOT NULL,
    assign_score NUMBER(3),
    exam_score NUMBER(3),
    exam_date DATE
);

--  Primary Key
ALTER TABLE STUDY
ADD PRIMARY KEY (STUDENT_ID, MODULE_CODE);

--  Basic Data (12 row)
INSERT INTO study VALUES ('S001', 'M001', 70, 80, '11-JAN-2014');
INSERT INTO study VALUES ('S002', 'M001', 60, 65, '11-JAN-2014');
INSERT INTO study VALUES ('S003', 'M001', 80, 90, '11-JAN-2014');
INSERT INTO study VALUES ('S004', 'M001', 70, 45, '11-JAN-2014');
INSERT INTO study VALUES ('S001', 'M002', 50, 60, '11-FEB-2014');
INSERT INTO study VALUES ('S002', 'M002', 55, 76, '11-FEB-2014');
INSERT INTO study VALUES ('S004', 'M002', 30, 80, '27-FEB-2014');
INSERT INTO study VALUES ('S002', 'M003', 65, 40, '27-FEB-2014');
INSERT INTO study VALUES ('S003', 'M003', 35, 48, '27-FEB-2014');
INSERT INTO study VALUES ('S001', 'M004', 60, 60, '03-JAN-2014');
INSERT INTO study VALUES ('S003', 'M004', 50, 65, '03-JAN-2014');
INSERT INTO study VALUES ('S004', 'M004', 80, NULL, '03-JAN-2014');
--  NULL means the student did not taken the exam