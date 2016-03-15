CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS testtable1, testtable2;

CREATE TABLE testtable1 (key integer, value integer);
INSERT INTO testtable1 SELECT i, i FROM generate_series(1, 1000) AS i; 

CREATE TABLE testtable2 (key integer, value integer);
INSERT INTO testtable2 SELECT i, i FROM generate_series(1, 1000) AS i; 

ANALYZE;

--- SELECT * FROM testtable1 T1 INNER JOIN testtable2 T2 ON (T1.key = T2.key);
SELECT generate_plan_tree_dot('SELECT * FROM testtable1 T1 INNER JOIN testtable2 T2 ON (T1.key = T2.key);', 'sample-hash-join.dot');

DROP TABLE testtable1, testtable2;
