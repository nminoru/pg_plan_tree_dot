CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS test1, test2;

CREATE TABLE test1 (aggkey int4, value decimal(12,2));
CREATE TABLE test2 (aggkey int4, value decimal(12,2));

INSERT INTO test1 (aggkey, value) SELECT i * 2, (random() * 100000) / 100  FROM generate_series(1, 1000000) AS i;
INSERT INTO test2 (aggkey, value) SELECT i * 3, (random() * 100000) / 100  FROM generate_series(1, 1000000) AS i;
