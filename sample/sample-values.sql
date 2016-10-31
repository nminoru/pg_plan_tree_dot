CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

--- SELECT t.symbol, t.number FROM (VALUES ('foo', 1), ('bar', 2), ('baz', 3)) AS t(symbol, number);
SELECT generate_plan_tree_dot('SELECT t.symbol, t.number FROM (VALUES (''foo'', 1), (''bar'', 2), (''baz'', 3)) AS t(symbol, number);', 'sample-values.dot');
