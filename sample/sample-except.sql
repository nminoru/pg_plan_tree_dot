\include prepare-union.sql;

--- SELECT * FROM test1 EXCEPT SELECT * FROM test2;
SELECT generate_plan_tree_dot('SELECT * FROM test1 EXCEPT SELECT * FROM test2;', 'sample-except.dot');

\include cleanup-union.sql;

