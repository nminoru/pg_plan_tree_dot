CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP SEQUENCE IF EXISTS seq;
DROP TABLE IF EXISTS test;

CREATE SEQUENCE seq;
CREATE TABLE test (id1 INTEGER);

INSERT INTO test VALUES (1);

SELECT nextval('seq');

-- SELECT lastval() + id1 FROM test;

SELECT generate_plan_tree_dot('SELECT lastval() + id1 FROM test', 'sample-sequence-lastval.dot');

DROP TABLE test;
DROP SEQUENCE seq;
