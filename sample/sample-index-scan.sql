CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TABLE IF EXISTS index_scan_test;

CREATE TABLE index_scan_test (a INTEGER, b INTEGER, c INTEGER, d INTEGER);
CREATE INDEX index_scan_test_index ON index_scan_test (a, (b + c));

INSERT INTO index_scan_test VALUES ( 1,  2,  3,  4);
INSERT INTO index_scan_test VALUES ( 5,  6,  7,  8);
INSERT INTO index_scan_test VALUES ( 9, 10, 11, 12);
INSERT INTO index_scan_test VALUES (13, 14, 15, 16);
INSERT INTO index_scan_test VALUES (17, 18, 19, 20);
INSERT INTO index_scan_test VALUES ( 2,  2,  3,  4);
INSERT INTO index_scan_test VALUES ( 6,  6,  7,  8);
INSERT INTO index_scan_test VALUES (10, 10, 11, 12);
INSERT INTO index_scan_test VALUES (14, 14, 15, 16);
INSERT INTO index_scan_test VALUES (18, 18, 19, 20);

VACUUM ANALYZE;

--- SELECT b + c FROM index_scan_test WHERE a > 10;
SELECT generate_plan_tree_dot('SELECT b + c FROM index_scan_test WHERE a > 10;', 'sample-index-scan.dot');

DROP TABLE index_scan_test;
