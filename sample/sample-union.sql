\include prepare-union.sql;

--- SELECT * FROM test1 UNION SELECT * FROM test2;
SELECT generate_plan_tree_dot('SELECT * FROM test1 UNION SELECT * FROM test2;', 'sample-union.dot');

\include cleanup-union.sql;

