\include prepare-union.sql;

--- SELECT * FROM test1 INTERSECT ALL SELECT * FROM test2;
SELECT generate_plan_tree_dot('SELECT * FROM test1 INTERSECT ALL SELECT * FROM test2;', 'sample-intersect-all.dot');

\include cleanup-union.sql;



