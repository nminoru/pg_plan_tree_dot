CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS testtable;

CREATE TABLE testtable (a INTEGER, b INTEGER, c INTEGER, d INTEGER);
INSERT INTO testtable SELECT i, i, i, i FROM generate_series(1, 1000) AS i; 
CREATE INDEX testindex ON testtable (b, c);

ANALYZE;

SET enable_bitmapscan    = off;
SET enable_indexscan     = on;
SET enable_indexonlyscan = on;

--- SELECT b, c FROM testtable WHERE b BETWEEN 10 AND 20;
SELECT generate_plan_tree_dot('SELECT b, c FROM testtable WHERE b BETWEEN 10 AND 20;', 'sample-index-only-scan.dot');

DROP TABLE testtable;
