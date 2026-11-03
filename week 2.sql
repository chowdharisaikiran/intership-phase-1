START TRANSACTION;

INSERT INTO students
(student_id, name, age, gender)
VALUES
(999999, 'Test Student', 20, 'Male');

SELECT *
FROM students
WHERE student_id = 999999;

ROLLBACK;

SELECT *
FROM students;

START TRANSACTION;

UPDATE students
SET age = 21
WHERE student_id = 999999;

SELECT *
FROM students
WHERE student_id = 999999;

ROLLBACK;

UPDATE students
SET age = 21
WHERE student_id = 999999
LIMIT 1;

SET SQL_SAFE_UPDATES = 0;

START TRANSACTION;

UPDATE students
SET age = 21
WHERE student_id = 999999
AND name = 'Test Student';

SELECT *
FROM students
WHERE student_id = 999999;

ROLLBACK;

SELECT *
FROM students
WHERE age >= 20;

SELECT *
FROM academic_performance
WHERE final_marks >= 75;

SELECT *
FROM staff
WHERE overall_attendance_percentage >= 90;

SELECT
    s.student_id,
    s.name,
    a.quiz1_marks,
    a.quiz2_marks,
    a.quiz3_marks,
    a.midterm_marks,
    a.final_marks,
    a.quiz_average
FROM students s
INNER JOIN academic_performance a
ON s.student_id = a.student_id;

SELECT
    s.staff_id,
    s.staff_name,
    s.subject,
    s.overall_attendance_percentage,
    a.status,
    COUNT(*) AS total_records
FROM staff s
INNER JOIN staff_attendance a
ON s.staff_id = a.staff_id
GROUP BY
    s.staff_id,
    s.staff_name,
    s.subject,
    s.overall_attendance_percentage,
    a.status;
    
    SELECT
    AVG(quiz1_marks) AS avg_quiz1,
    AVG(quiz2_marks) AS avg_quiz2,
    AVG(quiz3_marks) AS avg_quiz3,
    AVG(midterm_marks) AS avg_midterm,
    AVG(final_marks) AS avg_final
FROM academic_performance;

SELECT
    s.student_id,
    s.name,
    sa.attendance_percentage,
    ap.quiz_average,
    ap.midterm_marks,
    ap.final_marks,
    p.academic_risk
FROM students s
LEFT JOIN student_attendance sa
    ON s.student_id = sa.student_id
LEFT JOIN academic_performance ap
    ON s.student_id = ap.student_id
LEFT JOIN predictions p
    ON s.student_id = p.student_id;
    
SELECT
    s.student_id,
    s.name,
    l.study_hours_per_day,
    l.learning_style,
    l.motivation_level,
    l.sleep_hours
FROM students s
LEFT JOIN learning_profile l
ON s.student_id = l.student_id;

SELECT
    staff_id,
    total_working_days,
    days_present,
    overall_attendance_percentage
FROM attendance_summary;

SELECT
    student_id,
    COUNT(*) AS total
FROM students
GROUP BY student_id
HAVING COUNT(*) > 1;

SELECT *
FROM students
WHERE student_id IS NULL
OR name IS NULL
OR age IS NULL
OR gender IS NULL;

SELECT *
FROM academic_performance
WHERE quiz1_marks IS NULL
OR quiz2_marks IS NULL
OR quiz3_marks IS NULL
OR midterm_marks IS NULL
OR final_marks IS NULL;

SELECT *
FROM student_attendance
WHERE attendance_percentage < 0
OR attendance_percentage > 100
OR lab_attendance_percentage < 0
OR lab_attendance_percentage > 100;

SELECT DISTINCT status
FROM staff_attendance;

SELECT *
FROM learning_profile
WHERE study_hours_per_day IS NULL
OR learning_style IS NULL
OR motivation_level IS NULL;

SELECT *
FROM academic_performance
WHERE quiz1_marks < 0 OR quiz1_marks > 100
OR quiz2_marks < 0 OR quiz2_marks > 100
OR quiz3_marks < 0 OR quiz3_marks > 100
OR midterm_marks < 0 OR midterm_marks > 100
OR final_marks < 0 OR final_marks > 100;

