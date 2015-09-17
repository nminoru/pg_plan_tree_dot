CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS test;

CREATE TABLE test (key INTEGER, value INTEGER);

INSERT INTO test VALUES (1, 100);
INSERT INTO test VALUES (2, 200);
INSERT INTO test VALUES (3, 300);

--- SELECT x FROM test WHERE key = 3 FOR UPDATE
BEGIN;

SELECT generate_plan_tree_dot('SELECT key FROM test WHERE key = 3 FOR UPDATE;', 'sample-select-for-update.dot');

COMMIT;

DROP TABLE test;
