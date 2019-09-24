--  Q.1: Show all female student information in Student Table
SELECT 
  * 
FROM 
  STUDENT 
WHERE 
  sex = 'F';

--  Q.2: Show all student information in Student Table order by their name
SELECT 
  * 
FROM 
  STUDENT 
ORDER BY 
  STUDENT_NAME;

--  Q.3 Show all student information in Student Table in descending order of their STUDENT_ID
SELECT 
  * 
FROM 
  STUDENT 
ORDER BY 
  STUDENT_ID DESC;

--  Q.4: how all student information in Student Table in ascending order of SEX and descending order of their STUDENT_ID.
SELECT 
  * 
FROM 
  STUDENT 
ORDER BY 
  SEX ASC ,STUDENT_ID DESC;

--  Q.5: Show student_id, student name, sex (but use the alias name Gender) in Student Table in ascending order of Gender and descending order of their STUDENT_ID
SELECT 
  STUDENT_ID, STUDENT_NAME, sex as Gender 
FROM 
  STUDENT 
ORDER BY 
  Gender ASC, STUDENT_ID DESC;

--  Q.6
SELECT 
  to_char(sysdate, 'DD-MM-YYYY') 
FROM 
  DUAL;

--  Q.7

--  a) 2012-12-28
SELECT 
  to_char(sysdate, 'YYYY-MM-DD') 
FROM 
  DUAL;

--  b) 2012-28-December
SELECT 
  to_char(sysdate, 'YYYY-DD-MONTH') 
FROM 
  DUAL;

--  c) 2012-Dec-28
SELECT 
  to_char(sysdate, 'YYYY-MON-DD') 
FROM 
  DUAL;

--  d) 28 DEC 2012
SELECT 
  to_char(sysdate, 'DD MON YYYY') 
FROM 
  DUAL;

--  Q.8
SELECT 
  to_char(sysdate, 'HH12 AM') 
FROM 
  DUAL;

--  Q.9

--  a) 03:20:30 PM
SELECT 
  to_char(sysdate, 'HH12:MI:SS AM') 
FROM 
  DUAL;

--  b) 15:20:30
SELECT 
  to_char(sysdate, 'HH24:MI:SS') 
FROM 
  DUAL;

--  Q.10: Show all job_title from Staff table where the job_title starts from the character T
SELECT 
  TITLE 
FROM 
  STAFF 
WHERE 
  TITLE LIKE 'T%';

--  Q.11: Show all names from Staff table where the name ends with the character N or n
SELECT 
  NAME 
FROM 
  STAFF 
WHERE 
  UPPER(NAME) LIKE '%N';

--  Q.12: Show all names from Student table where the name contains the character ?˜r??
SELECT 
  STUDENT_NAME 
FROM 
  STUDENT 
WHERE 
  STUDENT_NAME LIKE '%r%';

--  Q.13: Show the extra pay amount (hour_salary x extra_hour) of each staff
SELECT 
  STAFF_ID, NAME, (HOUR_SALARY*EXTRA_HOUR) as EXTRA_PAY 
FROM 
  STAFF; 

--  Q.14: Show the total extra pay amount of each job_title
SELECT 
  TITLE, SUM((HOUR_SALARY*EXTRA_HOUR)) as EXTRA_PAY 
FROM 
  STAFF 
GROUP BY 
  TITLE;

--  Q.15: Show the total extra pay amount needs to be paid to all staff
SELECT 
  SUM(HOUR_SALARY*EXTRA_HOUR) as EXTRA_PAY 
FROM 
  STAFF;

--  Q.16: Show the total extra pay amount of each job_title, but only display those job_title when the total extra pay of that job_title is higher than 1500
SELECT 
  TITLE, SUM((HOUR_SALARY*EXTRA_HOUR)) as EXTRA_PAY 
FROM 
  STAFF 
GROUP BY 
  TITLE
HAVING 
  SUM(HOUR_SALARY*EXTRA_HOUR) > 1500;

--  Q.17: Show the total extra pay amount of each job_title, but only display those job_title when the total extra pay is higher than 1500 and if the job_title is Admin or Account.
SELECT 
  TITLE, SUM((HOUR_SALARY*EXTRA_HOUR)) as EXTRA_PAY 
FROM 
  STAFF 
WHERE 
  TITLE = 'Admin' or TITLE = 'Account'
GROUP BY 
  TITLE
HAVING 
  SUM(HOUR_SALARY*EXTRA_HOUR) > 1500;

--  Q.18: Add one new column birthday to the table Student, and make Mary Wong birthday as '02-Mar-1995' and find the age of Mary Wong (ignore months, just show the year of age)

--  Add new column brithday
ALTER TABLE 
  STUDENT
ADD 
  brithday Date;

--  Update Mary's brithday 02-Mar-1995
UPDATE 
  STUDENT 
SET 
  brithday = '02-Mar-1995' 
WHERE 
  STUDENT_NAME = 'Mary Wong';

--  Show Age

--  Case 1
SELECT 
  STUDENT_NAME, (
                  CASE 
                    WHEN (TO_CHAR(SYSDATE, 'MM') - TO_CHAR(BRITHDAY, 'MM')) >= 0 
                      THEN (TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(BRITHDAY, 'YYYY')) 
                    ELSE (TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(BRITHDAY, 'YYYY')-1) 
                  END
                ) as AGE
FROM 
  STUDENT
WHERE 
  STUDENT_NAME = 'Mary Wong';

--  Case 2
SELECT
  STUDENT_NAME, 
  trunc(months_between(sysdate, brithday) / 12) as Age
FROM 
  STUDENT 
WHERE 
  STUDENT_NAME = 'Mary Wong';

--  Q.19: Show the month as well

--  Case 1
SELECT 
  STUDENT_NAME, (
                  CASE 
                    WHEN (TO_CHAR(SYSDATE, 'MM') - TO_CHAR(BRITHDAY, 'MM')) >= 0 
                      THEN (TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(BRITHDAY, 'YYYY')) 
                    ELSE (TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(BRITHDAY, 'YYYY')-1) 
                  END
                ) as AGE ,
                (
                  CASE
                    WHEN (TO_CHAR(SYSDATE, 'MM') - TO_CHAR(BRITHDAY, 'MM')) >= 0 
                      THEN (TO_CHAR(SYSDATE, 'MM') - TO_CHAR(BRITHDAY, 'MM'))
                    ELSE (TO_CHAR(SYSDATE, 'MM') + 12 - TO_CHAR(BRITHDAY, 'MM'))
                  END
                ) as AGE_MONTHS 
FROM 
  STUDENT 
WHERE 
  STUDENT_NAME = 'Mary Wong';
  
--  Case 2
SELECT
  STUDENT_NAME, 
  TRUNC(MONTHS_BETWEEN(sysdate, brithday) / 12) as Age,
  TRUNC(MOD(MONTHS_BETWEEN(sysdate, brithday), 12)) as Age_months
FROM 
  STUDENT 
WHERE 
  STUDENT_NAME = 'Mary Wong';