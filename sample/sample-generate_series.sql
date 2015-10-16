CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

--- SELECT * FROM generate_series(1, 100);
SELECT generate_plan_tree_dot('SELECT * FROM generate_series(1, 100);', 'sample-generate_series.dot');
