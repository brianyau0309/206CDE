--  1. For the Module Table, show all columns, 
--     together with the Teacher Names.
SELECT 
  a.*, b.name
FROM 
  MODULE a, STAFF b
WHERE 
  a.teacher = b.staff_id;

--  2. Show the Teacher name, Module_code, 
--     and Module_name who teaches Web Programming.
SELECT 
  b.name, a.module_code, a.module_name
FROM 
  MODULE a, STAFF b
WHERE 
  a.teacher = b.staff_id and a.module_name = 'Web Programming';

--  3. For the Study Table, other than showing all the original columns, 
--     also show corresponding Student_name and Module_Name.
SELECT
  a.*, b.module_name, c.student_name
FROM
  study a, module b, student c
WHERE
  a.student_id = c.student_id and a.module_code = b.module_code;

--  4. Show all students (module_name, student_name, student_id,) 
--     who have studied the module that the module name contains the word 'System' 
--     (You must use table-join for this question).
SELECT
  a.student_id, c.student_name, b.module_name
FROM
  study a, module b, student c
WHERE
  a.student_id = c.student_id and 
  a.module_code = b.module_code and 
  b.module_name LIKE '%System%';

--  5. Redo question (4) above but show only 
--     student_name, student_id, module_code 
--     (You must use sub-query).
SELECT
  b.student_id, b.student_name, a.module_code
FROM
  study a, student b
WHERE
  a.student_id = b.student_id and
  (
   SELECT 
     module_name 
   FROM 
     module 
   WHERE
     module_code = a.module_code
   ) LIKE '%System%';

--  6. Show the student (student_id, module_code, exam_score) 
--     who achieved the highest exam score in the Study table.
SELECT
  a.student_id, a.module_code, a.exam_score
FROM 
  study a, (SELECT
              MAX(exam_score) max_score
            FROM
              study) b
WHERE
  a.exam_score = b.max_score;

--  7. Show the student (student_name, student_id, exam_score) 
--     who achieved the highest exam score
SELECT
  a.student_id, b.student_name, a.exam_score
FROM 
  study a, student b, (SELECT
                         MAX(exam_score) max_score
                       FROM
                         study) c
WHERE
  a.student_id = b.student_id and
  a.exam_score = c.max_score;

--  8. Find the average exam score in the Study table.
SELECT
  AVG(NVL(exam_score,0))
FROM
  study;
  
--  9. Show all students (student_id) who achieved the exam score better than the average exam score 
--     found in question (8) above. (Do not show duplicated student_id).
SELECT
  a.student_id
FROM
  study a, (SELECT
              AVG(NVL(exam_score,0)) avg_mark
            FROM
              study) b
WHERE
  a.exam_score > b.avg_mark
GROUP BY
  student_id;


--  10. Show all students (student name, student_id) whose assign_score is higher than exam_score.
SELECT
  a.student_id, b.student_name
FROM
  study a, student b
WHERE
  a.student_id = b.student_id and
  a.assign_score > a.exam_score;

--  11. For the module 'M001', show all students (student name, student_id, exam_score) 
--      whose exam_score is higher than student_id 'S002'.
SELECT
  a.student_id, b.student_name, a.exam_score
FROM
  study a, student b
WHERE
  a.student_id = b.student_id and 
  a.module_code = 'M001' and
  a.exam_score > (SELECT 
                    exam_score 
                  FROM 
                    study 
                  WHERE 
                    student_id = 'S002' and 
                    module_code = 'M001');

--  12. Show all students (student_id, exam_score), 
--      whose any exam_score is higher than ANY exam_score of student 'John Wo'. 
--      (you must use the ANY operator)
SELECT 
  a.student_id, a.exam_score
FROM 
  study a
WHERE 
  a.exam_score > ANY(SELECT 
                       exam_score 
                     FROM 
                       study a, student b 
                     WHERE 
                       a.student_id = b.student_id and 
                       b.student_name = 'John Wo');
                       
