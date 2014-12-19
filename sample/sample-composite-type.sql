CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

CREATE TYPE xypoint AS (
       x int,
       y int);

CREATE TABLE triangle (
       t1 xypoint, 
       t2 xypoint,
       t3 xypoint);

INSERT INTO triangle VALUES (ROW(0, 0), ROW(1, 0), ROW(0, 1));
INSERT INTO triangle VALUES (ROW(0, 3), ROW(1, 2), ROW(2, 1));

-- SELECT * FROM triangle WHERE (t1).x >= 0;
SELECT generate_plan_tree_dot('SELECT * FROM triangle WHERE (t1).x >= 0;', 'sample-create-type.dot');

DROP TABLE triangle;
DROP TYPE xypoint;

