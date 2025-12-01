
/* \i C:/Users/Frans/Downloads/SQL_Querys_sem2.sql; */

--Q1

SELECT
    ci.course_code AS "Course Code",
    ci.instance_id AS "Course Instance ID",
    cl.hp AS "HP",
    ci.study_period AS "Period",
    ci.num_students AS "# Students",

    -- Specific activity hours
    ROUND(SUM(CASE WHEN pa.activity_name = 'Lecture'
                   THEN pa.planned_hours * ta.factor ELSE 0 END)) 
                   AS "Lecture Hours",

    ROUND(SUM(CASE WHEN pa.activity_name = 'Tutorial'
                   THEN pa.planned_hours * ta.factor ELSE 0 END)) 
                   AS "Tutorial Hours",

    ROUND(SUM(CASE WHEN pa.activity_name = 'Laboration'
                   THEN pa.planned_hours * ta.factor ELSE 0 END)) 
                   AS "Lab Hours",

    ROUND(SUM(CASE WHEN pa.activity_name = 'Seminar'
                   THEN pa.planned_hours * ta.factor ELSE 0 END)) 
                   AS "Seminar Hours",

    -- Total overhead hours (other activity names)
    ROUND(SUM(CASE 
                 WHEN pa.activity_name NOT IN ('Lecture','Tutorial','Laboration','Seminar')
                 THEN pa.planned_hours * ta.factor 
                 ELSE 0 
              END)) AS "Other Overhead Hours",

    -- Admin formula
    ROUND(2 * cl.hp + 28 + 0.2 * ci.num_students) AS "Admin Hours",

    -- Exam formula
    ROUND(32 + 0.725 * ci.num_students) AS "Exam Hours",

    -- Total Hours = all activity-hours + admin + exam
    ROUND(
        SUM(pa.planned_hours * ta.factor)
        + (2 * cl.hp + 28 + 0.2 * ci.num_students)
        + (32 + 0.725 * ci.num_students)
    ) AS "Total Hours"

FROM course_instance ci
JOIN course_layout cl
    ON ci.course_code = cl.course_code
LEFT JOIN planned_activity pa
    ON pa.course_instance_id = ci.instance_id
LEFT JOIN teaching_activity ta
    ON pa.activity_name = ta.activity_name

WHERE ci.study_year = EXTRACT(YEAR FROM CURRENT_DATE)

GROUP BY
    ci.course_code,
    ci.instance_id,
    cl.hp,
    ci.study_period,
    ci.num_students

ORDER BY ci.course_code, ci.instance_id;




--Q2

WITH params AS (
    -- Change the course instance ID here
    SELECT 4::INT AS course_instance_id
),
course_teachers AS (
    -- All teachers assigned to the course instance
    SELECT DISTINCT
        emp.employment_id,
        p.first_name || ' ' || p.last_name AS teacher_name,
        jt.title AS job_title
    FROM employee_on_activity eoa
    JOIN employee emp ON eoa.employment_id = emp.employment_id
    JOIN person p ON emp.personal_number = p.personal_number
    JOIN job_title jt ON emp.job_title_id = jt.job_title_id
    JOIN planned_activity pa ON eoa.activity_instance_id = pa.activity_instance_id
    JOIN params prm ON pa.course_instance_id = prm.course_instance_id
),
course_activities AS (
    -- All activities in the course instance
    SELECT
        pa.activity_instance_id,
        pa.activity_name,
        pa.course_instance_id,
        pa.planned_hours,
        ta.factor
    FROM planned_activity pa
    JOIN teaching_activity ta ON pa.activity_name = ta.activity_name
    JOIN params prm ON pa.course_instance_id = prm.course_instance_id
),
teacher_activity_hours AS (
    -- Cross join teachers x activities, get hours if assigned
    SELECT
        ct.teacher_name,
        ct.job_title,
        ca.activity_name,
        COALESCE(CEILING(CASE WHEN eoa.employment_id IS NOT NULL 
                               THEN ca.planned_hours * ca.factor ELSE 0 END),0) AS planned_hours
    FROM course_teachers ct
    CROSS JOIN course_activities ca
    LEFT JOIN employee_on_activity eoa
        ON eoa.activity_instance_id = ca.activity_instance_id
       AND eoa.employment_id = ct.employment_id
)
SELECT
    ci.course_code AS "Course Code",
    ci.instance_id AS "Course Instance ID",
    cl.hp AS "HP",
    tah.teacher_name AS "Teacher's Name",
    tah.job_title AS "Job Title",
    
    -- Activity-specific hours
    SUM(CASE WHEN tah.activity_name = 'Lecture' THEN tah.planned_hours ELSE 0 END) AS "Lecture Hours",
    SUM(CASE WHEN tah.activity_name = 'Tutorial' THEN tah.planned_hours ELSE 0 END) AS "Tutorial Hours",
    SUM(CASE WHEN tah.activity_name = 'Laboration' THEN tah.planned_hours ELSE 0 END) AS "Laborations Hours",
    SUM(CASE WHEN tah.activity_name = 'Seminar' THEN tah.planned_hours ELSE 0 END) AS "Seminar Hours",
    SUM(CASE 
            WHEN tah.activity_name NOT IN ('Lecture','Tutorial','Laboration','Seminar')
            THEN tah.planned_hours
            ELSE 0 
        END) AS "Other Overhead Hours",

    -- Admin & Exam
    CEILING(2 * cl.hp + 28 + 0.2 * ci.num_students) AS "Admin Hours",
    CEILING(32 + 0.725 * ci.num_students) AS "Exam Hours",

    -- Total hours
    CEILING(
        SUM(tah.planned_hours) 
        + (2 * cl.hp + 28 + 0.2 * ci.num_students)
        + (32 + 0.725 * ci.num_students)
    ) AS "Total Hours"

