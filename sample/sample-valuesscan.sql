CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

-- SELECT * FROM (VALUES (1), (2), (3)) AS t(i);

SELECT generate_plan_tree_dot('SELECT * FROM (VALUES (1), (2), (3)) AS t(i)', 'sample-valuesscan.dot');

