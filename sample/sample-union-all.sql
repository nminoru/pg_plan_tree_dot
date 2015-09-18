\include prepare-union.sql;

--- SELECT * FROM test1 UNION ALL SELECT * FROM test2;
SELECT generate_plan_tree_dot('SELECT * FROM test1 UNION ALL SELECT * FROM test2;', 'sample-union-all.dot');

\include cleanup-union.sql;