FROM teacher_activity_hours tah
JOIN params prm ON true
JOIN course_instance ci ON ci.instance_id = prm.course_instance_id
JOIN course_layout cl ON ci.course_code = cl.course_code

GROUP BY
    ci.course_code,
    ci.instance_id,
    cl.hp,
    ci.num_students,
    tah.teacher_name,
    tah.job_title

ORDER BY tah.teacher_name;






--Q3
WITH params AS (
    -- Change the employee ID here
    SELECT 19 AS employment_id
),
current_year_courses AS (
    -- All course instances for the current year
    SELECT ci.instance_id, ci.course_code, ci.num_students, ci.study_period, ci.study_year
    FROM course_instance ci
    WHERE ci.study_year = EXTRACT(YEAR FROM CURRENT_DATE)
),
teacher_activities AS (
    -- All planned activities assigned to the specific teacher in current year courses
    SELECT
        eoa.employment_id,
        p.first_name || ' ' || p.last_name AS teacher_name,
        jt.title AS job_title,
        ci.instance_id,
        ci.course_code,
        ci.num_students,
        ci.study_period,
        cl.hp,
        pa.activity_name,
        pa.planned_hours,
        ta.factor
    FROM employee_on_activity eoa
    JOIN employee emp ON eoa.employment_id = emp.employment_id
    JOIN person p ON emp.personal_number = p.personal_number
    JOIN job_title jt ON emp.job_title_id = jt.job_title_id
    JOIN planned_activity pa ON eoa.activity_instance_id = pa.activity_instance_id
    JOIN teaching_activity ta ON pa.activity_name = ta.activity_name
    JOIN current_year_courses ci ON pa.course_instance_id = ci.instance_id
    JOIN course_layout cl ON ci.course_code = cl.course_code
    JOIN params prm ON eoa.employment_id = prm.employment_id
)
SELECT
    ta.course_code AS "Course Code",
    ta.instance_id AS "Course Instance ID",
    ta.hp AS "HP",
    ta.study_period AS "Period",
    ta.teacher_name AS "Teacher's Name",

    -- Activity-specific hours
    SUM(CASE WHEN ta.activity_name = 'Lecture' THEN CEILING(ta.planned_hours * ta.factor) ELSE 0 END) AS "Lecture Hours",
    SUM(CASE WHEN ta.activity_name = 'Tutorial' THEN CEILING(ta.planned_hours * ta.factor) ELSE 0 END) AS "Tutorial Hours",
    SUM(CASE WHEN ta.activity_name = 'Laboration' THEN CEILING(ta.planned_hours * ta.factor) ELSE 0 END) AS "Laborations Hours",
    SUM(CASE WHEN ta.activity_name = 'Seminar' THEN CEILING(ta.planned_hours * ta.factor) ELSE 0 END) AS "Seminar Hours",
    SUM(CASE WHEN ta.activity_name = 'Overhead' THEN CEILING(ta.planned_hours * ta.factor) ELSE 0 END) AS "Other Overhead Hours",

    -- Admin & Exam hours (per course instance)
    CEILING(2 * ta.hp + 28 + 0.2 * ta.num_students) AS "Admin Hours",
    CEILING(32 + 0.725 * ta.num_students) AS "Exam Hours",

    -- Total hours per teacher per course instance
    CEILING(
        SUM(CEILING(ta.planned_hours * ta.factor)) 
        + (2 * ta.hp + 28 + 0.2 * ta.num_students)
        + (32 + 0.725 * ta.num_students)
    ) AS "Total Hours"

FROM teacher_activities ta
GROUP BY
    ta.course_code,
    ta.instance_id,
    ta.hp,
    ta.study_period,
    ta.num_students,
    ta.teacher_name
ORDER BY ta.course_code;




--Q4
 WITH params AS (
    -- Set the minimum number of courses and the current period here
    SELECT 1 AS min_courses, 'P1'::study_period_enum AS current_period
),
current_period_courses AS (
    -- All course instances for the specified period in the current year
    SELECT ci.instance_id, ci.study_period, ci.study_year
    FROM course_instance ci
    JOIN params prm ON ci.study_period = prm.current_period
    WHERE ci.study_year = EXTRACT(YEAR FROM CURRENT_DATE)
)
SELECT
    emp.employment_id AS "Employment ID",
    p.first_name || ' ' || p.last_name AS "Teacher's Name",
    ci.study_period AS "Period",
    COUNT(DISTINCT ci.instance_id) AS "No of courses"
FROM employee_on_activity eoa
JOIN employee emp ON eoa.employment_id = emp.employment_id
JOIN person p ON emp.personal_number = p.personal_number
JOIN planned_activity pa ON eoa.activity_instance_id = pa.activity_instance_id
JOIN current_period_courses ci ON pa.course_instance_id = ci.instance_id
GROUP BY
    emp.employment_id,
    p.first_name,
    p.last_name,
    ci.study_period
HAVING
    COUNT(DISTINCT ci.instance_id) >= (SELECT min_courses FROM params)
ORDER BY ci.study_period, "No of courses" DESC, "Teacher's Name";
