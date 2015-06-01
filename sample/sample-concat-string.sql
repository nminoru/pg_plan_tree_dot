CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS test;

CREATE TABLE test (id1 VARCHAR, id2 INTEGER);

INSERT INTO test VALUES ('Value:', 42);

-- SELECT id1 || id2 FROM test

SELECT generate_plan_tree_dot('SELECT id1 || id2 FROM test', 'sample-concat-string.dot');

DROP TABLE test;
