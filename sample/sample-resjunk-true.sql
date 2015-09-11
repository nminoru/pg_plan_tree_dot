CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS resjunk_test;

CREATE TABLE resjunk_test (key integer, time timestamp);

INSERT INTO resjunk_test VALUES (random() * 100, current_timestamp);
INSERT INTO resjunk_test VALUES (random() * 100, current_timestamp);
INSERT INTO resjunk_test VALUES (random() * 100, current_timestamp);
INSERT INTO resjunk_test VALUES (random() * 100, current_timestamp);

-- SELECT key FROM resjunk_test ORDER BY time;

SELECT generate_plan_tree_dot('SELECT key FROM resjunk_test ORDER BY time', 'sample-resjunk-true.dot');

DROP TABLE resjunk_test;

