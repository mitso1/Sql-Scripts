-- JOB TITLES (creates job_title_id = 1..5)
INSERT INTO job_title (title) VALUES
  ('Manager'),
  ('Teacher'),
  ('Principal'),
  ('TA'),
  ('Researcher');


-- DEPARTMENTS
INSERT INTO department (department_name, manager) VALUES
  ('Admin', 'Zahir Conrad'),
  ('Electronics', 'Martina Tillman'),
  ('Data Science', 'Garrison Grant'),
  ('HR', 'Kuame Mann');


-- SETTINGS
INSERT INTO settings (settings_row, max_cinstances_per_employee)
VALUES (1, 4);


-- TEACHING ACTIVITIES
INSERT INTO teaching_activity (activity_name, factor) VALUES
  ('Laboration', 2.4),
  ('Lecture',   3.6),
  ('Tutorial',  2.4),
  ('Seminar',   1.8);


-- COURSE LAYOUTS (min/max used by students_in_range trigger)
INSERT INTO course_layout (course_code, course_name, min_students, max_students, hp) VALUES
  ('IS1307', 'Embedded Systems',      35, 148, 7.5),
  ('IS1407', 'Embedded Electronics',  13,  89, 7.5),
  ('IS1304', 'Embedded Systems II',   15,  75, 4.0),
  ('IX1401', 'Complicated Math',      10, 128, 4.0),
  ('IV1101', 'Databased',             32, 126, 7.5);


