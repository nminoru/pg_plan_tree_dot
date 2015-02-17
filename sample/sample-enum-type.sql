CREATE EXTENSION IF NOT EXISTS pg_plan_tree_dot;

DROP TYPE IF EXISTS color;
DROP TABLE IF EXISTS screen;

CREATE TYPE color AS ENUM (
       'black',
       'white',
       'red',
       'green',
       'blue');

CREATE TABLE screen (
       forecolor color,
       bgcolor color);

INSERT INTO screen VALUES ('red',   'black');
INSERT INTO screen VALUES ('white', 'black');
INSERT INTO screen VALUES ('green', 'black');
INSERT INTO screen VALUES ('blue',  'white');

-- SELECT * FROM screen WHERE bgcolor = 'black';
SELECT generate_plan_tree_dot('SELECT * FROM screen WHERE bgcolor = ''black'';', 'sample-enum-type.dot');

DROP TABLE screen;
DROP TYPE color;
