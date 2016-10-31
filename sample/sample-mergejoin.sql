CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

CREATE TABLE T1 (C1 int, C2 int);
CREATE TABLE T2 (C1 int, C2 int);

INSERT INTO T1 (C1, C2) SELECT i, i FROM generate_series(0, 10000) AS i;
INSERT INTO T2 (C1, C2) SELECT i, i FROM generate_series(0, 10000) AS i;

CREATE INDEX ON T2 (C1);

ANALYZE;

SET enable_hashjoin = off;

-- SELECT T1.C1, T1.C2 FROM T1 JOIN T2 ON (T1.C1 = T2.C1) ORDER BY T2.C2;
SELECT generate_plan_tree_dot('SELECT T1.C1, T1.C2 FROM T1 JOIN T2 ON (T1.C1 = T2.C1) ORDER BY T2.C2;', 'sample-mergejoin.dot');

DROP TABLE IF EXISTS T1 CASCADE;
DROP TABLE IF EXISTS T2 CASCADE;