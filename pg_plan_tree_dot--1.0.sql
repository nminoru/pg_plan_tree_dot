-- CREATE FUNCTION public.trigger_plan_tree_view()
-- RETURNS void
-- AS 'MODULE_PATHNAME'
-- LANGUAGE C VOLATILE STRICT;

CREATE FUNCTION public.generate_plan_tree_dot(
       IN sql      text,
       IN filename text)      
RETURNS void
AS 'MODULE_PATHNAME'
LANGUAGE C VOLATILE STRICT;

CREATE FUNCTION public.generate_plan_state_tree_dot(
       IN sql      text,
       IN filename text)      
RETURNS void
AS 'MODULE_PATHNAME'
LANGUAGE C VOLATILE STRICT;
