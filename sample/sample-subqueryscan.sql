CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

CREATE TABLE customer (c_custkey INTEGER);
CREATE TABLE orders (o_orderkey INTEGER, o_custkey INTEGER);

INSERT INTO customer (c_custkey) SELECT i FROM generate_series(1, 100) AS i;
INSERT INTO orders (o_orderkey, o_custkey) SELECT i, (i % 100) + 1 FROM generate_series(1, 1000) AS i;

ANALYZE;

--- SELECT c_count, count(*) AS custdist FROM ( SELECT c_custkey, count(o_orderkey) FROM customer LEFT OUTER JOIN orders ON c_custkey = o_custkey GROUP BY c_custkey ) as c_orders (c_custkey, c_count) GROUP BY c_count;

SELECT generate_plan_tree_dot('SELECT c_count, count(*) AS custdist FROM ( SELECT c_custkey, count(o_orderkey) FROM customer LEFT OUTER JOIN orders ON c_custkey = o_custkey GROUP BY c_custkey ) as c_orders (c_custkey, c_count) GROUP BY c_count;', 'sample-subqueryscan.dot');

DROP TABLE customer, orders;