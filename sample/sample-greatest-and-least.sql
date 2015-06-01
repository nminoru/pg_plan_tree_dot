CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS test;

CREATE TABLE test (id1 INTEGER, id2 INTEGER, id3 INTEGER, id4 INTEGER, id5 INTEGER);

INSERT INTO test VALUES (10, 20, 30, 40, 50);

-- SELECT greatest(id1, id2, id3, id4, id5) FROM test;
-- SELECT least(id1, id2, id3, id4, id5) FROM test;
SELECT generate_plan_tree_dot('SELECT greatest(id1, id2, id3, id4, id5) FROM test', 'sample-greatest.dot');
SELECT generate_plan_tree_dot('SELECT least(id1, id2, id3, id4, id5) FROM test', 'sample-least.dot');

DROP TABLE test;