-- PERSON (100 rows). Personal numbers are CHAR(12) strings.
INSERT INTO person (personal_number, first_name, last_name, phone_number, address) VALUES
  ('200012310001','Zahir','Conrad','+46766893148','736-2163 Blandit Street'),
  ('200012310002','Martina','Tillman','+46735651725','Ap #539-2614 Non, Ave'),
  ('200012310003','Garrison','Grant','+46739495546','P.O. Box 972, 7348 Ipsum. Av.'),
  ('200012310004','Daphne','Freeman','+46771669727','194-2505 Auctor Avenue'),
  ('200012310005','Karyn','Jenkins','+46756526186','Ap #446-1720 Venenatis St.'),
  ('200012310006','Ray','Leon','+46776737798','5441 Sed Street'),
  ('200012310007','Clementine','Simpson','+46765444627','Ap #272-8556 Consectetuer Av.'),
  ('200012310008','Randall','Logan','+46778685666','648-6127 Non, Avenue'),
  ('200012310009','Hammett','Cherry','+46742647768','Ap #274-1940 Dictum Av.'),
  ('200012310010','Wynne','Potts','+46715514485','Ap #989-5473 Mauris St.'),
  ('200012310011','Zenaida','Baldwin','+46748716992','P.O. Box 977, 333 Mollis St.'),
  ('200012310012','Andrew','Preston','+46784441512','P.O. Box 495, 9700 Parturient Road'),
  ('200012310013','Rigel','Andrews','+46782638732','Ap #108-5165 Eu Rd.'),
  ('200012310014','Jackson','Chang','+46778526815','Ap #695-467 Ornare St.'),
  ('200012310015','Neve','Rush','+46781187375','Ap #443-5025 Ac St.'),
  ('200012310016','Tyler','Burch','+46751938246','8005 Erat. Street'),
  ('200012310017','Oprah','Snow','+46756595342','Ap #386-4517 Egestas. Rd.'),
  ('200012310018','Kitra','Rice','+46742472436','Ap #971-105 Gravida Rd.'),
  ('200012310019','Keegan','Snow','+46757928883','5448 Habitant Av.'),
  ('200012310020','Dillon','Boyer','+46733457563','9678 Tortor St.'),
  ('200012310021','Brent','Davis','+46735533818','642-1511 Orci St.'),
  ('200012310022','Sophia','Hensley','+46787467782','875-293 Id, St.'),
  ('200012310023','Carson','Kerr','+46777784491','576-4701 Morbi Road'),
  ('200012310024','Astra','Potter','+46779172327','P.O. Box 627, 806 Leo, Road'),
  ('200012310025','Hedwig','Griffin','+46732256396','593-8025 Suspendisse Avenue'),
  ('200012310026','Bo','Mosley','+46767952898','3188 Urna Avenue'),
  ('200012310027','Shana','Rosario','+46734527824','Ap #985-6034 Velit Avenue'),
  ('200012310028','Scott','Mcconnell','+46786823482','Ap #561-7197 Eget Rd.'),
  ('200012310029','Angelica','Cash','+46788583133','P.O. Box 550, 6506 Dolor, St.'),
  ('200012310030','Brenden','Monroe','+46763413275','Ap #149-6629 Orci. Av.'),
  ('200012310031','Brielle','Trujillo','+46762358653','376-5705 Lectus Rd.'),
  ('200012310032','Sopoline','Mitchell','+46739382873','4173 Scelerisque Rd.'),
  ('200012310033','Deirdre','Blake','+46747341458','1908 Enim Av.'),
  ('200012310034','Buckminster','Smith','+46736184276','Ap #343-1999 Eleifend, Av.'),
  ('200012310035','Barry','Bender','+46792973475','P.O. Box 963, 337 Eget St.'),
  ('200012310036','Hyatt','Blanchard','+46763333492','256-8398 Tincidunt St.'),
  ('200012310037','Brielle','Lewis','+46717461617','Ap #615-866 Eu Ave'),
  ('200012310038','Hammett','Wilcox','+46744328663','P.O. Box 986, 6482 Bibendum Rd.'),
  ('200012310039','Nevada','Sanford','+46784468968','Ap #954-9499 In St.'),
  ('200012310040','Otto','Conley','+46795187785','6323 Rutrum St.'),
  ('200012310041','Eleanor','Skinner','+46795434787','Ap #825-984 Metus Rd.'),
  ('200012310042','Madeline','Blevins','+46745356495','P.O. Box 619, 934 Ac Rd.'),
  ('200012310043','Blaze','Mcknight','+46747452957','P.O. Box 585, 5348 Aliquet. Rd.'),
  ('200012310044','Yael','Russo','+46747638134','Ap #412-3251 Sit Rd.'),
  ('200012310045','Wallace','Ayala','+46727928897','Ap #436-1039 Ligula. St.'),
  ('200012310046','Ashton','Fitzpatrick','+46787753734','Ap #817-7888 Porttitor Rd.'),
  ('200012310047','Charde','Gillespie','+46737883329','Ap #320-8820 Viverra. Rd.'),
  ('200012310048','Ishmael','Roth','+46784358545','Ap #510-6521 Tempus Road'),
  ('200012310049','Vincent','Fry','+46779527867','5747 Vivamus Av.'),
  ('200012310050','Kuame','Mann','+46765715788','P.O. Box 233, 8738 Adipiscing St.'),
  ('200012310051','Burke','Hubbard','+46756373894','836-696 Sed Rd.'),
  ('200012310052','Desirae','Pitts','+46747581748','P.O. Box 452, 4858 Vivamus Rd.'),
  ('200012310053','Risa','Ball','+46785562344','Ap #455-1325 Lorem Street'),
  ('200012310054','Seth','Santiago','+46738963716','240-4541 Libero Rd.'),
  ('200012310055','Josiah','Olson','+46766654785','P.O. Box 414, 6301 Phasellus St.'),
  ('200012310056','Aphrodite','Sanchez','+46742676556','Ap #838-3972 Porttitor St.'),
  ('200012310057','Talon','Everett','+46735783235','Ap #353-9895 Est St.'),
  ('200012310058','Alana','Bolton','+46727763726','3933 Lorem, Rd.'),
  ('200012310059','Chiquita','Armstrong','+46793178541','506-7952 Ante. Rd.'),
  ('200012310060','Willow','Gray','+46764455633','742-7752 Sollicitudin Road'),
  ('200012310061','Mona','Salinas','+46757613795','Ap #850-7625 Metus Avenue'),
  ('200012310062','Octavius','Church','+46748868472','P.O. Box 922, 1784 Posuere, Avenue'),
  ('200012310063','Fuller','Santana','+46766225872','P.O. Box 420, 7575 Risus Avenue'),
  ('200012310064','Clarke','Mueller','+46727782928','P.O. Box 286, 2878 A, St.'),
  ('200012310065','Louis','Mccall','+46734825965','Ap #356-5532 Aenean Av.'),
  ('200012310066','Scott','Briggs','+46743368844','639-8714 Nulla. Street'),
  ('200012310067','Merrill','Miranda','+46729893684','Ap #416-7761 Purus Rd.'),
  ('200012310068','Gisela','Reilly','+46752228353','5414 Sed Road'),
  ('200012310069','Nero','Acevedo','+46747388747','8176 Integer St.'),
  ('200012310070','Mufutau','Rosario','+46715258526','P.O. Box 566, 8058 Ante. Street'),
  ('200012310071','Hayley','Dawson','+46738276732','P.O. Box 366, 7879 Auctor Rd.'),
  ('200012310072','Cathleen','Jennings','+46739188448','211-1562 Vitae, Av.'),
  ('200012310073','Jerome','Ortega','+46781986468','Ap #852-7438 Malesuada. St.'),
  ('200012310074','Paula','Acevedo','+46728891188','1362 Est Rd.'),
  ('200012310075','Celeste','Mooney','+46775157918','8326 Nunc St.'),
  ('200012310076','Hedley','Bass','+46776448254','Ap #307-2164 Sed, St.'),
  ('200012310077','Kathleen','Ochoa','+46735724446','107-4006 Suspendisse Rd.'),
  ('200012310078','Erasmus','David','+46767222492','Ap #500-8687 Tincidunt, Ave'),
  ('200012310079','Jonah','Pate','+46768825856','636-6991 Nisl. Av.'),
  ('200012310080','Lyle','Sloan','+46764733942','Ap #455-7274 Ridiculus Av.'),
  ('200012310081','Baxter','Carson','+46726286627','Ap #666-181 Vivamus Street'),
  ('200012310082','Thomas','Rodriguez','+46718981548','666-7047 Neque. St.'),
  ('200012310083','Angela','Chase','+46786353798','526-7802 Et, St.'),
  ('200012310084','Thaddeus','Diaz','+46764381888','982 Penatibus Rd.'),
  ('200012310085','Cameron','Hudson','+46779352747','389-5523 Posuere Rd.'),
  ('200012310086','Hashim','Mejia','+46724996628','2096 Et Rd.'),
  ('200012310087','Noah','Alvarado','+46734877436','4602 Curabitur Avenue'),
  ('200012310088','Len','Coffey','+46773225267','750-6758 Cursus St.'),
  ('200012310089','Quail','Briggs','+46727499451','822 Luctus Ave'),
  ('200012310090','Laurel','Carroll','+46797718568','287-3813 Sed Av.'),
  ('200012310091','Vivien','Mcfarland','+46746159144','420-2294 Auctor St.'),
  ('200012310092','Nicholas','Faulkner','+46779556886','Ap #420-6902 Auctor Ave'),
  ('200012310093','Thor','Lowe','+46786488274','Ap #848-2206 Dignissim. Street'),
  ('200012310094','Reese','Hendrix','+46729236213','P.O. Box 683, 4719 Tristique Rd.'),
  ('200012310095','Nigel','Malone','+46798743512','2980 Sed St.'),
  ('200012310096','Rama','Padilla','+46778883679','6348 Est Ave'),
  ('200012310097','Macy','Craig','+46769681456','Ap #925-9275 Lacinia Avenue'),
  ('200012310098','Angela','Spence','+46788454465','P.O. Box 429, 9746 Parturient Av.'),
  ('200012310099','Vincent','Huber','+46745572456','402-1860 Lacinia St.'),
  ('200012310100','Wendy','Bonner','+46776372798','Ap #852-9326 A, Street');


