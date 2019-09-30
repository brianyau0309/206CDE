--  1. Show the Student_id, Module_code of the Study Table, 
--     buy only show the exam_date is later than 2014, Feb 01.
SELECT
  student_id, module_code, exam_date
FROM
  study
WHERE
  exam_date > TO_DATE('01-Feb-2014');

--  2. Show the Student_id, Module_code, exam_date of the Study Table, 
--     buy only show the exam_date taken in January.
SELECT
  student_id, module_code, exam_date
FROM
  study
WHERE
  TO_CHAR(exam_date, 'Mon') = 'Jan';
  
--  3. Show the average exam_score of student S004
--  (if the student did not take an exam, the score will not be counted).
SELECT
  AVG(exam_score) as avg_exam_score
FROM
  study
WHERE
  student_id = 'S004';

--  4. Show the average exam_score of student S004
--  (if the student did not take an exam, the score will be treated as 0 (zero)).
SELECT
  AVG(NVL(exam_score,0)) as avg_exam_score
FROM
  study
WHERE
  student_id = 'S004';

--  5. Redo (4) above, but show only two decimal digits.
SELECT
  TO_CHAR(AVG(NVL(exam_score,0)), '999.99') as avg_exam_score
FROM
  study
WHERE
  student_id = 'S004';

--  6. Show the highest Assign_score of the Study Table.
SELECT
  MAX(assign_score) as highest_assign_score
FROM
  study;

--  7. Show the lowest Exam_score of the Study Table. 
--  (Null value not counted)
SELECT
  MIN(exam_score) as lowert_exam_score
FROM
  study;

--  8. Show the highest Assign_score, highest Exam_score of the Study Table.
SELECT
  MAX(assign_score) as highest_assign_score,
  MAX(exam_score) as highest_exam_score
FROM
  study;

--  9. Show the Student_id, highest Assign_score, and highest Exam_score of each student in the Study Table.
SELECT
  student_id, 
  MAX(assign_score) as highest_assign_score, 
  MAX(exam_score) as highest_exam_score
FROM
  study
GROUP BY
  student_id;

--  10. Show the Module_code (in ascending order), highest Assign_score, and highest Exam_score of each Module in the Study Table.
SELECT
  module_code, 
  MAX(assign_score) as highest_assign_score, 
  MAX(exam_score) as highest_exam_score
FROM
  study
GROUP BY
  module_code
ORDER BY
  module_code ASC;

--  11. Show how many modules that S001 has taken.
SELECT
  COUNT(module_code) as modules
FROM
  study
WHERE
  student_id = 'S001';

--  12. For each student, show student_id, and how many modules had been taken by this student.
SELECT
  student_id, 
  COUNT(module_code) as modules
FROM
  study
GROUP BY
  student_id;

--  13. Show the Student_id, Module_code, and Actual Score of each module of each student. 
--  (note: Actual score = (Assign_score+Exam_score)/2 )
SELECT
  student_id, module_code, 
  (NVL(assign_score, 0) + NVL(exam_score, 0)) / 2 as actual_score
FROM
  study
ORDER BY
  student_id;
  
--  14. For each student, show the Student_id, Average Score of this student order by their Student_id. 
--  (note 1: Average score = Average of all actual score of all modules of each student)  
--  (note 2: Show only two decimal digits)
SELECT 
  student_id, 
  TO_CHAR(
    AVG((NVL(assign_score, 0) + NVL(exam_score, 0)) / 2)
    , '999.99') as average_score
FROM 
  study 
GROUP BY 
  student_id
ORDER BY
  student_id;

--  15. Redo (14) above, assign a column heading Average_Score for the average score column.
SELECT 
  student_id, 
  TO_CHAR(
    AVG((NVL(assign_score, 0) + NVL(exam_score, 0)) / 2)
    , '999.99') as average_score
FROM 
  study 
GROUP BY 
  student_id
ORDER BY
  student_id;

--  16. Talk to the classmate next to you, ask him/her to allow you access (Select Right) his/her Staff Table. 
--  (hints: see SQL command Grant on lecture notes)
GRANT SELECT ON staff to stu043;

--  17. Create a table named Other_Staff, copy the records from your classmate¡¦s Staff Table into Other_Staff.
CREATE TABLE other_staff
as SELECT 
     * 
   FROM 
     stu043.staff;

SELECT
  *
FROM
  other_staff;

--  18. Ask your classmate to stop your access right to his/her Staff Table.
REVOKE SELECT ON staff FROM stu043;

--  19. Show who (student_id) has the highest exam_score
SELECT
  a.student_id
FROM 
  study a
WHERE
  a.exam_score = (SELECT MAX(exam_score) FROM study);

--  20. For each module, show who (student_id and module_code) 
--      has the highest exam_score of that module.  
--      Show the result in acceding order of module_code.
SELECT
  a.module_code, a.student_id, a.exam_score
FROM
study a, (SELECT 
            module_code, MAX(exam_score) hightest
          FROM 
            study
          GROUP BY
            module_code) b
WHERE
  a.module_code = b.module_code and
  a.exam_score = b.hightest
ORDER BY
  a.module_code ASC;
