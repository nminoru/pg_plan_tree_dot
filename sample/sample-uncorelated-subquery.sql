CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS employee, cities, regions;

CREATE TABLE employee (
       ID         int,
       name       varchar(10),
       salary     real,
       start_date date,
       city       varchar(10),
       region     char(1));

CREATE TABLE cities (
       city       varchar(10),
       region     char(1),
       population int
       );

CREATE TABLE regions (
       region     char(1),
       magicword  text
       );

INSERT INTO employee VALUES (1,  'Jason', 40420,  '94/02/01', 'New York', 'W');
INSERT INTO employee VALUES (2,  'Robert',14420,  '95/01/02', 'Vancouver','N');
INSERT INTO employee VALUES (3,  'Celia', 24020,  '96/12/03', 'Toronto',  'W');
INSERT INTO employee VALUES (4,  'Linda', 40620,  '87/11/04', 'New York', 'N');
INSERT INTO employee VALUES (5,  'David', 80026,  '98/10/05', 'Vancouver','W');
INSERT INTO employee VALUES (6,  'James', 70060,  '99/09/06', 'Toronto',  'N');
INSERT INTO employee VALUES (7,  'Alison',90620,  '00/08/07', 'New York', 'W');
INSERT INTO employee VALUES (8,  'Chris', 26020,  '01/07/08', 'Vancouver','N');
INSERT INTO employee VALUES (9,  'Mary',  60020,  '02/06/09', 'Toronto',  'W');

INSERT INTO cities   VALUES ('New York',  'W', 123);
INSERT INTO cities   VALUES ('Vancouver', 'N',   4);
INSERT INTO cities   VALUES ('Toronto',   'W',   5);

INSERT INTO regions  VALUES ('W', 'cafebabe');
INSERT INTO regions  VALUES ('N', 'deadbeaf');

--- SELECT E.ID, E.name FROM employee E WHERE E.salary > (SELECT C.population FROM cities C WHERE C.region = (SELECT R.region FROM regions R WHERE R.magicword = 'deadbeaf'));

SELECT generate_plan_tree_dot('SELECT E.ID, E.name FROM employee E WHERE E.salary > (SELECT C.population FROM cities C WHERE C.region = (SELECT R.region FROM regions R WHERE R.magicword = ''deadbeaf''));', 'sample-uncorelated-subquery.dot');

DROP TABLE cities, employee, regions;
