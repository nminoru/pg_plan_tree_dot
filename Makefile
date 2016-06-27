# pg_plan_tree_dot/Makefile

MODULE_big = pg_plan_tree_dot
OBJS = pg_plan_tree_dot.o plan_tree_view.o 

EXTENSION = pg_plan_tree_dot
DATA = pg_plan_tree_dot--1.0.sql pg_plan_tree_dot--unpackaged--1.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

# CFLAGS += -DCUSTOM_PLAN

COMPILER = $(CXX) $(CFLAGS)

%.o : %.cpp
ifdef DEPDIR
	@if test ! -d $(DEPDIR); then mkdir -p $(DEPDIR); fi
	$(CXX) $(CFLAGS) $(CPPFLAGS) -c -o $@ $< -MMD -MP -MF $(DEPDIR)/$(*F).Po
else
	$(CXX) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
endif

