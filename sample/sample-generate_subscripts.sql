CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

--- SELECT generate_subscripts('{NULL, 1, NULL, 2}'::int[], 1) AS s;
SELECT generate_plan_tree_dot('SELECT generate_subscripts(''{NULL, 1, NULL, 2}''::int[], 1) AS s;', 'sample-generate_subscripts.dot');