--  13. Show all students (student_id, exam_score), 
--      whose any exam_score is higher than ALL exam_score of 'Mary Wong'. 
--      (you cannot use the ALL operator)
SELECT 
  a.student_id, a.exam_score
FROM 
  study a
WHERE 
  a.exam_score > (SELECT 
                    MAX(exam_score) 
                  FROM 
                    study a, student b 
                  WHERE 
                    a.student_id = b.student_id and 
                    b.student_name = 'Mary Wong');
                    
--  14. Show all students (student_id, exam_score), 
--      whose any exam_score is higher than ALL exam_score of 'Mary Wong'. 
--      (you must use the ALL operator)
SELECT 
  a.student_id, a.exam_score
FROM 
  study a
WHERE 
  a.exam_score > ALL(SELECT 
                       exam_score 
                     FROM 
                       study a, student b 
                     WHERE 
                       a.student_id = b.student_id and 
                       b.student_name = 'Mary Wong');
                       
--  15. Show the top-3 assign_score.
SELECT 
  assign_score
FROM 
  (SELECT assign_score FROM study ORDER BY assign_score DESC)
WHERE 
  ROWNUM <= 3

--  16. Show the student (student_id, assign_score) 
--      who achieved the top-3 highest assign_score.
SELECT
  student_id, assign_score
FROM
  study
WHERE
  assign_score in (SELECT 
                     assign_score
                   FROM 
                     (SELECT assign_score FROM study ORDER BY assign_score DESC)
                   WHERE 
                     ROWNUM <= 3);

--  17. Now, add a new column 'Credits' to the Study table (use number(2) ), 
--      then update the Study table's Credits column using the information in the Module table.
ALTER TABLE study
ADD credits NUMBER(2);

UPDATE study a
SET credits = (SELECT 
                 credits
               FROM
                 module b
               WHERE
                 a.module_code = b.module_code 
              );
--  Special Challenge
--  1. Find the better-achieved module(s) of each student.  
--     Better-achieved module means the Actual score of that modules is higher than this student¡¦s overall average score. 
--     Show only Student_id, Module_code, and Actual Score of each student, order by student_id and module_code.
--     (note: Actual score = (Assign_score+Exam_score)/2 )
--     (note: Average score = Average of all actual score of all modules of each student)
SELECT
  b.student_id, b.module_code, b.actual_score
FROM
  (SELECT
     student_id,
     module_code,
     (NVL(assign_score, 0)+NVL(exam_score, 0))/2 actual_score 
   FROM
     study) b,
  (SELECT
     student_id,
     AVG((NVL(assign_score, 0)+NVL(exam_score, 0))/2) avg_score 
   FROM
     study
   GROUP BY
     student_id) c
WHERE
  b.student_id = c.student_id and
  b.actual_score > c.avg_score
ORDER BY 
  student_id;

--  2. For each module, show the student (student name, student_id, module_code, exam_score) 
--     who achieved the highest exam_score.
SELECT
  a.module_code, a.student_id, b.student_name, a.exam_score
FROM
study a, student b, (SELECT 
                       module_code, MAX(exam_score) hightest
                     FROM 
                       study
                     GROUP BY
                       module_code) c
WHERE
  a.student_id = b.student_id and
  a.module_code = c.module_code and
  a.exam_score = c.hightest
ORDER BY
  a.module_code ASC;

--  3. For each module, show the student (student name, student_id, module_code, exam_score)
--     who achieved the highest Actual_score.
SELECT
  a.module_code, 
  a.student_id, 
  b.student_name, 
  (NVL(a.assign_score, 0)+NVL(a.exam_score, 0))/2 actual_score
FROM
  study a, student b, (SELECT 
                         module_code, 
                         MAX((NVL(assign_score, 0)+NVL(exam_score, 0))/2) hightest
                       FROM 
                         study
                       GROUP BY
                         module_code) c
WHERE
  a.student_id = b.student_id and
  a.module_code = c.module_code and
  (NVL(a.assign_score, 0)+NVL(a.exam_score, 0))/2 = c.hightest
ORDER BY
  a.module_code ASC;
