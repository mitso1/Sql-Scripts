--DO $$ 
--DECLARE 
--    r RECORD;
--BEGIN 
--    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') LOOP
--        EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(r.tablename) || ' CASCADE';
--    END LOOP; 
--END $$; 

--DROP TYPE study_period_enum CASCADE;

-- TABLE: course_layout

CREATE TABLE course_layout (
    course_code CHAR(10) PRIMARY KEY,
    course_name VARCHAR(50),
    min_students INT,
    max_students INT,
    hp FLOAT(10)
);


-- TABLE: department

CREATE TABLE department (
    department_name VARCHAR(50) PRIMARY KEY,
    manager VARCHAR(50)
);


-- TABLE: job_title

CREATE TABLE job_title (
    job_title_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(50)
);


-- TABLE: person

CREATE TABLE person (
    personal_number CHAR(12) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number CHAR(20),
    address VARCHAR(50)
);


-- TABLE: teaching_activity

CREATE TABLE teaching_activity (
    activity_name CHAR(30) PRIMARY KEY,
    factor FLOAT(10)
);


-- TABLE: course_instance

CREATE TYPE study_period_enum AS ENUM ('P1', 'P2', 'P3', 'P4');

CREATE TABLE course_instance (
    instance_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    num_students INT,
    study_period study_period_enum,
    study_year INT,
    course_code CHAR(10) NOT NULL,

    FOREIGN KEY (course_code)
        REFERENCES course_layout(course_code)
);

-- TABLE: employee

CREATE TABLE employee (
    employment_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    skill_set VARCHAR(255),
    salary INT,
    job_title_id INT NOT NULL,
    department_name VARCHAR(50) NOT NULL,
    personal_number CHAR(12) NOT NULL,

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
    activity_instance_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
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

CREATE TABLE settings (
    settings_row INT PRIMARY KEY NOT NULL DEFAULT 1,
    max_cinstances_per_employee INT DEFAULT 4,
    CONSTRAINT settings_one_row CHECK (settings_row = 1)
);

-- TRIGGERS

CREATE OR REPLACE FUNCTION limit_employee_course_instances()
RETURNS TRIGGER AS $$
DECLARE
    new_period study_period_enum;            -- study period of the activity being assigned
    new_instance INT;          -- course_instance_id for this activity
    instance_count INT;        -- number of distinct course instances already assigned
    max_allowed_instances INT; -- max number of course instances allowed per employee
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

    -- 4. Read value from settings table
    SELECT max_cinstances_per_employee
    INTO max_allowed_instances
    FROM settings;

    -- 5. If already at the limit number of distinct course instances, block
    IF instance_count >= max_allowed_instances THEN
        RAISE EXCEPTION
            'Employee % is already assigned to % course instances in study period %, cannot assign another (limit = %).',
            NEW.employment_id, instance_count, new_period, max_allowed_instances;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_limit_employee_course_instances
BEFORE INSERT ON employee_on_activity
FOR EACH ROW
EXECUTE FUNCTION limit_employee_course_instances();



CREATE OR REPLACE FUNCTION students_in_range()
RETURNS TRIGGER AS $$
DECLARE
    min INT;            
    max INT;   

BEGIN

    SELECT min_students INTO min FROM course_layout WHERE course_code = NEW.course_code;
    SELECT max_students INTO max FROM course_layout WHERE course_code = NEW.course_code;

    IF NEW.num_students < min THEN
        RAISE EXCEPTION
            'The number of students(%) is below the minimum(%) allowed for this course(%)',
            NEW.num_students, min, NEW.course_code;
    END IF;

    IF NEW.num_students > max THEN
        RAISE EXCEPTION
            'The number of students(%) is above the maximum(%) allowed for this course(%)',
            NEW.num_students, max, NEW.course_code;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tgr_students_in_range
BEFORE INSERT ON course_instance
FOR EACH ROW
EXECUTE FUNCTION students_in_range();

-- Improvements to database according to feedback
ALTER TABLE employee
ADD COLUMN supervisor_id INT;

ALTER TABLE employee
ADD CONSTRAINT fk_employee_supervisor
FOREIGN KEY (supervisor_id)
REFERENCES employee(employment_id)
ON DELETE SET NULL;

ALTER TABLE department
DROP COLUMN manager;

ALTER TABLE department
ADD COLUMN manager_employment_id INT;

ALTER TABLE department
ADD CONSTRAINT fk_department_manager
FOREIGN KEY (manager_employment_id)
REFERENCES employee(employment_id)
ON DELETE SET NULL;
