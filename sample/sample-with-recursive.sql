CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

-- WITH RECURSIVE t(n) AS (VALUES(1) UNION ALL SELECT n + 1 FROM t WHERE n < 100) SELECT sum(n) FROM t;
SELECT generate_plan_tree_dot('WITH RECURSIVE t(n) AS (VALUES(1) UNION ALL SELECT n + 1 FROM t WHERE n < 100) SELECT sum(n) FROM t;', 'sample-with-recursive.dot');
