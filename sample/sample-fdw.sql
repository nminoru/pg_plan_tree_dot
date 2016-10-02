CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

DO $d$
    BEGIN
        EXECUTE $$CREATE SERVER loopback FOREIGN DATA WRAPPER postgres_fdw
            OPTIONS (host '127.0.0.1', port '$$||current_setting('port')||$$',
             dbname '$$||current_database()||$$'
            )$$;
    END;
$d$;

CREATE USER MAPPING FOR CURRENT_USER SERVER loopback;

CREATE TABLE t1 (key int, value int, dummy int);

INSERT INTO t1 (key, value) SELECT i % 3, i FROM GENERATE_SERIES(1, 1000) AS i;

CREATE FOREIGN TABLE ft (
       key int,
       value int,
       dummy int
) SERVER loopback OPTIONS (schema_name 'public', table_name 't1');

-- SELECT key, count(*), sum(value) FROM ft WHERE value % 10 = 0 GROUP BY key ORDER BY key;
SELECT generate_plan_tree_dot('SELECT key, count(*), sum(value) FROM ft WHERE value % 10 = 0 GROUP BY key ORDER BY key;', 'sample-fdw.dot', true);

DROP TABLE t1 CASCADE;
DROP FOREIGN TABLE ft CASCADE;
DROP SERVER loopback CASCADE;
