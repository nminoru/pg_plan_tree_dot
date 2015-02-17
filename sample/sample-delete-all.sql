CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TYPE IF EXISTS pair;

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

-- DELETE FROM pair;
SELECT generate_plan_tree_dot('DELETE FROM pair;', 'sample-delete-all.dot');

DROP TABLE pair;
