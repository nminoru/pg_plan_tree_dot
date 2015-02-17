CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TYPE IF EXISTS color;
DROP TABLE IF EXISTS screen;

CREATE DOMAIN us_postal_code AS TEXT
       CHECK(VALUE ~ '^\d{5}$'
       OR VALUE    ~ '^\d{5}-\d{4}$'
       );

CREATE TABLE us_snail_addy (
       address_id SERIAL PRIMARY KEY,
       street1 TEXT NOT NULL,
       street2 TEXT,
       street3 TEXT,
       city TEXT NOT NULL,
       postal us_postal_code NOT NULL
       );

INSERT INTO screen VALUES ('red',   'black');
INSERT INTO screen VALUES ('white', 'black');
INSERT INTO screen VALUES ('green', 'black');
INSERT INTO screen VALUES ('blue',  'white');

-- SELECT * FROM screen WHERE bgcolor = 'black';
SELECT generate_plan_tree_dot('SELECT * FROM screen WHERE bgcolor = ''black'';', '/tmp/sample-enum-type.dot');

DROP TABLE screen;
DROP TYPE color;
