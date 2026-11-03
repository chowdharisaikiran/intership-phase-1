use vidya_db

SELECT
    COUNT(*) AS total_students,
    ROUND(AVG(quiz_average), 2) AS avg_quiz_score,
    ROUND(AVG(midterm_marks), 2) AS avg_midterm,
    ROUND(AVG(final_marks), 2) AS avg_final
FROM academic_performance;

SELECT
    COUNT(*) AS total_academic_records,
    ROUND(AVG(quiz_average), 2) AS average_quiz_score,
    ROUND(AVG(midterm_marks), 2) AS average_midterm,
    ROUND(AVG(final_marks), 2) AS average_final
FROM academic_performance;

SELECT
    s.student_id,
    s.name,
    ap.quiz_average,
    ap.midterm_marks,
    ap.final_marks,
    ROUND(
        (ap.quiz_average + ap.midterm_marks + ap.final_marks) / 3, 2
    ) AS overall_average
FROM students s
INNER JOIN academic_performance ap
    ON s.student_id = ap.student_id
ORDER BY overall_average DESC
LIMIT 10;

SELECT
    s.student_id,
    s.name,
    ap.quiz_average,
    ap.midterm_marks,
    ap.final_marks
FROM students s
INNER JOIN academic_performance ap
    ON s.student_id = ap.student_id
WHERE ap.quiz_average < 40
   OR ap.midterm_marks < 40
   OR ap.final_marks < 40
ORDER BY ap.final_marks ASC;

SELECT
    s.student_id,
    s.name,
    sa.attendance_percentage,
    CASE
        WHEN sa.attendance_percentage >= 90 THEN 'Excellent'
        WHEN sa.attendance_percentage >= 75 THEN 'Good'
        WHEN sa.attendance_percentage >= 60 THEN 'Average'
        ELSE 'Low Attendance'
    END AS attendance_category
FROM students s
INNER JOIN student_attendance sa
    ON s.student_id = sa.student_id
ORDER BY sa.attendance_percentage DESC;

SELECT
    academic_risk,
    COUNT(*) AS total_students,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM predictions), 2
    ) AS risk_percentage
FROM predictions
GROUP BY academic_risk
ORDER BY total_students DESC;

SELECT
    s.subject,
    COUNT(DISTINCT s.staff_id) AS total_staff,
    COUNT(sa.attendance_id) AS total_attendance_records,
    SUM(CASE WHEN sa.status = 'Present' THEN 1 ELSE 0 END)
        AS present_days,
    SUM(CASE WHEN sa.status = 'Absent' THEN 1 ELSE 0 END)
        AS absent_days
FROM staff s
LEFT JOIN staff_attendance sa
    ON s.staff_id = sa.staff_id
GROUP BY s.subject
ORDER BY present_days DESC;

SELECT
    s.student_id,
    s.name,
    sa.attendance_percentage,
    ap.quiz_average,
    ap.midterm_marks,
    ap.final_marks,
    lp.study_hours_per_day,
    lp.learning_style,
    lp.motivation_level,
    p.academic_risk,
    p.predicted_final_score
FROM students s
LEFT JOIN student_attendance sa
    ON s.student_id = sa.student_id
LEFT JOIN academic_performance ap
    ON s.student_id = ap.student_id
LEFT JOIN learning_profile lp
    ON s.student_id = lp.student_id
LEFT JOIN predictions p
    ON s.student_id = p.student_id
ORDER BY s.student_id;

SELECT
    s.staff_id,
    s.staff_name,
    s.subject,
    COUNT(sa.attendance_id) AS total_days,
    SUM(CASE WHEN sa.status = 'Present' THEN 1 ELSE 0 END)
        AS present_days,
    SUM(CASE WHEN sa.status = 'Absent' THEN 1 ELSE 0 END)
        AS absent_days,
    SUM(CASE WHEN LOWER(sa.status) = 'leave' THEN 1 ELSE 0 END)
        AS leave_days
FROM staff s
LEFT JOIN staff_attendance sa
    ON s.staff_id = sa.staff_id
GROUP BY
    s.staff_id,
    s.staff_name,
    s.subject
ORDER BY present_days DESC;

SELECT
    sa.student_id
FROM student_attendance sa
LEFT JOIN students s
    ON sa.student_id = s.student_id
WHERE s.student_id IS NULL;

SELECT
    p.student_id
FROM predictions p
LEFT JOIN students s
    ON p.student_id = s.student_id
WHERE s.student_id IS NULL;

CREATE OR REPLACE VIEW vw_student_performance AS
SELECT
    s.student_id,
    s.name,
    ap.quiz_average,
    ap.midterm_marks,
    ap.final_marks,
    p.academic_risk,
    p.predicted_final_score
FROM students s
LEFT JOIN academic_performance ap
    ON s.student_id = ap.student_id
LEFT JOIN predictions p
    ON s.student_id = p.student_id;
    
    CREATE OR REPLACE VIEW vw_student_attendance AS
SELECT
    s.student_id,
    s.name,
    sa.attendance_percentage,
    sa.lab_attendance_percentage
FROM students s
LEFT JOIN student_attendance sa
    ON s.student_id = sa.student_id;
    
    CREATE OR REPLACE VIEW vw_staff_attendance AS
SELECT
    s.staff_id,
    s.staff_name,
    s.subject,
    COUNT(sa.attendance_id) AS total_records,
    SUM(CASE WHEN sa.status = 'Present' THEN 1 ELSE 0 END)
        AS present_days,
    SUM(CASE WHEN sa.status = 'Absent' THEN 1 ELSE 0 END)
        AS absent_days
FROM staff s
LEFT JOIN staff_attendance sa
    ON s.staff_id = sa.staff_id
GROUP BY
    s.staff_id,
    s.staff_name,
    s.subject;
    
    SELECT * FROM vw_student_performance;

SELECT * FROM vw_student_attendance;

SELECT * FROM vw_staff_attendance;
