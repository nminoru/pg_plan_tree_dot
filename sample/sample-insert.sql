CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS test;

CREATE TABLE test (key INTEGER, value INTEGER);

INSERT INTO test VALUES (1, 100);
INSERT INTO test VALUES (2, 200);
INSERT INTO test VALUES (3, 300);

--- INSERT INTO test (key, value) VALUES (4, (SELECT value FROM test WHERE key = 3));
SELECT generate_plan_tree_dot('INSERT INTO test (key, value) VALUES (4, (SELECT value FROM test WHERE key = 3));', 'sample-insert.dot');

DROP TABLE test;
