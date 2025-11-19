
-- TABLE: course_layout

CREATE TABLE course_layout (
    course_code CHAR(10) PRIMARY KEY,
    course_name CHAR(30),
    min_students INT,
    max_students INT,
    hp FLOAT(10)
);


-- TABLE: department

CREATE TABLE department (
    department_name CHAR(30) PRIMARY KEY,
    manager CHAR(30)
);


-- TABLE: job_title

CREATE TABLE job_title (
    job_title_id INT PRIMARY KEY,
    title CHAR(30)
);


-- TABLE: person

CREATE TABLE person (
    personal_number INT PRIMARY KEY,
    first_name CHAR(30),
    last_name CHAR(30),
    phone_number CHAR(20),
    address VARCHAR(30)
);


-- TABLE: teaching_activity

CREATE TABLE teaching_activity (
    activity_name CHAR(30) PRIMARY KEY,
    factor FLOAT(10)
);


-- TABLE: course_instance

CREATE TYPE study_period_enum AS ENUM ('P1', 'P2', 'P3', 'P4');

CREATE TABLE course_instance (
    instance_id INT PRIMARY KEY,
    num_students INT,
    study_period study_period_enum,
    study_year INT,
    course_code CHAR(10) NOT NULL,

    FOREIGN KEY (course_code)
        REFERENCES course_layout(course_code)
);


-- TABLE: employee

CREATE TABLE employee (
    employment_id INT PRIMARY KEY,
    skill_set VARCHAR(30),
    salary INT,
    job_title_id INT NOT NULL,
    department_name CHAR(30) NOT NULL,
    personal_number INT NOT NULL,

    FOREIGN KEY (job_title_id)
        REFERENCES job_title(job_title_id),

    FOREIGN KEY (department_name)
        REFERENCES department(department_name),

    FOREIGN KEY (personal_number)
        REFERENCES person(personal_number)
);


-- TABLE: planned_activity
-- (Course instance × teaching activity) planned hours

CREATE TABLE planned_activity (
    activity_instance_id INT PRIMARY KEY,
    course_instance_id INT NOT NULL,
    activity_name CHAR(30) NOT NULL,
    planned_hours INT,

    FOREIGN KEY (course_instance_id)
        REFERENCES course_instance(instance_id),

    FOREIGN KEY (activity_name)
        REFERENCES teaching_activity(activity_name)
);

CREATE TABLE employee_on_activity (
    activity_instance_id INT NOT NULL,
    employment_id INT NOT NULL,

    PRIMARY KEY (activity_instance_id, employment_id),

    FOREIGN KEY (activity_instance_id)
        REFERENCES planned_activity(activity_instance_id),

    FOREIGN KEY (employment_id)
        REFERENCES employee(employment_id)

    
);


-- TRIGGERS

CREATE OR REPLACE FUNCTION limit_employee_course_instances()
RETURNS TRIGGER AS $$
DECLARE
    new_period INT;            -- study period of the activity being assigned
    new_instance INT;          -- course_instance_id for this activity
    instance_count INT;        -- number of distinct course instances already assigned
BEGIN


    -- 1. Get the course_instance linked to the activity
    SELECT course_instance_id INTO new_instance
    FROM planned_activity
    WHERE activity_instance_id = NEW.activity_instance_id;

    -- 2. Get the study period of that course instance
    SELECT study_period INTO new_period
    FROM course_instance
    WHERE instance_id = new_instance;


    -- 3. Count DISTINCT course instances already assigned to this employee in the same study period
    SELECT COUNT(DISTINCT pa.course_instance_id) INTO instance_count
    FROM employee_on_activity eoa
    JOIN planned_activity pa
        ON pa.activity_instance_id = eoa.activity_instance_id
    JOIN course_instance ci
        ON ci.instance_id = pa.course_instance_id
    WHERE eoa.employment_id = NEW.employment_id
      AND ci.study_period = new_period;

    -- 4. If already at 4 distinct course instances, block
    IF instance_count >= 4 THEN
        RAISE EXCEPTION
            'Employee % is already assigned to 4 course instances in study period %, cannot assign a 5th.',
            NEW.employment_id, new_period;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_limit_employee_course_instances
BEFORE INSERT ON employee_on_activity
FOR EACH ROW
EXECUTE FUNCTION limit_employee_course_instances();

