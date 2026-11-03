USE vidya_db;
SHOW TABLES;
DESCRIBE students;
-- Select database
USE vidya_db;

-- Display all databases
SHOW DATABASES;

-- Display all tables
SHOW TABLES;

-- View table structure
DESCRIBE students;

-- View table records
SELECT * FROM students;

-- Count total students
SELECT COUNT(*) AS total_students
FROM students;

-- View unique subjects
SELECT DISTINCT subject
FROM staff;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'vidya_db'
AND CONSTRAINT_NAME = 'PRIMARY';

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'vidya_db'
AND REFERENCED_TABLE_NAME IS NOT NULL;



SELECT
    TABLE_NAME,
    COLUMN_NAME,
    COLUMN_KEY,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'vidya_db'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

SELECT
    s.student_id,
    s.name,
    sa.attendance_percentage,
    sa.lab_attendance_percentage
FROM students s
INNER JOIN student_attendance sa
ON s.student_id = sa.student_id;

SELECT
    s.student_id,
    s.name,
    a.quiz_average,
    a.midterm_marks,
    a.final_marks
FROM students s
INNER JOIN academic_performance a
ON s.student_id = a.student_id;

SELECT
    s.student_id,
    s.name,
    l.learning_style,
    l.motivation_level,
    l.study_hours_per_day
FROM students s
INNER JOIN learning_profile l
ON s.student_id = l.student_id;

SELECT
    s.student_id,
    s.name,
    p.predicted_final_score,
    p.academic_risk
FROM students s
INNER JOIN predictions p
ON s.student_id = p.student_id;

SELECT
    s.student_id,
    s.name,
    r.focus_area,
    r.recommended_action,
    r.priority
FROM students s
INNER JOIN recommendations r
ON s.student_id = r.student_id;

SELECT
    s.staff_id,
    s.staff_name,
    a.date,
    a.status
FROM staff s
INNER JOIN staff_attendance a
ON s.staff_id = a.staff_id;

SELECT student_id, COUNT(*) AS total
FROM students
GROUP BY student_id
HAVING COUNT(*) > 1;

SELECT student_id, COUNT(*) AS total
FROM students
GROUP BY student_id
HAVING COUNT(*) > 1;

SELECT staff_id, COUNT(*) AS total
FROM staff
GROUP BY staff_id
HAVING COUNT(*) > 1;

SELECT student_id, COUNT(*) AS total
FROM academic_performance
GROUP BY student_id
HAVING COUNT(*) > 1;

SELECT student_id, COUNT(*) AS total
FROM learning_profile
GROUP BY student_id
HAVING COUNT(*) > 1;


