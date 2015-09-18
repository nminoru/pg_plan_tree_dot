
CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS test1, test2;

CREATE TABLE test1 (aggkey int4, value decimal(12,2));
CREATE TABLE test2 (aggkey int4, value decimal(12,2));

INSERT INTO test1 (aggkey, value) SELECT i * 2, (random() * 100000) / 100  FROM generate_series(1, 1000000) AS i;
INSERT INTO test2 (aggkey, value) SELECT i * 3, (random() * 100000) / 100  FROM generate_series(1, 1000000) AS i;

--- SELECT * FROM test1 UNION SELECT * FROM test2;
SELECT generate_plan_tree_dot('SELECT * FROM test1 UNION SELECT * FROM test2;', 'sample-union.dot');

--- SELECT * FROM test1 UNION ALL SELECT * FROM test2;
SELECT generate_plan_tree_dot('SELECT * FROM test1 UNION ALL SELECT * FROM test2;', 'sample-union-all.dot');

--- SELECT * FROM test1 INTERSECT SELECT * FROM test2;
SELECT generate_plan_tree_dot('SELECT * FROM test1 INTERSECT SELECT * FROM test2;', 'sample-intersect.dot');

--- SELECT * FROM test1 INTERSECT ALL SELECT * FROM test2;
SELECT generate_plan_tree_dot('SELECT * FROM test1 INTERSECT ALL SELECT * FROM test2;', 'sample-intersect-all.dot');

--- SELECT * FROM test1 EXCEPT SELECT * FROM test2;
SELECT generate_plan_tree_dot('SELECT * FROM test1 EXCEPT SELECT * FROM test2;', 'sample-except.dot');

--- SELECT * FROM test1 EXCEPT ALL SELECT * FROM test2;
SELECT generate_plan_tree_dot('SELECT * FROM test1 EXCEPT ALL SELECT * FROM test2;', 'sample-except-all.dot');

DROP TABLE test1, test2;
