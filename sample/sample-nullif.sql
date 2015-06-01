CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS test;

CREATE TABLE test (id1 INTEGER, id2 INTEGER);

INSERT INTO test VALUES (11, 10);

-- SELECT NULLIF(id1, id2) FROM test

SELECT generate_plan_tree_dot('SELECT NULLIF(id1, id2) FROM test', 'sample-nullif.dot');

DROP TABLE test;