-- COURSE INSTANCES
-- These numbers respect the min/max ranges in course_layout so the students_in_range trigger will accept them.
-- instance_id values will be 1..6 (assigned by IDENTITY)
INSERT INTO course_instance (num_students, study_period, study_year, course_code) VALUES
  (100, 'P3', 2025, 'IS1307'),  -- valid: between 35 and 148
  (148, 'P2', 2025, 'IS1307'),  -- edge value
  (35,  'P1', 2025, 'IS1307'),  -- edge value
  (50,  'P1', 2025, 'IS1304'),  -- valid: between 15 and 75
  (100, 'P3', 2027, 'IX1401'),  -- valid: between 10 and 128
  (40,  'P2', 2025, 'IV1101');  -- valid: between 32 and 126


-- EMPLOYEES (100 rows) -- uses job_title_id 1..5 and personal_numbers from person table
INSERT INTO employee (skill_set, salary, job_title_id, department_name, personal_number) VALUES
  ('Good at party',                      120000, 1, 'Admin',        '200012310001'),
  ('Epic, Good at party',                70000,  1, 'Electronics',  '200012310002'),
  ('Awsome, Good at party, Epic',        70000,  1, 'Data Science', '200012310003'),
  ('Based, Epic',                        40000,  4, 'Electronics',  '200012310004'),
  ('Based, Good at party, Good at data', 50000,  4, 'Data Science', '200012310005'),
  ('Good at data, Epic, Awsome',         60000,  4, 'Data Science', '200012310006'),
  ('Based, Epic, Good at data',          55000,  5, 'Electronics',  '200012310007'),
  ('Awsome, Good at data, Based',        60000,  5, 'HR',           '200012310008'),
  ('Epic, Based',                        55000,  5, 'HR',           '200012310009'),
  ('Epic, Good at party',                40000,  2, 'Admin',        '200012310010'),
  ('Based, Good at party',               60000,  2, 'Admin',        '200012310011'),
  ('Awsome, Good at data',               40000,  2, 'Data Science', '200012310012'),
  ('Based, Epic',                        60000,  4, 'Admin',        '200012310013'),
  ('Awsome, Good at data',               40000,  4, 'Admin',        '200012310014'),
  ('Good at party, Based, Epic',         45000,  4, 'Admin',        '200012310015'),
  ('Epic, Based, Awsome',                45000,  5, 'Electronics',  '200012310016'),
  ('Good at data',                       55000,  5, 'Data Science', '200012310017'),
  ('Epic, Good at party',                45000,  5, 'Electronics',  '200012310018'),
  ('Good at party, Based',               40000,  2, 'Electronics',  '200012310019'),
  ('Good at party, Based, Awsome',       40000,  2, 'HR',           '200012310020'),
  ('Based, Good at party',               40000,  2, 'HR',           '200012310021'),
  ('Good at party, Epic',                45000,  4, 'HR',           '200012310022'),
  ('Good at data, Based, Epic',          55000,  4, 'Data Science', '200012310023'),
  ('Based, Good at data',                40000,  4, 'Electronics',  '200012310024'),
  ('Epic, Good at party',                55000,  5, 'Admin',        '200012310025'),
  ('Based',                              40000,  5, 'HR',           '200012310026'),
  ('Epic, Awsome, Based',                50000,  5, 'HR',           '200012310027'),
  ('Good at data',                       45000,  2, 'Admin',        '200012310028'),
  ('Good at data, Epic',                 40000,  2, 'Electronics',  '200012310029'),
  ('Good at party, Good at data',        55000,  2, 'Data Science', '200012310030'),
  ('Awsome, Based, Epic',                55000,  4, 'HR',           '200012310031'),
  ('Epic',                               60000,  4, 'Electronics',  '200012310032'),
  ('Good at data, Awsome, Good at party',55000,  4, 'Data Science', '200012310033'),
  ('Based, Awsome',                      55000,  5, 'HR',           '200012310034'),
  ('Based, Good at party',               60000,  5, 'Data Science', '200012310035'),
  ('Good at party',                      50000,  5, 'Electronics',  '200012310036'),
  ('Good at party, Based',               40000,  2, 'Admin',        '200012310037'),
  ('Good at data',                       60000,  2, 'HR',           '200012310038'),
  ('Good at data, Awsome',               50000,  2, 'Data Science', '200012310039'),
  ('Good at party, Epic',                40000,  4, 'Admin',        '200012310040'),
  ('Based, Epic',                        55000,  4, 'Electronics',  '200012310041'),
  ('Awsome, Good at party',              40000,  4, 'Data Science', '200012310042'),
  ('Good at party, Good at data',        45000,  5, 'Admin',        '200012310043'),
  ('Epic, Awsome, Good at data',         40000,  5, 'Admin',        '200012310044'),
  ('Based, Good at data, Epic',          60000,  5, 'HR',           '200012310045'),
  ('Good at party, Good at data',        55000,  2, 'HR',           '200012310046'),
  ('Based, Awsome',                      40000,  2, 'Admin',        '200012310047'),
  ('Epic, Good at data',                 50000,  2, 'HR',           '200012310048'),
  ('Good at data, Based',                55000,  4, 'HR',           '200012310049'),
  ('Based, Epic',                        70000,  1, 'Admin',        '200012310050'),
  ('Awsome',                             60000,  4, 'Data Science', '200012310051'),
  ('Awsome, Good at data, Based',        45000,  5, 'Admin',        '200012310052'),
  ('Based, Awsome',                      55000,  5, 'Data Science', '200012310053'),
  ('Good at data, Good at party',        55000,  5, 'Admin',        '200012310054'),
  ('Awsome, Good at party, Based',       60000,  2, 'Data Science', '200012310055'),
  ('Good at data, Good at party',        60000,  2, 'Admin',        '200012310056'),
  ('Awsome',                             40000,  2, 'Data Science', '200012310057'),
  ('Good at data, Good at party',        55000,  4, 'Electronics',  '200012310058'),
  ('Based, Good at data, Epic',          60000,  4, 'Electronics',  '200012310059'),
  ('Epic',                               45000,  4, 'Admin',        '200012310060'),
  ('Good at party',                      40000,  5, 'Data Science', '200012310061'),
  ('Based, Good at data',                50000,  5, 'HR',           '200012310062'),
  ('Good at party, Epic',                60000,  5, 'Admin',        '200012310063'),
  ('Based',                              45000,  2, 'Electronics',  '200012310064'),
  ('Based, Good at data',                40000,  2, 'Admin',        '200012310065'),
  ('Epic',                               60000,  2, 'Admin',        '200012310066'),
  ('Epic, Based, Good at data',          50000,  4, 'Electronics',  '200012310067'),
  ('Good at data, Based',                50000,  4, 'Data Science', '200012310068'),
  ('Good at data, Based',                40000,  4, 'HR',           '200012310069'),
  ('Good at data, Awsome',               45000,  5, 'Admin',        '200012310070'),
  ('Good at party, Good at data, Epic',  45000,  5, 'HR',           '200012310071'),
  ('Based',                              50000,  5, 'HR',           '200012310072'),
  ('Good at data, Based, Good at party', 40000,  2, 'HR',           '200012310073'),
  ('Awsome, Based, Good at data',        40000,  2, 'HR',           '200012310074'),
  ('Epic, Based',                        55000,  2, 'Admin',        '200012310075'),
  ('Based, Epic',                        40000,  4, 'Data Science', '200012310076'),
  ('Based, Awsome, Epic',                40000,  4, 'Data Science', '200012310077'),
  ('Good at party, Epic',                55000,  4, 'HR',           '200012310078'),
  ('Good at party',                      40000,  5, 'HR',           '200012310079'),
  ('Based',                              55000,  5, 'HR',           '200012310080'),
  ('Good at data, Epic',                 60000,  5, 'Electronics',  '200012310081'),
  ('Epic, Good at data',                 60000,  2, 'Electronics',  '200012310082'),
  ('Epic',                               55000,  2, 'Electronics',  '200012310083'),
  ('Good at data, Good at party',        55000,  2, 'Electronics',  '200012310084'),
  ('Awsome',                             45000,  4, 'Data Science', '200012310085'),
  ('Good at data, Based',                45000,  4, 'Data Science', '200012310086'),
  ('Based, Awsome',                      45000,  4, 'Data Science', '200012310087'),
  ('Based, Good at data',                40000,  5, 'HR',           '200012310088'),
  ('Awsome, Good at party',              40000,  5, 'Admin',        '200012310089'),
  ('Epic, Good at data',                 60000,  5, 'Admin',        '200012310090'),
  ('Epic, Good at data',                 50000,  2, 'HR',           '200012310091'),
  ('Awsome, Based',                      50000,  2, 'Admin',        '200012310092'),
  ('Awsome, Based, Good at party',       40000,  2, 'Admin',        '200012310093'),
  ('Good at data, Good at party',        40000,  4, 'Admin',        '200012310094'),
  ('Good at party, Good at data',        50000,  4, 'Electronics',  '200012310095'),
  ('Good at party, Epic',                45000,  4, 'Admin',        '200012310096'),
  ('Good at party, Good at data, Based', 50000,  5, 'Data Science', '200012310097'),
  ('Epic, Good at data',                 40000,  5, 'Admin',        '200012310098'),
  ('Good at party, Good at data, Epic',  45000,  5, 'Electronics',  '200012310099'),
  ('Based, Good at data',                55000,  2, 'Electronics',  '200012310100');


