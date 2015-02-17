CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS input_table;
DROP TABLE IF EXISTS output_table;

SELECT setseed(0);

CREATE TABLE input_table (aggkey int4, i int4, t text);
CREATE TABLE output_table (aggkey int4, sum int4, avg int4, max int4, min int4);

INSERT INTO input_table (aggkey, i, t) SELECT i % 10, random() * 100, random() FROM generate_series(1,1000) AS i;

-- WITH tmp (aggkey, sum, avg, max, min) AS (SELECT aggkey, sum(i), avg(i), max(i), min(i) FROM input_table GROUP BY aggkey) INSERT INTO output_table (aggkey, sum, avg, max, min) SELECT * FROM tmp;
SELECT generate_plan_tree_dot('WITH tmp (aggkey, sum, avg, max, min) AS (SELECT aggkey, sum(i), avg(i), max(i), min(i) FROM input_table GROUP BY aggkey) INSERT INTO output_table (aggkey, sum, avg, max, min) SELECT * FROM tmp;', 'sample-with.dot');

DROP TABLE output_table;
DROP TABLE input_table;
