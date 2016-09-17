\echo Use "CREATE EXTENSION pg_plan_tree_dot" to load this file. \quit

CREATE FUNCTION public.generate_plan_tree_dot(
       IN sql      text,
       IN filename text,
       IN simplify bool DEFAULT false)
RETURNS void
AS 'MODULE_PATHNAME'
LANGUAGE C VOLATILE STRICT;
