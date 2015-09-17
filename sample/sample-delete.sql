CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS test;

CREATE TABLE test (key INTEGER, value INTEGER);

INSERT INTO test VALUES (1, 100);
INSERT INTO test VALUES (2, 200);
INSERT INTO test VALUES (3, 300);

--- DELETE FROM test WHERE key = 3;
SELECT generate_plan_tree_dot('DELETE FROM test WHERE key = 3;', 'sample-delete.dot');

DROP TABLE test;