-- PLANNED ACTIVITY
-- We create planned activities referencing the 6 course_instances (IDs 1..6).
-- Use explicit column list so order doesn't matter.
INSERT INTO planned_activity (planned_hours, activity_name, course_instance_id) VALUES
  (24, 'Laboration', 1),
  (24, 'Seminar',    1),
  (34, 'Laboration', 2),
  (34, 'Seminar',    2),
  (37, 'Seminar',    3),
  (10, 'Lecture',    3),
  (19, 'Tutorial',   3),
  (31, 'Lecture',    4),
  (21, 'Seminar',    4),
  (25, 'Lecture',    4),
  (20, 'Lecture',    5),
  (15, 'Tutorial',   5),
  (18, 'Laboration', 6),
  (12, 'Seminar',    6),
  (14, 'Tutorial',   6);


-- EMPLOYEE_ON_ACTIVITY
-- activity_instance_id will be 1..15 in the order inserted above.
-- employment_id values reference employee.employment_id (1..100). We keep assignments light
-- and ensure no employee exceeds 4 distinct course instances in the same study_period.
INSERT INTO employee_on_activity (activity_instance_id, employment_id) VALUES
  (1,  1),  -- activity 1 (course_instance 1)
  (2,  2),  -- activity 2 (course_instance 1)
  (3,  3),  -- activity 3 (course_instance 2)
  (4,  4),  -- activity 4 (course_instance 2)
  (5,  5),  -- activity 5 (course_instance 3)
  (6,  6),  -- activity 6 (course_instance 3)
  (7,  7),  -- activity 7 (course_instance 3)
  (8,  8),  -- activity 8 (course_instance 4)
  (9,  9),  -- activity 9 (course_instance 4)
  (10, 10), -- activity 10 (course_instance 4)
  (11, 11), -- activity 11 (course_instance 5)
  (12, 12), -- activity 12 (course_instance 5)
  (13, 13), -- activity 13 (course_instance 6)
  (14, 14), -- activity 14 (course_instance 6)
  (15, 15), -- activity 15 (course_instance 6)

  -- a few employees with multiple assignments but within the limit:
  (1,  16), -- employee 16 also does activity 1 (course_instance 1)
  (3,  16), -- employee 16 also does activity 3 (course_instance 2) -> distinct instances in period P2/P3 differ, still under limit
  (5,  17),
  (7,  17),
  (9,  17),
  (11, 18),
  (13, 18),
  (2,  19),
  (4,  19),
  (6,  19),
  (8,  19);

-- (That distribution keeps distinct course-instance-per-period counts <= 4 for every employee.)
