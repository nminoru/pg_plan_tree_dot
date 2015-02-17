CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS pair;

CREATE TABLE pair (
       x real,
       y real);

INSERT INTO pair VALUES (0, 1);
INSERT INTO pair VALUES (1, 2);
INSERT INTO pair VALUES (2, 3);
INSERT INTO pair VALUES (3, 4);
INSERT INTO pair VALUES (5, 6);
INSERT INTO pair VALUES (7, 8);
INSERT INTO pair VALUES (9, 0);

--- SELECT x, y FROM pair WHERE CASE WHEN x > 0 THEN y/x > 1.5 WHEN x < 0 THEN y/x < 1.5 ELSE false END;
SELECT generate_plan_tree_dot('SELECT x, y FROM pair WHERE CASE WHEN x > 0 THEN y/x > 1.5 WHEN x < 0 THEN y/x < 1.5 ELSE false END;', 'sample-case-when-else.dot');

DROP TABLE pair;
