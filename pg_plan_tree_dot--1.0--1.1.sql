\echo Use "ALTER EXTENSION pg_plan_tree_dot UPDATE TO '1.1'" to load this file. \quit

DROP FUNCTION public.generate_plan_state_tree(text, text) CASCADE;
DROP FUNCTION public.generate_plan_tree(text, text) CASCADE;

CREATE FUNCTION public.generate_plan_tree_dot(
       IN sql      text,
       IN filename text,
       IN simplify bool DEFAULT false)
RETURNS void
AS 'MODULE_PATHNAME'
LANGUAGE C VOLATILE STRICT;